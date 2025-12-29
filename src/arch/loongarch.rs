// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
LoongArch32 and LoongArch64

Refs:
- LoongArch Reference Manual - Volume 1: Basic Architecture
  https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

delegate_size!(delegate_all);

#[cfg(target_arch = "loongarch64")]
use core::cell::UnsafeCell;
pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap};

#[cfg(target_arch = "loongarch32")]
macro_rules! addi {
    () => {
        "addi.w"
    };
}
#[cfg(target_arch = "loongarch64")]
macro_rules! addi {
    () => {
        "addi.d"
    };
}

#[rustfmt::skip]
macro_rules! atomic_load {
    ($ty:ident, $($size:literal)?, $suffix:tt) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
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
        $(
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("ld.", $suffix, " {tmp0}, {src}, 0"), // atomic { tmp0 = *src }
                    concat!(addi!(), " {src}, {src}, ", $size),   // src = src.byte_add($size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("ld.", $suffix, " {tmp1}, {src}, ", $size), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("ld.", $suffix, " {tmp0}, {src}, 0"),       // atomic { tmp0 = *src }
                    concat!(addi!(), " {src}, {src}, 2*", $size),       // src = src.byte_add(2*$size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("st.", $suffix, " {tmp0}, {dst}, 0"), // atomic { *dst = tmp0 }
                    concat!(addi!(), " {dst}, {dst}, ", $size),   // dst = dst.byte_add($size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("st.", $suffix, " {tmp1}, {dst}, ", $size), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("st.", $suffix, " {tmp0}, {dst}, 0"),       // atomic { *dst = tmp0 }
                    concat!(addi!(), " {dst}, {dst}, 2*", $size),       // dst = dst.byte_add(2*$size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
        }
        )?
    };
}

#[rustfmt::skip]
macro_rules! atomic_store {
    ($ty:ident, $suffix:tt) => {
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

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
    };
}

