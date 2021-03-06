// The rustc-cfg emitted by the build script are *not* public API.

#![warn(rust_2018_idioms, single_use_lifetimes)]

use std::{env, str};

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
    let target_arch = match env::var("CARGO_CFG_TARGET_ARCH") {
        Ok(target_arch) => target_arch,
        Err(e) => {
            println!(
                "cargo:warning={}: unable to get CARGO_CFG_TARGET_ARCH environment variable: {}",
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
    // as of 1.62.0-nightly, specifying it as rerun-if-env-changed does not work.
    println!("cargo:rerun-if-env-changed=CARGO_ENCODED_RUSTFLAGS");
    println!("cargo:rerun-if-env-changed=RUSTFLAGS");
    println!("cargo:rerun-if-env-changed=CARGO_BUILD_RUSTFLAGS");
    let mut target_upper = target.replace(['-', '.'], "_");
    target_upper.make_ascii_uppercase();
    println!("cargo:rerun-if-env-changed=CARGO_TARGET_{}_RUSTFLAGS", target_upper);

    let version = match rustc_version() {
        Some(version) => version,
        None => {
            println!(
                "cargo:warning={}: unable to determine rustc version; assuming latest stable rustc (1.{})",
                env!("CARGO_PKG_NAME"),
                Version::LATEST.minor
            );
            Version::LATEST
        }
    };

    // Note that this is `no_`*, not `has_*`. This allows treating as the latest
    // stable rustc is used when the build script doesn't run. This is useful
    // for non-cargo build systems that don't run the build script.
    // const_fn_trait_bound stabilized in Rust 1.61 (nightly-2022-03-08): https://github.com/rust-lang/rust/pull/93827
    if !version.probe(61, 2022, 3, 7) {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_no_const_fn_trait_bound");
    }

    match &*target_arch {
        "x86_64" => {
            // x86_64 macos always support cmpxchg16b: https://github.com/rust-lang/rust/blob/1.62.0/compiler/rustc_target/src/spec/x86_64_apple_darwin.rs#L7
            let is_x86_64_macos = target == "x86_64-apple-darwin";
            if has_target_feature("cmpxchg16b", is_x86_64_macos, &version, None, true) {
                target_feature("cmpxchg16b");
            }
        }
        "x86" => {
            // i486 doesn't have cmpxchg8b.
            // i386 is additionally missing bswap, cmpxchg, and xadd.
            // See also https://reviews.llvm.org/D18802.
            let mut no_cmpxchg8b = false;
            let mut no_cmpxchg = false;
            if target.starts_with("i486") {
                no_cmpxchg8b = true;
            } else if target.starts_with("i386") {
                if target.contains("-ios")
                    || target.contains("-tvos")
                    || target.contains("-watchos")
                {
                    // Apple's i386 simulator is actually i686.
                    // https://github.com/rust-lang/rust/blob/1.62.0/compiler/rustc_target/src/spec/apple_sdk_base.rs#L31
                } else {
                    no_cmpxchg = true;
                }
            }
            // target-cpu is preferred over arch in target triple.
            // e.g., --target=i486 --target-cpu=i386
            if let Some(cpu) = target_cpu() {
                if cpu == "i486" {
                    no_cmpxchg8b = true;
                } else if cpu == "i386" {
                    no_cmpxchg = true;
                }
            }
            if no_cmpxchg {
                no_cmpxchg8b = true;
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_cmpxchg");
            }
            if no_cmpxchg8b {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_cmpxchg8b");
            }
        }
        "aarch64" => {
            // aarch64 macos always support lse and lse2 because it is armv8.6: https://github.com/rust-lang/rust/blob/1.62.0/compiler/rustc_target/src/spec/aarch64_apple_darwin.rs#L5
            let is_aarch64_macos = target == "aarch64-apple-darwin";
            // aarch64_target_feature stabilized in Rust 1.61.
            if has_target_feature("lse", is_aarch64_macos, &version, Some(61), true) {
                target_feature("lse");
            }
            // As of rustc 1.62.0, target_feature "lse2" is not available on rustc side:
            // https://github.com/rust-lang/rust/blob/1.62.0/compiler/rustc_codegen_ssa/src/target_features.rs#L45
            if has_target_feature("lse2", is_aarch64_macos, &version, None, false) {
                target_feature("lse2");
            }
        }
        "arm" => {
            // #[cfg(target_feature = "v7")] and others don't work on stable.
            // armv7-unknown-linux-gnueabihf
            //    ^^
            let mut arch =
                target.strip_prefix("arm").or_else(|| target.strip_prefix("thumb")).unwrap();
            arch = arch.split_once('-').unwrap().0;
            arch = arch.split_once('.').unwrap_or((arch, "")).0; // ignore .base/.main suffix
            arch = arch.strip_prefix("eb").unwrap_or(arch); // ignore endianness
            let mut known = true;
            // As of rustc nightly-2022-07-09, there are the following "vN*" patterns:
            // $ rustc +nightly --print target-list | grep -E '^(arm|thumb)(eb)?' | sed -E 's/^(arm|thumb)(eb)?//' | sed -E 's/(\-|\.).*$//' | LC_ALL=C sort | uniq | sed -E 's/^/"/g' | sed -E 's/$/"/g'
            // ""
            // "64_32"
            // "v4t"
            // "v5te"
            // "v6"
            // "v6k"
            // "v6m"
            // "v7"
            // "v7a"
            // "v7em"
            // "v7k"
            // "v7m"
            // "v7neon"
            // "v7r"
            // "v7s"
            // "v8m"
            //
            // - v7, v7a, v7neon, v7s, and v7k are "aclass"
            // - v6m, v7em, v7m, and v8m are "mclass"
            // - v7r is "rclass"
            // - 64_32 is aarch64 https://github.com/rust-lang/rust/blob/1aabd8a4a6e1871f14e804302bd60dfcbffd5761/compiler/rustc_target/src/spec/arm64_32_apple_watchos.rs#L10
            //
            // Other targets don't have *class target feature.
            // For example:
            // $ rustc +nightly --print cfg --target arm-unknown-linux-gnueabi | grep target_feature
            // target_feature="llvm14-builtins-abi"
            // target_feature="v5te"
            // target_feature="v6"
            match arch {
                "v7" | "v7a" | "v7neon" | "v7s" | "v7k" => target_feature("aclass"),
                "v6m" | "v7em" | "v7m" | "v8m" => target_feature("mclass"),
                "v7r" => target_feature("rclass"),
                // arm-linux-androideabi is v5te
                // https://github.com/rust-lang/rust/blob/1.62.0/compiler/rustc_target/src/spec/arm_linux_androideabi.rs#L11-L12
                _ if target == "arm-linux-androideabi" => arch = "v5te",
                // v6 targets other than v6m don't have *class target feature.
                "" | "v6" | "v6k" => arch = "v6",
                // Other targets don't have *class target feature.
                "v4t" | "v5te" => {}
                _ => {
                    known = false;
                    println!(
                        "cargo:warning={}: unrecognized arm target: {}",
                        env!("CARGO_PKG_NAME"),
                        target
                    );
                }
            }
            if known {
                let v6 = arch.starts_with("v6");
                let v7 = arch.starts_with("v7");
                let v8 = arch.starts_with("v8");
                if v6 || v7 || v8 {
                    target_feature("v6");
                    if v7 || v8 {
                        target_feature("v7");
                        if v8 {
                            target_feature("v8");
                        }
                    }
                }
            }
        }
        "riscv32" | "riscv64" => {
            let arch = target.strip_prefix("riscv").unwrap();
            // #[cfg(target_feature = "a")] doesn't work on stable.
            // riscv64gc-unknown-linux-gnu
            //      ^^^^
            let arch = arch.split_once('-').unwrap().0;
            // G = IMAFD
            if arch.contains('a') || arch.contains('g') {
                target_feature("a");
            }
        }
        "powerpc64" => {
            if target.starts_with("powerpc64-") {
                // Only check powerpc64 (be) -- powerpc64le is pwr8+ https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/Target/PowerPC/PPC.td#L652
                if let Some(cpu) = target_cpu().as_deref() {
                    // https://github.com/llvm/llvm-project/commit/549e118e93c666914a1045fde38a2cac33e1e445
                    if matches!(cpu, "pwr8" | "pwr9" | "pwr10") {
                        target_feature("partword-atomics"); // l[bh]arx and st[bh]cx.
                        target_feature("quadword-atomics"); // lqarx and stqcx.
                    }
                }
            }
        }
        _ => {}
    }
}

fn target_feature(name: &str) {
    println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"{}\"", name);
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
            flag = flag.strip_prefix("-C").unwrap_or(flag);
            if let Some(flag) = flag.strip_prefix("target-feature=") {
                for s in flag.split(',') {
                    // TODO: Handles cases where a specific target feature
                    // implicitly enables another target feature.
                    match (s.as_bytes().first(), s.as_bytes().get(1..)) {
                        (Some(b'+'), Some(f)) if f == name.as_bytes() => has_target_feature = true,
                        (Some(b'-'), Some(f)) if f == name.as_bytes() => has_target_feature = false,
                        _ => {}
                    }
                }
            }
        }
    }
    has_target_feature
}

