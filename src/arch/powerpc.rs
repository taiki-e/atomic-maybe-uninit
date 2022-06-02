// Refs: https://github.com/boostorg/atomic/blob/a17267547071e0dd60c81945bcb6bf0162a5db07/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp
//
// Generated asm:
// - powerpc https://godbolt.org/z/3Phdaqhrj
// - powerpc64 https://godbolt.org/z/jzcs4foM6
// - powerpc64le https://godbolt.org/z/YT3cT1n85

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic_load_store {
    ($int_type:ident, $ld_suffix:tt, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                #[cfg(target_arch = "powerpc64")]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("l", $ld_suffix, " {tmp}, 0({src})"),
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                out("r0") _,
                                options(nostack),
                            )
                        }
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("l", $ld_suffix, " {tmp}, 0({src})"),
                                "cmpd 7, {tmp}, {tmp}",
                                "bne- 7, 2f",
                                "2:",
                                "isync",
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                out("r0") _,
                                out("r7") _,
                                options(nostack),
                            )
                        }
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
                #[cfg(target_arch = "powerpc")]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) load from src to tmp
                                $release,
                                concat!("l", $ld_suffix, " {tmp}, 0({src})"),
                                $acquire,
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                out("r0") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("lwsync", ""),
                        Ordering::SeqCst => atomic_load!("lwsync", "sync"),
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
                                concat!("l", $ld_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                $release,
                                concat!("st", $asm_suffix, " {tmp}, 0({dst})"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                out("r0") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        Ordering::Release => atomic_store!("lwsync"),
                        Ordering::SeqCst => atomic_store!("sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($int_type:ident, $ld_suffix:tt, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $ld_suffix, $asm_suffix);
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
                                // load from val to val_tmp
                                concat!("l", $ld_suffix, " {val_tmp}, 0({val})"),
                                // (atomic) swap
                                $release,
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("l", $asm_suffix, "arx {out_tmp}, 0, {dst}"),
                                    // store val to dst
                                    concat!("st", $asm_suffix, "cx. {val_tmp}, 0, {dst}"),
                                    "bne 0, 2b",
                                $acquire,
                                // store out_tmp to out
                                concat!("st", $asm_suffix, " {out_tmp}, 0({out})"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                val_tmp = lateout(reg) _,
                                out = inout(reg) out => _,
                                out_tmp = out(reg) _,
                                out("r0") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("lwsync", ""),
                        Ordering::Release => atomic_swap!("", "lwsync"),
                        Ordering::AcqRel => atomic_swap!("lwsync", "lwsync"),
                        Ordering::SeqCst => atomic_swap!("lwsync", "sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[cfg(target_endian = "little")]
atomic!(i8, "bz", "b");
#[cfg(target_endian = "little")]
atomic!(u8, "bz", "b");
#[cfg(target_endian = "little")]
atomic!(i16, "hz", "h");
#[cfg(target_endian = "little")]
atomic!(u16, "hz", "h");
#[cfg(target_endian = "big")]
atomic_load_store!(i8, "bz", "b");
#[cfg(target_endian = "big")]
atomic_load_store!(u8, "bz", "b");
#[cfg(target_endian = "big")]
atomic_load_store!(i16, "hz", "h");
#[cfg(target_endian = "big")]
atomic_load_store!(u16, "hz", "h");
atomic!(i32, "wz", "w");
atomic!(u32, "wz", "w");
#[cfg(target_arch = "powerpc64")]
atomic!(i64, "d", "d");
#[cfg(target_arch = "powerpc64")]
atomic!(u64, "d", "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "wz", "w");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "wz", "w");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d", "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d", "d");

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    #[cfg(target_endian = "little")]
    test_atomic!(i8);
    #[cfg(target_endian = "little")]
    test_atomic!(u8);
    #[cfg(target_endian = "little")]
    test_atomic!(i16);
    #[cfg(target_endian = "little")]
    test_atomic!(u16);
    #[cfg(target_endian = "big")]
    test_atomic_load_store!(i8);
    #[cfg(target_endian = "big")]
    test_atomic_load_store!(u8);
    #[cfg(target_endian = "big")]
    test_atomic_load_store!(i16);
    #[cfg(target_endian = "big")]
    test_atomic_load_store!(u16);
    test_atomic!(i32);
    test_atomic!(u32);
    #[cfg(target_arch = "powerpc64")]
    test_atomic!(i64);
    #[cfg(target_arch = "powerpc64")]
    test_atomic!(u64);

    stress_test_load_store!();
    stress_test_load_swap!();
}
