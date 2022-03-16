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
    // #[cfg(target_feature = "v7")] doesn't work on stable.
    if let Some(mut arch) = target.strip_prefix("arm").or_else(|| target.strip_prefix("thumb")) {
        // armv7-unknown-linux-gnueabihf
        //    ^^
        //
        // As of rustc 1.61.0-nightly (2022-03-13), all v7+ targets are:
        // $ rustc --print target-list | grep -E '^(arm(eb)?|thumb)(v7|v8|v9)'
        // armebv7r-none-eabi
        // armebv7r-none-eabihf
        // armv7-apple-ios
        // armv7-linux-androideabi
        // armv7-unknown-freebsd
        // armv7-unknown-linux-gnueabi
        // armv7-unknown-linux-gnueabihf
        // armv7-unknown-linux-musleabi
        // armv7-unknown-linux-musleabihf
        // armv7-unknown-linux-uclibceabi
        // armv7-unknown-linux-uclibceabihf
        // armv7-unknown-netbsd-eabihf
        // armv7-wrs-vxworks-eabihf
        // armv7a-kmc-solid_asp3-eabi
        // armv7a-kmc-solid_asp3-eabihf
        // armv7a-none-eabi
        // armv7a-none-eabihf
        // armv7r-none-eabi
        // armv7r-none-eabihf
        // armv7s-apple-ios
        // thumbv7a-pc-windows-msvc
        // thumbv7a-uwp-windows-msvc
        // thumbv7em-none-eabi
        // thumbv7em-none-eabihf
        // thumbv7m-none-eabi
        // thumbv7neon-linux-androideabi
        // thumbv7neon-unknown-linux-gnueabihf
        // thumbv7neon-unknown-linux-musleabihf
        // thumbv8m.base-none-eabi
        // thumbv8m.main-none-eabi
        // thumbv8m.main-none-eabihf
        //
        // So, there is the following "vN*" patterns in v7+:
        // $ rustc --print target-list | grep -E '^(arm(eb)?|thumb)(v7|v8|v9)' | sed -E 's/^(arm(eb)?|thumb)//' | sed -E 's/(\-|\.).*$//' | LC_ALL=C sort | uniq
        // v7
        // v7a
        // v7em
        // v7m
        // v7neon
        // v7r
        // v7s
        // v8m
        //
        // - v7, v7a, v7neon, and v7s are "aclass"
        // - v7em, v7m, and v8m are "mclass"
        // - v7r is "rclass"
        arch = arch.split_once('-').unwrap().0;
        arch = arch.split_once('.').unwrap_or((arch, "")).0; // ignore .base/.main suffix
        arch = arch.strip_prefix("eb").unwrap_or(arch); // ignore endianness
        if arch.starts_with("v7") || arch.starts_with("v8") {
            let mut known = true;
            if matches!(arch, "v7" | "v7a" | "v7neon" | "v7s") {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature_aclass");
            } else if matches!(arch, "v7em" | "v7m" | "v8m") {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature_mclass");
            } else if matches!(arch, "v7r") {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature_rclass");
            } else {
                known = false;
                println!(
                    "cargo:warning={}: unrecognized arm arch: {}",
                    env!("CARGO_PKG_NAME"),
                    arch
                );
            }
            if known {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature_v7");
                if arch.starts_with("v8") {
                    println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature_v8");
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
