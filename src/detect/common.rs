// SPDX-License-Identifier: Apache-2.0 OR MIT

#[derive(Clone, Copy)]
#[repr(transparent)]
pub(crate) struct CpuInfo(u32);

impl CpuInfo {
    #[inline]
    fn set(&mut self, bit: CpuInfoFlag) {
        self.0 = set(self.0, bit as u32);
    }
    #[inline]
    #[must_use]
    fn test(self, bit: CpuInfoFlag) -> bool {
        test(self.0, bit as u32)
    }
}

#[inline]
#[must_use]
fn set(x: u32, bit: u32) -> u32 {
    x | (1 << bit)
}
#[inline]
#[must_use]
fn test(x: u32, bit: u32) -> bool {
    x & (1 << bit) != 0
}

#[inline]
pub(crate) fn detect() -> CpuInfo {
    use core::sync::atomic::{AtomicU32, Ordering};

    static CACHE: AtomicU32 = AtomicU32::new(0);
    let mut info = CpuInfo(CACHE.load(Ordering::Relaxed));
    if info.0 != 0 {
        return info;
    }
    info.set(CpuInfoFlag::Init);
    // Note: detect_false cfg is intended to make it easy for developers to test
    // cases where features usually available is not available, and is not a public API.
    if !cfg!(atomic_maybe_uninit_test_detect_false) {
        _detect(&mut info);
    }
    CACHE.store(info.0, Ordering::Relaxed);
    info
}

macro_rules! flags {
    ($(
        $(#[$attr:meta])*
        $func:ident($name:literal, any($($cfg:ident),*)),
    )*) => {
        #[allow(dead_code, non_camel_case_types)]
        #[derive(Clone, Copy)]
        #[cfg_attr(test, derive(PartialEq, Eq, PartialOrd, Ord))]
        #[repr(u32)]
        enum CpuInfoFlag {
            Init = 0,
            $($func,)*
        }
        impl CpuInfo {
            $(
                $(#[$attr])*
                #[cfg(any(test, not(any($($cfg = $name),*))))]
                #[inline]
                #[must_use]
                pub(crate) fn $func(self) -> bool {
                    self.test(CpuInfoFlag::$func)
                }
            )*
            #[cfg(test)] // for test
            const ALL_FLAGS: &'static [(&'static str, CpuInfoFlag, bool)] = &[$(
                ($name, CpuInfoFlag::$func, cfg!(any($($cfg = $name),*))),
            )*];
        }
        #[test]
        #[cfg_attr(atomic_maybe_uninit_test_detect_false, ignore = "detection disabled")]
        fn test_detect() {$(
            $(#[$attr])*
            {
                const _: u32 = 1_u32 << CpuInfoFlag::$func as u32;
                assert_eq!($name.replace(|c: char| c == '-' || c == '.', "_"), stringify!($func));
                if detect().$func() {
                    assert!(detect().test(CpuInfoFlag::$func));
                } else {
                    assert!(!detect().test(CpuInfoFlag::$func));
                }
            }
        )*}
    };
}

// rustc definitions: https://github.com/rust-lang/rust/blob/ddaf12390d3ffb7d5ba74491a48f3cd528e5d777/compiler/rustc_target/src/target_features.rs

// LLVM definitions: https://github.com/llvm/llvm-project/blob/llvmorg-22.1.0-rc1/llvm/lib/Target/X86/X86.td
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
flags! {
    #[allow(dead_code)]
    avx("avx", any(target_feature)),
    avx2("avx2", any(target_feature)),
    #[allow(dead_code)]
    avx512f("avx512f", any(target_feature)),
    #[allow(dead_code)]
    ermsb("ermsb", any(target_feature /* nightly */)),
    #[allow(dead_code)]
    fsrm("fsrm", any(/*  */)),

    // Ice Lake, Zen 4, or later CPUs.
    icelake_or_later("icelake-or-later", any(/* shorthand for some avx512* */)),
}

#[allow(
    clippy::alloc_instead_of_core,
    clippy::std_instead_of_alloc,
    clippy::std_instead_of_core,
    clippy::undocumented_unsafe_blocks,
    clippy::wildcard_imports
)]
#[cfg(test)]
mod tests_common {
    use std::{collections::BTreeSet, vec};

    use super::*;

    #[test]
    fn test_bit_flags() {
        let mut flags = vec![("init", CpuInfoFlag::Init)];
        flags.extend(CpuInfo::ALL_FLAGS.iter().map(|&(name, flag, _)| (name, flag)));
        let flag_set = flags.iter().map(|(_, flag)| flag).collect::<BTreeSet<_>>();
        let name_set = flags.iter().map(|(_, flag)| flag).collect::<BTreeSet<_>>();
        if flag_set.len() != flags.len() {
            panic!("CpuInfo flag values must be unique")
        }
        if name_set.len() != flags.len() {
            panic!("CpuInfo flag names must be unique")
        }

        let mut x = CpuInfo(0);
        for &(_, f) in &flags {
            assert!(!x.test(f));
        }
        for i in 0..flags.len() {
            x.set(flags[i].1);
            for &(_, f) in &flags[..i + 1] {
                assert!(x.test(f));
            }
            for &(_, f) in &flags[i + 1..] {
                assert!(!x.test(f));
            }
        }
        for &(_, f) in &flags {
            assert!(x.test(f));
        }
    }

    #[test]
    fn print_features() {
        use std::{fmt::Write as _, string::String};

        let mut features = String::new();
        features.push_str("\nfeatures:\n");
        for &(name, flag, compile_time) in CpuInfo::ALL_FLAGS {
            let run_time = detect().test(flag);
            if run_time == compile_time {
                let _ = writeln!(features, "  {name}: {run_time}");
            } else {
                let _ = writeln!(
                    features,
                    "  {name}: {compile_time} (compile-time), {run_time} (run-time)",
                );
            }
        }
        test_helper::eprintln_nocapture!("{features}");
    }
}
