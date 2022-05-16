// Generated asm:
// - armv7-a https://godbolt.org/z/KPPxxMzWq
// - armv7-r https://godbolt.org/z/9cPf7cb9j
// - armv7-m https://godbolt.org/z/bW44v9dvj

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature_mclass)))]
macro_rules! asm_dmb {
    () => {
        "dmb ish"
    };
}
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature_mclass))]
macro_rules! asm_dmb {
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
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    macro_rules! atomic_load {
                        ($acq:expr) => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{src}]"),
                                $acq, // acquire fence
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
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!(asm_dmb!()),
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
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($acq:expr, $rel:expr) => {
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{val}]"),
                                // (atomic) store tmp to dst
                                $rel, // release fence
                                concat!("str", $asm_suffix, " {tmp}, [{dst}]"),
                                $acq, // acquire fence
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", asm_dmb!()),
                        Ordering::SeqCst => atomic_store!(asm_dmb!(), asm_dmb!()),
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
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acq:expr, $rel:expr) => {
                            asm!(
                                // load from val to val_tmp
                                concat!("ldr", $asm_suffix, " {val_tmp}, [{val}]"),
                                // (atomic) swap
                                $rel, // release fence
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ldrex", $asm_suffix, " {out_tmp}, [{dst}]"),
                                    // store val to dst
                                    concat!("strex", $asm_suffix, " {r}, {val_tmp}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, 0x0",
                                    "bne 2b",
                                $acq, // acquire fence
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
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!(asm_dmb!(), ""),
                        Ordering::Release => atomic_swap!("", asm_dmb!()),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!(asm_dmb!(), asm_dmb!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
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
        #[cfg(any(target_feature = "aclass", atomic_maybe_uninit_target_feature_aclass))]
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    macro_rules! atomic_load {
                        ($acq:expr) => {
                            asm!(
                                // (atomic) load from src to tmp pair
                                "ldrexd r2, r3, [{src}]",
                                "clrex",
                                $acq, // acquire fence
                                // store tmp pair to out
                                "strd r2, r3, [{out}]",
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                // tmp pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!(asm_dmb!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        #[cfg(any(target_feature = "aclass", atomic_maybe_uninit_target_feature_aclass))]
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                order: Ordering,
            ) {
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($acq:expr, $rel:expr) => {
                            asm!(
                                // load from val to val pair
                                "ldrd r2, r3, [{val}]",
                                // (atomic) store val pair to dst
                                $rel, // release fence
                                "2:",
                                    // load from dst to tmp pair
                                    "ldrexd r4, r5, [{dst}]",
                                    // store val pair to dst
                                    "strexd {r}, r2, r3, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, 0x0",
                                    "bne 2b",
                                $acq, // acquire fence
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                r = lateout(reg) _,
                                // val pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // tmp pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", asm_dmb!()),
                        Ordering::SeqCst => atomic_store!(asm_dmb!(), asm_dmb!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        #[cfg(any(target_feature = "aclass", atomic_maybe_uninit_target_feature_aclass))]
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acq:expr, $rel:expr) => {
                            asm!(
                                // load from val to val pair
                                "ldrd r2, r3, [{val}]",
                                // (atomic) swap
                                $rel, // release fence
                                "2:",
                                    // load from dst to tmp pair
                                    "ldrexd r4, r5, [{dst}]",
                                    // store val pair to dst
                                    "strexd {r}, r2, r3, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, 0x0",
                                    "bne 2b",
                                $acq, // acquire fence
                                // store tmp pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                r = lateout(reg) _,
                                // val pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // tmp pair - must be even-numbered and not R14
                                lateout("r4") _,
                                lateout("r5") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!(asm_dmb!(), ""),
                        Ordering::Release => atomic_swap!("", asm_dmb!()),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!(asm_dmb!(), asm_dmb!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
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
