// Generated asm:
// - armv8-m baseline https://godbolt.org/z/crb989Te3
// - armv8-m mainline https://godbolt.org/z/PrezjhsY6

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

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
                        ($acquire:tt) => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("ld", $acquire, $asm_suffix, " {tmp}, [{src}]"),
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("r"),
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{val}]"),
                                // (atomic) store tmp to dst
                                concat!("st", $release, $asm_suffix, " {tmp}, [{dst}]"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("r"),
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to val_tmp
                                concat!("ldr", $asm_suffix, " {val_tmp}, [{val}]"),
                                // (atomic) swap
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ld", $acquire, "ex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                    // store val to dst
                                    concat!("st", $release, "ex", $asm_suffix, " {r}, {val_tmp}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, 0x0",
                                    "bne 2b",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                r = lateout(reg) _,
                                out_tmp = lateout(reg) _,
                                val_tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("r", "r"),
                        Ordering::Acquire => atomic_swap!("a", "r"),
                        Ordering::Release => atomic_swap!("r", "l"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!("a", "l"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
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
                let success = crate::utils::upgrade_success_ordering(success, failure);

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                unsafe {
                    let mut r: i32;
                    macro_rules! atomic_cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from old/new to old_tmp/new_tmp
                                concat!("ldr", $asm_suffix, " {old_tmp}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new_tmp}, [{new}]"),
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ld", $acquire, "ex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                    "cmp {out_tmp}, {old_tmp}",
                                    "bne 3f",
                                    // store val to dst
                                    concat!("st", $release, "ex", $asm_suffix, " {r}, {new_tmp}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b",
                                    "b 4f",
                                "3:",
                                    "movs {r}, #1",
                                "4:",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                r = lateout(reg) r,
                                out_tmp = lateout(reg) _,
                                old_tmp = lateout(reg) _,
                                new_tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match success {
                        Ordering::Relaxed => atomic_cmpxchg!("r", "r"),
                        Ordering::Acquire => atomic_cmpxchg!("a", "r"),
                        Ordering::Release => atomic_cmpxchg!("r", "l"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_cmpxchg!("a", "l"),
                        _ => unreachable_unchecked!("{:?}", success),
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
                let success = crate::utils::upgrade_success_ordering(success, failure);

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange_weak`.
                unsafe {
                    let mut r: i32;
                    macro_rules! atomic_cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from old/new to old_tmp/new_tmp
                                concat!("ldr", $asm_suffix, " {old_tmp}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new_tmp}, [{new}]"),
                                // load from dst to out_tmp
                                concat!("ld", $acquire, "ex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                "cmp {out_tmp}, {old_tmp}",
                                "bne 3f",
                                // store val to dst
                                concat!("st", $release, "ex", $asm_suffix, " {r}, {new_tmp}, [{dst}]"),
                                "b 4f",
                                "3:",
                                    "clrex",
                                    "movs {r}, #1",
                                "4:",
                                // store out_tmp to out
                                concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                                dst = inout(reg) dst => _,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                r = lateout(reg) r,
                                out_tmp = lateout(reg) _,
                                old_tmp = lateout(reg) _,
                                new_tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match success {
                        Ordering::Relaxed => atomic_cmpxchg!("r", "r"),
                        Ordering::Acquire => atomic_cmpxchg!("a", "r"),
                        Ordering::Release => atomic_cmpxchg!("r", "l"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_cmpxchg!("a", "l"),
                        _ => unreachable_unchecked!("{:?}", success),
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

    stress_test_load_store!();
    stress_test_load_swap!();
}
