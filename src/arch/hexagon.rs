// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Hexagon

Refs:
- Qualcomm Hexagon V73 Programmer’s Reference Manual
  https://docs.qualcomm.com/bundle/publicresource/80-N2040-53_REV_AB_Qualcomm_Hexagon_V73_Programmers_Reference_Manual.pdf

Generated asm:
- hexagon https://godbolt.org/z/hGMTeEvo1
*/

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap},
    utils::{MaybeUninit64, Pair},
};

macro_rules! atomic_load_store {
    ($ty:ident, $size:tt, $load_ext:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("{out} = mem", $load_ext, $size, "({src})"), // atomic { out = *src }
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("mem", $size, "({dst}) = {val}"), // atomic { *dst = val }
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "2:", // 'retry:
                            "{out} = memw_locked({dst})",    // atomic { out = *dst; RESERVE = dst }
                            "memw_locked({dst},p0) = {val}", // atomic { if RESERVE == dst { *dst = val; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump 2b",              // if !p0 { jump 'retry }
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32 = 1;
                    asm!(
                        "2:", // 'retry:
                            "{out} = memw_locked({dst})",     // atomic { out = *dst; RESERVE = dst }
                            "{{ p0 = cmp.eq({out},{old})",    // p0 = out == old
                                "if (!p0.new) jump:nt 3f }}", // if !p0 { jump 'cmp-fail }
                            "memw_locked({dst},p0) = {new}",  // atomic { if RESERVE == dst { *dst = new; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump 2b",               // if !p0 { jump 'retry }
                            "jump 4f",                        // jump 'success
                        "3:", // 'cmp-fail:
                            "{r} = #0",                       // r = 0
                        "4:", // 'success:
                        dst = in(reg) dst,
                        old = in(reg) old,
                        new = in(reg) new,
                        out = out(reg) out,
                        r = inout(reg) r,
                        out("p0") _,
                        options(nostack, preserves_flags),
                    );
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
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "{val} = asl({val},{shift})",        // val <<= shift
                        "2:", // 'retry:
                            "{out} = memw_locked({dst})",    // atomic { out = *dst; RESERVE = dst }
                            "{tmp} = and({out},~{mask})",    // tmp = out & !mask
                            "{tmp} = or({tmp},{val})",       // tmp |= new
                            "memw_locked({dst},p0) = {tmp}", // atomic { if RESERVE == dst { *dst = tmp; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump 2b",              // if !p0 { jump 'retry }
                        "{out} = asr({out},{shift})",        // out >>= shift
                        dst = in(reg) dst,
                        val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
                        out = out(reg) out,
                        shift = in(reg) shift,
                        mask = in(reg) mask,
                        tmp = out(reg) _,
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32 = 1;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "{old} = asl({old},{shift})",         // old <<= shift
                        "{new} = asl({new},{shift})",         // new <<= shift
                        "2:", // 'retry:
                            "{out} = memw_locked({dst})",     // atomic { out = *dst; RESERVE = dst }
                            "{tmp} = and({out},{mask})",      // tmp = out & mask
                            "{{ p0 = cmp.eq({tmp},{old})",    // p0 = tmp == old
                                "if (!p0.new) jump:nt 3f }}", // if !p0 { jump 'cmp-fail }
                            "{tmp} = and({out},~{mask})",     // tmp = out & !mask
                            "{tmp} = or({tmp},{new})",        // tmp |= new
                            "memw_locked({dst},p0) = {tmp}",  // atomic { if RESERVE == dst { *dst = tmp; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump 2b",               // if !p0 { jump 'retry }
                            "jump 4f",                        // jump 'success
                        "3:", // 'cmp-fail:
                            "{r} = #0",                       // r = 0
                        "4:", // 'success:
                        "{out} = asr({out},{shift})",         // out >>= shift
                        dst = in(reg) dst,
                        old = inout(reg) crate::utils::ZeroExtend::zero_extend(old) => _,
                        new = inout(reg) crate::utils::ZeroExtend::zero_extend(new) => _,
                        out = out(reg) out,
                        shift = in(reg) shift,
                        mask = in(reg) mask,
                        tmp = out(reg) _,
                        r = inout(reg) r,
                        out("p0") _,
                        options(nostack, preserves_flags),
                    );
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
atomic!(i32);
atomic!(u32);
atomic!(isize);
atomic!(usize);

macro_rules! atomic64 {
    ($ty:ident) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let (prev_lo, prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "{{ r3:2 = memd({src}) }}", // atomic { r2:r3 = *src }
                        src = in(reg) src,
                        out("r2") prev_lo,
                        out("r3") prev_hi,
                        options(nostack, preserves_flags),
                    );
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty
                }
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let val = MaybeUninit64 { $ty: val };

                // SAFETY: the caller must uphold the safety contract.
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
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let val = MaybeUninit64 { $ty: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "2:", // 'retry:
                            "{{ r5:4 = memd_locked({dst}) }}", // atomic { r4:r5 = *dst; RESERVE = dst }
                            "memd_locked({dst},p0) = r3:2",    // atomic { if RESERVE == dst { *dst = r2:r3; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump 2b",                // if !p0 { jump 'retry }
                        dst = in(reg) dst,
                        in("r2") val.pair.lo,
                        in("r3") val.pair.hi,
                        out("r4") prev_lo,
                        out("r5") prev_hi,
                        out("p0") _,
                        options(nostack, preserves_flags),
                    );
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let old = MaybeUninit64 { $ty: old };
                let new = MaybeUninit64 { $ty: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32 = 1;
                    asm!(
                        "2:", // 'retry:
                            "{{ r7:6 = memd_locked({dst}) }}", // atomic { r6:r7 = *dst; RESERVE = dst }
                            // TODO: merge two cmp?
                            "{{ p0 = cmp.eq(r6,r2)",           // p0 = r6 == r2
                                "if (!p0.new) jump:nt 3f }}",  // if !p0 { jump 'cmp-fail }
                            "{{ p0 = cmp.eq(r7,r3)",           // p0 = r7 == r3
                                "if (!p0.new) jump:nt 3f }}",  // if !p0 { jump 'cmp-fail }
                            "memd_locked({dst},p0) = r5:4",    // atomic { if RESERVE == dst { *dst = r4:r5; p0 = true } else { p0 = false }; RESERVE = None }
                            "if (!p0) jump 2b",                // if !p0 { jump 'retry }
                            "jump 4f",                         // jump 'success
                        "3:", // 'cmp-fail:
                            "{r} = #0",                        // r = 0
                        "4:", // 'success:
                        dst = in(reg) dst,
                        r = inout(reg) r,
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
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty, r != 0)
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);

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
