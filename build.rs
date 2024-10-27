// SPDX-License-Identifier: Apache-2.0 OR MIT

// The rustc-cfg emitted by the build script are *not* public API.

#![allow(clippy::match_same_arms)] // https://github.com/rust-lang/rust-clippy/issues/12044

use std::{env, str};

fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    let target = &*env::var("TARGET").expect("TARGET not set");
    let target_arch = &*env::var("CARGO_CFG_TARGET_ARCH").expect("CARGO_CFG_TARGET_ARCH not set");
    let target_os = &*env::var("CARGO_CFG_TARGET_OS").expect("CARGO_CFG_TARGET_OS not set");

    let version = match rustc_version() {
        Some(version) => version,
        None => {
            if env::var_os("ATOMIC_MAYBE_UNINIT_DENY_WARNINGS").is_some() {
                panic!("unable to determine rustc version")
            }
            println!(
                "cargo:warning={}: unable to determine rustc version; assuming latest stable rustc (1.{})",
                env!("CARGO_PKG_NAME"),
                Version::LATEST.minor
            );
            Version::LATEST
        }
    };

    if version.minor >= 80 {
        println!(
            r#"cargo:rustc-check-cfg=cfg(target_feature,values("x87","v8m","fast-serialization"))"#
        );

        // Custom cfgs set by build script. Not public API.
        // grep -F 'cargo:rustc-cfg=' build.rs | grep -Ev '^ *//' | sed -E 's/^.*cargo:rustc-cfg=//; s/(=\\)?".*$//' | LC_ALL=C sort -u | tr '\n' ',' | sed -E 's/,$/\n/'
        println!(
            "cargo:rustc-check-cfg=cfg(atomic_maybe_uninit_no_asm_maybe_uninit,atomic_maybe_uninit_no_const_fn_trait_bound,atomic_maybe_uninit_no_const_mut_refs,atomic_maybe_uninit_no_loongarch64_asm,atomic_maybe_uninit_s390x_no_reg_addr,atomic_maybe_uninit_target_feature,atomic_maybe_uninit_unstable_asm_experimental_arch,portable_atomic_pre_llvm_20)"
        );
        // TODO: handle multi-line target_feature_fallback
        // grep -F 'target_feature_fallback("' build.rs | grep -Ev '^ *//' | sed -E 's/^.*target_feature_fallback\(//; s/",.*$/"/' | LC_ALL=C sort -u | tr '\n' ',' | sed -E 's/,$/\n/'
        println!(
            r#"cargo:rustc-check-cfg=cfg(atomic_maybe_uninit_target_feature,values("a","cmpxchg16b","fast-serialization","lse","lse128","lse2","mclass","partword-atomics","quadword-atomics","rcpc","rcpc3","v5te","v6","v7","v8","v8m","x87","zaamo","zabha"))"#
        );
    }

    // https://github.com/rust-lang/rust/pull/123745 (includes https://github.com/rust-lang/cargo/pull/13560) merged in Rust 1.79 (nightly-2024-04-11).
    if !version.probe(79, 2024, 4, 10) {
        // HACK: If --target is specified, rustflags is not applied to the build
        // script itself, so the build script will not be recompiled when rustflags
        // is changed. That in itself is not a problem, but the old Cargo does
        // not rerun the build script as well, which can be problematic.
        // https://github.com/rust-lang/cargo/issues/13003
        // This problem has been fixed in 1.79 so only older versions need a workaround.
        println!("cargo:rerun-if-env-changed=CARGO_ENCODED_RUSTFLAGS");
        println!("cargo:rerun-if-env-changed=RUSTFLAGS");
        println!("cargo:rerun-if-env-changed=CARGO_BUILD_RUSTFLAGS");
        let mut target_upper = target.replace(['-', '.'], "_");
        target_upper.make_ascii_uppercase();
        println!("cargo:rerun-if-env-changed=CARGO_TARGET_{target_upper}_RUSTFLAGS");
    }

    // Note that cfgs are `no_`*, not `has_*`. This allows treating as the latest
    // stable rustc is used when the build script doesn't run. This is useful
    // for non-cargo build systems that don't run the build script.

    // const_fn_trait_bound stabilized in Rust 1.61 (nightly-2022-03-08): https://github.com/rust-lang/rust/pull/93827
    if !version.probe(61, 2022, 3, 7) {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_no_const_fn_trait_bound");
    }
    // https://github.com/rust-lang/rust/pull/114790 merged in nightly-2023-08-24
    if !version.probe(74, 2023, 8, 23) {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_no_asm_maybe_uninit");
    }
    // const_mut_refs/const_refs_to_cell stabilized in Rust 1.83 (nightly-2024-09-16): https://github.com/rust-lang/rust/pull/129195
    if !version.probe(83, 2024, 9, 15) {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_no_const_mut_refs");
    }

    if version.llvm < 20 {
        println!("cargo:rustc-cfg=portable_atomic_pre_llvm_20");
    }

    match target_arch {
        "loongarch64" => {
            if version.minor < 72 {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_loongarch64_asm");
            }
        }
        "arm64ec" | "avr" | "hexagon" | "mips" | "mips32r6" | "mips64" | "mips64r6" | "msp430"
        | "powerpc" | "powerpc64" | "xtensa" => {
            if version.nightly && is_allowed_feature("asm_experimental_arch") {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_unstable_asm_experimental_arch");
            }
        }
        // https://github.com/rust-lang/rust/pull/111331 merged in Rust 1.71 (nightly-2023-05-09).
        "s390x" => {
            if version.nightly
                && version.probe(71, 2023, 5, 8)
                && is_allowed_feature("asm_experimental_arch")
            {
                // https://github.com/rust-lang/rust/pull/119431 merged in Rust 1.77 (nightly-2024-01-05).
                if !version.probe(77, 2024, 1, 4) {
                    println!("cargo:rustc-cfg=atomic_maybe_uninit_s390x_no_reg_addr");
                }
                println!("cargo:rustc-cfg=atomic_maybe_uninit_unstable_asm_experimental_arch");
            }
        }
        _ => {}
    }

    match target_arch {
        "x86" => {
            // i586 is -C target-feature=+x87 by default, but cfg(target_feature = "x87") doesn't work.
            // And core assumes x87 is always available.
            // https://github.com/rust-lang/rust/blob/1.80.0/library/core/src/num/dec2flt/fpu.rs#L6
            // https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_target/src/spec/targets/i686_unknown_uefi.rs#L24
            // However, custom bare metal targets tend to disable x87 and do not use floats.
            let has_x87 = target_os != "none";
            target_feature_fallback("x87", has_x87);
        }
        "x86_64" => {
            // cmpxchg16b_target_feature stabilized in Rust 1.69.
            if needs_target_feature_fallback(&version, Some(69)) {
                // x86_64 Apple targets always support CMPXCHG16B:
                // https://github.com/rust-lang/rust/blob/1.68.0/compiler/rustc_target/src/spec/x86_64_apple_darwin.rs#L8
                // https://github.com/rust-lang/rust/blob/1.68.0/compiler/rustc_target/src/spec/apple_base.rs#L69-L70
                // (Since Rust 1.78, Windows (except Windows 7) targets also enable CMPXCHG16B, but
                // this branch is only used on pre-1.69 that cmpxchg16b_target_feature is unstable.)
                // Script to get builtin targets that support CMPXCHG16B by default:
                // $ (for target in $(rustc --print target-list | grep -E '^x86_64'); do rustc --print cfg --target "${target}" | grep -Fq '"cmpxchg16b"' && printf '%s\n' "${target}"; done)
                let is_apple = env::var("CARGO_CFG_TARGET_VENDOR").unwrap_or_default() == "apple";
                let has_cmpxchg16b = is_apple;
                // LLVM recognizes this also as cx16 target feature: https://godbolt.org/z/KM3jz616j
                // However, it is unlikely that rustc will support that name, so we ignore it.
                target_feature_fallback("cmpxchg16b", has_cmpxchg16b);
            }
        }
        "aarch64" | "arm64ec" => {
            // target_feature "lse2"/"lse128"/"rcpc3" is unstable and available on rustc side since nightly-2024-08-30: https://github.com/rust-lang/rust/pull/128192
            if !version.probe(82, 2024, 8, 29) || needs_target_feature_fallback(&version, None) {
                // FEAT_LSE2 doesn't imply FEAT_LSE. FEAT_LSE128 implies FEAT_LSE but not FEAT_LSE2. FEAT_LRCPC3 implies FEAT_LRCPC.
                // AArch64 macOS always supports FEAT_LSE/FEAT_LSE2/FEAT_LRCPC because M1 is Armv8.4 with all features of Armv8.5 except FEAT_BTI:
                // https://github.com/llvm/llvm-project/blob/llvmorg-19.1.0/llvm/lib/Target/AArch64/AArch64Processors.td#L1203
                // https://github.com/llvm/llvm-project/blob/llvmorg-19.1.0/llvm/lib/Target/AArch64/AArch64Processors.td#L865
                // Script to get builtin targets that support FEAT_LSE/FEAT_LSE2/FEAT_LRCPC by default:
                // $ (for target in $(rustc --print target-list | grep -E '^aarch64|^arm64'); do rustc --print cfg --target "${target}" | grep -Fq '"lse"' && printf '%s\n' "${target}"; done)
                // $ (for target in $(rustc --print target-list | grep -E '^aarch64|^arm64'); do rustc --print cfg --target "${target}" | grep -Fq '"lse2"' && printf '%s\n' "${target}"; done)
                // $ (for target in $(rustc --print target-list | grep -E '^aarch64|^arm64'); do rustc --print cfg --target "${target}" | grep -Fq '"rcpc"' && printf '%s\n' "${target}"; done)
                let is_macos = target_os == "macos";
                let mut has_lse = is_macos;
                let mut has_rcpc = is_macos;
                target_feature_fallback("lse2", is_macos);
                // LLVM supports FEAT_LRCPC3 and FEAT_LSE128 on LLVM 16+:
                // https://github.com/llvm/llvm-project/commit/a6aaa969f7caec58a994142f8d855861cf3a1463
                // https://github.com/llvm/llvm-project/commit/7fea6f2e0e606e5339c3359568f680eaf64aa306
                has_lse |= target_feature_fallback("lse128", false);
                has_rcpc |= target_feature_fallback("rcpc3", false);
                // aarch64_target_feature stabilized in Rust 1.61.
                if needs_target_feature_fallback(&version, Some(61)) {
                    target_feature_fallback("lse", has_lse);
                    target_feature_fallback("rcpc", has_rcpc);
                }
            }
        }
        "arm" => {
            // #[cfg(target_feature = "v7")] and others don't work on stable.
            // armv7-unknown-linux-gnueabihf
            //    ^^
            let mut subarch =
                target.strip_prefix("arm").or_else(|| target.strip_prefix("thumb")).unwrap();
            subarch = subarch.strip_prefix("eb").unwrap_or(subarch); // ignore endianness
            subarch = subarch.split_once('-').unwrap().0; // ignore vender/os/env
            subarch = subarch.split_once('.').unwrap_or((subarch, "")).0; // ignore .base/.main suffix
            let mut known = true;
            // As of rustc nightly-2024-05-04, there are the following "vN*" patterns:
            // $ rustc +nightly --print target-list | grep -E '^(arm|thumb)(eb)?' | sed -E 's/^(arm|thumb)(eb)?//; s/(\-|\.).*$//' | LC_ALL=C sort -u | sed -E 's/^/"/g; s/$/"/g'
            // ""
            // "64_32"
            // "64e"
            // "64ec"
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
            // "v8r"
            //
            // - v7, v7a, v7neon, v7s, and v7k are aclass
            // - v6m, v7em, v7m, and v8m are mclass
            // - v7r and v8r are rclass
            // - 64_32 and 64e are aarch64
            // - 64ec is arm64ec
            //
            // Legacy Arm architectures (pre-v7 except v6m) don't have *class target feature.
            // For example:
            // $ rustc +nightly --print cfg --target arm-unknown-linux-gnueabi | grep -F target_feature
            // target_feature="v5te"
            // target_feature="v6"
            //
            // In addition to above known sub-architectures, we also recognize armv{8,9}-{a,r}.
            // Note that there is a CPU that Armv8-A but 32-bit only (Cortex-A32).
            let mut mclass = false;
            match subarch {
                "v7" | "v7a" | "v7neon" | "v7s" | "v7k" | "v8" | "v8a" | "v9" | "v9a" => {} // aclass
                "v7r" | "v8r" | "v9r" => {} // rclass
                "v6m" | "v7em" | "v7m" | "v8m" => mclass = true,
                // arm-linux-androideabi is v5te
                // https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_target/src/spec/targets/arm_linux_androideabi.rs#L18
                _ if target == "arm-linux-androideabi" => subarch = "v5te",
                // armeb-unknown-linux-gnueabi is v8 & aclass
                // https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_target/src/spec/targets/armeb_unknown_linux_gnueabi.rs#L18
                _ if target == "armeb-unknown-linux-gnueabi" => subarch = "v8",
                // Legacy Arm architectures (pre-v7 except v6m) don't have *class target feature.
                "" => subarch = "v6",
                "v4t" | "v5te" | "v6" | "v6k" => {}
                _ => {
                    known = false;
                    if env::var_os("ATOMIC_MAYBE_UNINIT_DENY_WARNINGS").is_some() {
                        panic!("unrecognized Arm subarch: {target}")
                    }
                    println!(
                        "cargo:warning={}: unrecognized Arm subarch: {target}",
                        env!("CARGO_PKG_NAME")
                    );
                }
            }
            let mut v5te = known && subarch.starts_with("v5te");
            let mut v6 = known && subarch.starts_with("v6");
            let mut v7 = known && subarch.starts_with("v7");
            let (v8, v8m) = if known && (subarch.starts_with("v8") || subarch.starts_with("v9")) {
                // Armv8-M is not considered as v8 by LLVM.
                // https://github.com/rust-lang/stdarch/blob/a0c30f3e3c75adcd6ee7efc94014ebcead61c507/crates/core_arch/src/arm_shared/mod.rs
                if subarch.contains('m') {
                    // Armv8-M Mainline is a superset of Armv7-M.
                    // Armv8-M Baseline is a superset of Armv6-M.
                    // That said, LLVM handles thumbv8m.main without v8m like v6m, not v7m: https://godbolt.org/z/Ph96v9zae
                    // TODO: Armv9-M has not yet been released,
                    // so it is not clear how it will be handled here.
                    (false, true)
                } else {
                    (true, false)
                }
            } else {
                (false, false)
            };
            // As of rustc 1.80, target_feature "v8m" is not available on rustc side:
            // https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_target/src/target_features.rs#L54
            v6 |= target_feature_fallback("v8m", v8m);
            if needs_target_feature_fallback(&version, None) {
                v7 |= target_feature_fallback("v8", v8);
                v6 |= target_feature_fallback("v7", v7);
                v5te |= target_feature_fallback("v6", v6);
                target_feature_fallback("v5te", v5te);
                target_feature_fallback("mclass", mclass);
            }
        }
        "riscv32" | "riscv64" => {
            // zabha and zacas imply zaamo in GCC and Rust, but do not in LLVM (but enabling them
            // without zaamo or a is not allowed, so we can assume zaamo is available when zabha is enabled).
            // https://github.com/llvm/llvm-project/blob/llvmorg-19.1.0/llvm/lib/TargetParser/RISCVISAInfo.cpp#L772-L778
            // https://github.com/gcc-mirror/gcc/blob/08693e29ec186fd7941d0b73d4d466388971fe2f/gcc/config/riscv/arch-canonicalize#L45-L46
            // https://github.com/rust-lang/rust/pull/130877
            let mut has_zaamo = false;
            // target_feature "zaamo"/"zabha" is unstable and available on rustc side since nightly-2024-10-02: https://github.com/rust-lang/rust/pull/130877
            if (!version.probe(83, 2024, 10, 1) || needs_target_feature_fallback(&version, None))
                && version.llvm >= 19
            {
                // amo*.{b,h}
                // available since LLVM 19 https://github.com/llvm/llvm-project/commit/89f87c387627150d342722b79c78cea2311cddf7 / https://github.com/llvm/llvm-project/commit/6b7444964a8d028989beee554a1f5c61d16a1cac
                has_zaamo |= target_feature_fallback("zabha", false);
                // amo*.{w,d}
                // available since LLVM 19 https://github.com/llvm/llvm-project/commit/1a14c446dd800b1d79fed1735c48e392d06e495d / https://github.com/llvm/llvm-project/commit/8be079cdddfd628d356d9ddb5ab397ea95fb1030
                target_feature_fallback("zaamo", has_zaamo);
            }
            // Ratified RISC-V target features stabilized in Rust 1.75. https://github.com/rust-lang/rust/pull/116485
            if needs_target_feature_fallback(&version, Some(75)) {
                // riscv64gc-unknown-linux-gnu
                //        ^^
                let mut subarch = target.strip_prefix(target_arch).unwrap();
                subarch = subarch.split_once('-').unwrap().0;
                subarch = subarch.split_once(['z', 'Z']).unwrap_or((subarch, "")).0;
                // riscv64-linux-android is riscv64gc
                // https://github.com/rust-lang/rust/blob/1.74.0/compiler/rustc_target/src/spec/riscv64_linux_android.rs#L12
                // riscv32-wrs-vxworks and riscv64-wrs-vxworks are also riscv*gc,
                // but only available on Rust 1.83+ where "a" target_feature is stable.
                // https://github.com/rust-lang/rust/pull/130549
                if target == "riscv64-linux-android" {
                    subarch = "gc";
                }
                // G = IMAFD
                let a = subarch.contains('a') || subarch.contains('g');
                target_feature_fallback("a", a);
            }
        }
        "powerpc64" => {
            // target_feature "quadword-atomics" is unstable and available on rustc side since nightly-2024-09-28: https://github.com/rust-lang/rust/pull/130873
            if !version.probe(83, 2024, 9, 27) || needs_target_feature_fallback(&version, None) {
                let target_endian =
                    env::var("CARGO_CFG_TARGET_ENDIAN").expect("CARGO_CFG_TARGET_ENDIAN not set");
                // powerpc64le is pwr8+ by default https://github.com/llvm/llvm-project/blob/llvmorg-19.1.0/llvm/lib/Target/PowerPC/PPC.td#L702
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
                        // https://github.com/llvm/llvm-project/blob/llvmorg-19.1.0/llvm/lib/Target/PowerPC/PPC.td#L702
                        // https://github.com/llvm/llvm-project/blob/llvmorg-19.1.0/llvm/lib/Target/PowerPC/PPC.td#L483
                        // On the minimum external LLVM version of the oldest rustc version which we can use asm_experimental_arch
                        // on this target (see CI config for more), "future" is based on pwr10 features.
                        // https://github.com/llvm/llvm-project/blob/llvmorg-12.0.0/llvm/lib/Target/PowerPC/PPC.td#L370
                        has_pwr8_features = cpu == "ppc64le" || cpu == "future";
                    }
                }
                // l[bh]arx and st[bh]cx.
                target_feature_fallback("partword-atomics", has_pwr8_features);
                // lqarx and stqcx.
                target_feature_fallback("quadword-atomics", has_pwr8_features);
            }
        }
        "s390x" => {
            // https://github.com/llvm/llvm-project/blob/llvmorg-19.1.0/llvm/lib/Target/SystemZ/SystemZFeatures.td
            let mut arch9_features = false; // z196+
            if let Some(cpu) = target_cpu() {
                // LLVM and GCC recognize the same names:
                // https://github.com/llvm/llvm-project/blob/llvmorg-19.1.0/llvm/lib/Target/SystemZ/SystemZProcessors.td
                // https://github.com/gcc-mirror/gcc/blob/releases/gcc-14.2.0/gcc/config/s390/s390.opt#L58-L125
                match &*cpu {
                    "arch9" | "z196" | "arch10" | "zEC12" | "arch11" | "z13" | "arch12" | "z14"
                    | "arch13" | "z15" | "arch14" | "z16" => arch9_features = true,
                    _ => {}
                }
            }
            // As of rustc 1.80, target_feature "fast-serialization" is not available on rustc side:
            // https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_target/src/target_features.rs
            // bcr 14,0
            target_feature_fallback("fast-serialization", arch9_features);
        }
        _ => {}
    }
}