fn target_cpu() -> Option<String> {
    let rustflags = env::var_os("CARGO_ENCODED_RUSTFLAGS")?;
    let rustflags = rustflags.to_string_lossy();
    let mut cpu = None;
    for mut flag in rustflags.split('\x1f') {
        flag = flag.strip_prefix("-C").unwrap_or(flag);
        if let Some(flag) = flag.strip_prefix("target-cpu=") {
            cpu = Some(flag);
        }
    }
    cpu.map(str::to_owned)
}

mod version {
    use std::{env, process::Command, str};

    pub(crate) struct Version {
        pub(crate) minor: u32,
        pub(crate) nightly: bool,
        commit_date: Date,
    }

    impl Version {
        pub(crate) const LATEST: Self = Self::stable(62);

        const fn stable(minor: u32) -> Self {
            Self { minor, nightly: false, commit_date: Date::new(0, 0, 0) }
        }

        pub(crate) fn probe(&self, minor: u32, year: u16, month: u8, day: u8) -> bool {
            self.minor >= minor
                && (!self.nightly || self.commit_date >= Date::new(year, month, day))
        }
    }

    #[derive(PartialEq, Eq, PartialOrd, Ord)]
    struct Date {
        year: u16,
        month: u8,
        day: u8,
    }

    impl Date {
        const fn new(year: u16, month: u8, day: u8) -> Self {
            Self { year, month, day }
        }
    }

    pub(crate) fn rustc_version() -> Option<Version> {
        let rustc = env::var_os("RUSTC")?;
        // Use verbose version output because the packagers add extra strings to the normal version output.
        let output = Command::new(rustc).args(&["--version", "--verbose"]).output().ok()?;
        let output = str::from_utf8(&output.stdout).ok()?;

        let mut release =
            output.lines().find_map(|line| line.strip_prefix("release: "))?.splitn(2, '-');
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

        if nightly {
            let mut commit_date =
                output.lines().find_map(|line| line.strip_prefix("commit-date: "))?.splitn(3, '-');
            let year = commit_date.next()?.parse::<u16>().ok()?;
            let month = commit_date.next()?.parse::<u8>().ok()?;
            let day = commit_date.next()?.parse::<u8>().ok()?;
            if month > 12 || day > 31 {
                return None;
            }
            Some(Version { minor, nightly, commit_date: Date::new(year, month, day) })
        } else {
            Some(Version::stable(minor))
        }
    }
}
use version::{rustc_version, Version};
