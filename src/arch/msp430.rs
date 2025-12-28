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
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic {
    ($ty:ident, $suffix:tt) => {
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

atomic!(u8, "b");
atomic!(u16, "w");

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