// HACK: Currently, it seems that the only way to handle unstable target
// features on the stable is to parse the `-C target-feature` in RUSTFLAGS.
//
// - #[cfg(target_feature = "unstable_target_feature")] doesn't work on stable.
// - CARGO_CFG_TARGET_FEATURE excludes unstable target features on stable.
//
// As mentioned in the [RFC2045], unstable target features are also passed to LLVM
// (e.g., https://godbolt.org/z/4rr7rMcfG), so this hack works properly on stable.
//
// [RFC2045]: https://rust-lang.github.io/rfcs/2045-target-feature.html#backend-compilation-options
fn needs_target_feature_fallback(version: &Version, stable: Option<u32>) -> bool {
    match stable {
        // In these cases, cfg(target_feature = "...") would work, so skip emitting our own fallback target_feature cfg.
        _ if version.nightly => false,
        Some(stabilized) if version.minor >= stabilized => false,
        _ => true,
    }
}
fn target_feature_fallback(name: &str, mut has_target_feature: bool) -> bool {
    if let Some(rustflags) = env::var_os("CARGO_ENCODED_RUSTFLAGS") {
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

fn is_allowed_feature(name: &str) -> bool {
    // https://github.com/dtolnay/thiserror/pull/248
    if env::var_os("RUSTC_STAGE").is_some() {
        return false;
    }

    // allowed by default
    let mut allowed = true;
    if let Some(rustflags) = env::var_os("CARGO_ENCODED_RUSTFLAGS") {
        for mut flag in rustflags.to_string_lossy().split('\x1f') {
            flag = flag.strip_prefix("-Z").unwrap_or(flag);
            if let Some(flag) = flag.strip_prefix("allow-features=") {
                // If it is specified multiple times, the last value will be preferred.
                allowed = flag.split(',').any(|allowed| allowed == name);
            }
        }
    }
    allowed
}

mod version {
    use std::{env, iter, process::Command, str};

    pub(crate) fn rustc_version() -> Option<Version> {
        let rustc = env::var_os("RUSTC")?;
        let rustc_wrapper = env::var_os("RUSTC_WRAPPER").filter(|v| !v.is_empty());
        // Do not apply RUSTC_WORKSPACE_WRAPPER: https://github.com/cuviper/autocfg/issues/58#issuecomment-2067625980
        let mut rustc = rustc_wrapper.into_iter().chain(iter::once(rustc));
        let mut cmd = Command::new(rustc.next().unwrap());
        cmd.args(rustc);
        // Use verbose version output because the packagers add extra strings to the normal version output.
        // Do not use long flags (--version --verbose) because clippy-deriver doesn't handle them properly.
        // -vV is also matched with that cargo internally uses: https://github.com/rust-lang/cargo/blob/0.80.0/src/cargo/util/rustc.rs#L65
        let output = cmd.arg("-vV").output().ok()?;
        let verbose_version = str::from_utf8(&output.stdout).ok()?;
        Version::parse(verbose_version)
    }

    pub(crate) struct Version {
        pub(crate) minor: u32,
        pub(crate) nightly: bool,
        commit_date: Date,
        pub(crate) llvm: u32,
    }

    impl Version {
        // The known latest stable version. If we unable to determine
        // the rustc version, we assume this is the current version.
        // It is no problem if this is older than the actual latest stable.
        // LLVM version is assumed to be the minimum external LLVM version:
        // https://github.com/rust-lang/rust/blob/1.82.0/src/bootstrap/src/core/build_steps/llvm.rs#L586
        pub(crate) const LATEST: Self = Self::stable(82, 17);

        pub(crate) const fn stable(rustc_minor: u32, llvm_major: u32) -> Self {
            Self {
                minor: rustc_minor,
                nightly: false,
                commit_date: Date::UNKNOWN,
                llvm: llvm_major,
            }
        }

        pub(crate) fn probe(&self, minor: u32, year: u16, month: u8, day: u8) -> bool {
            if self.nightly {
                self.minor > minor
                    || self.minor == minor && self.commit_date >= Date::new(year, month, day)
            } else {
                self.minor >= minor
            }
        }

        pub(crate) fn parse(verbose_version: &str) -> Option<Self> {
            let mut release = verbose_version
                .lines()
                .find(|line| line.starts_with("release: "))
                .map(|line| &line["release: ".len()..])?
                .splitn(2, '-');
            let version = release.next().unwrap();
            let channel = release.next().unwrap_or_default();
            let mut digits = version.splitn(3, '.');
            let major = digits.next()?;
            if major != "1" {
                return None;
            }
            let minor = digits.next()?.parse::<u32>().ok()?;
            let _patch = digits.next().unwrap_or("0").parse::<u32>().ok()?;
            let nightly = channel == "nightly" || channel == "dev";

            // Note that rustc 1.49-1.50 (and 1.13 or older) don't print LLVM version.
            let llvm_major = (|| {
                let version = verbose_version
                    .lines()
                    .find(|line| line.starts_with("LLVM version: "))
                    .map(|line| &line["LLVM version: ".len()..])?;
                let mut digits = version.splitn(3, '.');
                let major = digits.next()?.parse::<u32>().ok()?;
                let _minor = digits.next()?.parse::<u32>().ok()?;
                let _patch = digits.next().unwrap_or("0").parse::<u32>().ok()?;
                Some(major)
            })()
            .unwrap_or(0);

            // we don't refer commit date on stable/beta.
            if nightly {
                let commit_date = (|| {
                    let mut commit_date = verbose_version
                        .lines()
                        .find(|line| line.starts_with("commit-date: "))
                        .map(|line| &line["commit-date: ".len()..])?
                        .splitn(3, '-');
                    let year = commit_date.next()?.parse::<u16>().ok()?;
                    let month = commit_date.next()?.parse::<u8>().ok()?;
                    let day = commit_date.next()?.parse::<u8>().ok()?;
                    if month > 12 || day > 31 {
                        return None;
                    }
                    Some(Date::new(year, month, day))
                })();
                Some(Self {
                    minor,
                    nightly,
                    commit_date: commit_date.unwrap_or(Date::UNKNOWN),
                    llvm: llvm_major,
                })
            } else {
                Some(Self::stable(minor, llvm_major))
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
        const UNKNOWN: Self = Self::new(0, 0, 0);

        const fn new(year: u16, month: u8, day: u8) -> Self {
            Self { year, month, day }
        }
    }
}
use self::version::{rustc_version, Version};
