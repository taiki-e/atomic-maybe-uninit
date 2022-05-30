// The rustc-cfg emitted by the build script are *not* public API.

#![warn(rust_2018_idioms, single_use_lifetimes)]

use std::{env, process::Command, str};

// rustc +stable -Vv | grep -E '^(commit-date|release)'
const LATEST_STABLE: Version = Version { minor: 61, nightly: false };

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
    //
    // Ideally, the build script should be rebuilt when CARGO_ENCODED_RUSTFLAGS
    // is changed, but since it is an environment variable set by cargo,
    // as of 1.62.0-nightly, it is not useful to specify it as rerun-if-env-changed.
    println!("cargo:rerun-if-env-changed=RUSTFLAGS");
    println!("cargo:rerun-if-env-changed=CARGO_BUILD_RUSTFLAGS");
    println!(
        "cargo:rerun-if-env-changed=CARGO_TARGET_{}_RUSTFLAGS",
        target.to_uppercase().replace('-', "_").replace('.', "_")
    );

    let version = match rustc_version() {
        Some(version) => version,
        None => {
            println!(
                "cargo:warning={}: unable to determine rustc version; assuming rustc 1.{}",
                env!("CARGO_PKG_NAME"),
                LATEST_STABLE.minor
            );
            LATEST_STABLE
        }
    };

    // const_fn_trait_bound stabilized in Rust 1.61.
    if version.minor < 61 {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_no_const_fn_trait_bound");
    }

    if target.starts_with("aarch64") {
        // aarch64 macos always support lse and lse2 because it is armv8.6: https://github.com/rust-lang/rust/blob/1.61.0/compiler/rustc_target/src/spec/aarch64_apple_darwin.rs#L5
        let is_aarch64_macos = target == "aarch64-apple-darwin";
        // aarch64_target_feature stabilized in Rust 1.61.
        if has_target_feature("lse", is_aarch64_macos, &version, Some(61), true) {
            println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"lse\"");
        }
        // As of rustc 1.61.0, target_feature "lse2" is not available on rustc side:
        // https://github.com/rust-lang/rust/blob/1.61.0/compiler/rustc_codegen_ssa/src/target_features.rs#L45
        if has_target_feature("lse2", is_aarch64_macos, &version, None, false) {
            println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"lse2\"");
        }
    }
    // #[cfg(target_feature = "v7")] and others don't work on stable.
    if let Some(mut arch) = target.strip_prefix("arm").or_else(|| target.strip_prefix("thumb")) {
        // armv7-unknown-linux-gnueabihf
        //    ^^
        arch = arch.split_once('-').unwrap().0;
        arch = arch.split_once('.').unwrap_or((arch, "")).0; // ignore .base/.main suffix
        arch = arch.strip_prefix("eb").unwrap_or(arch); // ignore endianness
        let mut known = true;
        // As of rustc 1.63.0-nightly (2022-05-27), there are the following "vN*" patterns:
        // $ rustc +nightly --print target-list | grep -E '^(arm|thumb)(eb)?' | sed -E 's/^(arm|thumb)(eb)?//' | sed -E 's/(\-|\.).*$//' | LC_ALL=C sort | uniq | sed -E 's/^/"/g' | sed -E 's/$/"/g'
        // ""
        // "v4t"
        // "v5te"
        // "v6"
        // "v6k"
        // "v6m"
        // "v7"
        // "v7a"
        // "v7em"
        // "v7m"
        // "v7neon"
        // "v7r"
        // "v7s"
        // "v8m"
        //
        // - v7, v7a, v7neon, and v7s are "aclass"
        // - v6m, v7em, v7m, and v8m are "mclass"
        // - v7r is "rclass"
        //
        // Other targets (we don't currently support them) don't have *class target feature.
        // For example:
        // $ rustc +nightly --print cfg --target arm-unknown-linux-gnueabi | grep target_feature
        // target_feature="llvm14-builtins-abi"
        // target_feature="v5te"
        // target_feature="v6"
        if matches!(arch, "v7" | "v7a" | "v7neon" | "v7s") {
            println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"aclass\"");
        } else if matches!(arch, "v6m" | "v7em" | "v7m" | "v8m") {
            println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"mclass\"");
        } else if matches!(arch, "v7r") {
            println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"rclass\"");
        } else {
            known = false;
            println!(
                "cargo:warning={}: unrecognized arm target: {}",
                env!("CARGO_PKG_NAME"),
                target
            );
        }
        if known {
            println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"v6\"");
            if arch.starts_with("v7") || arch.starts_with("v8") {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"v7\"");
                if arch.starts_with("v8") {
                    println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"v8\"");
                }
            }
        }
    }
    // #[cfg(target_feature = "a")] doesn't work on stable.
    if let Some(target) = target.strip_prefix("riscv") {
        // riscv64gc-unknown-linux-gnu
        //      ^^^^
        let arch = target.split_once('-').unwrap().0;
        // G = IMAFD
        if arch.contains('a') || arch.contains('g') {
            println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"a\"");
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

fn has_target_feature(
    name: &str,
    mut has_target_feature: bool,
    version: &Version,
    stabilized: Option<u32>,
    is_in_rustc: bool,
) -> bool {
    // HACK: Currently, it seems that the only way to handle unstable target
    // features on the stable is to parse the `-C target-feature` in RUSTFLAGS.
    //
    // - #[cfg(target_feature = "unstable_target_feature")] doesn't work on stable.
    // - CARGO_CFG_TARGET_FEATURE excludes unstable target features on stable.
    //
    // As mentioned in the [RFC2045], unstable target features are also passed to LLVM
    // (e.g., https://godbolt.org/z/8Eh3z5Wzb), so this hack works properly on stable.
    //
    // [RFC2045]: https://rust-lang.github.io/rfcs/2045-target-feature.html#backend-compilation-options
    if is_in_rustc
        && (version.nightly || stabilized.map_or(false, |stabilized| version.minor >= stabilized))
    {
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
                    // TODO: Handles cases where a specific target feature
                    // implicitly enables another target feature.
                    match (s.as_bytes()[0] as char, &s.as_bytes()[1..]) {
                        ('+', f) if f == name.as_bytes() => has_target_feature = true,
                        ('-', f) if f == name.as_bytes() => has_target_feature = false,
                        _ => {}
                    }
                }
            }
        }
    }
    has_target_feature
}
