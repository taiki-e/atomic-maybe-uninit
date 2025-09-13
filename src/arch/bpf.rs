// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
BPF

Refs:
- BPF Instruction Set Architecture (ISA)
  https://github.com/torvalds/linux/blob/v6.12/Documentation/bpf/standardization/instruction-set.rst

Generated asm:
- bpf https://godbolt.org/z/oEGqWY1f4
*/

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic_load_store {
    ($ty:ident, $size:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("{out} = *(", $size, " *) ({src} + 0)"), // atomic { out = *src }
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
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("*(", $size, " *) ({dst} + 0) = {val}"), // atomic { *dst = val }
                        dst = in(reg) dst,
                        val = in(reg) val,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
    };
}

macro_rules! atomic64 {
    ($ty:ident) => {
        atomic_load_store!($ty, "u64");
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "{out} = xchg_64({dst} + 0, {val})", // atomic { _x = *dst; *dst = val; out = _x }
                        dst = in(reg) dst,
                        val = in(reg) val,
                        out = lateout(reg) out,
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
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: u64 = 1;
                    asm!(
                        "r0 = cmpxchg_64({dst} + 0, r0, {new})", // atomic { _x = *dst; if _x == r0 { *dst = new }; r0 = _x }
                        "if r0 == {old} goto 2f",                // if r0 == old { jump 'success }
                        "{r} = 0",                               // r = 0
                        "2:", // 'success
                        dst = in(reg) dst,
                        old = in(reg) old,
                        new = in(reg) new,
                        r = inout(reg) r,
                        inout("r0") old => out,
                        options(nostack, preserves_flags),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

/*
// TODO: doesn't work due to "bitwise operator &= on pointer prohibited" verification error.
macro_rules! atomic_sub_word {
    ($ty:ident, $size:tt) => {
        atomic_load_store!($ty, $size);
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
                        "{mask} <<= {shift}",                        // mask <<= shift & 63
                        "{val} <<= {shift}",                         // val <<= shift & 63
                        "r0 = *(u64 *) ({dst} + 0)",                 // atomic { r0 = *dst }
                        "2:", // 'retry:
                            "{prev} = r0",                           // prev = r0
                            "{new} = {val}",                         // new = val
                            "{new} ^= r0",                           // new ^= r0
                            "{new} &= {mask}",                       // new &= mask
                            "{new} ^= r0",                           // new ^= r0
                            "r0 = cmpxchg_64({dst} + 0, r0, {new})", // atomic { _x = *dst; if _x == r0 { *dst = new }; r0 = _x }
                            "if r0 != {prev} goto 2b",               // if r0 != prev { jump 'retry }
                        "r0 >>= {shift}",                            // r0 >>= shift & 63
                        dst = in(reg) dst,
                        val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
                        shift = in(reg) shift,
                        mask = inout(reg) mask => _,
                        prev = out(reg) _,
                        new = out(reg) _,
                        out("r0") out,
                        options(nostack, preserves_flags),
                    );
                }
                out
            }
        }
        /*
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
                        "TODO",
                        options(nostack, preserves_flags),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
        */
    };
}

atomic_sub_word!(i8, "u8");
atomic_sub_word!(u8, "u8");
atomic_sub_word!(i16, "u16");
atomic_sub_word!(u16, "u16");
atomic_sub_word!(i32, "u32");
atomic_sub_word!(u32, "u32");
*/
atomic_load_store!(i8, "u8");
atomic_load_store!(u8, "u8");
atomic_load_store!(i16, "u16");
atomic_load_store!(u16, "u16");
atomic_load_store!(i32, "u32");
atomic_load_store!(u32, "u32");
atomic64!(i64);
atomic64!(u64);
atomic64!(isize);
atomic64!(usize);

// -----------------------------------------------------------------------------
// cfg macros

// TODO: RMW on {8,16,32}-bit
#[macro_export]
macro_rules! cfg_has_atomic_8 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_8 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_16 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_16 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
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
