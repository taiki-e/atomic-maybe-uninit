// Refs:
// - ARM Compiler armasm User Guide
//   https://developer.arm.com/documentation/dui0801/latest
// - Arm Architecture Reference Manual for A-profile architecture
//   https://developer.arm.com/documentation/ddi0487/latest
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - aarch64 https://godbolt.org/z/aTqxx6zMr
// - aarch64+lse https://godbolt.org/z/1vv6MzKfK
// - aarch64+lse+lse2 https://godbolt.org/z/nKMjhYGW8

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt, $val_modifier:tt) => {
        #[cfg(target_pointer_width = "32")]
        atomic!($int_type, $asm_suffix, $val_modifier, ":w");
        #[cfg(target_pointer_width = "64")]
        atomic!($int_type, $asm_suffix, $val_modifier, "");
    };
    ($int_type:ident, $asm_suffix:tt, $val_modifier:tt, $ptr_modifier:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("ld", $acquire, "r", $asm_suffix, " {tmp", $val_modifier, "}, [{src", $ptr_modifier, "}]"),
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp", $val_modifier, "}, [{out", $ptr_modifier, "}]"),
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("a"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp", $val_modifier, "}, [{val", $ptr_modifier, "}]"),
                                // (atomic) store tmp to dst
                                concat!("st", $release, "r", $asm_suffix, " {tmp", $val_modifier, "}, [{dst", $ptr_modifier, "}]"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        // Release and SeqCst stores are equivalent.
                        Ordering::Release | Ordering::SeqCst => atomic_store!("l"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp", $val_modifier, "}, [{val", $ptr_modifier, "}]"),
                                // (atomic) swap
                                // Refs: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/SWPA--SWPAL--SWP--SWPL--SWPAL--SWP--SWPL
                                concat!("swp", $acquire, $release, $asm_suffix, " {tmp", $val_modifier, "}, {tmp", $val_modifier, "}, [{dst", $ptr_modifier, "}]"),
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp", $val_modifier, "}, [{out", $ptr_modifier, "}]"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to val_tmp
                                concat!("ldr", $asm_suffix, " {val_tmp", $val_modifier, "}, [{val", $ptr_modifier, "}]"),
                                // (atomic) swap
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ld", $acquire, "xr", $asm_suffix, " {out_tmp", $val_modifier, "}, [{dst", $ptr_modifier, "}]"),
                                    // store val to dst
                                    concat!("st", $release, "xr", $asm_suffix, " {r:w}, {val_tmp", $val_modifier, "}, [{dst", $ptr_modifier, "}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp", $val_modifier, "}, [{out", $ptr_modifier, "}]"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                val_tmp = lateout(reg) _,
                                out = inout(reg) out => _,
                                out_tmp = lateout(reg) _,
                                r = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("a", ""),
                        Ordering::Release => atomic_swap!("", "l"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!("a", "l"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

atomic!(i8, "b", ":w");
atomic!(u8, "b", ":w");
atomic!(i16, "h", ":w");
atomic!(u16, "h", ":w");
atomic!(i32, "", ":w");
atomic!(u32, "", ":w");
atomic!(i64, "", "");
atomic!(u64, "", "");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "", ":w");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "", ":w");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "", "");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "", "");

