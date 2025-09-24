// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Armv8 AArch32

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#arm

LLVM doesn't generate CLREX for Armv8-M Baseline, but it actually supports CLREX.
https://developer.arm.com/documentation/dui1095/a/The-Cortex-M23-Instruction-Set/Memory-access-instructions
https://community.arm.com/cfs-file/__key/telligent-evolution-components-attachments/01-2057-00-00-00-01-28-35/Cortex_2D00_M-for-Beginners-_2D00_-2017_5F00_EN_5F00_v2.pdf

Refs:
- Arm A-profile A32/T32 Instruction Set Architecture
  https://developer.arm.com/documentation/ddi0597/latest
- Arm® Architecture Reference Manual for A-profile architecture
  https://developer.arm.com/documentation/ddi0487/latest (PDF)
- Arm® Architecture Reference Manual Supplement Armv8, for the Armv8-R AArch32 architecture profile
  https://developer.arm.com/documentation/ddi0568/latest (PDF)
- Arm® v8-M Architecture Reference Manual
  https://developer.arm.com/documentation/ddi0553/latest (PDF)
- Arm® Cortex®-M33 Devices Generic User Guide
  https://developer.arm.com/documentation/100235/0100
- Arm Cortex-M23 Devices Generic User Guide
  https://developer.arm.com/documentation/dui1095/a

Generated asm:
- armv8-a https://godbolt.org/z/xoPv85sMo
- armv8-m baseline https://godbolt.org/z/MrMdWfoEq
- armv8-m mainline https://godbolt.org/z/5odW5YnxP
*/

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
use crate::utils::{MaybeUninit64, Pair};

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("r", "r"),
            Ordering::Acquire => $op!("a", "r"),
            Ordering::Release => $op!("r", "l"),
            // AcqRel and SeqCst RMWs are equivalent.
            Ordering::AcqRel | Ordering::SeqCst => $op!("a", "l"),
            _ => unreachable!(),
        }
    };
}

// Adds S suffix if needed. We prefer instruction without S suffix,
// but Armv8-M Baseline doesn't support thumb2 instructions.
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
macro_rules! s {
    ($op:tt, $operand:tt) => {
        concat!($op, " ", $operand)
    };
}
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
macro_rules! s {
    ($op:tt, $operand:tt) => {
        concat!($op, "s ", $operand)
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $suffix:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                concat!("ld", $acquire, $suffix, " {out}, [{src}]"), // atomic { out = *src }
                                src = in(reg) src,
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("r"),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("a"),
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                concat!("st", $release, $suffix, " {val}, [{dst}]"), // atomic { *dst = val }
                                dst = in(reg) dst,
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("r"),
                        // Release and SeqCst stores are equivalent.
                        Ordering::Release | Ordering::SeqCst => atomic_store!("l"),
                        _ => unreachable!(),
                    }
                }
            }
        }
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "ex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                    concat!("st", $release, "ex", $suffix, " {r}, {val}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = val; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                                  // if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                                                       // if Z == 0 { jump 'retry }
                                dst = in(reg) dst,
                                val = in(reg) val,
                                out = out(reg) out,
                                r = out(reg) _,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
                out
            }
        }
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "ex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                    "cmp {out}, {old}",                                             // if out == old { Z = 1 } else { Z = 0 }
                                    "bne 3f",                                                       // if Z == 0 { jump 'cmp-fail }
                                    concat!("st", $release, "ex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                                  // if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                                                       // if Z == 0 { jump 'retry }
                                    "b 4f",                                                         // jump 'success
                                "3:", // 'cmp-fail:
                                    "clrex",                                                        // EXCLUSIVE = None
                                    s!("mov", "{r}, #1"),                                           // r = 1
                                "4:", // 'success:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::zero_extend32::$ty(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP and s! modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("ld", $acquire, "ex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                "cmp {out}, {old}",                                             // if out == old { Z = 1 } else { Z = 0 }
                                "bne 3f",                                                       // if Z == 0 { jump 'cmp-fail }
                                concat!("st", $release, "ex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                "b 4f",                                                         // jump 'success
                                "3:", // 'cmp-fail:
                                    "clrex",                                                    // EXCLUSIVE = None
                                    s!("mov", "{r}, #1"),                                       // r = 1
                                "4:", // 'success:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::zero_extend32::$ty(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP and s! modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg_weak, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
        }
    };
}

