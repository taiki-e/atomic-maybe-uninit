// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
MIPS32 and MIPS64

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#mips

Refs:
- The MIPS32® Instruction Set Manual, Revision 6.06 (MD00086) https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00086-2B-MIPS32BIS-AFP-6.06.pdf
- The MIPS64® Instruction Set Reference Manual, Revision 6.06 (MD00087) https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00087-2B-MIPS64BIS-AFP-6.06.pdf
- MIPS® Coherence Protocol Specification, Revision 01.01 (MD00605) https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00605-2B-CMPCOHERE-AFP-01.01.pdf

Generated asm:
- mips https://godbolt.org/z/KMYoovEWe
- mipsel https://godbolt.org/z/5n1c1M4Ev
- mips64 https://godbolt.org/z/qErPfjKM9
- mips64el https://godbolt.org/z/n1P1vGvfe
*/

#[path = "cfgs/mips.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("sync", ""),
            Ordering::Release => $op!("", "sync"),
            // AcqRel and SeqCst RMWs are equivalent.
            Ordering::AcqRel | Ordering::SeqCst => $op!("sync", "sync"),
            _ => unreachable!(),
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $size:tt, $l_u_suffix:tt) => {
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
                                ".set push",
                                ".set noat",
                                concat!("l", $size, " {out}, 0({src})"), // atomic { out = *src }
                                $acquire,                                // fence
                                ".set pop",
                                src = in(reg) ptr_reg!(src),
                                out = out(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("sync"),
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
                    macro_rules! store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                $release,                                // fence
                                concat!("s", $size, " {val}, 0({dst})"), // atomic { *dst = val }
                                $acquire,                                // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(store, order);
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $size:tt, $ll_sc_suffix:tt) => {
        atomic_load_store!($ty, $size, "");
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
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                $release,                                             // fence
                                "2:", // 'retry:
                                    concat!("ll", $ll_sc_suffix, " {out}, 0({dst})"), // atomic { out = *dst; LL = dst }
                                    "move {tmp}, {val}",                              // tmp = val
                                    concat!("sc", $ll_sc_suffix, " {tmp}, 0({dst})"), // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                                    "beqz {tmp}, 2b",                                 // if tmp == 0 { jump 'retry }
                                $acquire,                                             // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                tmp = out(reg) _,
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
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                $release,                                             // fence
                                "2:", // 'retry:
                                    concat!("ll", $ll_sc_suffix, " {out}, 0({dst})"), // atomic { out = *dst; LL = dst }
                                    "bne {out}, {old}, 3f",                           // if out != old { jump 'cmp-fail }
                                    "move {tmp}, {new}",                              // tmp = new
                                    concat!("sc", $ll_sc_suffix, " {tmp}, 0({dst})"), // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                                    "beqz {tmp}, 2b",                                 // if tmp == 0 { jump 'retry }
                                    "b 4f",                                           // jump 'success
                                "3:", // 'cmp-fail:
                                    "li {tmp}, 0",                                    // tmp = 0
                                "4:", // 'success:
                                $acquire,                                             // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                tmp = out(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($ty:ident, $size:tt) => {
        atomic_load_store!($ty, $size, "u");
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                "sllv {mask}, {mask}, {shift}", // mask <<= shift & 31
                                "sllv {val}, {val}, {shift}",   // val <<= shift & 31
                                "nor {mask}, {mask}, $zero",    // mask = !mask
                                $release,                       // fence
                                "2:", // 'retry:
                                    "ll {out}, 0({dst})",       // atomic { out = *dst; LL = dst }
                                    "and {tmp}, {out}, {mask}", // tmp = out & mask
                                    "or {tmp}, {tmp}, {val}",   // tmp |= val
                                    "sc {tmp}, 0({dst})",       // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                                    "beqz {tmp}, 2b",           // if tmp == 0 { jump 'retry }
                                "srlv {out}, {out}, {shift}",   // out >>= shift & 31
                                $acquire,                       // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) _,
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
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                "sllv {mask}, {mask}, {shift}", // mask <<= shift & 31
                                "sllv {old}, {old}, {shift}",   // old <<= shift & 31
                                "sllv {new}, {new}, {shift}",   // new <<= shift & 31
                                $release,                       // fence
                                "2:", // 'retry:
                                    "ll {out}, 0({dst})",       // atomic { out = *dst; LL = dst }
                                    "and {tmp}, {out}, {mask}", // tmp = out & mask
                                    "bne {tmp}, {old}, 3f",     // if tmp != old { jump 'cmp-fail }
                                    "xor {tmp}, {out}, {new}",  // tmp = out ^ new
                                    "and {tmp}, {tmp}, {mask}", // tmp &= mask
                                    "xor {tmp}, {tmp}, {out}",  // tmp ^= out
                                    "sc {tmp}, 0({dst})",       // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                                    "beqz {tmp}, 2b",           // if tmp == 0 { jump 'retry }
                                    "b 4f",                     // jump 'success
                                "3:", // 'cmp-fail:
                                    "li {tmp}, 0",              // tmp = 0
                                "4:", // 'success:
                                "srlv {out}, {out}, {shift}",   // out >>= shift & 31
                                $acquire,                       // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) crate::utils::ZeroExtend::zero_extend(old) => _,
                                new = inout(reg) crate::utils::ZeroExtend::zero_extend(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

atomic_sub_word!(i8, "b");
atomic_sub_word!(u8, "b");
atomic_sub_word!(i16, "h");
atomic_sub_word!(u16, "h");
atomic!(i32, "w", "");
atomic!(u32, "w", "");
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
atomic!(i64, "d", "d");
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
atomic!(u64, "d", "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "w", "");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "w", "");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d", "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d", "d");
