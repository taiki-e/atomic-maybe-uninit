// The rustc-cfg emitted by the build script are *not* public API.

#![warn(rust_2018_idioms, single_use_lifetimes)]

use std::{env, process::Command, str};

// rustc +stable -Vv | grep -E '^(commit-date|release)'
const LATEST_STABLE: Version = Version { minor: 59 };

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

    let version = match rustc_version() {
        Some(version) => version,
        None => {
            println!("cargo:warning={}: unable to determine rustc version", env!("CARGO_PKG_NAME"));
            LATEST_STABLE
        }
    };

    if version.minor >= 61 {
        // TODO: invert cfg once Rust 1.61 became stable.
        println!("cargo:rustc-cfg=const_fn_trait_bound");
    }

    // #[cfg(not(target_feature = "a"))] doesn't work on stable.
    if let Some(target) = target.strip_prefix("riscv") {
        // riscv64gc-unknown-linux-gnu
        //      ^^^^
        let arch = target.split_once('-').unwrap().0;
        // G = IMAFD
        if arch.contains('a') || arch.contains('g') {
            println!("cargo:rustc-cfg=target_feature_a");
        }
    }
}

struct Version {
    minor: u32,
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
    let _channel = release.next().unwrap_or_default();
    let mut digits = version.splitn(3, '.');
    let major = digits.next()?.parse::<u32>().ok()?;
    if major != 1 {
        return None;
    }
    let minor = digits.next()?.parse::<u32>().ok()?;
    let _patch = digits.next().unwrap_or("0").parse::<u32>().ok()?;

    Some(Version { minor })
}
