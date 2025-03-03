// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
AArch64

Refs:
- Arm A-profile A64 Instruction Set Architecture
  https://developer.arm.com/documentation/ddi0602/2024-12
- Arm Compiler armasm User Guide
  https://developer.arm.com/documentation/dui0801/latest
- Arm Architecture Reference Manual for A-profile architecture
  https://developer.arm.com/documentation/ddi0487/latest (PDF)
- Arm Architecture Reference Manual Supplement - Armv8, for Armv8-R AArch64 architecture profile
  https://developer.arm.com/documentation/ddi0600/latest (PDF)
- portable-atomic https://github.com/taiki-e/portable-atomic

Generated asm:
- aarch64 https://godbolt.org/z/e8Wesj5WP
- aarch64 msvc https://godbolt.org/z/jcTW8Eafo
- aarch64 (+lse) https://godbolt.org/z/999aq8jGE
- aarch64 msvc (+lse) https://godbolt.org/z/TodsEnfz6
- aarch64 (+lse,+lse2) https://godbolt.org/z/r1M5GYWEj
- aarch64 (+lse,+lse2,+rcpc3) https://godbolt.org/z/c9dnqxM45
- aarch64 (+rcpc) https://godbolt.org/z/Ezc49YK6h
- aarch64 (+lse2,+lse128) https://godbolt.org/z/GMdboxzjc
- aarch64 (+lse2,+lse128,+rcpc3) https://godbolt.org/z/9beasofnd
*/

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap},
    utils::{MaybeUninit128, Pair},
};

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        atomic_rmw!($op, $order, write = $order)
    };
    ($op:ident, $order:ident, write = $write:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", "", ""),
            Ordering::Acquire => $op!("a", "", ""),
            Ordering::Release => $op!("", "l", ""),
            Ordering::AcqRel => $op!("a", "l", ""),
            // In MSVC environments, SeqCst stores/writes needs fences after writes.
            // https://reviews.llvm.org/D141748
            #[cfg(target_env = "msvc")]
            Ordering::SeqCst if $write == Ordering::SeqCst => $op!("a", "l", "dmb ish"),
            // AcqRel and SeqCst RMWs are equivalent in non-MSVC environments.
            Ordering::SeqCst => $op!("a", "l", ""),
            _ => unreachable!(),
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $suffix:tt, $val_modifier:tt, $cmp_ext:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                concat!("ld", $acquire, "r", $suffix, " {out", $val_modifier, "}, [{src}]"), // atomic { out = *src }
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // SAFETY: cfg guarantee that the CPU supports FEAT_LRCPC.
                        #[cfg(any(target_feature = "rcpc", atomic_maybe_uninit_target_feature = "rcpc"))]
                        Ordering::Acquire => atomic_load!("ap"),
                        #[cfg(not(any(target_feature = "rcpc", atomic_maybe_uninit_target_feature = "rcpc")))]
                        Ordering::Acquire => atomic_load!("a"),
                        Ordering::SeqCst => atomic_load!("a"),
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt, $fence:tt) => {
                            asm!(
                                concat!("st", $release, "r", $suffix, " {val", $val_modifier, "}, [{dst}]"), // atomic { *dst = val }
                                $fence,                                                                      // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("l", ""),
                        // AcqRel and SeqCst RMWs are equivalent in non-MSVC environments.
                        #[cfg(not(target_env = "msvc"))]
                        Ordering::SeqCst => atomic_store!("l", ""),
                        // In MSVC environments, SeqCst stores/writes needs fences after writes.
                        // https://reviews.llvm.org/D141748
                        #[cfg(target_env = "msvc")]
                        Ordering::SeqCst => atomic_store!("l", "dmb ish"),
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            // Refs:
                            // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/SWP--SWPA--SWPAL--SWPL--Swap-word-or-doubleword-in-memory-
                            // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/SWPB--SWPAB--SWPALB--SWPLB--Swap-byte-in-memory-
                            // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/SWPH--SWPAH--SWPALH--SWPLH--Swap-halfword-in-memory-
                            asm!(
                                concat!("swp", $acquire, $release, $suffix, " {val", $val_modifier, "}, {out", $val_modifier, "}, [{dst}]"), // atomic { _x = *dst; *dst = val; out = _x }
                                $fence,                                                                                                      // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "xr", $suffix, " {out", $val_modifier, "}, [{dst}]"),        // atomic { out = *dst; EXCLUSIVE = dst }
                                    concat!("st", $release, "xr", $suffix, " {r:w}, {val", $val_modifier, "}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = val; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cbnz {r:w}, 2b",                                                                    // if r != 0 { jump 'retry }
                                $fence,                                                                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                r = out(reg) _,
                                options(nostack, preserves_flags),
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $fence:tt) => {{
                            // Refs:
                            // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CAS--CASA--CASAL--CASL--Compare-and-swap-word-or-doubleword-in-memory-
                            // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CASB--CASAB--CASALB--CASLB--Compare-and-swap-byte-in-memory-
                            // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CASH--CASAH--CASALH--CASLH--Compare-and-swap-halfword-in-memory-
                            asm!(
                                // cas writes the current value to the first register,
                                // so copy the `old`'s value for later comparison.
                                concat!("mov {out", $val_modifier, "}, {old", $val_modifier, "}"),                                           // out = old
                                concat!("cas", $acquire, $release, $suffix, " {out", $val_modifier, "}, {new", $val_modifier, "}, [{dst}]"), // atomic { if *dst == out { *dst = new } else { out = *dst } }
                                $fence,                                                                                                      // fence
                                concat!("cmp {out", $val_modifier, "}, {old", $val_modifier, "}", $cmp_ext),                                 // if out == old { Z = 1 } else { Z = 0 }
                                "cset {r:w}, eq",                                                                                            // r = Z
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = lateout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            );
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                            (out, r != 0)
                        }};
                    }
                    #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $fence:tt) => {{
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "xr", $suffix, " {out", $val_modifier, "}, [{dst}]"),        // atomic { out = *dst; EXCLUSIVE = dst }
                                    concat!("cmp {out", $val_modifier, "}, {old", $val_modifier, "}", $cmp_ext),         // if out == old { Z = 1 } else { Z = 0 }
                                    "b.ne 3f",                                                                           // if Z == 0 { jump 'cmp-fail }
                                    concat!("st", $release, "xr", $suffix, " {r:w}, {new", $val_modifier, "}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cbnz {r:w}, 2b",                                                                    // if r != 0 { jump 'retry }
                                    $fence,                                                                              // fence
                                    "b 4f",                                                                              // jump 'success
                                "3:", // 'cmp-fail:
                                    "mov {r:w}, #1",                                                                     // r = 1
                                    "clrex",                                                                             // EXCLUSIVE = None
                                "4:", // 'success:
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            );
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                            // 0 if the store was successful, 1 if no store was performed
                            (out, r == 0)
                        }};
                    }
                    atomic_rmw!(cmpxchg, order, write = success)
                }
            }
            #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let r: i32;
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                concat!("ld", $acquire, "xr", $suffix, " {out", $val_modifier, "}, [{dst}]"),        // atomic { out = *dst; EXCLUSIVE = dst }
                                concat!("cmp {out", $val_modifier, "}, {old", $val_modifier, "}", $cmp_ext),         // if out == old { Z = 1 } else { Z = 0 }
                                "b.ne 3f",                                                                           // if Z == 0 { jump 'cmp-fail }
                                concat!("st", $release, "xr", $suffix, " {r:w}, {new", $val_modifier, "}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                // TODO: emit fence only when the above sc succeed?
                                // "cbnz {r:w}, 4f",
                                $fence,                                                                              // fence
                                "b 4f",                                                                              // jump 'success
                                "3:", // 'cmp-fail:
                                    "mov {r:w}, #1",                                                                 // r = 1
                                    "clrex",                                                                         // EXCLUSIVE = None
                                "4:", // 'success:
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg_weak, order, write = success);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
        }
    };
}

