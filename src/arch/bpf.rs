// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
BPF

Refs:
- BPF Instruction Set Architecture (ISA)
  https://github.com/torvalds/linux/blob/v6.16/Documentation/bpf/standardization/instruction-set.rst

Generated asm:
- bpf https://godbolt.org/z/oEGqWY1f4
*/

delegate_size!(delegate_all);

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic32 {
    ($ty:ident) => {
        #[cfg(target_feature = "alu32")]
        delegate_signed!(delegate_all, $ty);
        #[cfg(target_feature = "alu32")]
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("{out} = *(", stringify!($ty), " *) ({src} + 0)"), // atomic { out = *src }
                                src = in(reg) src,
                                out = lateout(wreg) out,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Acquire | Ordering::SeqCst => {
                            // TODO: v4 has load_acquire: https://github.com/llvm/llvm-project/pull/108636
                            asm!(
                                "w0 = cmpxchg32_32({src} + 0, w0, w0)", // atomic { _x = *dst; if _x == r0 { *dst = new }; r0 = _x }
                                src = in(reg) src,
                                inout("w0") 0_u32 => out,
                                options(nostack, preserves_flags),
                            );
                        }
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
        #[cfg(target_feature = "alu32")]
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("*(", stringify!($ty), " *) ({dst} + 0) = w0"), // atomic { *dst = val }
                                dst = in(reg) dst,
                                in("w0") val, // TODO: rustc or LLVM bug: wreg sometimes allocated to reg
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Release | Ordering::SeqCst => {
                            // TODO: v4 has store_release: https://github.com/llvm/llvm-project/pull/108636
                            <$ty as AtomicSwap>::atomic_swap(
                                dst,
                                val,
                                Ordering::SeqCst, // swap is always SeqCst
                            );
                        }
                        _ => unreachable!(),
                    }
                }
            }
        }
        #[cfg(target_feature = "alu32")]
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
                        "{val} = xchg32_32({dst} + 0, {val})", // atomic { _x = *dst; *dst = val; out = _x }
                        dst = in(reg) dst,
                        val = inout(wreg) val => out,
                        options(nostack, preserves_flags),
                    );
                }
                out
            }
        }
        #[cfg(target_feature = "alu32")]
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
                        "w0 = cmpxchg32_32({dst} + 0, w0, {new})", // atomic { _x = *dst; if _x == r0 { *dst = new }; r0 = _x }
                        "if w0 == {old} goto 2f",                  // if r0 == old { jump 'success }
                        "{r} = 0",                                 // r = 0
                        "2:", // 'success
                        dst = in(reg) dst,
                        old = in(wreg) old,
                        new = in(wreg) new,
                        r = inout(reg) r,
                        inout("w0") old => out,
                        options(nostack, preserves_flags),
                    );
                    // crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

macro_rules! atomic64 {
    ($ty:ident) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("{out} = *(", stringify!($ty), " *) ({src} + 0)"), // atomic { out = *src }
                                src = in(reg) src,
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Acquire | Ordering::SeqCst => {
                            // TODO: v4 has load_acquire: https://github.com/llvm/llvm-project/pull/108636
                            asm!(
                                "r0 = cmpxchg_64({src} + 0, r0, r0)", // atomic { _x = *dst; if _x == r0 { *dst = new }; r0 = _x }
                                src = in(reg) src,
                                inout("r0") 0_u64 => out,
                                options(nostack, preserves_flags),
                            );
                        }
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
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("*(", stringify!($ty), " *) ({dst} + 0) = {val}"), // atomic { *dst = val }
                                dst = in(reg) dst,
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Release | Ordering::SeqCst => {
                            // TODO: v4 has store_release: https://github.com/llvm/llvm-project/pull/108636
                            <$ty as AtomicSwap>::atomic_swap(
                                dst,
                                val,
                                Ordering::SeqCst, // swap is always SeqCst
                            );
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
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "{val} = xchg_64({dst} + 0, {val})", // atomic { _x = *dst; *dst = val; out = _x }
                        dst = in(reg) dst,
                        val = inout(reg) val => out,
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
                    // crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

/*
macro_rules! atomic_sub_word {
    ($ty:ident) => {
        #[cfg(target_feature = "alu32")]
        delegate_signed!(delegate_load_store, $ty);
        #[cfg(target_feature = "alu32")]
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("{out} = *(", stringify!($ty), " *) ({src} + 0)"), // atomic { out = *src }
                                src = in(reg) src,
                                out = lateout(wreg) out,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Acquire | Ordering::SeqCst => {
                            // TODO: v4 has load_acquire: https://github.com/llvm/llvm-project/pull/108636
                            <$ty as AtomicCompareExchange>::atomic_compare_exchange(
                                src,
                                MaybeUninit::new(0),
                                MaybeUninit::new(0),
                                Ordering::SeqCst, // CAS is always SeqCst
                                Ordering::SeqCst,
                            );
                        }
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
        #[cfg(target_feature = "alu32")]
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("*(", stringify!($ty), " *) ({dst} + 0) = w0"), // atomic { *dst = val }
                                dst = in(reg) dst,
                                in("w0") val, // TODO: rustc or LLVM bug: wreg sometimes allocated to reg
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Release | Ordering::SeqCst => {
                            // TODO: v4 has store_release: https://github.com/llvm/llvm-project/pull/108636
                            <$ty as AtomicSwap>::atomic_swap(
                                dst,
                                val,
                                Ordering::SeqCst, // swap is always SeqCst
                            );
                        }
                        _ => unreachable!(),
                    }
                }
            }
        }
        // TODO: doesn't work due to "bitwise operator &= on pointer prohibited" verification error.
        #[cfg(target_feature = "alu32")]
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
                        "w0 = *(u32 *) ({dst} + 0)",                 // atomic { r0 = *dst }
                        "2:", // 'retry:
                            "{prev} = w0",                           // prev = r0
                            "{new} = {val}",                         // new = val
                            "{new} ^= w0",                           // new ^= r0
                            "{new} &= {mask}",                       // new &= mask
                            "{new} ^= w0",                           // new ^= r0
                            "w0 = cmpxchg32_32({dst} + 0, w0, {new})", // atomic { _x = *dst; if _x == r0 { *dst = new }; r0 = _x }
                            "if w0 != {prev} goto 2b",               // if r0 != prev { jump 'retry }
                        "w0 >>= {shift}",                            // r0 >>= shift & 63
                        dst = in(reg) dst,
                        val = inout(wreg) crate::utils::zero_extend32::$ty(val) => _,
                        shift = in(wreg) shift,
                        mask = inout(wreg) mask => _,
                        prev = out(wreg) _,
                        new = out(wreg) _,
                        out("w0") out,
                        options(nostack, preserves_flags),
                    );
                }
                out
            }
        }
        /*
        #[cfg(target_feature = "alu32")]
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
*/

// atomic_sub_word!(u8);
// atomic_sub_word!(u16);
atomic32!(u32);
atomic64!(u64);

// -----------------------------------------------------------------------------
// cfg macros

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
#[cfg(not(target_feature = "alu32"))]
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => {};
}
#[cfg(not(target_feature = "alu32"))]
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_feature = "alu32")]
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_feature = "alu32")]
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
