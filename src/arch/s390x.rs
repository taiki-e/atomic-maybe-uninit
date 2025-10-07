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

Generated asm:
- s390x https://godbolt.org/z/Y4YvPsTWz
- s390x (z196) https://godbolt.org/z/v9Wbro8oj
*/

delegate_size!(delegate_all);

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap},
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
    ($ty:ident, $l_suffix:tt, $suffix:tt) => {
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
    };
}

macro_rules! atomic {
    ($ty:ident, $suffix:tt) => {
        atomic_load_store!($ty, $suffix, $suffix);
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
    ($ty:ident, $l_suffix:tt, $suffix:tt, $bits:tt, $risbg_swap:tt, $risbg_cas:tt) => {
        atomic_load_store!($ty, $l_suffix, $suffix);
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
                        "l {prev}, 0({dst})",
                        "2:", // 'retry:
                            "rll {out}, {prev}, 0({shift})",
                            concat!("risbg {out}, {val}, 32, ", $risbg_swap),
                            "rll {out}, {out}, 0({shift_c})",
                            "cs {prev}, {out}, 0({dst})",
                            "jl 2b",
                        concat!("rll {out}, {prev}, ", $bits ,"({shift})"),
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
                        "l {prev}, 0({dst})",
                        "2:", // 'retry:
                            concat!("rll {out}, {prev}, ", $bits ,"({shift})"),
                            concat!("risbg {new}, {out}, 32, ", $risbg_cas, ", 0"),
                            concat!("ll", $suffix, "r {out}, {out}"),
                            "cr {out}, {old}",
                            "jlh 3f",
                            concat!("rll {tmp}, {new}, -", $bits ,"({shift_c})"),
                            "cs {prev}, {tmp}, 0({dst})",
                            "jl 2b",
                        "3:", // 'cmp-fail:
                        "ipm {r}",
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

atomic_sub_word!(u8, "b", "c", "8", "39, 24", "55");
atomic_sub_word!(u16, "h", "h", "16", "47, 16", "47");
atomic!(u32, "");
atomic!(u64, "g");

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
