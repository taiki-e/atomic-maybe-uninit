// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
s390x (SystemZ)

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#s390x

Refs:
- z/Architecture Principles of Operation, Fifteenth Edition (SA22-7832-14)
  https://www.ibm.com/docs/en/module_1678991624569/pdf/SA22-7832-14.pdf
- portable-atomic
  https://github.com/taiki-e/portable-atomic

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

delegate_size!(delegate_all);

pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    cell::UnsafeCell,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap},
    utils::{MaybeUninit128, Pair},
};

// bcr 14,0 requires fast-BCR-serialization facility added in arch9 (z196).
#[cfg(any(
    target_feature = "fast-serialization",
    atomic_maybe_uninit_target_feature = "fast-serialization",
))]
macro_rules! serialization {
    () => {
        "bcr 14, 0"
    };
}
#[cfg(not(any(
    target_feature = "fast-serialization",
    atomic_maybe_uninit_target_feature = "fast-serialization",
)))]
macro_rules! serialization {
    () => {
        "bcr 15, 0"
    };
}

// Extracts and checks condition code.
#[inline(always)]
const fn extract_cc(r: i64) -> bool {
    const BIT: i64 = 1 << 31;
    r.wrapping_add(-268435456) & BIT != 0
}

macro_rules! atomic_load_store {
    ($ty:ident, $($size:literal)?, $l_suffix:tt, $suffix:tt) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        concat!("l", $l_suffix, " {out}, 0({src})"), // atomic { out = *src }
                        src = in(reg_addr) ptr_reg!(src),
                        out = lateout(reg) out,
                        options(nostack, preserves_flags),
                    );
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
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($acquire:expr) => {
                            asm!(
                                concat!("st", $suffix, " {val}, 0({dst})"), // atomic { *dst = val }
                                $acquire,                                   // fence
                                dst = in(reg_addr) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => atomic_store!(""),
                        Ordering::SeqCst => atomic_store!(serialization!()),
                        _ => unreachable!(),
                    }
                }
            }
        }
        $(
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("l", $l_suffix, " {tmp0}, 0({src})"), // atomic { tmp0 = *src }
                    concat!("la {src}, ", $size, "({src})"),     // src = src.byte_add($size)
                    src = inout(reg_addr) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("l", $l_suffix, " {tmp1}, ", $size, "({src})"), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("l", $l_suffix, " {tmp0}, 0({src})"),           // atomic { tmp0 = *src }
                    concat!("la {src}, 2*", $size, "({src})"),              // src = src.byte_add(2*$size)
                    src = inout(reg_addr) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("st", $suffix, " {tmp0}, 0({dst})"), // atomic { *dst = tmp0 }
                    concat!("la {dst}, ", $size, "({dst})"),     // dst = dst.byte_add($size)
                    dst = inout(reg_addr) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("st", $suffix, " {tmp1}, ", $size, "({dst})"), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("st", $suffix, " {tmp0}, 0({dst})"),           // atomic { *dst = tmp0 }
                    concat!("la {dst}, 2*", $size, "({dst})"),             // dst = dst.byte_add(2*$size)
                    dst = inout(reg_addr) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
        }
        )?
    };
}

