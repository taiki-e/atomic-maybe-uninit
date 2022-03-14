// The rustc-cfg emitted by the build script are *not* public API.

#![warn(rust_2018_idioms, single_use_lifetimes)]

use std::{env, process::Command, str};

// rustc +stable -Vv | grep -E '^(commit-date|release)'
const LATEST_STABLE: Version = Version { minor: 59, nightly: false };

fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    let target = match env::var("TARGET") {
        Ok(target) => target,
        Err(e) => {
            println!(
                "cargo:warning={}: unable to get TARGET environment variable: {}",
                env!("CARGO_PKG_NAME"),
                e
            );
            return;
        }
    };
    // HACK: If --target is specified, rustflags is not applied to the build
    // script itself, so the build script will not be rerun when these are changed.
    println!("cargo:rerun-if-env-changed=RUSTFLAGS");
    println!("cargo:rerun-if-env-changed=CARGO_BUILD_RUSTFLAGS");
    println!(
        "cargo:rerun-if-env-changed=CARGO_TARGET_{}_RUSTFLAGS",
        target.to_uppercase().replace('-', "_").replace('.', "_")
    );

    let version = match rustc_version() {
        Some(version) => version,
        None => {
            println!("cargo:warning={}: unable to determine rustc version", env!("CARGO_PKG_NAME"));
            LATEST_STABLE
        }
    };

    if version.minor >= 61 {
        // TODO: invert cfg once Rust 1.61 became stable.
        println!("cargo:rustc-cfg=atomic_maybe_uninit_const_fn_trait_bound");
    }

    // #[cfg(target_feature = "lse")] doesn't work on stable.
    // https://github.com/rust-lang/rust/pull/90621
    if target.starts_with("aarch64") && has_target_feature("lse", &version, None) {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature_lse");
    }
    // #[cfg(target_feature = "a")] doesn't work on stable.
    if let Some(target) = target.strip_prefix("riscv") {
        // riscv64gc-unknown-linux-gnu
        //      ^^^^
        let arch = target.split_once('-').unwrap().0;
        // G = IMAFD
        if arch.contains('a') || arch.contains('g') {
            println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature_a");
        }
    }
}

struct Version {
    minor: u32,
    nightly: bool,
}

fn rustc_version() -> Option<Version> {
    let rustc = env::var_os("RUSTC")?;
    // Use verbose version output because the packagers add extra strings to the normal version output.
    let output = Command::new(rustc).args(&["--version", "--verbose"]).output().ok()?;
    let output = str::from_utf8(&output.stdout).ok()?;

    let mut release = output
        .lines()
        .find(|line| line.starts_with("release: "))
        .map(|line| &line["release: ".len()..])?
        .splitn(2, '-');
    let version = release.next().unwrap();
    let channel = release.next().unwrap_or_default();
    let mut digits = version.splitn(3, '.');
    let major = digits.next()?.parse::<u32>().ok()?;
    if major != 1 {
        return None;
    }
    let minor = digits.next()?.parse::<u32>().ok()?;
    let _patch = digits.next().unwrap_or("0").parse::<u32>().ok()?;
    let nightly = channel == "nightly" || channel == "dev";

    Some(Version { minor, nightly })
}

fn has_target_feature(name: &str, version: &Version, stabilized: Option<u32>) -> bool {
    // HACK: Currently, it seems that the only way that works on the stable is
    // to parse the `-C target-feature` in RUSTFLAGS.
    //
    // - #[cfg(target_feature = "unstable_target_feature")] doesn't work on stable.
    // - CARGO_CFG_TARGET_FEATURE excludes unstable features on stable.
    //
    // As mentioned in the [RFC2045], unstable target features are also passed to LLVM
    // (e.g., https://godbolt.org/z/8Eh3z5Wzb), so this hack works properly on stable.
    //
    // [RFC2045]: https://rust-lang.github.io/rfcs/2045-target-feature.html#backend-compilation-options
    let mut has_target_feature = false;
    if version.nightly || stabilized.map_or(false, |stabilized| version.minor >= stabilized) {
        has_target_feature = env::var("CARGO_CFG_TARGET_FEATURE")
            .ok()
            .map_or(false, |s| s.split(',').any(|s| s == name));
    } else if let Some(rustflags) = env::var_os("CARGO_ENCODED_RUSTFLAGS") {
        for mut flag in rustflags.to_string_lossy().split('\x1f') {
            if flag.starts_with("-C") {
                flag = &flag["-C".len()..];
            }
            if flag.starts_with("target-feature=") {
                flag = &flag["target-feature=".len()..];
                for s in flag.split(',').filter(|s| !s.is_empty()) {
                    match (s.as_bytes()[0] as char, &s[1..]) {
                        ('+', f) if f == name => has_target_feature = true,
                        ('-', f) if f == name => has_target_feature = false,
                        _ => {}
                    }
                }
            }
        }
    }
    has_target_feature
}
