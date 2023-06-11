// AArch64
//
// Refs:
// - ARM Compiler armasm User Guide
//   https://developer.arm.com/documentation/dui0801/latest
// - Arm A-profile A64 Instruction Set Architecture
//   https://developer.arm.com/documentation/ddi0602/latest
// - Arm Architecture Reference Manual for A-profile architecture
//   https://developer.arm.com/documentation/ddi0487/latest
// - Arm Architecture Reference Manual Supplement - Armv8, for Armv8-R AArch64 architecture profile
//   https://developer.arm.com/documentation/ddi0600/latest
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - aarch64 https://godbolt.org/z/8bhjvcETc
// - aarch64 msvc https://godbolt.org/z/nqzMxq1fW
// - aarch64 (+lse) https://godbolt.org/z/njj3n8xe1
// - aarch64 msvc (+lse) https://godbolt.org/z/TbvbcMP9f
// - aarch64 (+lse,+lse2) https://godbolt.org/z/91EP1Tvfq
// - aarch64 (+rcpc) https://godbolt.org/z/oYEhW56vo

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
            _ => unreachable!("{:?}", $order),
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt, $val_modifier:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

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
                                out = inout(reg) ptr_reg!(out) => _,
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
                                out = inout(reg) ptr_reg!(out) => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }
                        #[cfg(not(any(target_feature = "rcpc", atomic_maybe_uninit_target_feature = "rcpc")))]
                        Ordering::Acquire => atomic_load!("a"),
                        Ordering::SeqCst => atomic_load!("a"),
                        _ => unreachable!("{:?}", order),
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

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
                        _ => unreachable!("{:?}", order),
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp", $val_modifier, "}, [{val}]"),
                                // (atomic) swap
                                // Refs: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/SWPA--SWPAL--SWP--SWPL--SWPAL--SWP--SWPL
                                concat!("swp", $acquire, $release, $asm_suffix, " {tmp", $val_modifier, "}, {tmp", $val_modifier, "}, [{dst}]"),
                                $fence,
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp", $val_modifier, "}, [{out}]"),
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                out = inout(reg) ptr_reg!(out) => _,
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
                                // (atomic) swap
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ld", $acquire, "xr", $asm_suffix, " {out_tmp", $val_modifier, "}, [{dst}]"),
                                    // store val to dst
                                    concat!("st", $release, "xr", $asm_suffix, " {r:w}, {val_tmp", $val_modifier, "}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                $fence,
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp", $val_modifier, "}, [{out}]"),
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                val_tmp = out(reg) _,
                                out = inout(reg) ptr_reg!(out) => _,
                                out_tmp = lateout(reg) _,
                                r = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);

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
                                // (atomic) compare and exchange
                                // Refs: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/CASA--CASAL--CAS--CASL--CASAL--CAS--CASL
                                concat!("cas", $acquire, $release, $asm_suffix, " {out_tmp", $val_modifier, "}, {new_tmp", $val_modifier, "}, [{dst}]"),
                                $fence,
                                concat!("cmp {out_tmp", $val_modifier, "}, {old_tmp", $val_modifier, "}"),
                                // store tmp to out
                                concat!("str", $asm_suffix, " {out_tmp", $val_modifier, "}, [{out}]"),
                                "cset {r:w}, eq",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                old = in(reg) ptr_reg!(old),
                                old_tmp = out(reg) _,
                                new = in(reg) ptr_reg!(new),
                                new_tmp = out(reg) _,
                                out = inout(reg) ptr_reg!(out) => _,
                                out_tmp = lateout(reg) _,
                                r = lateout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            );
                            debug_assert!(r == 0 || r == 1, "r={}", r);
                            r != 0
                        }};
                    }
                    #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $fence:tt) => {{
                            asm!(
                                // load from old/new to old_tmp/new_tmp
                                concat!("ldr", $asm_suffix, " {new_tmp", $val_modifier, "}, [{new}]"),
                                concat!("ldr", $asm_suffix, " {old_tmp", $val_modifier, "}, [{old}]"),
                                // (atomic) compare and exchange
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
                                out = inout(reg) ptr_reg!(out) => _,
                                out_tmp = lateout(reg) _,
                                r = lateout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            );
                            debug_assert!(r == 0 || r == 1, "r={}", r);
                            // 0 if the store was successful, 1 if no store was performed
                            r == 0
                        }};
                    }
                    atomic_rmw!(cmpxchg, order, write = success)
                }
            }
            #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let r: i32;
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                // load from old/new to old_tmp/new_tmp
                                concat!("ldr", $asm_suffix, " {new_tmp", $val_modifier, "}, [{new}]"),
                                concat!("ldr", $asm_suffix, " {old_tmp", $val_modifier, "}, [{old}]"),
                                // (atomic) compare and exchange
                                concat!("ld", $acquire, "xr", $asm_suffix, " {out_tmp", $val_modifier, "}, [{dst}]"),
                                concat!("cmp {out_tmp", $val_modifier, "}, {old_tmp", $val_modifier, "}"),
                                "b.ne 3f",
                                concat!("st", $release, "xr", $asm_suffix, " {r:w}, {new_tmp", $val_modifier, "}, [{dst}]"),
                                // TODO: only emit when the above sc succeed
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
                                out = inout(reg) ptr_reg!(out) => _,
                                out_tmp = lateout(reg) _,
                                r = lateout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg_weak, order, write = success);
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    r == 0
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
// - CASP (DWCAS) added as FEAT_LSE (mandatory from armv8.1-a)
// - LDP/STP (DW load/store) if FEAT_LSE2 (optional from armv8.2-a, mandatory from armv8.4-a) is available
//
// If FEAT_LSE is available at compile-time, we use CASP for load/CAS. Otherwise, use LDXP/STXP loop.
// If FEAT_LSE2 is available at compile-time, we use LDP/STP for load/store.
//
// Note: FEAT_LSE2 doesn't imply FEAT_LSE.
//
// Refs:
// - LDP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/LDP
// - LDXP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/LDXP
// - LDAXP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/LDAXP
// - STP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/STP
// - STXP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/STXP
// - STLXP: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/STLXP
//
// Note: Load-Exclusive pair (by itself) does not guarantee atomicity; to complete an atomic
// operation (even load/store), a corresponding Store-Exclusive pair must succeed.
// See Arm Architecture Reference Manual for A-profile architecture
// Section B2.2.1 "Requirements for single-copy atomicity", and
// Section B2.9 "Synchronization and semaphores" for more.
macro_rules! atomic128 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                #[cfg(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"))]
                // SAFETY: the caller must guarantee that `dst` is valid for reads,
                // 16-byte aligned, that there are no concurrent non-atomic operations.
                // the above cfg guarantee that the CPU supports FEAT_LSE2.
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
                                out = in(reg) ptr_reg!(out),
                                tmp_hi = out(reg) _,
                                tmp_lo = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load_relaxed!(""),
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
                                out = in(reg) ptr_reg!(out),
                                tmp_hi = out(reg) _,
                                tmp_lo = out(reg) _,
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            );
                        },
                        _ => unreachable!("{:?}", order),
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
                                // - https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/CASPA--CASPAL--CASP--CASPL--CASPAL--CASP--CASPL
                                // - https://github.com/taiki-e/portable-atomic/pull/20
                                concat!("casp", $acquire, $release, " x4, x5, x4, x5, [{src}]"),
                                // store out pair to out
                                "stp x4, x5, [{out}]",
                                src = in(reg) ptr_reg!(src),
                                out = in(reg) ptr_reg!(out),
                                // must be allocated to even/odd register pair
                                inout("x4") 0_u64 => _, // out_lo
                                inout("x5") 0_u64 => _, // out_lo
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
                                out = in(reg) ptr_reg!(out),
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
                        _ => unreachable!("{:?}", order),
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                #[cfg(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"))]
                // SAFETY: the caller must guarantee that `dst` is valid for writes,
                // 16-byte aligned, that there are no concurrent non-atomic operations.
                // the above cfg guarantee that the CPU supports FEAT_LSE2.
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
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "dmb ish"),
                        Ordering::SeqCst => atomic_store!("dmb ish", "dmb ish"),
                        _ => unreachable!("{:?}", order),
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
                                // (atomic) store val pair to dst
                                "2:",
                                    // load from dst to tmp pair
                                    concat!("ld", $acquire, "xp {tmp_lo}, {tmp_hi}, [{dst}]"),
                                    // store val pair to dst
                                    concat!("st", $release, "xp {r:w}, {val_lo}, {val_hi}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                $fence,
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                tmp_hi = lateout(reg) _,
                                tmp_lo = lateout(reg) _,
                                r = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(store, order);
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $fence:tt) => {
                            asm!(
                                // load from val to val pair
                                "ldp {val_lo}, {val_hi}, [{val}]",
                                // (atomic) swap
                                "2:",
                                    // load from dst to out pair
                                    concat!("ld", $acquire, "xp {out_lo}, {out_hi}, [{dst}]"),
                                    // store val pair to dst
                                    concat!("st", $release, "xp {r:w}, {val_lo}, {val_hi}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cbnz {r:w}, 2b",
                                $fence,
                                // store out pair to out
                                "stp {out_lo}, {out_hi}, [{out}]",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                out = inout(reg) ptr_reg!(out) => _,
                                val_hi = out(reg) _,
                                val_lo = out(reg) _,
                                out_hi = lateout(reg) _,
                                out_lo = lateout(reg) _,
                                r = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let r: i32;
                    #[cfg(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse"))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $fence:tt) => {{
                            asm!(
                                // load from old/new to x6-x7/x4-x5 pairs
                                "ldp x6, x7, [{old}]",
                                "ldp x4, x5, [{new}]",
                                // casp writes the current value to the first register pair,
                                // so copy the `old`'s value for later comparison.
                                "mov x8, x6",
                                "mov x9, x7",
                                // (atomic) compare and exchange
                                // Refs: https://developer.arm.com/documentation/dui0801/g/A64-Data-Transfer-Instructions/CASPA--CASPAL--CASP--CASPL--CASPAL--CASP--CASPL
                                concat!("casp", $acquire, $release, " x8, x9, x4, x5, [{dst}]"),
                                $fence,
                                // compare x6-x7 pair and x8-x9 pair
                                "eor {tmp_hi}, x9, x7",
                                "eor {tmp_lo}, x8, x6",
                                "orr {tmp_hi}, {tmp_lo}, {tmp_hi}",
                                // store tmp to out
                                "stp x8, x9, [{out}]",
                                "cmp {tmp_hi}, #0",
                                "cset {r:w}, eq",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                old = in(reg) ptr_reg!(old),
                                new = in(reg) ptr_reg!(new),
                                out = inout(reg) ptr_reg!(out) => _,
                                r = lateout(reg) r,
                                tmp_hi = lateout(reg) _,
                                tmp_lo = lateout(reg) _,
                                // must be allocated to even/odd register pair
                                out("x6") _, // old_lo
                                out("x7") _, // old_hi
                                // must be allocated to even/odd register pair
                                out("x4") _, // new_lo
                                out("x5") _, // new_hi
                                // must be allocated to even/odd register pair
                                out("x8") _, // out_lo
                                out("x9") _, // out_hi
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            );
                            debug_assert!(r == 0 || r == 1, "r={}", r);
                            r != 0
                        }};
                    }
                    #[cfg(not(any(target_feature = "lse", atomic_maybe_uninit_target_feature = "lse")))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $fence:tt) => {{
                            asm!(
                                // load from old/new to old/new pair
                                "ldp {new_lo}, {new_hi}, [{new}]",
                                "ldp {old_lo}, {old_hi}, [{old}]",
                                // (atomic) compare and exchange
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
                                out = inout(reg) ptr_reg!(out) => _,
                                out_hi = lateout(reg) _,
                                out_lo = lateout(reg) _,
                                r = lateout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            );
                            debug_assert!(r == 0 || r == 1, "r={}", r);
                            // 0 if the store was successful, 1 if no store was performed
                            r == 0
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

    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
    stress_test!(u16);
    stress_test!(u32);
    stress_test!(u64);
    stress_test!(u128);
}
