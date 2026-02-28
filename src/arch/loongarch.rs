// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
LoongArch32 and LoongArch64

Refs:
- LoongArch Reference Manual - Volume 1: Basic Architecture
  https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

delegate_size!(delegate_all);

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap},
    utils::RegSize,
};

macro_rules! sll_w {
    ($val:expr, $shift:expr) => {{
        let mut val = $val;
        let shift: RegSize = $shift;
        #[allow(unused_unsafe)]
        // SAFETY: calling SLL.W is safe
        unsafe {
            asm!(
                "sll.w {val}, {val}, {shift}", // val <<= shift & 31
                val = inout(reg) val,
                shift = in(reg) shift,
                options(pure, nomem, nostack, preserves_flags),
            );
        }
        val
    }};
}
#[inline(always)]
fn srl_w(mut val: MaybeUninit<u32>, shift: RegSize) -> MaybeUninit<u32> {
    // SAFETY: calling SRL.W is safe
    unsafe {
        asm!(
            "srl.w {val}, {val}, {shift}", // val >>= shift & 31
            val = inout(reg) val,
            shift = in(reg) shift,
            options(pure, nomem, nostack, preserves_flags),
        );
    }
    val
}

#[rustfmt::skip]
macro_rules! atomic_load {
    ($ty:ident, $suffix:tt) => {
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
                                concat!("ld.", $suffix, " {out}, {src}, 0"), // atomic { out = sign_extend(*src) }
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
    ($ty:ident, $suffix:tt) => {
        atomic_load!($ty, $suffix);
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
                                concat!("amswap_db.", $suffix, " $zero, {val}, {dst}"), // atomic { _x = *dst; *dst = val; _ = sign_extend(_x) }
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
                    // successful LL/SC has SeqCst semantics.
                    #[cfg(any(
                        target_arch = "loongarch32",
                        atomic_maybe_uninit_test_prefer_st_ll_sc_over_amswap,
                    ))]
                    asm!(
                        "2:", // 'retry:
                            concat!("ll.", $suffix, " {out}, {dst}, 0"),  // atomic { out = sign_extend(*dst); LL = dst }
                            "move {tmp}, {val}",                          // tmp = val
                            concat!("sc.", $suffix, " {tmp}, {dst}, 0"),  // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                            "beqz {tmp}, 2b",                             // if tmp == 0 { jump 'retry }
                        dst = in(reg) ptr_reg!(dst),
                        val = in(reg) val,
                        out = out(reg) out,
                        tmp = out(reg) _,
                        options(nostack, preserves_flags),
                    );
                    // AMO has SeqCst semantics.
                    #[cfg(not(any(
                        target_arch = "loongarch32",
                        atomic_maybe_uninit_test_prefer_st_ll_sc_over_amswap,
                    )))]
                    asm!(
                        concat!("amswap_db.", $suffix, " {out}, {val}, {dst}"), // atomic { _x = *dst; *dst = val; out = sign_extend(_x) }
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
            // Note: both GCC 15 and LLVM 22 implement weak CAS with strong CAS: https://godbolt.org/z/xEc1cxE16
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
                    let mut r: RegSize;
                    macro_rules! cmpxchg {
                        ($failure_fence:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ll.", $suffix, " {out}, {dst}, 0"), // atomic { out = sign_extend(*dst); LL = dst }
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
                    // successful LL/SC has SeqCst semantics, and fence is needed for branch that doesn't call sc.
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
    ($ty:ident, $suffix:tt) => {
        atomic_load!($ty, $suffix);
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
                let mut out: MaybeUninit<u32>;

                // SAFETY: the caller must uphold the safety contract.
                // successful LL/SC has SeqCst semantics.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "2:", // 'retry:
                            "ll.w {out}, {dst}, 0",      // atomic { out = sign_extend(*dst); LL = dst }
                            "andn {tmp}, {out}, {mask}", // tmp = out & !mask
                            "or {tmp}, {tmp}, {val}",    // tmp |= val
                            "sc.w {tmp}, {dst}, 0",      // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                            "beqz {tmp}, 2b",            // if tmp == 0 { jump 'retry }
                        dst = in(reg) ptr_reg!(dst),
                        val = in(reg) sll_w!(crate::utils::extend32::$ty::zero(val), shift),
                        out = out(reg) out,
                        mask = in(reg) sll_w!(mask, shift),
                        tmp = out(reg) _,
                        options(nostack, preserves_flags),
                    );
                }
                crate::utils::extend32::$ty::extract(srl_w(out, shift))
            }
        }
        impl AtomicCompareExchange for $ty {
            // Note: both GCC 15 and LLVM 22 implement weak CAS with strong CAS: https://godbolt.org/z/xEc1cxE16
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
                let mut out: MaybeUninit<u32>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: RegSize;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($failure_fence:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    "ll.w {out}, {dst}, 0",      // atomic { tmp = sign_extend(*dst); LL = dst }
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
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) sll_w!(crate::utils::extend32::$ty::zero(old), shift),
                                new = in(reg) sll_w!(crate::utils::extend32::$ty::zero(new), shift),
                                out = out(reg) out,
                                mask = in(reg) sll_w!(mask, shift),
                                tmp = out(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    // successful LL/SC has SeqCst semantics, and fence is needed for branch that doesn't call sc.
                    match failure {
                        Ordering::Relaxed => cmpxchg!("dbar 1792"),
                        Ordering::Acquire => cmpxchg!("dbar 20"),
                        // TODO: LLVM uses dbar 20 (Acquire) here, but should it not be dbar 16 (SeqCst)?
                        Ordering::SeqCst => cmpxchg!("dbar 16"),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (crate::utils::extend32::$ty::extract(srl_w(out, shift)), r != 0)
                }
            }
        }
    };
}

atomic_sub_word!(u8, "b");
atomic_sub_word!(u16, "h");
atomic!(u32, "w");
#[cfg(target_arch = "loongarch64")]
atomic!(u64, "d");

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
