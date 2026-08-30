// SPDX-License-Identifier: Apache-2.0 OR MIT

// The rustc-cfg emitted by the build script are *not* public API.

#![allow(clippy::match_same_arms)] // https://github.com/rust-lang/rust-clippy/issues/12044

#[path = "src/gen/build.rs"]
mod generated;
#[path = "src/build/rustflags.rs"]
mod rustflags;
#[path = "src/build/version.rs"]
mod version;

use std::{env, str};

use self::{
    rustflags::Rustflags,
    version::{Version, rustc_version},
};

fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    let target = &*env::var("TARGET").expect("TARGET not set");
    let target_arch = &*env::var("CARGO_CFG_TARGET_ARCH").expect("CARGO_CFG_TARGET_ARCH not set");
    let target_os = &*env::var("CARGO_CFG_TARGET_OS").expect("CARGO_CFG_TARGET_OS not set");
    let rustflags = env::var_os("CARGO_ENCODED_RUSTFLAGS").unwrap_or_default();
    let rustflags = rustflags.to_string_lossy();
    let cargo_unstable_allow_features = env::var("CARGO_UNSTABLE_ALLOW_FEATURES").ok();
    let rustflags = Rustflags::new(&rustflags, cargo_unstable_allow_features.as_deref());

    let (version, version_pass) = match rustc_version() {
        Some(version) => (version, true),
        None => {
            if env::var_os("ATOMIC_MAYBE_UNINIT_DENY_WARNINGS").is_some() {
                panic!("unable to determine rustc version")
            }
            println!(
                "cargo:warning={}: unable to determine rustc version; assuming latest stable rustc (1.{})",
                env!("CARGO_PKG_NAME"),
                Version::LATEST.minor
            );
            (Version::LATEST, false)
        }
    };

    if version.minor >= 80 {
        println!(
            r#"cargo:rustc-check-cfg=cfg(target_feature,values("acquire-release","fast-serialization","zalasr"))"#
        );

        // Custom cfgs set by build script. Not public API.
        // grep -F 'cargo:rustc-cfg=' build.rs | grep -Ev '^ *//' | sed -E 's/^.*cargo:rustc-cfg=//; s/(=\\)?".*$//' | LC_ALL=C sort -u | tr '\n' ',' | sed -E 's/,$/\n/'
        println!(
            "cargo:rustc-check-cfg=cfg(atomic_maybe_uninit_llvm_20_or_later,atomic_maybe_uninit_no_asm,atomic_maybe_uninit_no_cmpxchg,atomic_maybe_uninit_no_cmpxchg8b,atomic_maybe_uninit_no_const_mut_refs,atomic_maybe_uninit_no_diagnostic_namespace,atomic_maybe_uninit_no_ldex_stex,atomic_maybe_uninit_no_ll_sc,atomic_maybe_uninit_no_stbar,atomic_maybe_uninit_no_strict_provenance,atomic_maybe_uninit_no_sync,atomic_maybe_uninit_target_feature,atomic_maybe_uninit_unstable_asm_experimental_arch,atomic_maybe_uninit_v4)"
        );
        // TODO: handle multi-line emit_target_feature_fallback
        // grep -F 'emit_target_feature_fallback("' build.rs | grep -Ev '^ *//' | sed -E 's/^.*emit_target_feature_fallback\(//; s/",.*$/"/' | LC_ALL=C sort -u | tr '\n' ',' | sed -E 's/,$/\n/'
        println!(
            r#"cargo:rustc-check-cfg=cfg(atomic_maybe_uninit_target_feature,values("a","acquire-release","fast-serialization","isa-68020","isa-68060","lam-bh","lamcas","leoncasa","lowbytefirst","lse128","lse2","mclass","msync","partword-atomics","quadword-atomics","rcpc3","rmw","scq","thumb-mode","thumb2","tinyencoding","v5te","v6","v7","v8plus","v9","x87","zaamo","zabha","zacas","zalasr","zalrsc"))"#
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

    // #[diagnostic] stabilized in Rust 1.78 (nightly-2024-03-09): https://github.com/rust-lang/rust/pull/119888
    if !version.probe(78, 2024, 3, 8) {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_no_diagnostic_namespace");
    }
    // const_mut_refs/const_refs_to_cell stabilized in Rust 1.83 (nightly-2024-09-16): https://github.com/rust-lang/rust/pull/129195
    if !version.probe(83, 2024, 9, 15) {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_no_const_mut_refs");
    }
    // strict_provenance/exposed_provenance APIs stabilized in Rust 1.84 (nightly-2024-10-22): https://github.com/rust-lang/rust/pull/130350
    if !version.probe(84, 2024, 10, 21) {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_no_strict_provenance");
    }

    if version_pass && version.llvm >= 20 {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_llvm_20_or_later");
    }

    match target_arch {
        "arm64ec" | "s390x" => {
            // asm! on Arm64EC and s390x stabilized in Rust 1.84 (nightly-2024-11-11): https://github.com/rust-lang/rust/pull/131781, https://github.com/rust-lang/rust/pull/131258
            if !version.probe(84, 2024, 11, 10) {
                if version.nightly
                    && (target_arch != "s390x" || version.probe(77, 2024, 1, 4))
                    && rustflags.is_allowed_feature("asm_experimental_arch")
                {
                    // https://github.com/rust-lang/rust/pull/119431 merged in Rust 1.77 (nightly-2024-01-05).
                    // The part of this feature we use has not been changed since nightly-2024-01-05
                    // until it was stabilized, so it can safely be enabled in nightly for that period.
                    println!("cargo:rustc-cfg=atomic_maybe_uninit_unstable_asm_experimental_arch");
                } else {
                    println!("cargo:rustc-cfg=atomic_maybe_uninit_no_asm");
                }
            }
        }
        "loongarch32" => {
            // asm! on loongarch32 stabilized in Rust 1.91 (nightly-2025-08-11): https://github.com/rust-lang/rust/pull/144402
            if !version.probe(91, 2025, 8, 10) {
                if version.nightly && rustflags.is_allowed_feature("asm_experimental_arch") {
                    // Inline assembly support is implemented from the beginning: https://github.com/rust-lang/rust/pull/142053
                    // The part of this feature we use has not been changed since added
                    // until it was stabilized, so it can safely be enabled in nightly for that period.
                    println!("cargo:rustc-cfg=atomic_maybe_uninit_unstable_asm_experimental_arch");
                } else {
                    println!("cargo:rustc-cfg=atomic_maybe_uninit_no_asm");
                }
            }
        }
        "powerpc" | "powerpc64" => {
            // asm! on PowerPC stabilized in Rust 1.95 (nightly-2026-01-28): https://github.com/rust-lang/rust/pull/147996
            if !version.probe(95, 2026, 1, 27) {
                if version.nightly && rustflags.is_allowed_feature("asm_experimental_arch") {
                    // The part of this feature we use has not been changed since our MSRV
                    // until it was stabilized, so it can safely be enabled in nightly for that period.
                    println!("cargo:rustc-cfg=atomic_maybe_uninit_unstable_asm_experimental_arch");
                } else {
                    println!("cargo:rustc-cfg=atomic_maybe_uninit_no_asm");
                }
            }
        }
        "avr" | "bpf" | "m68k" | "mips" | "mips32r6" | "mips64" | "mips64r6" | "msp430"
        | "xtensa" => {
            if version.nightly && rustflags.is_allowed_feature("asm_experimental_arch") {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_unstable_asm_experimental_arch");
            }
        }
        "csky" => {
            // https://github.com/rust-lang/rust/pull/136217 merged in Rust 1.86 (nightly-2025-02-14).
            if version.nightly
                && version.probe(86, 2025, 2, 13)
                && rustflags.is_allowed_feature("asm_experimental_arch")
            {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_unstable_asm_experimental_arch");
            }
        }
        "hexagon" => {
            // https://github.com/rust-lang/rust/pull/133452 merged in Rust 1.85 (nightly-2024-11-29).
            if version.nightly
                && version.probe(85, 2024, 11, 28)
                && rustflags.is_allowed_feature("asm_experimental_arch")
            {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_unstable_asm_experimental_arch");
            }
        }
        "sparc" | "sparc64" => {
            // https://github.com/rust-lang/rust/pull/132472 merged in Rust 1.84 (nightly-2024-11-08).
            if version.nightly
                && version.probe(84, 2024, 11, 7)
                && rustflags.is_allowed_feature("asm_experimental_arch")
            {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_unstable_asm_experimental_arch");
            }
        }
        _ => {}
    }

    match target_arch {
        "x86" => {
            // i486 doesn't have CMPXCHG8B.
            // i386 is additionally missing BSWAP, CMPXCHG, and XADD.
            // See also https://reviews.llvm.org/D18802.
            let mut no_cmpxchg8b = false;
            let mut no_cmpxchg = false;
            // i586 is -C target-feature=+x87 by default, but cfg(target_feature = "x87") doesn't work on pre-nightly-2024-12-14 or non-nightly.
            // And core assumes x87 is always available.
            // https://github.com/rust-lang/rust/blob/1.90.0/library/core/src/num/dec2flt/fpu.rs#L6
            // https://github.com/rust-lang/rust/blob/1.90.0/compiler/rustc_target/src/spec/targets/i686_unknown_uefi.rs#L24
            // However, custom bare metal targets tend to disable x87 and do not use floats.
            let mut x87 = target_os != "none";
            if let Some(cpu) = rustflags.target_cpu {
                match cpu {
                    // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/X86/X86.td#L1896-L1899
                    // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/X86/X86.td#L2243-L2248
                    "i386" => no_cmpxchg = true,
                    "i486" | "winchip-c6" | "winchip2" | "c3" => no_cmpxchg8b = true,
                    // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/X86/X86.td#L1950
                    "lakemont" => x87 = false,
                    _ => {}
                }
            }
            if no_cmpxchg {
                no_cmpxchg8b = true;
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_cmpxchg");
            }
            // LLVM recognizes this also as cx8 target feature: https://godbolt.org/z/Trx1x6odK
            // However, it is unlikely that rustc will support that name, so we will ignore it for now.
            if no_cmpxchg8b {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_cmpxchg8b");
            }
            // target_feature "x87" is unstable and available on rustc side since nightly-2024-12-14: https://github.com/rust-lang/rust/pull/133099
            if !version.probe(85, 2024, 12, 13) || needs_target_feature_fallback(&version, None) {
                for &(enabled, name) in &rustflags.target_feature {
                    // https://github.com/rust-lang/rust/blob/eab115ea6d842276c6ad7b819e08297c8e7693f0/compiler/rustc_target/src/target_features.rs#L425
                    match name {
                        b"x87" => x87 = enabled,
                        _ => {}
                    }
                }
                emit_target_feature_fallback("x87", x87);
            }
        }
        "aarch64" | "arm64ec" => {
            // target_feature "lse2"/"lse128"/"rcpc3" is unstable and available on rustc side since nightly-2024-08-30: https://github.com/rust-lang/rust/pull/128192
            if !version.probe(82, 2024, 8, 29) || needs_target_feature_fallback(&version, None) {
                // AArch64 macOS always supports FEAT_LSE2 because M1 is Armv8.4 with all features of Armv8.5 except FEAT_BTI:
                // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/AArch64/AArch64Processors.td#L1458
                // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/AArch64/AArch64Processors.td#L1052
                // Script to get builtin targets that support FEAT_LSE2 by default:
                // $ (for target in $(rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "aarch64" or .value.arch == "arm64ec" then .key else empty end'); do rustc --print cfg --target "${target}" | grep -Fq '"lse2"' && printf '%s\n' "${target}"; done)
                let mut lse2 = target_os == "macos";
                let mut lse128 = false;
                let mut rcpc3 = false;
                // TODO: Handles cases where a specific target cpu / ver target feature
                // implicitly enables target feature.
                for &(enabled, name) in &rustflags.target_feature {
                    // As of 1.99.0-nightly (nightly-2026-08-15):
                    //   $ rustc --print cfg --target aarch64-unknown-linux-gnu | grep lse
                    // "+" enables dependencies:
                    //   $ rustc --print cfg --target aarch64-unknown-linux-gnu -C target-feature=+lse128 | grep lse
                    //   target_feature="lse"
                    //   target_feature="lse128"
                    // "-" disables reverse dependencies, but leave dependencies:
                    //   $ rustc --print cfg --target aarch64-unknown-linux-gnu -C target-feature=+lse128,-lse128 | grep lse
                    //   target_feature="lse"
                    //   $ rustc --print cfg --target aarch64-unknown-linux-gnu -C target-feature=+lse128,-lse | grep lse
                    // -C target-cpu doesn't override -C target-feature even if it appears later:
                    //   $ rustc --print cfg --target aarch64-unknown-linux-gnu -C target-cpu=cortex-a76 | grep lse
                    //   target_feature="lse"
                    //   $ rustc --print cfg --target aarch64-unknown-linux-gnu -C target-feature=-lse -C target-cpu=cortex-a76 | grep lse
                    macro_rules! rev_dep {
                        ($($name:ident),* $(,)?) => {
                            if !enabled {
                                $($name = false;)*
                            }
                        };
                    }
                    // https://github.com/rust-lang/rust/blob/eab115ea6d842276c6ad7b819e08297c8e7693f0/compiler/rustc_target/src/target_features.rs#L216
                    match name {
                        b"lse2" => lse2 = enabled,
                        b"lse128" => lse128 = enabled,
                        b"lse" => rev_dep!(lse128),
                        b"rcpc3" => rcpc3 = enabled,
                        b"rcpc" | b"rcpc2" => rev_dep!(rcpc3),
                        _ => {}
                    }
                }
                emit_target_feature_fallback("lse2", lse2);
                emit_target_feature_fallback("lse128", lse128);
                emit_target_feature_fallback("rcpc3", rcpc3);
            }
        }
        "arm" => {
            // target_feature "acquire-release" is unstable and available on rustc side since nightly-2026-07-07: https://github.com/rust-lang/rust/pull/158405
            if !version.probe(99, 2026, 7, 6) || needs_target_feature_fallback(&version, None) {
                // #[cfg(target_feature = "v7")] and others don't work on stable.
                // armv7-unknown-linux-gnueabihf
                //    ^^
                let mut mclass = false;
                let mut v5te = false;
                let mut v6 = false;
                let mut v7 = false;
                let mut acquire_release = false;
                if let Some(mut subarch) =
                    target.strip_prefix("arm").or_else(|| target.strip_prefix("thumb"))
                {
                    subarch = subarch.strip_prefix("eb").unwrap_or(subarch); // ignore endianness
                    subarch = subarch.split_once('-').unwrap_or((subarch, "")).0; // ignore vender/os/env
                    let (mut subarch, suffix) = subarch.split_once('.').unwrap_or((subarch, "")); // .base/.main suffix
                    let mut known = true;
                    // As of nightly-2026-03-08, there are the following "vN*" patterns:
                    // $ rustc +nightly -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "arm" then .key else empty end' | sed -E 's/^(arm|thumb)(eb)?//; s/(\-|\.).*$//' | LC_ALL=C sort -u | sed -E 's/^/"/g; s/$/"/g'
                    // ""
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
                    //
                    // Legacy Arm architectures (pre-v7 except v6m) don't have *class target feature.
                    // For example:
                    // $ rustc +nightly --print cfg --target arm-unknown-linux-gnueabi | grep -F target_feature
                    // target_feature="v5te"
                    // target_feature="v6"
                    //
                    // In addition to above known sub-architectures, we also recognize armv{8,9}-{a,r}.
                    // Note that there is a CPU that Armv8-A but 32-bit only (Cortex-A32).
                    match subarch {
                        "v7" | "v7a" | "v7neon" | "v7s" | "v7k" | "v8" | "v8a" | "v9" | "v9a" => {} // aclass
                        "v7r" | "v8r" | "v9r" => {} // rclass
                        "v6m" | "v7em" | "v7m" | "v8m" => mclass = true,
                        // arm-linux-androideabi is v5te
                        // https://github.com/rust-lang/rust/blob/1.90.0/compiler/rustc_target/src/spec/targets/arm_linux_androideabi.rs#L19
                        _ if target == "arm-linux-androideabi" => subarch = "v5te",
                        // armeb-unknown-linux-gnueabi is v8 & aclass
                        // https://github.com/rust-lang/rust/blob/1.90.0/compiler/rustc_target/src/spec/targets/armeb_unknown_linux_gnueabi.rs#L20
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
                    if known && (subarch.starts_with("v8") || subarch.starts_with("v9")) {
                        // Armv8-M is not considered as v8 by LLVM.
                        // https://github.com/rust-lang/stdarch/blob/a0c30f3e3c75adcd6ee7efc94014ebcead61c507/crates/core_arch/src/arm_shared/mod.rs
                        if mclass {
                            // Armv8-M Mainline is a superset of Armv7-M.
                            // Armv8-M Baseline is a superset of Armv6-M.
                            // That said, LLVM handles thumbv8m.main without v8m like v6m, not v7m: https://godbolt.org/z/Ph96v9zae
                            // TODO: Armv9-M has not yet been released,
                            // so it is not clear how it will be handled here.
                            v6 = true;
                            v7 = suffix == "main";
                        } else {
                            v7 = true;
                        }
                        acquire_release = true;
                    }
                    v7 |= known && subarch.starts_with("v7");
                    v6 |= v7 || known && subarch.starts_with("v6");
                    v5te |= v6 || known && subarch.starts_with("v5te");
                }
                // All builtin targets that start with "thumb" enable thumb-mode, and
                // some builtin targets that start with "arm" are also enable thumb-mode.
                let mut thumb_mode =
                    target.starts_with("thumb") || generated::ARM_BUT_THUMB_MODE.contains(&target);
                let mut thumb2 = v7;
                let no_unstable = needs_target_feature_fallback(&version, None);
                // TODO: Handles cases where a specific target cpu
                // implicitly enables target feature.
                for &(enabled, name) in &rustflags.target_feature {
                    // See comment in aarch64 case.
                    macro_rules! dep {
                        ($($name:ident),* $(,)?) => {
                            if enabled {
                                $($name = true;)*
                            }
                        };
                    }
                    macro_rules! rev_dep {
                        ($($name:ident),* $(,)?) => {
                            if !enabled {
                                $($name = false;)*
                            }
                        };
                    }
                    // https://github.com/rust-lang/rust/blob/eab115ea6d842276c6ad7b819e08297c8e7693f0/compiler/rustc_target/src/target_features.rs#L160
                    match name {
                        b"v8" => dep!(v5te, v6, thumb2, v7, acquire_release),
                        b"acquire-release" => acquire_release = enabled,
                        _ if !no_unstable => {}
                        b"v8m.main" | b"v8.1m.main" | b"mve" | b"mve.fp" => {
                            dep!(v5te, v6, thumb2, v7);
                        }
                        b"v7" => {
                            v7 = enabled;
                            dep!(v5te, v6, thumb2);
                        }
                        b"v6t2" => {
                            dep!(v5te, v6, thumb2);
                            rev_dep!(v7);
                        }
                        b"thumb2" => {
                            thumb2 = enabled;
                            rev_dep!(v7);
                        }
                        b"v6k" | b"v8m" | b"v6m" => {
                            dep!(v5te, v6);
                            rev_dep!(v7);
                        }
                        b"v6" => {
                            v6 = enabled;
                            dep!(v5te);
                            rev_dep!(v7);
                        }
                        b"v5te" => {
                            v5te = enabled;
                            rev_dep!(v6, v7);
                        }
                        b"mclass" => mclass = enabled,
                        b"thumb-mode" => thumb_mode = enabled,
                        _ => {}
                    }
                }
                if no_unstable {
                    emit_target_feature_fallback("v7", v7);
                    emit_target_feature_fallback("v6", v6);
                    emit_target_feature_fallback("v5te", v5te);
                    emit_target_feature_fallback("mclass", mclass);
                    emit_target_feature_fallback("thumb-mode", thumb_mode);
                    emit_target_feature_fallback("thumb2", thumb2);
                }
                emit_target_feature_fallback("acquire-release", acquire_release);
            }
        }
        "riscv32" | "riscv64" => {
            let mut zalasr = false;
            let mut zacas = false;
            let mut zabha = false;
            let mut zaamo = false;
            let mut zalrsc = false;
            let mut a = false;
            // Ratified RISC-V target features stabilized in Rust 1.75. https://github.com/rust-lang/rust/pull/116485
            let check_a = needs_target_feature_fallback(&version, Some(75));
            if check_a {
                // riscv64gc-unknown-linux-gnu
                //        ^^
                if let Some(mut subarch) = target.strip_prefix(target_arch) {
                    subarch = subarch.split_once('-').unwrap_or((subarch, "")).0;
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
                    a = subarch.contains('a') || subarch.contains('g');
                }
            }
            // target_feature "zaamo"/"zabha"/"zalrsc" is unstable and available on rustc side
            // since nightly-2024-10-02 (https://github.com/rust-lang/rust/pull/130877),
            // and stabilized in Rust 1.94 (https://github.com/rust-lang/rust/pull/145948).
            let check_za = (!version.probe(83, 2024, 10, 1)
                || needs_target_feature_fallback(&version, Some(94)))
                && version.llvm >= 19;
            // target_feature "zacas" is unstable and available on rustc side
            // since nightly-2025-02-26 (https://github.com/rust-lang/rust/pull/137417),
            // and stabilized in Rust 1.94 (https://github.com/rust-lang/rust/pull/145948).
            let check_zacas = (!version.probe(87, 2025, 2, 25)
                || needs_target_feature_fallback(&version, Some(94)))
                && version.llvm >= 20;
            // TODO: Handles cases where a specific target cpu
            // implicitly enables target feature.
            for &(enabled, name) in &rustflags.target_feature {
                // See comment in aarch64 case.
                macro_rules! dep {
                    ($($name:ident),* $(,)?) => {
                        if enabled {
                            $($name = true;)*
                        }
                    };
                }
                macro_rules! rev_dep {
                    ($($name:ident),* $(,)?) => {
                        if !enabled {
                            $($name = false;)*
                        }
                    };
                }
                // https://github.com/rust-lang/rust/blob/eab115ea6d842276c6ad7b819e08297c8e7693f0/compiler/rustc_target/src/target_features.rs#L674
                match name {
                    b"zalasr" => zalasr = enabled,
                    b"zacas" if check_zacas => {
                        zacas = enabled;
                        // zabha and zacas imply zaamo in GCC, LLVM 20+, and Rust, but do not in LLVM 19.
                        // However, enabling them without zaamo or a is not allowed in LLVM 19, so we can assume
                        // zaamo is available when zabha is enabled).
                        // https://github.com/llvm/llvm-project/commit/956361ca080a689a96b6552d28681aaf0ad2f494
                        // https://github.com/gcc-mirror/gcc/commit/7b2b2e3d660edc8ef3a8cfbdfc2b0fd499459601
                        // https://github.com/gcc-mirror/gcc/commit/11c2453a16b725b7fb67778e1ab4636a51a1217d
                        // https://github.com/rust-lang/rust/pull/130877
                        dep!(zaamo);
                    }
                    _ if !check_a && !check_za => {}
                    b"a" => {
                        a = enabled;
                        dep!(zaamo, zalrsc);
                    }
                    b"rva23u64" => dep!(a, zaamo, zalrsc),
                    _ if !check_za => {}
                    b"zabha" => {
                        zabha = enabled;
                        dep!(zaamo);
                    }
                    b"zaamo" => {
                        zaamo = enabled;
                        rev_dep!(zacas, zabha, a);
                    }
                    b"zalrsc" => {
                        zalrsc = enabled;
                        rev_dep!(a);
                    }
                    _ => {}
                }
            }
            // As of Rust 1.93, target_feature "zalasr" is not available on rustc side:
            if version.llvm >= 22 {
                // available non-experimental since LLVM 22 https://github.com/llvm/llvm-project/pull/177331
                emit_target_feature_fallback("zalasr", zalasr);
            }
            if check_zacas {
                // amocas.{w,d,q} (and amocas.{b,h} if zabha is also available)
                // available as experimental since LLVM 17 https://github.com/llvm/llvm-project/commit/29f630a1ddcbb03caa31b5002f0cbc105ff3a869
                // available non-experimental since LLVM 20 https://github.com/llvm/llvm-project/commit/614aeda93b2225c6eb42b00ba189ba7ca2585c60
                emit_target_feature_fallback("zacas", zacas);
            }
            if check_za {
                // amo*.{b,h}
                // available since LLVM 19 https://github.com/llvm/llvm-project/commit/89f87c387627150d342722b79c78cea2311cddf7 / https://github.com/llvm/llvm-project/commit/6b7444964a8d028989beee554a1f5c61d16a1cac
                emit_target_feature_fallback("zabha", zabha);
                // amo*.{w,d}
                // available since LLVM 19 https://github.com/llvm/llvm-project/commit/1a14c446dd800b1d79fed1735c48e392d06e495d / https://github.com/llvm/llvm-project/commit/8be079cdddfd628d356d9ddb5ab397ea95fb1030
                emit_target_feature_fallback("zaamo", zaamo);
                // {lr,sc}.{w,d}
                // available since LLVM 19 https://github.com/llvm/llvm-project/commit/1a14c446dd800b1d79fed1735c48e392d06e495d / https://github.com/llvm/llvm-project/commit/8be079cdddfd628d356d9ddb5ab397ea95fb1030
                emit_target_feature_fallback("zalrsc", zalrsc);
            }
            if check_a {
                emit_target_feature_fallback("a", a);
            }
        }
        "powerpc" | "powerpc64" => {
            // target_feature "msync" is unstable and available on rustc side since nightly-2025-03-04: https://github.com/rust-lang/rust/pull/137860
            if !version.probe(87, 2025, 3, 3) || needs_target_feature_fallback(&version, None) {
                let mut partword_quadword_atomics = false;
                let mut msync = false;
                // Note that `-C target-cpu=native` is currently ignored.
                if let Some(cpu) = rustflags.target_cpu {
                    // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/PowerPC/PPC.td#L666
                    if let Some(mut cpu_version) = cpu.strip_prefix("pwr") {
                        cpu_version = cpu_version.strip_suffix('x').unwrap_or(cpu_version); // for pwr5x and pwr6x
                        if let Ok(cpu_version) = cpu_version.parse::<u32>() {
                            partword_quadword_atomics = cpu_version >= 8;
                        }
                    } else {
                        if generated::POWERPC_PARTWORD_QUADWORD_ATOMICS_CPU.contains(&cpu) {
                            partword_quadword_atomics = true;
                        }
                        if generated::POWERPC_MSYNC_CPU.contains(&cpu) {
                            msync = true;
                        }
                    }
                } else {
                    // powerpc64le is pwr8 by default https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/PowerPC/PPC.td#L804
                    // See also https://github.com/rust-lang/rust/issues/59932
                    partword_quadword_atomics = target_arch == "powerpc64"
                        && env::var("CARGO_CFG_TARGET_ENDIAN")
                            .expect("CARGO_CFG_TARGET_ENDIAN not set")
                            == "little";
                    msync = target_arch == "powerpc"
                        && (target.ends_with("spe")
                            || env::var("CARGO_CFG_TARGET_ABI")
                                .unwrap_or_default()
                                .split(',')
                                .any(|abi| abi == "spe"));
                }
                // power8 features: https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/PowerPC/PPC.td#L498
                let mut partword_atomics = partword_quadword_atomics;
                let mut quadword_atomics = partword_quadword_atomics;
                for &(enabled, name) in &rustflags.target_feature {
                    // https://github.com/rust-lang/rust/blob/eab115ea6d842276c6ad7b819e08297c8e7693f0/compiler/rustc_target/src/target_features.rs#L595
                    match name {
                        b"partword-atomics" => partword_atomics = enabled,
                        b"quadword-atomics" => quadword_atomics = enabled,
                        b"msync" => msync = enabled,
                        _ => {}
                    }
                }
                // target_feature "partword-atomics"/"quadword-atomics" is unstable and available on rustc side since nightly-2024-09-28: https://github.com/rust-lang/rust/pull/130873
                if !version.probe(83, 2024, 9, 27) || needs_target_feature_fallback(&version, None)
                {
                    // l[bh]arx and st[bh]cx.
                    emit_target_feature_fallback("partword-atomics", partword_atomics);
                    // lqarx and stqcx.
                    emit_target_feature_fallback("quadword-atomics", quadword_atomics);
                }
                emit_target_feature_fallback("msync", msync);
            }
        }
        "s390x" => {
            let mut arch_version = 8; // LLVM's baseline (z10): https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/SystemZ/SystemZProcessors.td#L16-L17
            // Note that `-C target-cpu=native` is currently ignored.
            if let Some(cpu) = rustflags.target_cpu {
                // LLVM and GCC recognize the same names:
                // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/SystemZ/SystemZProcessors.td
                // https://github.com/gcc-mirror/gcc/blob/releases/gcc-16.1.0/gcc/config/s390/s390.opt#L58-L128
                if let Some(v) = cpu.strip_prefix("arch") {
                    if let Ok(v) = v.parse::<u32>() {
                        arch_version = v;
                    }
                } else {
                    match cpu {
                        "z196" | "zEC12" | "z13" | "z14" | "z15" | "z16" | "z17" => {
                            arch_version = 9;
                        } // 9-
                        _ => {}
                    }
                }
            }
            // arch9 (z196) features: https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/SystemZ/SystemZFeatures.td#L103
            let mut fast_serialization = arch_version >= 9;
            for &(enabled, name) in &rustflags.target_feature {
                match name {
                    b"fast-serialization" => fast_serialization = enabled,
                    _ => {}
                }
            }
            // As of Rust 1.98, target_feature "fast-serialization" is not available on rustc side:
            // https://github.com/rust-lang/rust/blob/1.98.0/compiler/rustc_target/src/target_features.rs#L898
            // bcr 14,0
            emit_target_feature_fallback("fast-serialization", fast_serialization);
        }
        "loongarch64" => {
            // target_feature "lam-bh"/"lamcas"/"scq" is available as unstable on rustc side
            // since nightly-2025-03-16 (https://github.com/rust-lang/rust/pull/138056),
            // and stabilized in Rust 1.97 (https://github.com/rust-lang/rust/pull/154510).
            if version.llvm >= 20
                && (!version.probe(87, 2025, 3, 15)
                    || needs_target_feature_fallback(&version, Some(97)))
            {
                let mut lam_bh = false;
                let mut lamcas = false;
                let mut scq = false;
                // Note that `-C target-cpu=native` is currently ignored.
                if let Some(cpu) = rustflags.target_cpu {
                    // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/llvm/lib/Target/LoongArch/LoongArch.td#L166
                    if generated::LOONGARCH64_LAM_BH_LAMCAS_SCQ_CPU.contains(&cpu) {
                        lam_bh = true;
                        lamcas = true;
                        scq = true;
                    }
                }
                for &(enabled, name) in &rustflags.target_feature {
                    // https://github.com/rust-lang/rust/blob/eab115ea6d842276c6ad7b819e08297c8e7693f0/compiler/rustc_target/src/target_features.rs#L904
                    match name {
                        b"lam-bh" => lam_bh = enabled,
                        b"lamcas" => lamcas = enabled,
                        b"scq" => scq = enabled,
                        _ => {}
                    }
                }
                emit_target_feature_fallback("lam-bh", lam_bh);
                emit_target_feature_fallback("lamcas", lamcas);
                emit_target_feature_fallback("scq", scq);
            }
        }
        "sparc" => {
            let mut leoncasa = false;
            let mut v9 = false;
            let mut v7 = false;
            let is_linux_or_solaris = target_os == "linux" || target_os == "solaris";
            if let Some(cpu) = rustflags.target_cpu {
                // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/Sparc/Sparc.td#L175
                match cpu {
                    // https://github.com/llvm/llvm-project/pull/205810
                    "leon3" if version.llvm < 23 => {}
                    "v7" => v7 = true,
                    _ => {
                        if generated::SPARC_LEONCASA_CPU.contains(&cpu) {
                            leoncasa = true;
                        }
                        if generated::SPARC_V9_CPU.contains(&cpu) {
                            // v8plus is ABI feature so not associated with -C target-cpu.
                            v9 = true;
                        }
                    }
                }
            } else {
                // https://github.com/rust-lang/rust/blob/1.94.0/compiler/rustc_target/src/spec/targets/sparc_unknown_linux_gnu.rs#L19
                // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/clang/lib/Driver/ToolChains/Arch/Sparc.cpp#L169
                v9 = is_linux_or_solaris;
                // https://github.com/rust-lang/rust/blob/1.94.0/compiler/rustc_target/src/spec/targets/sparc_unknown_none_elf.rs#L12
                v7 = target == "sparc-unknown-none-elf";
            }
            // target_feature "leoncasa"/"v9" is unstable and available on rustc side since nightly-2024-11-11: https://github.com/rust-lang/rust/pull/132552
            // Note: nightly-2024-11-10 is unavailable: https://github.com/rust-lang/rust/issues/132838
            if !version.probe(84, 2024, 11, 10) || needs_target_feature_fallback(&version, None) {
                let mut v8plus = is_linux_or_solaris
                    || env::var("CARGO_CFG_TARGET_ABI")
                        .unwrap_or_default()
                        .split(',')
                        .any(|abi| abi == "v8plus");
                for &(enabled, name) in &rustflags.target_feature {
                    // https://github.com/rust-lang/rust/blob/eab115ea6d842276c6ad7b819e08297c8e7693f0/compiler/rustc_target/src/target_features.rs#L959
                    match name {
                        b"leoncasa" => leoncasa = enabled,
                        b"v9" => v9 = enabled,
                        b"v8plus" => v8plus = enabled,
                        _ => {}
                    }
                }
                emit_target_feature_fallback("leoncasa", leoncasa);
                emit_target_feature_fallback("v9", v9);
                emit_target_feature_fallback("v8plus", v8plus);
            }
            if v7 {
                // SPARC-V7 has no STBAR.
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_stbar");
            }
        }
        "mips" | "mips64" => {
            let mut mips1 = false;
            let mut r5900 = false;
            // Note that `-C target-cpu=native` is currently ignored.
            if let Some(cpu) = rustflags.target_cpu {
                // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/Mips/Mips.td#L266
                match cpu {
                    "mips1" => mips1 = true,
                    "r5900" => r5900 = true,
                    _ => {}
                }
            } else {
                // https://github.com/rust-lang/rust/blob/1.90.0/compiler/rustc_target/src/spec/targets/mipsel_sony_psx.rs#L26
                // (old rustc uses target_env instead of target_os: https://github.com/rust-lang/rust/commit/111f2e8a39fce63c6daac7eae88023f1e87c15d4)
                mips1 = target_arch == "mips"
                    && (target_os == "psx"
                        || env::var("CARGO_CFG_TARGET_ENV").unwrap_or_default() == "psx");
            }
            // MIPS-I has no SYNC and LL/SC.
            // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/Mips/MipsInstrInfo.td#L2199
            // R5900 has no LL/SC.
            // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/Mips/Mips64InstrInfo.td#L259
            // Note that R5900 short loop erratum fix is needless in our code since only LL/SC code path has loop in asm!.
            if mips1 {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_sync");
            }
            if r5900 || mips1 {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_ll_sc");
            }
        }
        "m68k" => {
            // target_feature "isa-68020" is unstable and available on rustc side since nightly-2024-12-16: https://github.com/rust-lang/rust/pull/134329
            if !version.probe(85, 2024, 12, 15) || needs_target_feature_fallback(&version, None) {
                let mut isa_68020 = false;
                let mut isa_68060 = false;
                if let Some(cpu) = rustflags.target_cpu {
                    // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/M68k/M68k.td#L69
                    if generated::M68K_ISA_68020_CPU.contains(&cpu) {
                        isa_68020 = true;
                    }
                    if generated::M68K_ISA_68060_CPU.contains(&cpu) {
                        isa_68060 = true;
                    }
                } else {
                    // https://github.com/rust-lang/rust/blob/1.90.0/compiler/rustc_target/src/spec/targets/m68k_unknown_linux_gnu.rs#L7
                    isa_68020 = target_os == "linux";
                }
                for &(enabled, name) in &rustflags.target_feature {
                    // See comment in aarch64 case.
                    macro_rules! dep {
                        ($($name:ident),* $(,)?) => {
                            if enabled {
                                $($name = true;)*
                            }
                        };
                    }
                    macro_rules! rev_dep {
                        ($($name:ident),* $(,)?) => {
                            if !enabled {
                                $($name = false;)*
                            }
                        };
                    }
                    // https://github.com/rust-lang/rust/blob/eab115ea6d842276c6ad7b819e08297c8e7693f0/compiler/rustc_target/src/target_features.rs#L967
                    match name {
                        b"isa-68060" => {
                            isa_68060 = enabled;
                            dep!(isa_68020);
                        }
                        b"isa-68030" | b"isa-68040" => {
                            dep!(isa_68020);
                            rev_dep!(isa_68060);
                        }
                        b"isa-68881" | b"isa-68882" => rev_dep!(isa_68060),
                        b"isa-68020" => {
                            isa_68020 = enabled;
                            rev_dep!(isa_68060);
                        }
                        b"isa-68000" | b"isa-68010" => rev_dep!(isa_68020, isa_68060),
                        _ => {}
                    }
                }
                emit_target_feature_fallback("isa-68020", isa_68020);
                emit_target_feature_fallback("isa-68060", isa_68060);
            }
        }
        "avr" => {
            let mut tinyencoding = false; // FamilyTiny
            let mut rmw = false; // FamilyXMEGAU
            let mut lowbytefirst = false; // FamilyXMEGA* | attiny102 | attiny104
            let mut llvm_missing_lowbytefirst = false;
            let cpu = match rustflags.target_cpu {
                Some(cpu) => cpu,
                None => {
                    // Handle legacy custom target names before https://github.com/Rahix/avr-hal/commit/9e96d0efe67367749b43084fcbe474649d6b62cf
                    target.rsplit_once('-').unwrap_or(("", "")).1
                }
            };
            // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc3/llvm/lib/Target/AVR/AVRDevices.td#L256
            match cpu {
                // attiny4/attiny5/attiny9/attiny10: 12.3. Accessing 16-bit Registers of https://ww1.microchip.com/downloads/en/DeviceDoc/atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-attiny9-attiny10_datasheet.pdf
                //   > To perform a 16-bit write operation, the high byte must be written before the low byte.
                // attiny20: 12.10 Accessing 16-bit Registers of https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8235-8-bit-AVR-Microcontroller-ATtiny20_Datasheet.pdf
                //   > To do a 16-bit write, the high byte must be written before the low byte.
                // attiny40: 12.9 Accessing Registers in 16-bit Mode of https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8263-8-bit-AVR-Microcontroller-tinyAVR-ATtiny40_Datasheet.pdf
                //   > To do a 16-bit write, the high byte must be written before the low byte.
                // attiny102/attiny104: 8.9. Accessing 16-bit Registers of https://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-8-bit-avr-microcontrollers-attiny102-attiny104_datasheet.pdf
                //   > For a write operation, the low byte of the 16-bit register must be written before the high byte.
                "attiny102" | "attiny104" => {
                    tinyencoding = true;
                    lowbytefirst = true;
                    // LLVM (as of 23) doesn't handle attiny102/attiny104 as lowbytefirst.
                    llvm_missing_lowbytefirst = true;
                }
                _ => {
                    if generated::AVR_TINYENCODING_CPU.contains(&cpu) {
                        tinyencoding = true;
                    }
                    if generated::AVR_RMW_CPU.contains(&cpu) {
                        rmw = true;
                    }
                    if generated::AVR_LOWBYTEFIRST_CPU.contains(&cpu) {
                        lowbytefirst = true;
                    }
                }
            }
            // target_feature "tinyencoding"/"lowbytefirst"/"rmw" is unstable and available on rustc side since nightly-2026-02-08: https://github.com/rust-lang/rust/pull/146900
            let needs_target_feature_fallback =
                !version.probe(95, 2026, 2, 7) || needs_target_feature_fallback(&version, None);
            if needs_target_feature_fallback || llvm_missing_lowbytefirst {
                for &(enabled, name) in &rustflags.target_feature {
                    // https://github.com/rust-lang/rust/blob/eab115ea6d842276c6ad7b819e08297c8e7693f0/compiler/rustc_target/src/target_features.rs#L981
                    match name {
                        b"tinyencoding" => tinyencoding = enabled,
                        b"rmw" => rmw = enabled,
                        b"lowbytefirst" => lowbytefirst = enabled,
                        _ => {}
                    }
                }
                if needs_target_feature_fallback {
                    emit_target_feature_fallback("tinyencoding", tinyencoding);
                    emit_target_feature_fallback("rmw", rmw);
                }
                emit_target_feature_fallback("lowbytefirst", lowbytefirst);
            }
        }
        "csky" => {
            let mut no_ldex_stex = true;
            if let Some(cpu) = rustflags.target_cpu {
                // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc1/llvm/lib/Target/CSKY/CSKY.td#L373
                if cpu.starts_with("ck860") || cpu.starts_with("c860") {
                    no_ldex_stex = false;
                }
            } else {
                // https://github.com/rust-lang/rust/blob/1.90.0/compiler/rustc_target/src/spec/targets/csky_unknown_linux_gnuabiv2hf.rs#L20
                if target == "csky-unknown-linux-gnuabiv2hf" {
                    no_ldex_stex = false;
                }
            }
            if no_ldex_stex {
                println!("cargo:rustc-cfg=atomic_maybe_uninit_no_ldex_stex");
            }
        }
        // TODO(bpf): Enable once https://github.com/aya-rs/bpf-linker/pull/386 released.
        // "bpf" => {
        //     // atomic_fetch_{add,and,xor,or}, {,cmp}xchg{32_32,_64}: LLVM 17+ (17 is our min LLVM version) https://github.com/llvm/llvm-project/commit/d0d1431ab1c88dd2fb8c09ae28909da3fb5f3a57
        //     // load_acquire, store_release: LLVM 21+ https://github.com/llvm/llvm-project/commit/17bfc00f7c4a424d7b5dc6da575865833701fd1a
        //     let mut v4 = false;
        //     if let Some(cpu) = rustflags.target_cpu {
        //         // https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0-rc1/llvm/lib/Target/BPF/BPF.td
        //         if let Some(cpu_version) = cpu.strip_prefix("v") {
        //             if let Ok(cpu_version) = cpu_version.parse::<u32>() {
        //                 if version.llvm >= 21 {
        //                     v4 = cpu_version >= 4;
        //                 }
        //             }
        //         }
        //     }
        //     if v4 {
        //         println!("cargo:rustc-cfg=atomic_maybe_uninit_v4");
        //     }
        // }
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
// Note that fallback doesn't catch the target feature enabled via target spec.
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
fn emit_target_feature_fallback(name: &str, has_target_feature: bool) {
    if has_target_feature {
        println!("cargo:rustc-cfg=atomic_maybe_uninit_target_feature=\"{name}\"");
    }
}