atomic!(i8, "b");
atomic!(u8, "b");
atomic!(i16, "h");
atomic!(u16, "h");
atomic!(i32, "");
atomic!(u32, "");
atomic!(isize, "");
atomic!(usize, "");

#[rustfmt::skip]
macro_rules! atomic64 {
    ($ty:ident) => {
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let (prev_lo, prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                concat!("ld", $acquire, "exd r0, r1, [{src}]"), // atomic { r0:r1 = *src; EXCLUSIVE = src }
                                "clrex",                                        // EXCLUSIVE = None
                                src = in(reg) src,
                                // prev pair - must be even-numbered and not R14
                                lateout("r0") prev_lo,
                                lateout("r1") prev_hi,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("r"),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("a"),
                        _ => unreachable!(),
                    }
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit64 { $ty: val };

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "exd r4, r5, [{dst}]"),     // atomic { r4:r5 = *dst; EXCLUSIVE = dst }
                                    concat!("st", $release, "exd r4, r2, r3, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = r2:r3; r4 = 0 } else { r4 = 1 }; EXCLUSIVE = None }
                                    "cmp r4, #0",                                       // if r4 == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                                           // if Z == 0 { jump 'retry }
                                dst = in(reg) dst,
                                // val pair - must be even-numbered and not R14
                                in("r2") val.pair.lo,
                                in("r3") val.pair.hi,
                                // tmp pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(store, order);
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit64 { $ty: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "exd r0, r1, [{dst}]"),      // atomic { r0:r1 = *dst; EXCLUSIVE = dst }
                                    concat!("st", $release, "exd {r}, r2, r3, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = r2:r3; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                       // if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                                            // if Z == 0 { jump 'retry }
                                dst = in(reg) dst,
                                r = out(reg) _,
                                // val pair - must be even-numbered and not R14
                                in("r2") val.pair.lo,
                                in("r3") val.pair.hi,
                                // prev pair - must be even-numbered and not R14
                                out("r0") prev_lo,
                                out("r1") prev_hi,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let old = MaybeUninit64 { $ty: old };
                let new = MaybeUninit64 { $ty: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "exd r2, r3, [{dst}]"),       // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                    "eor {tmp}, r3, {old_hi}",                            // tmp = r3 ^ old_hi
                                    "eor {r}, r2, {old_lo}",                              // r = r2 ^ old_lo
                                    "orrs {r}, {r}, {tmp}",                               // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 3f",                                             // if Z == 0 { jump 'cmp-fail }
                                    concat!("st", $release, "exd  {r}, r4, r5, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                        // if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                                             // if Z == 0 { jump 'retry }
                                    "b 4f",                                               // jump 'success
                                "3:", // 'cmp-fail:
                                    "clrex",                                              // EXCLUSIVE = None
                                    s!("mov", "{r}, #1"),                                 // r = 1
                                "4:", // 'success:
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                in("r4") new.pair.lo,
                                in("r5") new.pair.hi,
                                // Do not use `preserves_flags` because CMP, ORRS, and s! modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty, r == 0)
                }
            }
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let old = MaybeUninit64 { $ty: old };
                let new = MaybeUninit64 { $ty: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("ld", $acquire, "exd r2, r3, [{dst}]"),       // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                "eor {tmp}, r3, {old_hi}",                            // tmp = r3 ^ old_hi
                                "eor {r}, r2, {old_lo}",                              // r = r2 ^ old_lo
                                "orrs {r}, {r}, {tmp}",                               // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                "bne 3f",                                             // if Z == 0 { jump 'cmp-fail }
                                concat!("st", $release, "exd  {r}, r4, r5, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                "b 4f",                                               // jump 'success
                                "3:", // 'cmp-fail:
                                    "clrex",                                          // EXCLUSIVE = None
                                    s!("mov", "{r}, #1"),                             // r = 1
                                "4:", // 'success:
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                in("r4") new.pair.lo,
                                in("r5") new.pair.hi,
                                // Do not use `preserves_flags` because ORRS and s! modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg_weak, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty, r == 0)
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);

// -----------------------------------------------------------------------------
// cfg macros

#[macro_export]
macro_rules! cfg_has_atomic_8 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_8 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_16 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_16 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => {};
}
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