// There are a few ways to implement 128-bit atomic operations in AArch64.
//
// - LDXP/STXP loop (DW LL/SC)
// - CASP (DWCAS) added as FEAT_LSE (armv8.1-a)
// - LDP/STP (DW load/store) if FEAT_LSE2 (armv8.4-a) is available
//
// If FEAT_LSE2 is available at compile-time, we use LDP/STP for load/store.
// Otherwise, use LDXP/STXP loop.
//
// Note: As of rustc 1.61.0, -C target-feature=+lse2 does not implicitly enable lse.
// Also, target_feature "lse2" is not available on rustc side:
// https://github.com/rust-lang/rust/blob/1.61.0/compiler/rustc_codegen_ssa/src/target_features.rs#L45
//
// Refs:
// - LDP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/LDP
// - LDXP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/LDXP
// - LDAXP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/LDAXP
// - STP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/STP
// - STXP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/STXP
// - STLXP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/STLXP
macro_rules! atomic128 {
    ($int_type:ident) => {
        #[cfg(target_pointer_width = "32")]
        atomic128!($int_type, ":w");
        #[cfg(target_pointer_width = "64")]
        atomic128!($int_type, "");
    };
    ($int_type:ident, $ptr_modifier:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                #[cfg(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"))]
                // SAFETY: the caller must guarantee that `dst` is valid for reads,
                // 16-byte aligned, that there are no concurrent non-atomic operations.
                // the above cfg guarantee that the CPU supports FEAT_LSE2.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                // (atomic) load from src to tmp pair
                                concat!("ldp {tmp_lo}, {tmp_hi}, [{src", $ptr_modifier, "}]"),
                                $acquire,
                                // store tmp pair to out
                                concat!("stp {tmp_lo}, {tmp_hi}, [{out", $ptr_modifier, "}]"),
                                src = in(reg) src,
                                out = in(reg) out,
                                tmp_hi = out(reg) _,
                                tmp_lo = out(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        Ordering::Acquire => atomic_load!("dmb ishld"),
                        Ordering::SeqCst => atomic_load!("dmb ish"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
                #[cfg(not(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2")))]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) load from src to tmp pair
                                "2:",
                                    // load from src to tmp pair
                                    concat!("ld", $acquire, "xp {tmp_lo}, {tmp_hi}, [{src", $ptr_modifier, "}]"),
                                    // store tmp pair to src
                                    concat!("st", $release, "xp {r:w}, {tmp_lo}, {tmp_hi}, [{src", $ptr_modifier, "}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                // store tmp pair to out
                                concat!("stp {tmp_lo}, {tmp_hi}, [{out", $ptr_modifier, "}]"),
                                src = in(reg) src,
                                out = in(reg) out,
                                tmp_hi = out(reg) _,
                                tmp_lo = out(reg) _,
                                r = out(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("a", ""),
                        Ordering::SeqCst => atomic_load!("a", "l"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                order: Ordering,
            ) {
                #[cfg(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"))]
                // SAFETY: the caller must guarantee that `dst` is valid for writes,
                // 16-byte aligned, that there are no concurrent non-atomic operations.
                // the above cfg guarantee that the CPU supports FEAT_LSE2.
                unsafe {
                    macro_rules! atomic_store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to val pair
                                concat!("ldp {val_lo}, {val_hi}, [{val", $ptr_modifier, "}]"),
                                // (atomic) store val pair to dst
                                $release,
                                concat!("stp {val_lo}, {val_hi}, [{dst", $ptr_modifier, "}]"),
                                $acquire,
                                dst = in(reg) dst,
                                val = in(reg) val,
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "dmb ish"),
                        Ordering::SeqCst => atomic_store!("dmb ish", "dmb ish"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
                #[cfg(not(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2")))]
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to val pair
                                concat!("ldp {val_lo}, {val_hi}, [{val", $ptr_modifier, "}]"),
                                // (atomic) store val pair to dst
                                "2:",
                                    // load from dst to tmp pair
                                    concat!("ld", $acquire, "xp {tmp_lo}, {tmp_hi}, [{dst", $ptr_modifier, "}]"),
                                    // store val pair to dst
                                    concat!("st", $release, "xp {r:w}, {val_lo}, {val_hi}, [{dst", $ptr_modifier, "}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                tmp_hi = lateout(reg) _,
                                tmp_lo = lateout(reg) _,
                                r = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "l"),
                        Ordering::SeqCst => atomic_store!("a", "l"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to val pair
                                concat!("ldp {val_lo}, {val_hi}, [{val", $ptr_modifier, "}]"),
                                // (atomic) swap
                                "2:",
                                    // load from dst to tmp pair
                                    concat!("ld", $acquire, "xp {tmp_lo}, {tmp_hi}, [{dst", $ptr_modifier, "}]"),
                                    // store val pair to dst
                                    concat!("st", $release, "xp {r:w}, {val_lo}, {val_hi}, [{dst", $ptr_modifier, "}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                // store tmp pair to out
                                concat!("stp {tmp_lo}, {tmp_hi}, [{out", $ptr_modifier, "}]"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                tmp_hi = lateout(reg) _,
                                tmp_lo = lateout(reg) _,
                                r = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("a", ""),
                        Ordering::Release => atomic_swap!("", "l"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!("a", "l"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

atomic128!(i128);
atomic128!(u128);

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);
    test_atomic!(i32);
    test_atomic!(u32);
    test_atomic!(i64);
    test_atomic!(u64);
    test_atomic!(i128);
    test_atomic!(u128);

    stress_test_load_store!();
    stress_test_load_swap!();
}
