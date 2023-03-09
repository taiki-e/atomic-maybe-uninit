// The rustc-cfg emitted by the build script are *not* public API.

#![warn(rust_2018_idioms, single_use_lifetimes)]

use std::{env, str};

fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    let target = &*env::var("TARGET").expect("TARGET not set");
    let target_arch = &*env::var("CARGO_CFG_TARGET_ARCH").expect("CARGO_CFG_TARGET_ARCH not set");
    let target_os = &*env::var("CARGO_CFG_TARGET_OS").expect("CARGO_CFG_TARGET_OS not set");
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
    println!("cargo:rerun-if-env-changed=CARGO_TARGET_{target_upper}_RUSTFLAGS");

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

    match target_arch {
        "x86_64" => {
            // x86_64 macos always support CMPXCHG16B: https://github.com/rust-lang/rust/blob/1.67.0/compiler/rustc_target/src/spec/x86_64_apple_darwin.rs#L8
            let has_cmpxchg16b = target_os == "macos";
            // LLVM recognizes this also as cx16 target feature: https://godbolt.org/z/o4Y8W1hcb
            // It is unlikely that rustc will support that name, so we will ignore it for now.
            target_feature_if("cmpxchg16b", has_cmpxchg16b, &version, None, true);
        }
        "x86" => {
            // i486 doesn't have cmpxchg8b.
            // i386 is additionally missing bswap, cmpxchg, and xadd.
            // See also https://reviews.llvm.org/D18802.
            let mut no_cmpxchg8b = false;
            let mut no_cmpxchg = false;
            if target_os == "ios" || target_os == "tvos" || target_os == "watchos" {
                // Apple's i386 simulator is actually i686 (yonah).
                // https://github.com/rust-lang/rust/blob/1.67.0/compiler/rustc_target/src/spec/apple_base.rs#L68
            } else if target.starts_with("i486") {
                no_cmpxchg8b = true;
            } else if target.starts_with("i386") {
                no_cmpxchg = true;
            }
            // target-cpu is preferred over arch in target triple.
            // e.g., --target=i486 --target-cpu=i386
            if let Some(cpu) = target_cpu() {
                if cpu == "i486" {
                    no_cmpxchg8b = true;
                } else if cpu == "i386" {
                    no_cmpxchg = true;
                } else {
                    // Only i386 and i486 disables cmpxchg8b.
                    // https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0/llvm/lib/Target/X86/X86.td#L1260-L1593
                    no_cmpxchg8b = false;
                    no_cmpxchg = false;
                }
            }
            if no_cmpxchg {
                no_cmpxchg8b = true;
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_cmpxchg");
            }
            // LLVM recognizes this also as cx8 target feature: https://godbolt.org/z/7qhr5TMPo
            // It is unlikely that rustc will support that name, so we will ignore it for now.
            if no_cmpxchg8b {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_cmpxchg8b");
            }
        }
        "aarch64" => {
            // aarch64 macos always support FEAT_LSE/FEAT_LSE2/FEAT_LRCPC because it is armv8.6: https://github.com/rust-lang/rust/blob/1.67.0/compiler/rustc_target/src/spec/aarch64_apple_darwin.rs#L7
            let is_macos = target_os == "macos";
            // aarch64_target_feature stabilized in Rust 1.61.
            target_feature_if("lse", is_macos, &version, Some(61), true);
            target_feature_if("rcpc", is_macos, &version, Some(61), true);
            // As of rustc 1.67, target_feature "lse2" is not available on rustc side:
            // https://github.com/rust-lang/rust/blob/1.67.0/compiler/rustc_codegen_ssa/src/target_features.rs#L47
            target_feature_if("lse2", is_macos, &version, None, false);
        }
        "arm" => {
            // #[cfg(target_feature = "v7")] and others don't work on stable.
            // armv7-unknown-linux-gnueabihf
            //    ^^
            let mut subarch =
                target.strip_prefix("arm").or_else(|| target.strip_prefix("thumb")).unwrap();
            subarch = subarch.strip_prefix("eb").unwrap_or(subarch); // ignore endianness
            let full_subarch = subarch.split_once('-').unwrap().0; // ignore vender/os/env
            subarch = full_subarch.split_once('.').unwrap_or((full_subarch, "")).0; // ignore .base/.main suffix
            let mut known = true;
            // As of rustc nightly-2023-02-05, there are the following "vN*" patterns:
            // $ rustc +nightly --print target-list | grep -E '^(arm|thumb)(eb)?' | sed -E 's/^(arm|thumb)(eb)?//; s/(\-|\.).*$//' | LC_ALL=C sort -u | sed -E 's/^/"/g; s/$/"/g'
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
            // - 64_32 is aarch64 https://github.com/rust-lang/rust/blob/1.67.0/compiler/rustc_target/src/spec/arm64_32_apple_watchos.rs#L10
            //
            // Other targets don't have *class target feature.
            // For example:
            // $ rustc +nightly --print cfg --target arm-unknown-linux-gnueabi | grep target_feature
            // target_feature="llvm14-builtins-abi"
            // target_feature="v5te"
            // target_feature="v6"
            //
            // In addition to above known sub-architectures, we also recognize armv8-{a,r}.
            // Note that there is a CPU that armv8-a but 32-bit only (Cortex-A32).
            let mut is_aclass = false;
            let mut is_mclass = false;
            let mut is_rclass = false;
            match subarch {
                "v7" | "v7a" | "v7neon" | "v7s" | "v7k" | "v8a" => is_aclass = true,
                "v6m" | "v7em" | "v7m" | "v8m" => is_mclass = true,
                "v7r" | "v8r" => is_rclass = true,
                // arm-linux-androideabi is v5te
                // https://github.com/rust-lang/rust/blob/1.67.0/compiler/rustc_target/src/spec/arm_linux_androideabi.rs#L11-L12
                _ if target == "arm-linux-androideabi" => subarch = "v5te",
                // v6 targets other than v6m don't have *class target feature.
                "" | "v6" | "v6k" => subarch = "v6",
                // Other targets don't have *class target feature.
                "v4t" | "v5te" => {}
                _ => {
                    known = false;
                    println!(
                        "cargo:warning={}: unrecognized arm subarch: {}",
                        env!("CARGO_PKG_NAME"),
                        target
                    );
                }
            }
            target_feature_if("aclass", is_aclass, &version, None, true);
            target_feature_if("mclass", is_mclass, &version, None, true);
            target_feature_if("rclass", is_rclass, &version, None, true);
            let mut v6 = known && subarch.starts_with("v6");
            let mut v7 = known && subarch.starts_with("v7");
            let (v8, v8m) = if known && subarch.starts_with("v8") {
                // ARMv8-M Mainline/Baseline are not considered as v8 by rustc.
                // https://github.com/rust-lang/stdarch/blob/a0c30f3e3c75adcd6ee7efc94014ebcead61c507/crates/core_arch/src/arm_shared/mod.rs
                if subarch.starts_with("v8m") {
                    // ARMv8-M Mainline is a superset of ARMv7-M.
                    // ARMv8-M Baseline is a superset of ARMv6-M.
                    // That said, it seems LLVM handles thumbv8m.main without v8m like v6m.
                    // https://godbolt.org/z/j9r3Wzccz
                    v7 = full_subarch == "v8m.main";
                    (false, true)
                } else {
                    (true, false)
                }
            } else {
                (false, false)
            };
            v7 |= target_feature_if("v8", v8, &version, None, true);
            v6 |= target_feature_if("v8m", v8m, &version, None, false);
            v6 |= target_feature_if("v7", v7, &version, None, true);
            target_feature_if("v6", v6, &version, None, true);
        }
        _ if target_arch.starts_with("riscv") => {
            // #[cfg(target_feature = "a")] doesn't work on stable.
            // riscv64gc-unknown-linux-gnu
            //        ^^
            let mut subarch = target.strip_prefix(target_arch).unwrap();
            subarch = subarch.split_once('-').unwrap().0;
            target_feature_if(
                "a",
                // G = IMAFD
                subarch.contains('a') || subarch.contains('g'),
                &version,
                None,
                true,
            );
        }
        "powerpc64" => {
            let target_endian =
                env::var("CARGO_CFG_TARGET_ENDIAN").expect("CARGO_CFG_TARGET_ENDIAN not set");
            // powerpc64le is pwr8+ by default https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0/llvm/lib/Target/PowerPC/PPC.td#L652
            // See also https://github.com/rust-lang/rust/issues/59932
            let mut has_pwr8_features = target_endian == "little";
            // https://github.com/llvm/llvm-project/commit/549e118e93c666914a1045fde38a2cac33e1e445
            if let Some(cpu) = target_cpu().as_deref() {
                if let Some(mut cpu_version) = cpu.strip_prefix("pwr") {
                    cpu_version = cpu_version.strip_suffix('x').unwrap_or(cpu_version); // for pwr5x and pwr6x
                    if let Ok(cpu_version) = cpu_version.parse::<u32>() {
                        has_pwr8_features = cpu_version >= 8;
                    }
                } else {
                    // https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0/llvm/lib/Target/PowerPC/PPC.td#L652
                    // https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0/llvm/lib/Target/PowerPC/PPC.td#L434-L436
                    has_pwr8_features = cpu == "ppc64le" || cpu == "future";
                }
            }
            // Note: As of rustc 1.67, target_feature "partword-atomics"/"quadword-atomics" is not available on rustc side:
            // https://github.com/rust-lang/rust/blob/1.67.0/compiler/rustc_codegen_ssa/src/target_features.rs#L215
            // l[bh]arx and st[bh]cx.
            target_feature_if("partword-atomics", has_pwr8_features, &version, None, false);
            // lqarx and stqcx.
            target_feature_if("quadword-atomics", has_pwr8_features, &version, None, false);
        }
        _ => {}
    }
}

fn target_feature_if(
    name: &str,
    mut has_target_feature: bool,
    version: &Version,
    stabilized: Option<u32>,
    is_rustc_target_feature: bool,
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
    if is_rustc_target_feature
        && (version.nightly || stabilized.map_or(false, |stabilized| version.minor >= stabilized))
    {
        // In this case, cfg(target_feature = "...") would work, so skip emitting our own target_feature cfg.
        return false;
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
    if has_target_feature {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"{name}\"");
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
        // The known latest stable version. If we unable to determine
        // the rustc version, we assume this is the current version.
        // It is no problem if this is older than the actual latest stable.
        pub(crate) const LATEST: Self = Self::stable(68);

        const fn stable(minor: u32) -> Self {
            Self { minor, nightly: false, commit_date: Date::new(0, 0, 0) }
        }

        pub(crate) fn probe(&self, minor: u32, year: u16, month: u8, day: u8) -> bool {
            if self.nightly {
                self.minor > minor || self.commit_date >= Date::new(year, month, day)
            } else {
                self.minor >= minor
            }
        }
    }

    #[derive(PartialEq, PartialOrd)]
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
        let output = Command::new(rustc).args(["--version", "--verbose"]).output().ok()?;
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