atomic!(i8, "b", ":w", ", uxtb");
atomic!(u8, "b", ":w", ", uxtb");
atomic!(i16, "h", ":w", ", uxth");
atomic!(u16, "h", ":w", ", uxth");
atomic!(i32, "", ":w", "");
atomic!(u32, "", ":w", "");
atomic!(i64, "", "", "");
atomic!(u64, "", "", "");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "", ":w", "");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "", ":w", "");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "", "", "");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "", "", "");

// There are a few ways to implement 128-bit atomic operations in AArch64.
//
// - LDXP/STXP loop (DW LL/SC)
// - CASP (DWCAS) added as Armv8.1 FEAT_LSE (optional from Armv8.0, mandatory from Armv8.1)
// - LDP/STP (DW load/store) if Armv8.4 FEAT_LSE2 (optional from Armv8.2, mandatory from Armv8.4) is available
// - LDIAPP/STILP (DW acquire-load/release-store) added as Armv8.9 FEAT_LRCPC3 (optional from Armv8.2) (if FEAT_LSE2 is also available)
// - LDCLRP/LDSETP/SWPP (DW RMW) added as Armv9.4 FEAT_LSE128 (optional from Armv9.3)
//
// If FEAT_LSE is available at compile-time, we use CASP for load/CAS. Otherwise, use LDXP/STXP loop.
// If FEAT_LSE2 is available at compile-time, we use LDP/STP for load/store.
// If FEAT_LSE128 is available at compile-time, we use SWPP for swap/{release,seqcst}-store.
// If FEAT_LSE2 and FEAT_LRCPC3 are available at compile-time, we use LDIAPP/STILP for acquire-load/release-store.
//
// Note: FEAT_LSE2 doesn't imply FEAT_LSE. FEAT_LSE128 implies FEAT_LSE but not FEAT_LSE2.
//
// Refs:
// - LDXP: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/LDXP--Load-exclusive-pair-of-registers-
// - LDAXP: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/LDAXP--Load-acquire-exclusive-pair-of-registers-
// - STXP: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/STXP--Store-exclusive-pair-of-registers-
// - STLXP: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/STLXP--Store-release-exclusive-pair-of-registers-
//
// Note: Load-Exclusive pair (by itself) does not guarantee atomicity; to complete an atomic
// operation (even load/store), a corresponding Store-Exclusive pair must succeed.
// See Arm Architecture Reference Manual for A-profile architecture
// Section B2.2.1 "Requirements for single-copy atomicity", and
// Section B2.9 "Synchronization and semaphores" for more.
macro_rules! atomic128 {
    ($ty:ident) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let (mut prev_lo, mut prev_hi);

                #[cfg(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"))]
                // SAFETY: the caller must guarantee that `dst` is valid for reads,
                // 16-byte aligned, that there are no concurrent non-atomic operations.
                // the above cfg guarantee that the CPU supports FEAT_LSE2.
                //
                // Refs:
                // - LDP https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/LDP--Load-pair-of-registers-
                // - LDIAPP https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/LDIAPP--Load-Acquire-RCpc-ordered-pair-of-registers-
                unsafe {
                    macro_rules! atomic_load_relaxed {
                        ($iap:tt, $dmb_ishld:tt) => {
                            asm!(
                                concat!("ld", $iap, "p {prev_lo}, {prev_hi}, [{src}]"), // atomic { prev_lo:prev_hi = *src }
                                $dmb_ishld,                                             // fence
                                src = in(reg) ptr_reg!(src),
                                prev_hi = lateout(reg) prev_hi,
                                prev_lo = lateout(reg) prev_lo,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        // if FEAT_LRCPC3 && order != relaxed => ldiapp
                        // SAFETY: cfg guarantee that the CPU supports FEAT_LRCPC3.
                        #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                        Ordering::Acquire => atomic_load_relaxed!("iap", ""),
                        #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                        Ordering::SeqCst => {
                            asm!(
                                // ldar (or dmb ishld) is required to prevent reordering with preceding stlxp.
                                // https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108891
                                "ldar {tmp}, [{src}]",                  // atomic { tmp = *src }
                                "ldiapp {prev_lo}, {prev_hi}, [{src}]", // atomic { prev_lo:prev_hi = *src }
                                src = in(reg) ptr_reg!(src),
                                prev_hi = lateout(reg) prev_hi,
                                prev_lo = lateout(reg) prev_lo,
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }

                        // else => ldp
                        Ordering::Relaxed => atomic_load_relaxed!("", ""),
                        #[cfg(not(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3")))]
                        Ordering::Acquire => atomic_load_relaxed!("", "dmb ishld"),
                        #[cfg(not(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3")))]
                        Ordering::SeqCst => {
                            asm!(
                                // ldar (or dmb ishld) is required to prevent reordering with preceding stlxp.
                                // https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108891
                                "ldar {tmp}, [{src}]",               // atomic { tmp = *src }
                                "ldp {prev_lo}, {prev_hi}, [{src}]", // atomic { prev_lo:prev_hi = *src }
                                "dmb ishld",                         // fence
                                src = in(reg) ptr_reg!(src),
                                prev_hi = lateout(reg) prev_hi,
                                prev_lo = lateout(reg) prev_lo,
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }
                        _ => unreachable!(),
                    }
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty
                }
                #[cfg(not(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2")))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // Refs: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CASP--CASPA--CASPAL--CASPL--Compare-and-swap-pair-of-words-or-doublewords-in-memory-
                                concat!("casp", $acquire, $release, " x2, x3, x2, x3, [{src}]"), // atomic { if *src == x2:x3 { *dst = x2:x3 } else { x2:x3 = *dst } }
                                src = in(reg) ptr_reg!(src),
                                // must be allocated to even/odd register pair
                                inout("x2") 0_u64 => prev_lo,
                                inout("x3") 0_u64 => prev_hi,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "xp {prev_lo}, {prev_hi}, [{src}]"),        // atomic { prev_lo:prev_hi = *src; EXCLUSIVE = src }
                                    concat!("st", $release, "xp {r:w}, {prev_lo}, {prev_hi}, [{src}]"), // atomic { if EXCLUSIVE == src { *src = prev_lo:prev_hi; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cbnz {r:w}, 2b",                                                   // if r != 0 { jump 'retry }
                                src = in(reg) ptr_reg!(src),
                                prev_lo = out(reg) prev_lo,
                                prev_hi = out(reg) prev_hi,
                                r = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("a", ""),
                        Ordering::SeqCst => atomic_load!("a", "l"),
                        _ => unreachable!(),
                    }
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty
                }
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let val = MaybeUninit128 { $ty: val };

                #[cfg(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"))]
                // SAFETY: the caller must guarantee that `dst` is valid for writes,
                // 16-byte aligned, that there are no concurrent non-atomic operations.
                // the above cfg guarantee that the CPU supports FEAT_LSE2.
                //
                // Refs:
                // - STP: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/STP--Store-pair-of-registers-
                // - STILP: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/STILP--Store-release-ordered-pair-of-registers-
                unsafe {
                    macro_rules! atomic_store {
                        ($il:tt, $acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                            // fence
                                concat!("st", $il, "p {val_lo}, {val_hi}, [{dst}]"), // atomic { *dst = val_lo:val_hi }
                                $acquire,                                            // fence
                                dst = in(reg) ptr_reg!(dst),
                                val_lo = in(reg) val.pair.lo,
                                val_hi = in(reg) val.pair.hi,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    // Use swpp if stp requires fences.
                    // https://reviews.llvm.org/D143506
                    #[cfg(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128"))]
                    macro_rules! atomic_store_swpp {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                concat!("swpp", $acquire, $release, " {val_lo}, {val_hi}, [{dst}]"), // atomic { _x = *dst; *dst = val_lo:val_hi; val_lo:val_hi = _x }
                                $fence,                                                              // fence
                                dst = in(reg) ptr_reg!(dst),
                                val_lo = inout(reg) val.pair.lo => _,
                                val_hi = inout(reg) val.pair.hi => _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        // if FEAT_LSE128 && order == seqcst => swpp
                        // Prefer swpp if stp requires fences. https://reviews.llvm.org/D143506
                        // SAFETY: cfg guarantee that the CPU supports FEAT_LSE128.
                        #[cfg(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128"))]
                        Ordering::SeqCst => atomic_rmw!(atomic_store_swpp, order),

                        // if FEAT_LRCPC3 && order != relaxed => stilp
                        // SAFETY: cfg guarantee that the CPU supports FEAT_LRCPC3.
                        #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                        Ordering::Release => atomic_store!("il", "", ""),
                        #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                        #[cfg(not(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128")))]
                        Ordering::SeqCst => atomic_store!("il", "dmb ish", ""),

                        // if FEAT_LSE128 && order != relaxed => swpp
                        // Prefer swpp if stp requires fences. https://reviews.llvm.org/D143506
                        // SAFETY: cfg guarantee that the CPU supports FEAT_LSE128.
                        #[cfg(not(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3")))]
                        #[cfg(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128"))]
                        Ordering::Release => atomic_rmw!(atomic_store_swpp, order),

                        // else => stp
                        Ordering::Relaxed => atomic_store!("", "", ""),
                        #[cfg(not(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3")))]
                        #[cfg(not(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128")))]
                        Ordering::Release => atomic_store!("", "", "dmb ish"),
                        #[cfg(not(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3")))]
                        #[cfg(not(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128")))]
                        Ordering::SeqCst => atomic_store!("", "dmb ish", "dmb ish"),
                        _ => unreachable!(),
                    }
                }
                #[cfg(not(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2")))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! store {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "xp xzr, {tmp}, [{dst}]"),                  // atomic { xzr:tmp = *dst; EXCLUSIVE = dst }
                                    concat!("st", $release, "xp {tmp:w}, {val_lo}, {val_hi}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = val_lo:val_hi; tmp = 0 } else { tmp = 1 }; EXCLUSIVE = None }
                                    "cbnz {tmp:w}, 2b",                                                 // if tmp != 0 { jump 'retry }
                                $fence,                                                                 // fence
                                dst = in(reg) ptr_reg!(dst),
                                val_lo = in(reg) val.pair.lo,
                                val_hi = in(reg) val.pair.hi,
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(store, order);
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let val = MaybeUninit128 { $ty: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128"))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                concat!("swpp", $acquire, $release, " {val_lo}, {val_hi}, [{dst}]"), // atomic { _x = *dst; *dst = val_lo:val_hi; val_lo:val_hi = _x }
                                $fence,                                                              // fence
                                dst = in(reg) ptr_reg!(dst),
                                val_lo = inout(reg) val.pair.lo => prev_lo,
                                val_hi = inout(reg) val.pair.hi => prev_hi,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(not(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128")))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "xp {prev_lo}, {prev_hi}, [{dst}]"),      // atomic { prev_lo:prev_hi = *dst; EXCLUSIVE = dst }
                                    concat!("st", $release, "xp {r:w}, {val_lo}, {val_hi}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = val_lo:val_hi; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cbnz {r:w}, 2b",                                                 // if r != 0 { jump 'retry }
                                $fence,                                                               // fence
                                dst = in(reg) ptr_reg!(dst),
                                val_lo = in(reg) val.pair.lo,
                                val_hi = in(reg) val.pair.hi,
                                prev_lo = out(reg) prev_lo,
                                prev_hi = out(reg) prev_hi,
                                r = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty
                }
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let old = MaybeUninit128 { $ty: old };
                let new = MaybeUninit128 { $ty: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $fence:tt) => {{
                            // Refs: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CASP--CASPA--CASPAL--CASPL--Compare-and-swap-pair-of-words-or-doublewords-in-memory-
                            asm!(
                                // casp writes the current value to the first register pair,
                                // so copy the `old`'s value for later comparison.
                                "mov x8, {old_lo}",                                              // x8 = old_lo
                                "mov x9, {old_hi}",                                              // x9 = old_hi
                                concat!("casp", $acquire, $release, " x8, x9, x4, x5, [{dst}]"), // atomic { if *src == x8:x9 { *dst = x4:x5 } else { x8:x9 = *dst } }
                                $fence,                                                          // fence
                                "cmp x8, {old_lo}",                                              // if x8 == old_lo { Z = 1 } else { Z = 0 }
                                "ccmp x9, {old_hi}, #0, eq",                                     // if Z == 1 { if x9 == old_hi { Z = 1 } else { Z = 0 } } else { Z = 0 }
                                "cset {r:w}, eq",                                                // r = Z
                                dst = in(reg) ptr_reg!(dst),
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = lateout(reg) r,
                                // new pair - must be allocated to even/odd register pair
                                in("x4") new.pair.lo,
                                in("x5") new.pair.hi,
                                // prev pair - must be allocated to even/odd register pair
                                out("x8") prev_lo,
                                out("x9") prev_hi,
                                // Do not use `preserves_flags` because CMP and CCMP modify the condition flags.
                                options(nostack),
                            );
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                            (
                                MaybeUninit128 {
                                    pair: Pair { lo: prev_lo, hi: prev_hi }
                                }.$ty,
                                r != 0
                            )
                        }};
                    }
                    #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $fence:tt) => {{
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "xp {prev_lo}, {prev_hi}, [{dst}]"),        // atomic { prev_lo:prev_hi = *dst; EXCLUSIVE = dst }
                                    "cmp {prev_lo}, {old_lo}",                                          // if prev_lo == old_lo { Z = 1 } else { Z = 0 }
                                    "cset {r:w}, ne",                                                   // r = !Z
                                    "cmp {prev_hi}, {old_hi}",                                          // if prev_hi == old_hi { Z = 1 } else { Z = 0 }
                                    "cinc {r:w}, {r:w}, ne",                                            // if Z == 0 { r += 1 }
                                    "cbz {r:w}, 3f",                                                    // if r == 0 { jump 'success }
                                    // write back to ensure atomicity
                                    concat!("st", $release, "xp {r:w}, {prev_lo}, {prev_hi}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = prev_lo:prev_hi; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cbnz {r:w}, 2b",                                                   // if r != 0 { jump 'retry }
                                    "mov {r:w}, #1",                                                    // r = 1
                                    "b 4f",                                                             // jump 'cmp-fail
                                "3:", // 'success:
                                    concat!("st", $release, "xp {r:w}, {new_lo}, {new_hi}, [{dst}]"),   // atomic { if EXCLUSIVE == dst { *dst = new_lo:new_hi; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cbnz {r:w}, 2b",                                                   // if r != 0 { jump 'retry }
                                "4:", // 'cmp-fail:
                                $fence,
                                dst = in(reg) ptr_reg!(dst),
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                new_lo = in(reg) new.pair.lo,
                                new_hi = in(reg) new.pair.hi,
                                prev_lo = out(reg) prev_lo,
                                prev_hi = out(reg) prev_hi,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            );
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                            // 0 if the store was successful, 1 if no store was performed
                            (
                                MaybeUninit128 {
                                    pair: Pair { lo: prev_lo, hi: prev_hi }
                                }.$ty,
                                r == 0
                            )
                        }};
                    }
                    atomic_rmw!(cmpxchg, order, write = success)
                }
            }
        }
    };
}

atomic128!(i128);
atomic128!(u128);

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
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
