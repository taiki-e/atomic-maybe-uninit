// Generated asm:
// - mipsel https://godbolt.org/z/61zcr1cdT
// - mips64el https://godbolt.org/z/1sd3Pv1M6

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic_load_store {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                ".set noat",
                                // (atomic) load from src to tmp
                                concat!("l", $asm_suffix, " {tmp}, 0({src})"),
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                ".set at",
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                options(nostack),
                            );
                        }
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => {
                            asm!(
                                ".set noat",
                                // (atomic) load from src to tmp
                                concat!("l", $asm_suffix, " {tmp}, 0({src})"),
                                "sync",
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                ".set at",
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                options(nostack),
                            );
                        }
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
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                ".set noat",
                                // load from val to tmp
                                concat!("l", $asm_suffix, $asm_u_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                ".set at",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack),
                            );
                        }
                        Ordering::Release => {
                            asm!(
                                ".set noat",
                                // load from val to tmp
                                concat!("l", $asm_suffix, $asm_u_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                "sync",
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                ".set at",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack),
                            );
                        }
                        Ordering::SeqCst => {
                            asm!(
                                ".set noat",
                                // load from val to tmp
                                concat!("l", $asm_suffix, $asm_u_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                "sync",
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                "sync",
                                ".set at",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack),
                            );
                        }
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt, $asm_ll_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, $asm_u_suffix);
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
                        ($acq:expr, $rel:expr) => {
                            asm!(
                                ".set noat",
                                // load from val to val_tmp
                                concat!("l", $asm_suffix, " {val_tmp}, 0({val})"),
                                // (atomic) swap
                                $rel, // release fence
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ll", $asm_ll_suffix, " {out_tmp}, 0({dst})"),
                                    "move {r}, {val_tmp}",
                                    // store val to dst
                                    concat!("sc", $asm_ll_suffix, " {r}, 0({dst})"),
                                    // 1 if the store was successful, 0 if no store was performed
                                    "beqz {r}, 2b",
                                $acq, // acquire fence
                                // store out_tmp to out
                                concat!("s", $asm_suffix, " {out_tmp}, 0({out})"),
                                ".set at",
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
                        Ordering::Acquire => atomic_swap!("sync", ""),
                        Ordering::Release => atomic_swap!("", "sync"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!("sync", "sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

atomic_load_store!(i8, "b", "u");
atomic_load_store!(u8, "b", "u");
atomic_load_store!(i16, "h", "u");
atomic_load_store!(u16, "h", "u");
atomic!(i32, "w", "", "");
atomic!(u32, "w", "", "");
#[cfg(target_arch = "mips64")]
atomic!(i64, "d", "", "d");
#[cfg(target_arch = "mips64")]
atomic!(u64, "d", "", "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "w", "", "");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "w", "", "");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d", "", "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d", "", "d");

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic_load_store!(i8);
    test_atomic_load_store!(u8);
    test_atomic_load_store!(i16);
    test_atomic_load_store!(u16);
    test_atomic!(i32);
    test_atomic!(u32);
    #[cfg(target_arch = "mips64")]
    test_atomic!(i64);
    #[cfg(target_arch = "mips64")]
    test_atomic!(u64);

    stress_test_load_store!();
    stress_test_load_swap!();
}
