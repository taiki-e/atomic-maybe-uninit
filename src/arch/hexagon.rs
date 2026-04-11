// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Hexagon

Refs:
- Qualcomm Hexagon V79 Programmer Reference Manual
  https://docs.qualcomm.com/doc/80-N2040-60/topic

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
    utils::{MaybeUninit64, Pair},
};

#[inline(always)]
fn asl(mut val: MaybeUninit<u32>, shift: u32) -> MaybeUninit<u32> {
    // SAFETY: calling ASL is safe
    unsafe {
        asm!(
            "{val} = asl({val},{shift})", // val <<= shift
            val = inout(reg) val,
            shift = in(reg) shift,
            options(pure, nomem, nostack, preserves_flags),
        );
    }
    val
}
#[inline(always)]
fn lsr(mut val: MaybeUninit<u32>, shift: u32) -> MaybeUninit<u32> {
    // SAFETY: calling ASR is safe
    unsafe {
        asm!(
            "{val} = lsr({val},{shift})", // val >>= shift
            val = inout(reg) val,
            shift = in(reg) shift,
            options(pure, nomem, nostack, preserves_flags),
        );
    }
    val
}

// -----------------------------------------------------------------------------
// Register-width or smaller atomics

macro_rules! atomic_load_store {
    ($ty:ident, $suffix:tt, $load_ext:tt) => {
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
                // MEM{UB,UH,W} has SeqCst semantics according to LLVM 22's lowering.
                unsafe {
                    asm!(
                        concat!("{out} = mem", $load_ext, $suffix, "({src})"), // atomic { out = zero_extend(*src) }
                        src = in(reg) src,
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
                _order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

                // SAFETY: the caller must uphold the safety contract.
                // MEM{UB,UH,W} has SeqCst semantics according to LLVM 22's lowering.
                unsafe {
                    asm!(
                        concat!("mem", $suffix, "({dst}) = {val}"), // atomic { *dst = val }
                        dst = in(reg) dst,
                        val = in(reg) val,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
    };
}

macro_rules! atomic {
    ($ty:ident) => {
        atomic_load_store!($ty, "w", "");
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
                // MEMW_LOCKED has SeqCst semantics according to LLVM 22's lowering.
                unsafe {
                    asm!(
                        "2:", // 'retry:
                            "{out} = memw_locked({dst})",    // atomic { out = *dst; RESERVE = dst }
                            "memw_locked({dst},p0) = {val}", // atomic { if RESERVE == dst { *dst = val; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump:nt 2b",           // if !p0 { unlikely(); jump 'retry }
                        dst = in(reg) dst,
                        val = in(reg) val,
                        out = out(reg) out,
                        out("p0") _,
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
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;
                let r: u32;

                // SAFETY: the caller must uphold the safety contract.
                // MEMW_LOCKED has SeqCst semantics according to LLVM 22's lowering.
                unsafe {
                    asm!(
                        "2:", // 'retry:
                            "{out} = memw_locked({dst})",    // atomic { out = *dst; RESERVE = dst }
                            "{{ p0 = cmp.eq({out},{old})",   // parallel { p0 = out == old
                               "if (!p0.new) jump:t 3f }}",  //   if !p0.new { likely(); jump 'cmp-fail } }
                            "memw_locked({dst},p0) = {new}", // atomic { if RESERVE == dst { *dst = new; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump:nt 2b",           // if !p0 { unlikely(); jump 'retry }
                        "3:", // 'cmp-fail:
                        "{r} = mux(p0,#1,#0)",
                        dst = in(reg) dst,
                        old = in(reg) old,
                        new = in(reg) new,
                        out = out(reg) out,
                        r = lateout(reg) r,
                        out("p0") _,
                        options(nostack, preserves_flags),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                }
                (out, r != 0)
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($ty:ident, $suffix:tt) => {
        atomic_load_store!($ty, $suffix, "u");
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
                // MEMW_LOCKED has SeqCst semantics according to LLVM 22's lowering.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "2:", // 'retry:
                            "{{ {tmp} = {val}",                 // parallel { tmp = val
                               "{out} = memw_locked({dst}) }}", //   atomic { out = *dst; RESERVE = dst } }
                            "{tmp} |= and({out},~{mask})",      // tmp |= out & !mask
                            "memw_locked({dst},p0) = {tmp}",    // atomic { if RESERVE == dst { *dst = tmp; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump:nt 2b",              // if !p0 { unlikely(); jump 'retry }
                        dst = in(reg) dst,
                        val = in(reg) asl(crate::utils::extend32::$ty::zero(val), shift),
                        out = out(reg) out,
                        mask = in(reg) mask,
                        tmp = out(reg) _,
                        out("p0") _,
                        options(nostack, preserves_flags),
                    );
                }
                crate::utils::extend32::$ty::extract(lsr(out, shift))
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
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<u32>;
                let mut r: u32;

                // SAFETY: the caller must uphold the safety contract.
                // MEMW_LOCKED has SeqCst semantics according to LLVM 22's lowering.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "2:", // 'retry:
                            "{out} = memw_locked({dst})",    // atomic { out = *dst; RESERVE = dst }
                            "{tmp} = and({out},{mask})",     // tmp = out & mask
                            "{{ p0 = cmp.eq({tmp},{old})",   // parallel { p0 = tmp == old
                                "if (!p0.new) jump:t 3f }}", //   if !p0.new { likely(); jump 'cmp-fail } }
                            "{tmp} = and({out},~{mask})",    // tmp = out & !mask
                            "{tmp} |= asl({new},{shift})",   // tmp |= new << shift
                            "memw_locked({dst},p0) = {tmp}", // atomic { if RESERVE == dst { *dst = tmp; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump:nt 2b",           // if !p0 { unlikely(); jump 'retry }
                        "3:", // 'cmp-fail:
                        "{tmp} = mux(p0,#1,#0)",
                        dst = in(reg) dst,
                        old = in(reg) asl(crate::utils::extend32::$ty::zero(old), shift),
                        new = in(reg) crate::utils::extend32::$ty::zero(new),
                        out = out(reg) out,
                        mask = in(reg) mask,
                        shift = in(reg) shift,
                        tmp = out(reg) r,
                        out("p0") _,
                        options(nostack, preserves_flags),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                }
                (crate::utils::extend32::$ty::extract(lsr(out, shift)), r != 0)
            }
        }
    };
}

atomic_sub_word!(u8, "b");
atomic_sub_word!(u16, "h");
atomic!(u32);

// -----------------------------------------------------------------------------
// 64-bit atomics

delegate_signed!(delegate_all, u64);
impl AtomicLoad for u64 {
    #[inline]
    unsafe fn atomic_load(src: *const MaybeUninit<Self>, _order: Ordering) -> MaybeUninit<Self> {
        debug_assert_atomic_unsafe_precondition!(src, u64);
        let (out_lo, out_hi);

        // SAFETY: the caller must uphold the safety contract.
        // MEMD has SeqCst semantics according to LLVM 22's lowering.
        unsafe {
            asm!(
                "{{ r3:2 = memd({src}) }}", // atomic { r2:r3 = *src }
                src = in(reg) src,
                out("r2") out_lo,
                out("r3") out_hi,
                options(nostack, preserves_flags),
            );
            MaybeUninit64 { pair: Pair { lo: out_lo, hi: out_hi } }.whole
        }
    }
}
impl AtomicStore for u64 {
    #[inline]
    unsafe fn atomic_store(dst: *mut MaybeUninit<Self>, val: MaybeUninit<Self>, _order: Ordering) {
        debug_assert_atomic_unsafe_precondition!(dst, u64);
        let val = MaybeUninit64 { whole: val };

        // SAFETY: the caller must uphold the safety contract.
        // MEMD has SeqCst semantics according to LLVM 22's lowering.
        unsafe {
            asm!(
                "memd({dst}) = r3:2", // atomic { *dst = r2:r3 }
                dst = in(reg) dst,
                in("r2") val.pair.lo,
                in("r3") val.pair.hi,
                options(nostack, preserves_flags),
            );
        }
    }
}
impl AtomicSwap for u64 {
    #[inline]
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: MaybeUninit<Self>,
        _order: Ordering,
    ) -> MaybeUninit<Self> {
        debug_assert_atomic_unsafe_precondition!(dst, u64);
        let val = MaybeUninit64 { whole: val };
        let (mut prev_lo, mut prev_hi);

        // SAFETY: the caller must uphold the safety contract.
        // MEMD_LOCKED has SeqCst semantics according to LLVM 22's lowering.
        unsafe {
            asm!(
                "2:", // 'retry:
                    "{{ r5:4 = memd_locked({dst}) }}", // atomic { r4:r5 = *dst; RESERVE = dst }
                    "memd_locked({dst},p0) = r3:2",    // atomic { if RESERVE == dst { *dst = r2:r3; p0 = true } else { p0 = false }; RESERVE = None }
                    "if (!p0) jump:nt 2b",             // if !p0 { unlikely(); jump 'retry }
                dst = in(reg) dst,
                in("r2") val.pair.lo,
                in("r3") val.pair.hi,
                out("r4") prev_lo,
                out("r5") prev_hi,
                out("p0") _,
                options(nostack, preserves_flags),
            );
            MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
        }
    }
}
impl AtomicCompareExchange for u64 {
    #[inline]
    unsafe fn atomic_compare_exchange(
        dst: *mut MaybeUninit<Self>,
        old: MaybeUninit<Self>,
        new: MaybeUninit<Self>,
        _success: Ordering,
        _failure: Ordering,
    ) -> (MaybeUninit<Self>, bool) {
        debug_assert_atomic_unsafe_precondition!(dst, u64);
        let old = MaybeUninit64 { whole: old };
        let new = MaybeUninit64 { whole: new };
        let (mut prev_lo, mut prev_hi);
        let r: u32;

        // SAFETY: the caller must uphold the safety contract.
        // MEMD_LOCKED has SeqCst semantics according to LLVM 22's lowering.
        unsafe {
            asm!(
                "2:", // 'retry:
                    "{{ r7:6 = memd_locked({dst}) }}", // atomic { r6:r7 = *dst; RESERVE = dst }
                    // TODO: merge two cmp?
                    "{{ p0 = cmp.eq(r6,r2)",          // parallel { p0 = r6 == r2
                        "if (!p0.new) jump:t 3f }}",  //   if !p0.new { likely(); jump 'cmp-fail } }
                    "{{ p0 = cmp.eq(r7,r3)",          // parallel { p0 = r7 == r3
                        "if (!p0.new) jump:t 3f }}",  //   if !p0.new { likely(); jump 'cmp-fail } }
                    "memd_locked({dst},p0) = r5:4",   // atomic { if RESERVE == dst { *dst = r4:r5; p0 = true } else { p0 = false }; RESERVE = None }
                    "if (!p0) jump:nt 2b",            // if !p0 { unlikely(); jump 'retry }
                "3:", // 'cmp-fail:
                "{r} = mux(p0,#1,#0)",
                dst = in(reg) dst,
                r = lateout(reg) r,
                in("r2") old.pair.lo,
                in("r3") old.pair.hi,
                in("r4") new.pair.lo,
                in("r5") new.pair.hi,
                out("r6") prev_lo,
                out("r7") prev_hi,
                out("p0") _,
                options(nostack, preserves_flags),
            );
            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
            (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole, r != 0)
        }
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
