// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Armv8 AArch32

LLVM doesn't generate CLREX for Armv8-M Baseline, but it actually supports CLREX.
https://developer.arm.com/documentation/dui1095/a/The-Cortex-M23-Instruction-Set/Memory-access-instructions
https://community.arm.com/cfs-file/__key/telligent-evolution-components-attachments/01-2057-00-00-00-01-28-35/Cortex_2D00_M-for-Beginners-_2D00_-2017_5F00_EN_5F00_v2.pdf

Refs:
- Arm A-profile A32/T32 Instruction Set Architecture
  https://developer.arm.com/documentation/ddi0597/latest
- Arm Architecture Reference Manual for A-profile architecture
  https://developer.arm.com/documentation/ddi0487/latest (PDF)
- ARM Architecture Reference Manual Supplement - ARMv8, for the ARMv8-R AArch32 architecture profile
  https://developer.arm.com/documentation/ddi0568/latest (PDF)
- Armv8-M Architecture Reference Manual
  https://developer.arm.com/documentation/ddi0553/latest (PDF)
- Arm Cortex-M33 Devices Generic User Guide
  https://developer.arm.com/documentation/100235/0100
- Arm Cortex-M23 Devices Generic User Guide
  https://developer.arm.com/documentation/dui1095/a

Generated asm:
- armv8-a https://godbolt.org/z/TvnKGjfKn
- armv8-m baseline https://godbolt.org/z/Y9enGTP4Y
- armv8-m mainline https://godbolt.org/z/PqzfvcE73
*/

#[path = "cfgs/armv8.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

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

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                // (atomic) load from src to out
                                concat!("ld", $acquire, $asm_suffix, " {out}, [{src}]"),
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
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // (atomic) store val to dst
                                concat!("st", $release, $asm_suffix, " {val}, [{dst}]"),
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
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) swap (LL/SC loop)
                                "2:",
                                    // load from dst to tmp
                                    concat!("ld", $acquire, "ex", $asm_suffix, " {out}, [{dst}]"),
                                    // try to store val to dst
                                    concat!("st", $release, "ex", $asm_suffix, " {r}, {val}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b",
                                dst = in(reg) dst,
                                val = inout(reg) val => _,
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
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    // load from dst to out
                                    concat!("ld", $acquire, "ex", $asm_suffix, " {out}, [{dst}]"),
                                    "cmp {out}, {old}",
                                    "bne 3f", // jump if compare failed
                                    // try to store val to dst
                                    concat!("st", $release, "ex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b", // continue loop if store failed
                                    "b 4f",
                                "3:",
                                    // compare failed, mark r as failed and clear exclusive
                                    "clrex",
                                    s!("mov", "{r}, #1"),
                                "4:",
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = inout(reg) new => _,
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from dst to out
                                concat!("ld", $acquire, "ex", $asm_suffix, " {out}, [{dst}]"),
                                "cmp {out}, {old}",
                                "bne 3f",
                                // try to store new to dst
                                concat!("st", $release, "ex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                "b 4f",
                                "3:",
                                    // compare failed, mark r as failed and clear exclusive
                                    "clrex",
                                    s!("mov", "{r}, #1"),
                                "4:",
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = inout(reg) new => _,
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
    ($int_type:ident) => {
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let (prev_lo, prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                // (atomic) load from src to tmp pair
                                concat!("ld", $acquire, "exd r0, r1, [{src}]"),
                                "clrex",
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
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit64 { $int_type: val };

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) store val pair to dst (LL/SC loop)
                                "2:",
                                    // load from dst to tmp pair
                                    concat!("ld", $acquire, "exd r4, r5, [{dst}]"),
                                    // try to store val pair to dst
                                    concat!("st", $release, "exd r4, r2, r3, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp r4, #0",
                                    "bne 2b",
                                dst = in(reg) dst,
                                // val pair - must be even-numbered and not R14
                                inout("r2") val.pair.lo => _,
                                inout("r3") val.pair.hi => _,
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
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit64 { $int_type: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) swap (LL/SC loop)
                                "2:",
                                    // load from dst to out pair
                                    concat!("ld", $acquire, "exd r0, r1, [{dst}]"),
                                    // try to store val pair to dst
                                    concat!("st", $release, "exd {r}, r2, r3, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b",
                                dst = in(reg) dst,
                                r = out(reg) _,
                                // val pair - must be even-numbered and not R14
                                inout("r2") val.pair.lo => _,
                                inout("r3") val.pair.hi => _,
                                // prev pair - must be even-numbered and not R14
                                out("r0") prev_lo,
                                out("r1") prev_hi,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let old = MaybeUninit64 { $int_type: old };
                let new = MaybeUninit64 { $int_type: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    concat!("ld", $acquire, "exd r2, r3, [{dst}]"),
                                    "eor {tmp}, r3, {old_hi}",
                                    "eor {r}, r2, {old_lo}",
                                    "orrs {r}, {r}, {tmp}",
                                    "bne 3f", // jump if compare failed
                                    concat!("st", $release, "exd  {r}, r4, r5, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b", // continue loop if store failed
                                    "b 4f",
                                "3:",
                                    // compare failed, mark r as failed and clear exclusive
                                    "clrex",
                                    s!("mov", "{r}, #1"),
                                "4:",
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                inout("r4") new.pair.lo => _,
                                inout("r5") new.pair.hi => _,
                                // Do not use `preserves_flags` because CMP, ORRS, and s! modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type, r == 0)
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let old = MaybeUninit64 { $int_type: old };
                let new = MaybeUninit64 { $int_type: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("ld", $acquire, "exd r2, r3, [{dst}]"),
                                "eor {tmp}, r3, {old_hi}",
                                "eor {r}, r2, {old_lo}",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                concat!("st", $release, "exd  {r}, r4, r5, [{dst}]"),
                                "b 4f",
                                "3:",
                                    // compare failed, mark r as failed and clear exclusive
                                    "clrex",
                                    s!("mov", "{r}, #1"),
                                "4:",
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                inout("r4") new.pair.lo => _,
                                inout("r5") new.pair.hi => _,
                                // Do not use `preserves_flags` because ORRS and s! modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg_weak, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type, r == 0)
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);
