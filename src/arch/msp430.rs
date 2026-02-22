// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
MSP430

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#msp430

Refs:
- MSP430x5xx and MSP430x6xx Family User's Guide, Rev. Q
  https://www.ti.com/lit/ug/slau208q/slau208q.pdf
- portable-atomic
  https://github.com/taiki-e/portable-atomic

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

delegate_size!(delegate_all);

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap};

// LLVM doesn't support fence/compiler_fence for MSP430.
#[inline]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) fn fence(order: Ordering) {
    match order {
        Ordering::Relaxed => panic!("there is no such thing as a relaxed fence"),
        _ => {}
    }
    // SAFETY: using an empty asm is safe.
    // MSP430 is single-core and a compiler fence works as an atomic fence.
    unsafe {
        // Do not use `nomem` and `readonly` because prevent preceding and subsequent memory accesses from being reordered.
        asm!("", options(nostack, preserves_flags));
    }
}

macro_rules! atomic {
    ($ty:ident, $size:literal, $suffix:tt) => {
        delegate_signed!(delegate_all, $ty);
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
                        concat!("mov.", $suffix, " @{src}, {out}"), // atomic { out = *src }
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
                        concat!("mov.", $suffix, " {val}, 0({dst})"), // atomic { *dst = val }
                        dst = in(reg) dst,
                        val = in(reg) val,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("mov.", $suffix, " @{src}+, {tmp0}"), // atomic { tmp0 = *src; src = src.byte_add(size_of($ty)) }
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("mov.", $suffix, " @{src}+, {tmp0}"), // atomic { tmp0 = *src; src = src.byte_add(size_of($ty)) }
                    concat!("mov.", $suffix, " @{src}+, {tmp1}"), // atomic { tmp1 = *src; src = src.byte_add(size_of($ty)) }
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("mov.", $suffix, " {tmp0}, 0({dst})"), // atomic { *dst = tmp0 }
                    concat!("add #", $size, ", {dst}"),            // dst = dst.byte_add($size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    // Do not use `preserves_flags` because ADD modifies the V, N, Z, and C bits of the status register.
                    options(nostack),
                ),
                asm!(
                    concat!("mov.", $suffix, " {tmp1}, ", $size, "({dst})"), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("mov.", $suffix, " {tmp0}, 0({dst})"),           // atomic { *dst = tmp0 }
                    concat!("add #2*", $size, ", {dst}"),                    // dst = dst.byte_add(2*$size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    // Do not use `preserves_flags` because ADD modifies the V, N, Z, and C bits of the status register.
                    options(nostack),
                ),
            }
        }
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
                // On single-core systems, disabling interrupts is enough to prevent data race.
                // See "NOTE: Enable and Disable Interrupt" of User's Guide for NOP: https://www.ti.com/lit/ug/slau208q/slau208q.pdf#page=60
                unsafe {
                    asm!(
                        "mov r2, {sr}",                               // sr = SR
                        "dint {{ nop",                                // atomic { SR.GIE = 0
                        concat!("mov.", $suffix, " @{dst}, {out}"),   //   out = *dst
                        concat!("mov.", $suffix, " {val}, 0({dst})"), //   *dst = val
                        "nop {{ mov {sr}, r2 {{ nop",                 //   SR = sr }
                        dst = in(reg) dst,
                        val = in(reg) val,
                        out = out(reg) out,
                        sr = out(reg) _,
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
                let out: MaybeUninit<Self>;
                let mut r: $ty;

                // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
                // On single-core systems, disabling interrupts is enough to prevent data race.
                // See "NOTE: Enable and Disable Interrupt" of User's Guide for NOP: https://www.ti.com/lit/ug/slau208q/slau208q.pdf#page=60
                unsafe {
                    asm!(
                        "mov r2, {sr}",                               // sr = SR
                        "dint {{ nop",                                // atomic { SR.GIE = 0
                        concat!("mov.", $suffix, " @{dst}, {out}"),   //   out = *dst
                        concat!("xor.", $suffix, " {out}, {old}"),    //   old ^= out; if old == 0 { SR.Z = 1 } else { SR.Z = 0 }
                        "jne 2f",                                     //   if SR.Z == 0 { jump 'cmp-fail }
                        concat!("mov.", $suffix, " {new}, 0({dst})"), //   *dst = new
                        "2:", // 'cmp-fail:
                        "nop {{ mov {sr}, r2 {{ nop",                 //   SR = sr }
                        dst = in(reg) dst,
                        old = inout(reg) old => r,
                        new = in(reg) new,
                        out = out(reg) out,
                        sr = out(reg) _,
                        // XOR modifies the status register, but `preserves_flags` is okay since SREG is restored at the end.
                        options(nostack, preserves_flags),
                    );
                    (out, r == 0)
                }
            }
        }
    };
}

atomic!(u8, "1", "b");
atomic!(u16, "2", "w");

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
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
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