macro_rules! atomic {
    ($ty:ident, $($size:literal)?, $suffix:tt) => {
        atomic_load_store!($ty, $($size)?, $suffix, $suffix);
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        concat!("l", $suffix, " {out}, 0({dst})"),             // atomic { out = *dst }
                        "2:", // 'retry:
                            concat!("cs", $suffix, " {out}, {val}, 0({dst})"), // atomic { if *dst == out { cc = 0; *dst = val } else { cc = 1; out = *dst } }
                            "jl 2b",                                           // if cc == 1 { jump 'retry }
                        dst = in(reg_addr) ptr_reg!(dst),
                        val = in(reg) val,
                        out = out(reg) out,
                        // Do not use `preserves_flags` because CS modifies the condition code.
                        options(nostack),
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
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let out: MaybeUninit<Self>;
                let r;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // compare_exchange is always SeqCst.
                    asm!(
                        concat!("cs", $suffix, " {old}, {new}, 0({dst})"), // atomic { if *dst == old { cc = 0; *dst = new } else { cc = 1; old = *dst } }
                        "ipm {r}",                                         // r[:] = cc
                        dst = in(reg_addr) ptr_reg!(dst),
                        new = in(reg) new,
                        r = lateout(reg) r,
                        old = inout(reg) old => out,
                        // Do not use `preserves_flags` because CS modifies the condition code.
                        options(nostack),
                    );
                    (out, extract_cc(r))
                }
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($ty:ident, $size:literal, $l_suffix:tt, $suffix:tt, $bits:tt) => {
        atomic_load_store!($ty, $size, $l_suffix, $suffix);
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let (dst, shift, _mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized CAS loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "l {prev}, 0({dst})",                                              // atomic { prev = *dst }
                        "2:", // 'retry:
                            "rll {out}, {prev}, 0({shift})",                               // out = prev.rotate_left(shift)
                            concat!("risbg {out}, {val}, 32, 31+", $bits, ", 32-", $bits), // out = out | (val.rotate_left(32-$bits) & ((!0$ty as u32) << (32-$bits)))
                            "rll {out}, {out}, 0({shift_c})",                              // out = out.rotate_left(shift_c)
                            "cs {prev}, {out}, 0({dst})",                                  // atomic { if *dst == prev { cc = 0; *dst = out } else { cc = 1; prev = *dst } }
                            "jl 2b",                                                       // if cc == 1 { jump 'retry }
                        concat!("rll {out}, {prev}, ", $bits ,"({shift})"),                // out = prev.rotate_left(shift + $bits)
                        dst = in(reg_addr) ptr_reg!(dst),
                        val = in(reg) val,
                        out = out(reg) out,
                        shift = in(reg_addr) shift,
                        shift_c = in(reg_addr) shift.wrapping_neg(),
                        prev = out(reg) _,
                        // Do not use `preserves_flags` because CS and RISBG modify the condition code.
                        options(nostack),
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
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let (dst, shift, _mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;
                let r;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized CAS loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "l {prev}, 0({dst})",                                     // atomic { prev = *dst }
                        "2:", // 'retry:
                            concat!("rll {out}, {prev}, ", $bits ,"({shift})"),   // out = prev.rotate_left(shift + $bits)
                            concat!("risbg {new}, {out}, 32, 63-", $bits, ", 0"), // new = (new & !(!0$ty as u32)) | (out & !0$ty as u32)
                            concat!("ll", $suffix, "r {out}, {out}"),             // out = extract_and_zero_extend(out)
                            "cr {out}, {old}",                                    // if out == old { cc = 0 } else if out < old { cc = 1 } else { cc = 2 }
                            "jlh 3f",                                             // if cc == 2 { jump 'cmp-fail }
                            concat!("rll {tmp}, {new}, -", $bits ,"({shift_c})"), // out = prev.rotate_left(shift_c - $bits)
                            "cs {prev}, {tmp}, 0({dst})",                         // atomic { if *dst == prev { cc = 0; *dst = tmp } else { cc = 1; prev = *dst } }
                            "jl 2b",                                              // if cc == 1 { jump 'retry }
                        "3:", // 'cmp-fail:
                        "ipm {r}",                                                // r[:] = cc
                        dst = in(reg_addr) ptr_reg!(dst),
                        prev = out(reg) _,
                        old = in(reg) crate::utils::extend32::$ty::zero(old),
                        new = inout(reg) new => _,
                        shift = in(reg_addr) shift,
                        shift_c = in(reg_addr) shift.wrapping_neg(),
                        tmp = out(reg) _,
                        r = lateout(reg) r,
                        out = out(reg) out,
                        // Do not use `preserves_flags` because CS, CR, and RISBG modify the condition code.
                        options(nostack),
                    );
                    (out, extract_cc(r))
                }
            }
        }
    };
}

atomic_sub_word!(u8, "1", "b", "c", "8");
atomic_sub_word!(u16, "2", "h", "h", "16");
atomic!(u32, "4", "");
atomic!(u64,    , "g");