macro_rules! atomic {
    ($ty:ident, $($size:literal)?, $suffix:tt) => {
        atomic_load!($ty, $($size)?, $suffix);
        #[cfg(any(
            target_arch = "loongarch32",
            atomic_maybe_uninit_test_prefer_st_ll_sc_over_amswap,
        ))]
        atomic_store!($ty, $suffix);
        #[cfg(not(any(
            target_arch = "loongarch32",
            atomic_maybe_uninit_test_prefer_st_ll_sc_over_amswap,
        )))]
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

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
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(any(
                        target_arch = "loongarch32",
                        atomic_maybe_uninit_test_prefer_st_ll_sc_over_amswap,
                    ))]
                    asm!(
                        "2:", // 'retry:
                            concat!("ll.", $suffix, " {out}, {dst}, 0"),  // atomic { out = *dst; LL = dst }
                            "move {tmp}, {val}",                          // tmp = val
                            concat!("sc.", $suffix, " {tmp}, {dst}, 0"),  // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                            "beqz {tmp}, 2b",                             // if tmp == 0 { jump 'retry }
                        dst = in(reg) ptr_reg!(dst),
                        val = in(reg) val,
                        out = out(reg) out,
                        tmp = out(reg) _,
                        options(nostack, preserves_flags),
                    );
                    // AMO is always SeqCst.
                    #[cfg(not(any(
                        target_arch = "loongarch32",
                        atomic_maybe_uninit_test_prefer_st_ll_sc_over_amswap,
                    )))]
                    asm!(
                        concat!("amswap_db.", $suffix, " {out}, {val}, {dst}"), // atomic { _x = *dst; *dst = val; out = _x }
                        dst = in(reg) ptr_reg!(dst),
                        val = in(reg) val,
                        out = out(reg) out,
                        options(nostack, preserves_flags),
                    );
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
                _success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
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
    ($ty:ident, $size:literal, $suffix:tt) => {
        atomic_load!($ty, $size, $suffix);
        atomic_store!($ty, $suffix);
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
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
                        val = inout(reg) crate::utils::extend32::$ty::zero(val) => _,
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
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
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
                                old = inout(reg) crate::utils::extend32::$ty::zero(old) => _,
                                new = inout(reg) crate::utils::extend32::$ty::zero(new) => _,
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

atomic_sub_word!(u8, "1", "b");
atomic_sub_word!(u16, "2", "h");
atomic!(u32, "4", "w");
#[cfg(target_arch = "loongarch64")]
atomic!(u64,    , "d");

#[cfg(target_arch = "loongarch64")]
impl AtomicMemcpy for u64 {
    load_memcpy_opt64! { |src, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7|
        asm!(
            "ld.d {tmp0}, {src}, 0",    // atomic { tmp0 = *src }
            "addi.d {src}, {src}, 8",   // src = src.byte_add(8)
            src = inout(reg) src,
            tmp0 = out(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            "ld.d {tmp1}, {src}, 8",    // atomic { tmp1 = *src.byte_add(8) }
            "ld.d {tmp0}, {src}, 0",    // atomic { tmp0 = *src }
            "addi.d {src}, {src}, 2*8", // src = src.byte_add(2*8)
            src = inout(reg) src,
            tmp0 = out(reg) tmp0,
            tmp1 = out(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            "ld.d {tmp7}, {src}, 8*7",  // atomic { tmp7 = *src.byte_add(8*7) }
            "ld.d {tmp6}, {src}, 8*6",  // atomic { tmp6 = *src.byte_add(8*6) }
            "ld.d {tmp5}, {src}, 8*5",  // atomic { tmp5 = *src.byte_add(8*5) }
            "ld.d {tmp4}, {src}, 8*4",  // atomic { tmp4 = *src.byte_add(8*4) }
            "ld.d {tmp3}, {src}, 8*3",  // atomic { tmp3 = *src.byte_add(8*3) }
            "ld.d {tmp2}, {src}, 8*2",  // atomic { tmp2 = *src.byte_add(8*2) }
            "ld.d {tmp1}, {src}, 8*1",  // atomic { tmp1 = *src.byte_add(8*1) }
            "ld.d {tmp0}, {src}, 0",    // atomic { tmp0 = *src }
            "addi.d {src}, {src}, 8*8", // src = src.byte_add(8*8)
            src = inout(reg) src,
            tmp0 = out(reg) tmp0,
            tmp1 = out(reg) tmp1,
            tmp2 = out(reg) tmp2,
            tmp3 = out(reg) tmp3,
            tmp4 = out(reg) tmp4,
            tmp5 = out(reg) tmp5,
            tmp6 = out(reg) tmp6,
            tmp7 = out(reg) tmp7,
            options(nostack, preserves_flags),
        ),
    }
    store_memcpy_opt64! { |dst, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7|
        asm!(
            "st.d {tmp0}, {dst}, 0",    // atomic { *dst = tmp0 }
            "addi.d {dst}, {dst}, 8",   // dst = dst.byte_add(8)
            dst = inout(reg) dst,
            tmp0 = in(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            "st.d {tmp1}, {dst}, 8",    // atomic { *dst.byte_add(8) = tmp1 }
            "st.d {tmp0}, {dst}, 0",    // atomic { *dst = tmp0 }
            "addi.d {dst}, {dst}, 2*8", // dst = dst.byte_add(2*8)
            dst = inout(reg) dst,
            tmp0 = in(reg) tmp0,
            tmp1 = in(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            "st.d {tmp7}, {dst}, 8*7",  // atomic { *dst.byte_add(8*7) = tmp7 }
            "st.d {tmp6}, {dst}, 8*6",  // atomic { *dst.byte_add(8*6) = tmp6 }
            "st.d {tmp5}, {dst}, 8*5",  // atomic { *dst.byte_add(8*5) = tmp5 }
            "st.d {tmp4}, {dst}, 8*4",  // atomic { *dst.byte_add(8*4) = tmp4 }
            "st.d {tmp3}, {dst}, 8*3",  // atomic { *dst.byte_add(8*3) = tmp3 }
            "st.d {tmp2}, {dst}, 8*2",  // atomic { *dst.byte_add(8*2) = tmp2 }
            "st.d {tmp1}, {dst}, 8*1",  // atomic { *dst.byte_add(8*1) = tmp1 }
            "st.d {tmp0}, {dst}, 0",    // atomic { *dst = tmp0 }
            "addi.d {dst}, {dst}, 8*8", // dst = dst.byte_add(8*8)
            dst = inout(reg) dst,
            tmp0 = in(reg) tmp0,
            tmp1 = in(reg) tmp1,
            tmp2 = in(reg) tmp2,
            tmp3 = in(reg) tmp3,
            tmp4 = in(reg) tmp4,
            tmp5 = in(reg) tmp5,
            tmp6 = in(reg) tmp6,
            tmp7 = in(reg) tmp7,
            options(nostack, preserves_flags),
        ),
    }
}

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
#[cfg(target_arch = "loongarch64")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "loongarch64")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(target_arch = "loongarch64"))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(target_arch = "loongarch64"))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_memcpy {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_memcpy {
    ($($tt:tt)*) => {};
}
