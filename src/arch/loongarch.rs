// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
LoongArch

Refs:
- https://github.com/torvalds/linux/blob/v6.11/Documentation/arch/loongarch/introduction.rst#references

Generated asm:
- loongarch64 https://godbolt.org/z/36649a5c8
*/

#[path = "cfgs/loongarch.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

#[rustfmt::skip]
macro_rules! atomic_load {
    ($int_type:ident, $suffix:tt) => {
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
                                concat!("ld.", $suffix, " {out}, {src}, 0"), // atomic { out = *src }
                                $acquire,                                    // fence
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        Ordering::Acquire => atomic_load!("dbar 20"),
                        Ordering::SeqCst => atomic_load!("dbar 16"),
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $suffix:tt) => {
        atomic_load!($int_type, $suffix);
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
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("st.", $suffix, " {val}, {dst}, 0"), // atomic { *dst = val }
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Release | Ordering::SeqCst => {
                            asm!(
                                concat!("amswap_db.", $suffix, " $zero, {val}, {dst}"), // atomic { _x = *dst; *dst = val; _ = _x }
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        }
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
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // AMO is always SeqCst.
                    asm!(
                        concat!("amswap_db.", $suffix, " {out}, {val}, {dst}"), // atomic { _x = *dst; *dst = val; out = _x }
                        dst = in(reg) ptr_reg!(dst),
                        val = in(reg) val,
                        out = out(reg) out,
                        options(nostack, preserves_flags),
                    )
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
                _success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($failure_fence:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ll.", $suffix, " {out}, {dst}, 0"), // atomic { out = *dst; LL = dst }
                                    "bne {out}, {old}, 3f",                      // if out != old { jump 'cmp-fail }
                                    "move {tmp}, {new}",                         // tmp = new
                                    concat!("sc.", $suffix, " {tmp}, {dst}, 0"), // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                                    "beqz {tmp}, 2b",                            // if tmp == 0 { jump 'retry }
                                    "b 4f",                                      // jump 'success
                                "3:", // 'cmp-fail:
                                    $failure_fence,                              // fence
                                    "move {tmp}, $zero",                         // tmp = 0
                                "4:", // 'success:
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                tmp = out(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    // LL/SC is always SeqCst, and fence is needed for branch that doesn't call sc.
                    match failure {
                        Ordering::Relaxed => cmpxchg!("dbar 1792"),
                        Ordering::Acquire => cmpxchg!("dbar 20"),
                        // TODO: LLVM uses dbar 20 (Acquire) here, but should it not be dbar 16 (SeqCst)?
                        Ordering::SeqCst => cmpxchg!("dbar 16"),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($int_type:ident, $suffix:tt) => {
        atomic_load!($int_type, $suffix);
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
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                    // fence
                                concat!("st.", $suffix, " {val}, {dst}, 0"), // atomic { *dst = val }
                                $acquire,                                    // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "dbar 18"),
                        Ordering::SeqCst => atomic_store!("dbar 16", "dbar 16"),
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
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "sll.w {mask}, {mask}, {shift}", // mask <<= shift & 31
                        "sll.w {val}, {val}, {shift}",   // val <<= shift & 31
                        "2:", // 'retry:
                            "ll.w {out}, {dst}, 0",      // atomic { out = *dst; LL = dst }
                            "andn {tmp}, {out}, {mask}", // tmp = out & !mask
                            "or {tmp}, {tmp}, {val}",    // tmp |= val
                            "sc.w {tmp}, {dst}, 0",      // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                            "beqz {tmp}, 2b",            // if tmp == 0 { jump 'retry }
                        "srl.w {out}, {out}, {shift}",   // out >>= shift & 31
                        dst = in(reg) ptr_reg!(dst),
                        val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
                        out = out(reg) out,
                        shift = in(reg) shift,
                        mask = inout(reg) mask => _,
                        tmp = out(reg) _,
                        options(nostack, preserves_flags),
                    );
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
                _success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($failure_fence:tt) => {
                            asm!(
                                "sll.w {mask}, {mask}, {shift}", // mask <<= shift & 31
                                "sll.w {old}, {old}, {shift}",   // old <<= shift & 31
                                "sll.w {new}, {new}, {shift}",   // new <<= shift & 31
                                "2:", // 'retry:
                                    "ll.w {out}, {dst}, 0",      // atomic { tmp = *dst; LL = dst }
                                    "and {tmp}, {out}, {mask}",  // tmp = out & mask
                                    "bne {tmp}, {old}, 3f",      // if tmp != old { jump 'cmp-fail }
                                    "andn {tmp}, {out}, {mask}", // tmp = out & !mask
                                    "or {tmp}, {tmp}, {new}",    // tmp |= new
                                    "sc.w {tmp}, {dst}, 0",      // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                                    "beqz {tmp}, 2b",            // if tmp == 0 { jump 'retry }
                                    "b 4f",                      // jump 'success
                                "3:", // 'cmp-fail:
                                    $failure_fence,              // fence
                                    "move {tmp}, $zero",         // tmp = 0
                                "4:", // 'success:
                                "srl.w {out}, {out}, {shift}",   // out >>= shift & 31
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
                    // LL/SC is always SeqCst, and fence is needed for branch that doesn't call sc.
                    match failure {
                        Ordering::Relaxed => cmpxchg!("dbar 1792"),
                        Ordering::Acquire => cmpxchg!("dbar 20"),
                        // TODO: LLVM uses dbar 20 (Acquire) here, but should it not be dbar 16 (SeqCst)?
                        Ordering::SeqCst => cmpxchg!("dbar 16"),
                        _ => unreachable!(),
                    }
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
atomic!(i32, "w");
atomic!(u32, "w");
#[cfg(target_arch = "loongarch64")]
atomic!(i64, "d");
#[cfg(target_arch = "loongarch64")]
atomic!(u64, "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "w");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "w");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d");