impl AtomicMemcpy for u64 {
    load_memcpy_opt64! { |src, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7|
        asm!(
            "lg {tmp0}, 0({src})",  // atomic { tmp0 = *src }
            "la {src}, 8({src})",   // src = src.byte_add(8)
            src = inout(reg_addr) src,
            tmp0 = out(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            "lg {tmp1}, 8({src})",  // atomic { tmp1 = *src.byte_add(8) }
            "lg {tmp0}, 0({src})",  // atomic { tmp0 = *src }
            "la {src}, 2*8({src})", // src = src.byte_add(2*8)
            src = inout(reg_addr) src,
            tmp0 = out(reg) tmp0,
            tmp1 = out(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            "lg {tmp7}, 8*7({src})",    // atomic { tmp7 = *src.byte_add(8*7) }
            "lg {tmp6}, 8*6({src})",    // atomic { tmp6 = *src.byte_add(8*6) }
            "lg {tmp5}, 8*5({src})",    // atomic { tmp5 = *src.byte_add(8*5) }
            "lg {tmp4}, 8*4({src})",    // atomic { tmp4 = *src.byte_add(8*4) }
            "lg {tmp3}, 8*3({src})",    // atomic { tmp3 = *src.byte_add(8*3) }
            "lg {tmp2}, 8*2({src})",    // atomic { tmp2 = *src.byte_add(8*2) }
            "lg {tmp1}, 8*1({src})",    // atomic { tmp1 = *src.byte_add(8*1) }
            "lg {tmp0}, 0({src})",      // atomic { tmp0 = *src }
            "la {src}, 8*8({src})",     // src = src.byte_add(8*8)
            src = inout(reg_addr) src,
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
            "stg {tmp0}, 0({dst})", // atomic { *dst = tmp0 }
            "la {dst}, 8({dst})",   // dst = dst.byte_add(8)
            dst = inout(reg_addr) dst,
            tmp0 = in(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            "stg {tmp1}, 8({dst})", // atomic { *dst.byte_add(8) = tmp1 }
            "stg {tmp0}, 0({dst})", // atomic { *dst = tmp0 }
            "la {dst}, 2*8({dst})", // dst = dst.byte_add(2*8)
            dst = inout(reg_addr) dst,
            tmp0 = in(reg) tmp0,
            tmp1 = in(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            "stg {tmp7}, 8*7({dst})",   // atomic { *dst.byte_add(8*7) = tmp7 }
            "stg {tmp6}, 8*6({dst})",   // atomic { *dst.byte_add(8*6) = tmp6 }
            "stg {tmp5}, 8*5({dst})",   // atomic { *dst.byte_add(8*5) = tmp5 }
            "stg {tmp4}, 8*4({dst})",   // atomic { *dst.byte_add(8*4) = tmp4 }
            "stg {tmp3}, 8*3({dst})",   // atomic { *dst.byte_add(8*3) = tmp3 }
            "stg {tmp2}, 8*2({dst})",   // atomic { *dst.byte_add(8*2) = tmp2 }
            "stg {tmp1}, 8*1({dst})",   // atomic { *dst.byte_add(8*1) = tmp1 }
            "stg {tmp0}, 0({dst})",     // atomic { *dst = tmp0 }
            "la {dst}, 8*8({dst})",     // dst = dst.byte_add(8*8)
            dst = inout(reg_addr) dst,
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

macro_rules! atomic128 {
    ($ty:ident) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let (out_hi, out_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        "lpq %r0, 0({src})", // atomic { r0:r1 = *src }
                        src = in(reg_addr) ptr_reg!(src),
                        // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                        out("r0") out_hi,
                        out("r1") out_lo,
                        options(nostack, preserves_flags),
                    );
                    MaybeUninit128 { pair: Pair { lo: out_lo, hi: out_hi } }.whole
                }
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit128 { whole: val };

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($acquire:expr) => {
                            asm!(
                                "stpq %r0, 0({dst})", // atomic { *dst = r0:r1 }
                                $acquire,             // acquire
                                dst = in(reg_addr) ptr_reg!(dst),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                in("r0") val.pair.hi,
                                in("r1") val.pair.lo,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => atomic_store!(""),
                        Ordering::SeqCst => atomic_store!(serialization!()),
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
                let val = MaybeUninit128 { whole: val };
                let (mut prev_hi, mut prev_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        "lg %r0, 8({dst})",             // atomic { r0 = *dst.byte_add(8) }
                        "lg %r1, 0({dst})",             // atomic { r1 = *dst }
                        "2:", // 'retry:
                            "cdsg %r0, %r12, 0({dst})", // atomic { if *dst == r0:r1 { cc = 0; *dst = r12:r13 } else { cc = 1; r0:r1 = *dst } }
                            "jl 2b",                    // if cc == 1 { jump 'retry }
                        dst = in(reg_addr) ptr_reg!(dst),
                        // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                        out("r0") prev_hi,
                        out("r1") prev_lo,
                        in("r12") val.pair.hi,
                        in("r13") val.pair.lo,
                        // Do not use `preserves_flags` because CDSG modifies the condition code.
                        options(nostack),
                    );
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                }
            }
        }
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let old = MaybeUninit128 { whole: old };
                let new = MaybeUninit128 { whole: new };
                let (prev_hi, prev_lo);
                let r;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // compare_exchange is always SeqCst.
                    asm!(
                        "cdsg %r0, %r12, 0({dst})", // atomic { if *dst == r0:r1 { cc = 0; *dst = r12:13 } else { cc = 1; r0:r1 = *dst } }
                        "ipm {r}",                  // r[:] = cc
                        dst = in(reg_addr) ptr_reg!(dst),
                        r = lateout(reg) r,
                        // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                        inout("r0") old.pair.hi => prev_hi,
                        inout("r1") old.pair.lo => prev_lo,
                        in("r12") new.pair.hi,
                        in("r13") new.pair.lo,
                        // Do not use `preserves_flags` because CDSG modifies the condition code.
                        options(nostack),
                    );
                    (
                        MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole,
                        extract_cc(r)
                    )
                }
            }
        }
    };
}

atomic128!(u128);

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
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => {};
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
