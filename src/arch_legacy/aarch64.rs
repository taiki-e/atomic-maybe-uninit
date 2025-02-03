// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
AArch64

See arch/aarch64.rs for references and notes.

Generated asm:
- aarch64 https://godbolt.org/z/6TKofhrbb
- aarch64 msvc https://godbolt.org/z/5GzETjcE7
- aarch64 (+lse) https://godbolt.org/z/7jK5vej7b
- aarch64 msvc (+lse) https://godbolt.org/z/896zWazdW
- aarch64 (+lse,+lse2) https://godbolt.org/z/66cMd4Ys6
- aarch64 (+lse,+lse2,+rcpc3) https://godbolt.org/z/ojbaYn9Kf
- aarch64 (+rcpc) https://godbolt.org/z/4ahePW8TK
- aarch64 (+lse2,+lse128) https://godbolt.org/z/joMq5vv1h
- aarch64 (+lse2,+lse128,+rcpc3) https://godbolt.org/z/WdbsccKcz
*/

#[path = "../arch/cfgs/aarch64.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

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

macro_rules! atomic {
    ($ty:ident, $asm_suffix:tt, $val_modifier:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("ld", $acquire, "r", $asm_suffix, " {tmp", $val_modifier, "}, [{src}]"),
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp", $val_modifier, "}, [{out}]"),
                                src = in(reg) ptr_reg!(src),
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        #[cfg(any(target_feature = "rcpc", atomic_maybe_uninit_target_feature = "rcpc"))]
                        Ordering::Acquire => {
                            // SAFETY: cfg guarantee that the CPU supports FEAT_LRCPC.
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("ldapr", $asm_suffix, " {tmp", $val_modifier, "}, [{src}]"),
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp", $val_modifier, "}, [{out}]"),
                                src = in(reg) ptr_reg!(src),
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }
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
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt, $fence:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp", $val_modifier, "}, [{val}]"),
                                // (atomic) store tmp to dst
                                concat!("st", $release, "r", $asm_suffix, " {tmp", $val_modifier, "}, [{dst}]"),
                                $fence,
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                tmp = lateout(reg) _,
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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp", $val_modifier, "}, [{val}]"),
                                // (atomic) swap
                                // Refs:
                                // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/SWP--SWPA--SWPAL--SWPL--Swap-word-or-doubleword-in-memory-
                                // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/SWPB--SWPAB--SWPALB--SWPLB--Swap-byte-in-memory-
                                // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/SWPH--SWPAH--SWPALH--SWPLH--Swap-halfword-in-memory-
                                concat!("swp", $acquire, $release, $asm_suffix, " {tmp", $val_modifier, "}, {tmp", $val_modifier, "}, [{dst}]"),
                                $fence,
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp", $val_modifier, "}, [{out}]"),
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                // load from val to val_tmp
                                concat!("ldr", $asm_suffix, " {val_tmp", $val_modifier, "}, [{val}]"),
                                // (atomic) swap (LL/SC loop)
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ld", $acquire, "xr", $asm_suffix, " {out_tmp", $val_modifier, "}, [{dst}]"),
                                    // try to store val to dst
                                    concat!("st", $release, "xr", $asm_suffix, " {r:w}, {val_tmp", $val_modifier, "}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                $fence,
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp", $val_modifier, "}, [{out}]"),
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                val_tmp = out(reg) _,
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                out_tmp = out(reg) _,
                                r = lateout(reg) _,
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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $fence:tt) => {{
                            asm!(
                                // load from old/new to old_tmp/new_tmp
                                concat!("ldr", $asm_suffix, " {old_tmp", $val_modifier, "}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new_tmp", $val_modifier, "}, [{new}]"),
                                // cas writes the current value to the first register,
                                // so copy the `old`'s value for later comparison.
                                concat!("mov {out_tmp", $val_modifier, "}, {old_tmp", $val_modifier, "}"),
                                // (atomic) CAS
                                // Refs:
                                // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CAS--CASA--CASAL--CASL--Compare-and-swap-word-or-doubleword-in-memory-
                                // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CASB--CASAB--CASALB--CASLB--Compare-and-swap-byte-in-memory-
                                // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CASH--CASAH--CASALH--CASLH--Compare-and-swap-halfword-in-memory-
                                concat!("cas", $acquire, $release, $asm_suffix, " {out_tmp", $val_modifier, "}, {new_tmp", $val_modifier, "}, [{dst}]"),
                                $fence,
                                concat!("cmp {out_tmp", $val_modifier, "}, {old_tmp", $val_modifier, "}"),
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp", $val_modifier, "}, [{out}]"),
                                "cset {r:w}, eq",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                old = in(reg) ptr_reg!(old),
                                old_tmp = out(reg) _,
                                new = in(reg) ptr_reg!(new),
                                new_tmp = out(reg) _,
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                out_tmp = out(reg) _,
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
                                // load from old/new to old_tmp/new_tmp
                                concat!("ldr", $asm_suffix, " {new_tmp", $val_modifier, "}, [{new}]"),
                                concat!("ldr", $asm_suffix, " {old_tmp", $val_modifier, "}, [{old}]"),
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    concat!("ld", $acquire, "xr", $asm_suffix, " {out_tmp", $val_modifier, "}, [{dst}]"),
                                    concat!("cmp {out_tmp", $val_modifier, "}, {old_tmp", $val_modifier, "}"),
                                    "b.ne 3f", // jump if compare failed
                                    concat!("st", $release, "xr", $asm_suffix, " {r:w}, {new_tmp", $val_modifier, "}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b", // continue loop if store failed
                                    $fence,
                                    "b 4f",
                                "3:",
                                    "mov {r:w}, #1", // mark as failed
                                    "clrex",
                                "4:",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp", $val_modifier, "}, [{out}]"),
                                dst = inout(reg) ptr_reg!(dst) => _,
                                old = in(reg) ptr_reg!(old),
                                old_tmp = out(reg) _,
                                new = in(reg) ptr_reg!(new),
                                new_tmp = out(reg) _,
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                out_tmp = out(reg) _,
                                r = lateout(reg) r,
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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let r: i32;
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                // load from old/new to old_tmp/new_tmp
                                concat!("ldr", $asm_suffix, " {new_tmp", $val_modifier, "}, [{new}]"),
                                concat!("ldr", $asm_suffix, " {old_tmp", $val_modifier, "}, [{old}]"),
                                // (atomic) CAS
                                concat!("ld", $acquire, "xr", $asm_suffix, " {out_tmp", $val_modifier, "}, [{dst}]"),
                                concat!("cmp {out_tmp", $val_modifier, "}, {old_tmp", $val_modifier, "}"),
                                "b.ne 3f",
                                concat!("st", $release, "xr", $asm_suffix, " {r:w}, {new_tmp", $val_modifier, "}, [{dst}]"),
                                // TODO: emit fence only when the above sc succeed?
                                // // 0 if the store was successful, 1 if no store was performed
                                // "cbnz {r:w}, 4f",
                                $fence,
                                "b 4f",
                                "3:",
                                    "mov {r:w}, #1",
                                    "clrex",
                                "4:",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp", $val_modifier, "}, [{out}]"),
                                dst = inout(reg) ptr_reg!(dst) => _,
                                old = in(reg) ptr_reg!(old),
                                old_tmp = out(reg) _,
                                new = in(reg) ptr_reg!(new),
                                new_tmp = out(reg) _,
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                out_tmp = out(reg) _,
                                r = lateout(reg) r,
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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

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
                        ($acquire:tt) => {
                            asm!(
                                // (atomic) load from src to tmp pair
                                "ldp {tmp_lo}, {tmp_hi}, [{src}]",
                                $acquire,
                                // store tmp pair to out
                                "stp {tmp_lo}, {tmp_hi}, [{out}]",
                                src = in(reg) ptr_reg!(src),
                                out = in(reg) ptr_reg!(out_ptr),
                                tmp_hi = out(reg) _,
                                tmp_lo = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load_relaxed!(""),
                        #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                        Ordering::Acquire => {
                            // SAFETY: cfg guarantee that the CPU supports FEAT_LRCPC3.
                            // Refs: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/LDIAPP--Load-Acquire-RCpc-ordered-pair-of-registers-
                            asm!(
                                // (atomic) load from src to tmp pair
                                "ldiapp {tmp_lo}, {tmp_hi}, [{src}]",
                                // store tmp pair to out
                                "stp {tmp_lo}, {tmp_hi}, [{out}]",
                                src = in(reg) ptr_reg!(src),
                                out = in(reg) ptr_reg!(out_ptr),
                                tmp_hi = out(reg) _,
                                tmp_lo = out(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }
                        #[cfg(not(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3")))]
                        Ordering::Acquire => atomic_load_relaxed!("dmb ishld"),
                        Ordering::SeqCst => {
                            asm!(
                                // ldar (or dmb ishld) is required to prevent reordering with preceding stlxp.
                                // https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108891
                                "ldar {tmp}, [{src}]",
                                // (atomic) load from src to tmp pair
                                "ldp {tmp_lo}, {tmp_hi}, [{src}]",
                                "dmb ishld",
                                // store tmp pair to out
                                "stp {tmp_lo}, {tmp_hi}, [{out}]",
                                src = in(reg) ptr_reg!(src),
                                out = in(reg) ptr_reg!(out_ptr),
                                tmp_hi = out(reg) _,
                                tmp_lo = out(reg) _,
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            );
                        },
                        _ => unreachable!(),
                    }
                }
                #[cfg(not(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2")))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) load (CAS)
                                // Refs:
                                // - https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CASP--CASPA--CASPAL--CASPL--Compare-and-swap-pair-of-words-or-doublewords-in-memory-
                                // - https://github.com/taiki-e/portable-atomic/pull/20
                                concat!("casp", $acquire, $release, " x2, x3, x2, x3, [{src}]"),
                                // store out pair to out
                                "stp x2, x3, [{out}]",
                                src = in(reg) ptr_reg!(src),
                                out = in(reg) ptr_reg!(out_ptr),
                                // must be allocated to even/odd register pair
                                inout("x2") 0_u64 => _, // out_lo
                                inout("x3") 0_u64 => _, // out_lo
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) load from src to tmp pair
                                "2:",
                                    // load from src to tmp pair
                                    concat!("ld", $acquire, "xp {tmp_lo}, {tmp_hi}, [{src}]"),
                                    // store tmp pair to src
                                    concat!("st", $release, "xp {r:w}, {tmp_lo}, {tmp_hi}, [{src}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                // store tmp pair to out
                                "stp {tmp_lo}, {tmp_hi}, [{out}]",
                                src = in(reg) ptr_reg!(src),
                                out = in(reg) ptr_reg!(out_ptr),
                                tmp_hi = out(reg) _,
                                tmp_lo = out(reg) _,
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
                let val = val.as_ptr();

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
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to val pair
                                "ldp {val_lo}, {val_hi}, [{val}]",
                                // (atomic) store val pair to dst
                                $release,
                                "stp {val_lo}, {val_hi}, [{dst}]",
                                $acquire,
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) ptr_reg!(val),
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
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
                                // load from val to val pair
                                "ldp {val_lo}, {val_hi}, [{val}]",
                                // (atomic) swap
                                concat!("swpp", $acquire, $release, " {val_lo}, {val_hi}, [{dst}]"),
                                $fence,
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) ptr_reg!(val),
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                        Ordering::Release => {
                            // SAFETY: cfg guarantee that the CPU supports FEAT_LRCPC3.
                            // Refs: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/STILP--Store-release-ordered-pair-of-registers-
                            asm!(
                                // load from val to val pair
                                "ldp {val_lo}, {val_hi}, [{val}]",
                                // (atomic) store val pair to dst
                                "stilp {val_lo}, {val_hi}, [{dst}]",
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) ptr_reg!(val),
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }
                        #[cfg(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128"))]
                        #[cfg(not(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3")))]
                        Ordering::Release => atomic_rmw!(atomic_store_swpp, order),
                        #[cfg(not(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128")))]
                        #[cfg(not(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3")))]
                        Ordering::Release => atomic_store!("", "dmb ish"),
                        #[cfg(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128"))]
                        Ordering::SeqCst => atomic_rmw!(atomic_store_swpp, order),
                        #[cfg(not(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128")))]
                        Ordering::SeqCst => atomic_store!("dmb ish", "dmb ish"),
                        _ => unreachable!(),
                    }
                }
                #[cfg(not(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2")))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! store {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                // load from val to val pair
                                "ldp {val_lo}, {val_hi}, [{val}]",
                                // (atomic) store val pair to dst (LL/SC loop)
                                "2:",
                                    // load from dst to xzr/tmp pair
                                    concat!("ld", $acquire, "xp xzr, {tmp}, [{dst}]"),
                                    // try to store val pair to dst
                                    concat!("st", $release, "xp {tmp:w}, {val_lo}, {val_hi}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {tmp:w}, 2b",
                                $fence,
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                tmp = lateout(reg) _,
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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128"))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                // load from val to val pair
                                "ldp {val_lo}, {val_hi}, [{val}]",
                                // (atomic) swap
                                concat!("swpp", $acquire, $release, " {val_lo}, {val_hi}, [{dst}]"),
                                $fence,
                                // store out pair to out
                                "stp {val_lo}, {val_hi}, [{out}]",
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) ptr_reg!(val),
                                out = in(reg) ptr_reg!(out_ptr),
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(not(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128")))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                // load from val to val pair
                                "ldp {val_lo}, {val_hi}, [{val}]",
                                // (atomic) swap (LL/SC loop)
                                "2:",
                                    // load from dst to out pair
                                    concat!("ld", $acquire, "xp {out_lo}, {out_hi}, [{dst}]"),
                                    // try to store val pair to dst
                                    concat!("st", $release, "xp {r:w}, {val_lo}, {val_hi}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                $fence,
                                // store out pair to out
                                "stp {out_lo}, {out_hi}, [{out}]",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                out_hi = out(reg) _,
                                out_lo = out(reg) _,
                                r = lateout(reg) _,
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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $fence:tt) => {{
                            asm!(
                                // load from old/new to old/new pairs
                                "ldp {old_lo}, {old_hi}, [{old}]",
                                "ldp x4, x5, [{new}]",
                                // casp writes the current value to the first register pair,
                                // so copy the `old`'s value for later comparison.
                                "mov x8, {old_lo}",
                                "mov x9, {old_hi}",
                                // (atomic) CAS
                                // Refs: https://developer.arm.com/documentation/ddi0602/2024-12/Base-Instructions/CASP--CASPA--CASPAL--CASPL--Compare-and-swap-pair-of-words-or-doublewords-in-memory-
                                concat!("casp", $acquire, $release, " x8, x9, x4, x5, [{dst}]"),
                                $fence,
                                // compare old pair and out pair
                                "cmp x8, {old_lo}",
                                "ccmp x9, {old_hi}, #0, eq",
                                "cset {r:w}, eq",
                                // store out pair to out
                                "stp x8, x9, [{out}]",
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) ptr_reg!(old),
                                new = in(reg) ptr_reg!(new),
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                old_lo = out(reg) _,
                                old_hi = out(reg) _,
                                r = lateout(reg) r,
                                // new pair - must be allocated to even/odd register pair
                                out("x4") _, // new_lo
                                out("x5") _, // new_hi
                                // out pair - must be allocated to even/odd register pair
                                out("x8") _, // out_lo
                                out("x9") _, // out_hi
                                // Do not use `preserves_flags` because CMP and CCMP modify the condition flags.
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
                                // load from old/new to old/new pair
                                "ldp {new_lo}, {new_hi}, [{new}]",
                                "ldp {old_lo}, {old_hi}, [{old}]",
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    concat!("ld", $acquire, "xp {out_lo}, {out_hi}, [{dst}]"),
                                    "cmp {out_lo}, {old_lo}",
                                    "cset {r:w}, ne",
                                    "cmp {out_hi}, {old_hi}",
                                    "cinc {r:w}, {r:w}, ne",
                                    "cbz {r:w}, 3f", // jump if compare succeed
                                    concat!("st", $release, "xp {r:w}, {out_lo}, {out_hi}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b", // continue loop if store failed
                                    "mov {r:w}, #1", // mark as failed
                                    "b 4f",
                                "3:",
                                    concat!("st", $release, "xp {r:w}, {new_lo}, {new_hi}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b", // continue loop if store failed
                                "4:",
                                $fence,
                                // store out_tmp to out
                                "stp {out_lo}, {out_hi}, [{out}]",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                old = in(reg) ptr_reg!(old),
                                old_hi = out(reg) _,
                                old_lo = out(reg) _,
                                new = in(reg) ptr_reg!(new),
                                new_hi = out(reg) _,
                                new_lo = out(reg) _,
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                out_hi = out(reg) _,
                                out_lo = out(reg) _,
                                r = lateout(reg) r,
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
        }
    };
}

atomic128!(i128);
atomic128!(u128);
