// ARMv6-M and ARMv7
//
// Generated asm:
// - armv7-a https://godbolt.org/z/x4cbadvT3
// - armv7-r https://godbolt.org/z/Y87jGfP1q
// - armv7-m https://godbolt.org/z/c1rTPh313
// - armv6-m https://godbolt.org/z/sfMnvET7K

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

#[cfg(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"))]
use crate::raw::{AtomicCompareExchange, AtomicSwap};
use crate::raw::{AtomicLoad, AtomicStore};

#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
macro_rules! dmb {
    () => {
        "dmb ish"
    };
}
// Only a full system barrier exists in the M-class architectures.
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
macro_rules! dmb {
    () => {
        "dmb sy"
    };
}

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:expr) => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{src}]"),
                                $acquire, // acquire fence
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!(dmb!()),
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{val}]"),
                                // (atomic) store tmp to dst
                                $release, // release fence
                                concat!("str", $asm_suffix, " {tmp}, [{dst}]"),
                                $acquire, // acquire fence
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", dmb!()),
                        Ordering::SeqCst => atomic_store!(dmb!(), dmb!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        #[cfg(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"))]
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

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // load from val to val_tmp
                                concat!("ldr", $asm_suffix, " {val_tmp}, [{val}]"),
                                // (atomic) swap
                                $release, // release fence
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                    // store val to dst
                                    concat!("strex", $asm_suffix, " {r}, {val_tmp}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, 0x0",
                                    "bne 2b",
                                $acquire, // acquire fence
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                r = lateout(reg) _,
                                out_tmp = lateout(reg) _,
                                val_tmp = lateout(reg) _,
                                // Do not use `preserves_flags` because cmp modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!(dmb!(), ""),
                        Ordering::Release => atomic_swap!("", dmb!()),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!(dmb!(), dmb!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        #[cfg(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"))]
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

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_store_relaxed {
                        ($acquire_success:expr, $acquire_failure:expr) => {
                            asm!(
                                concat!("ldr", $asm_suffix, " {old_tmp}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new_tmp}, [{new}]"),
                                "2:",
                                    concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                    "cmp {out_tmp}, {old_tmp}",
                                    "bne 3f", // jump if compare failed
                                    concat!("strex", $asm_suffix, " {r}, {new_tmp}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b", // continue loop if store failed
                                    $acquire_success,
                                    "b 4f",
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                    $acquire_failure,
                                "4:",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                out_tmp = lateout(reg) _,
                                old_tmp = lateout(reg) _,
                                new_tmp = lateout(reg) _,
                                // Do not use `preserves_flags` because cmp modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_release {
                        ($acquire_failure:expr) => {
                            asm!(
                                concat!("ldr", $asm_suffix, " {old_tmp}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new_tmp}, [{new}]"),
                                concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                "cmp {out_tmp}, {old_tmp}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    concat!("strex", $asm_suffix, " {r}, {new_tmp}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                    "cmp {out_tmp}, {old_tmp}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                    $acquire_failure,
                                "4:",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                out_tmp = lateout(reg) _,
                                old_tmp = lateout(reg) _,
                                new_tmp = lateout(reg) _,
                                // Do not use `preserves_flags` because cmp modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_acqrel {
                        ($acquire_failure:expr) => {
                            asm!(
                                concat!("ldr", $asm_suffix, " {old_tmp}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new_tmp}, [{new}]"),
                                concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                "cmp {out_tmp}, {old_tmp}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    concat!("strex", $asm_suffix, " {r}, {new_tmp}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                    "cmp {out_tmp}, {old_tmp}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                    $acquire_failure,
                                    "b 5f",
                                "4:", // store succeed
                                    dmb!(), // acquire_success
                                "5:",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                out_tmp = lateout(reg) _,
                                old_tmp = lateout(reg) _,
                                new_tmp = lateout(reg) _,
                                // Do not use `preserves_flags` because cmp modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match (success, failure) {
                        (Relaxed, Relaxed) => cmpxchg_store_relaxed!("", ""),
                        (Relaxed, Acquire | SeqCst) => cmpxchg_store_relaxed!("", dmb!()),
                        (Acquire, Relaxed) => cmpxchg_store_relaxed!(dmb!(), ""),
                        (Acquire, Acquire | SeqCst) => cmpxchg_store_relaxed!(dmb!(), dmb!()),
                        (Release, Relaxed) => cmpxchg_release!(""),
                        (Release, Acquire | SeqCst) => cmpxchg_release!(dmb!()),
                        // AcqRel and SeqCst compare_exchange are equivalent.
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_acqrel!(""),
                        (AcqRel | SeqCst, _) => cmpxchg_acqrel!(dmb!()),
                        _ => unreachable_unchecked!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    r == 0
                }
            }
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

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange_weak`.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                concat!("ldr", $asm_suffix, " {old_tmp}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new_tmp}, [{new}]"),
                                concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                "cmp {out_tmp}, {old_tmp}",
                                "bne 3f", // jump if compare failed
                                $release,
                                concat!("strex", $asm_suffix, " {r}, {new_tmp}, [{dst}]"),
                                "b 4f",
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                "4:",
                                $acquire,
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                out_tmp = lateout(reg) _,
                                old_tmp = lateout(reg) _,
                                new_tmp = lateout(reg) _,
                                // Do not use `preserves_flags` because cmp modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_fail_load_relaxed {
                        ($release:expr) => {
                            asm!(
                                concat!("ldr", $asm_suffix, " {old_tmp}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new_tmp}, [{new}]"),
                                concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                "cmp {out_tmp}, {old_tmp}",
                                "bne 3f", // jump if compare failed
                                $release,
                                concat!("strex", $asm_suffix, " {r}, {new_tmp}, [{dst}]"),
                                // 0 if the store was successful, 1 if no store was performed
                                "cmp {r}, #0",
                                "beq 4f", // jump if store succeed
                                "b 5f", // jump (store failed)
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                    "b 5f",
                                "4:", // store succeed
                                    dmb!(), // acquire_success
                                "5:",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                out_tmp = lateout(reg) _,
                                old_tmp = lateout(reg) _,
                                new_tmp = lateout(reg) _,
                                // Do not use `preserves_flags` because cmp modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_success_load_relaxed {
                        ($release:expr) => {
                            asm!(
                                concat!("ldr", $asm_suffix, " {old_tmp}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new_tmp}, [{new}]"),
                                concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                "cmp {out_tmp}, {old_tmp}",
                                "bne 3f", // jump if compare failed
                                $release,
                                concat!("strex", $asm_suffix, " {r}, {new_tmp}, [{dst}]"),
                                // 0 if the store was successful, 1 if no store was performed
                                "cmp {r}, #0",
                                "beq 5f", // jump if store succeed
                                "b 4f", // jump (store failed)
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                "4:", // compare or store failed
                                    dmb!(), // acquire_failure
                                "5:",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                out_tmp = lateout(reg) _,
                                old_tmp = lateout(reg) _,
                                new_tmp = lateout(reg) _,
                                // Do not use `preserves_flags` because cmp modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match (success, failure) {
                        (Relaxed, Relaxed) => cmpxchg_weak!("", ""),
                        (Relaxed, Acquire | SeqCst) => cmpxchg_weak_success_load_relaxed!(""),
                        (Acquire, Relaxed) => cmpxchg_weak_fail_load_relaxed!(""),
                        (Acquire, Acquire | SeqCst) => cmpxchg_weak!(dmb!(), ""),
                        (Release, Relaxed) => cmpxchg_weak!("", dmb!()),
                        (Release, Acquire | SeqCst) => cmpxchg_weak_success_load_relaxed!(dmb!()),
                        // AcqRel and SeqCst compare_exchange_weak are equivalent.
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_weak_fail_load_relaxed!(dmb!()),
                        (AcqRel | SeqCst, _) => cmpxchg_weak!(dmb!(), dmb!()),
                        _ => unreachable_unchecked!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    r == 0
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

// Refs:
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/LDREXD
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/STREXD
#[rustfmt::skip]
macro_rules! atomic64 {
    ($int_type:ident) => {
        #[cfg(any(target_feature = "aclass", atomic_maybe_uninit_target_feature = "aclass"))]
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:expr) => {
                            asm!(
                                // (atomic) load from src to tmp pair
                                "ldrexd r2, r3, [{src}]",
                                "clrex",
                                $acquire, // acquire fence
                                // store tmp pair to out
                                "strd r2, r3, [{out}]",
                                src = in(reg) src,
                                out = in(reg) out,
                                // tmp pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!(dmb!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        #[cfg(any(target_feature = "aclass", atomic_maybe_uninit_target_feature = "aclass"))]
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // load from val to val pair
                                "ldrd r2, r3, [{val}]",
                                // (atomic) store val pair to dst
                                $release, // release fence
                                "2:",
                                    // load from dst to tmp pair
                                    "ldrexd r4, r5, [{dst}]",
                                    // store val pair to dst
                                    "strexd {r}, r2, r3, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, 0x0",
                                    "bne 2b",
                                $acquire, // acquire fence
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                r = lateout(reg) _,
                                // val pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // tmp pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                // Do not use `preserves_flags` because cmp modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", dmb!()),
                        Ordering::SeqCst => atomic_store!(dmb!(), dmb!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        #[cfg(any(target_feature = "aclass", atomic_maybe_uninit_target_feature = "aclass"))]
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

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // load from val to val pair
                                "ldrd r2, r3, [{val}]",
                                // (atomic) swap
                                $release, // release fence
                                "2:",
                                    // load from dst to out pair
                                    "ldrexd r4, r5, [{dst}]",
                                    // store val pair to dst
                                    "strexd {r}, r2, r3, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, 0x0",
                                    "bne 2b",
                                $acquire, // acquire fence
                                // store out pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                r = lateout(reg) _,
                                // val pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                // Do not use `preserves_flags` because cmp modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!(dmb!(), ""),
                        Ordering::Release => atomic_swap!("", dmb!()),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!(dmb!(), dmb!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        #[cfg(any(target_feature = "aclass", atomic_maybe_uninit_target_feature = "aclass"))]
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

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_store_relaxed {
                        ($acquire_success:expr, $acquire_failure:expr) => {
                            asm!(
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                "2:",
                                    "ldrexd r4, r5, [{dst}]",
                                    "eor {tmp}, r5, r3",
                                    "eor {r}, r4, r2",
                                    "orrs {r}, {r}, {tmp}",
                                    "bne 3f", // jump if compare failed
                                    "strexd  {r}, r8, r9, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b", // continue loop if store failed
                                    $acquire_success,
                                    "b 4f",
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                    $acquire_failure,
                                "4:",
                                // store r4-r5 pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                // new pair - must be even-numbered and not R14
                                lateout("r8") _,
                                lateout("r9") _,
                                // Do not use `preserves_flags` because cmp and orrs modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_release {
                        ($acquire_failure:expr) => {
                            asm!(
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    "strexd  {r}, r8, r9, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    "ldrexd r4, r5, [{dst}]",
                                    "eor {tmp}, r5, r3",
                                    "eor {r}, r4, r2",
                                    "orrs {r}, {r}, {tmp}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                    $acquire_failure,
                                "4:",
                                // store r4-r5 pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                // new pair - must be even-numbered and not R14
                                lateout("r8") _,
                                lateout("r9") _,
                                // Do not use `preserves_flags` because cmp and orrs modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_acqrel {
                        ($acquire_failure:expr) => {
                            asm!(
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    "strexd  {r}, r8, r9, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    "ldrexd r4, r5, [{dst}]",
                                    "eor {tmp}, r5, r3",
                                    "eor {r}, r4, r2",
                                    "orrs {r}, {r}, {tmp}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                    $acquire_failure,
                                    "b 5f",
                                "4:", // store succeed
                                    dmb!(), // acquire_success
                                "5:",
                                // store r4-r5 pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                // new pair - must be even-numbered and not R14
                                lateout("r8") _,
                                lateout("r9") _,
                                // Do not use `preserves_flags` because cmp and orrs modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match (success, failure) {
                        (Relaxed, Relaxed) => cmpxchg_store_relaxed!("", ""),
                        (Relaxed, Acquire | SeqCst) => cmpxchg_store_relaxed!("", dmb!()),
                        (Acquire, Relaxed) => cmpxchg_store_relaxed!(dmb!(), ""),
                        (Acquire, Acquire | SeqCst) => cmpxchg_store_relaxed!(dmb!(), dmb!()),
                        (Release, Relaxed) => cmpxchg_release!(""),
                        (Release, Acquire | SeqCst) => cmpxchg_release!(dmb!()),
                        // AcqRel and SeqCst compare_exchange are equivalent.
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_acqrel!(""),
                        (AcqRel | SeqCst, _) => cmpxchg_acqrel!(dmb!()),
                        _ => unreachable_unchecked!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    r == 0
                }
            }
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

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange_weak`.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                $release,
                                "strexd  {r}, r8, r9, [{dst}]",
                                "b 4f",
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                "4:",
                                $acquire,
                                // store r4-r5 pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                // new pair - must be even-numbered and not R14
                                lateout("r8") _,
                                lateout("r9") _,
                                // Do not use `preserves_flags` because orrs modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_fail_load_relaxed {
                        ($release:expr) => {
                            asm!(
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                $release,
                                "strexd  {r}, r8, r9, [{dst}]",
                                // 0 if the store was successful, 1 if no store was performed
                                "cmp {r}, #0",
                                "beq 4f", // jump if store succeed
                                "b 5f", // jump (store failed)
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                    "b 5f",
                                "4:", // store succeed
                                    dmb!(), // acquire_success
                                "5:",
                                // store r4-r5 pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                // new pair - must be even-numbered and not R14
                                lateout("r8") _,
                                lateout("r9") _,
                                // Do not use `preserves_flags` because cmp and orrs modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_success_load_relaxed {
                        ($release:expr) => {
                            asm!(
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                $release,
                                "strexd  {r}, r8, r9, [{dst}]",
                                // 0 if the store was successful, 1 if no store was performed
                                "cmp {r}, #0",
                                "beq 5f", // jump if store succeed
                                "b 4f", // jump (store failed)
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    "clrex",
                                "4:", // compare or store failed
                                    dmb!(), // acquire_failure
                                "5:",
                                // store r4-r5 pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                // new pair - must be even-numbered and not R14
                                lateout("r8") _,
                                lateout("r9") _,
                                // Do not use `preserves_flags` because cmp and orrs modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match (success, failure) {
                        (Relaxed, Relaxed) => cmpxchg_weak!("", ""),
                        (Relaxed, Acquire | SeqCst) => cmpxchg_weak_success_load_relaxed!(""),
                        (Acquire, Relaxed) => cmpxchg_weak_fail_load_relaxed!(""),
                        (Acquire, Acquire | SeqCst) => cmpxchg_weak!(dmb!(), ""),
                        (Release, Relaxed) => cmpxchg_weak!("", dmb!()),
                        (Release, Acquire | SeqCst) => cmpxchg_weak_success_load_relaxed!(dmb!()),
                        // AcqRel and SeqCst compare_exchange_weak are equivalent.
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_weak_fail_load_relaxed!(dmb!()),
                        (AcqRel | SeqCst, _) => cmpxchg_weak!(dmb!(), dmb!()),
                        _ => unreachable_unchecked!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    r == 0
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);

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

    stress_test_load_store!();
    stress_test_load_swap!();
}
