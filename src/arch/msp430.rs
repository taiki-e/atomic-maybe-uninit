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

Generated asm:
- msp430 https://godbolt.org/z/W8PYT7xx4
*/

#[path = "cfgs/msp430.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

// See portable-atomic's interrupt module for more.
#[inline(always)]
fn disable() -> u16 {
    let sr: u16;
    // SAFETY: reading the status register and disabling interrupts are safe.
    unsafe {
        // Do not use `nomem` and `readonly` because prevent subsequent memory accesses from being reordered before interrupts are disabled.
        // Do not use `preserves_flags` because DINT modifies the GIE (global interrupt enable) bit of the status register.
        // See "NOTE: Enable and Disable Interrupt" of User's Guide for NOP: https://www.ti.com/lit/ug/slau208q/slau208q.pdf#page=60
        asm!(
            "mov r2, {sr}", // sr = SR
            "dint {{ nop",  // SR.GIE = 0
            sr = out(reg) sr,
            options(nostack),
        );
    }
    sr
}
#[inline(always)]
unsafe fn restore(prev_sr: u16) {
    // SAFETY: the caller must guarantee that the state was retrieved by the previous `disable`,
    unsafe {
        // This clobbers the entire status register, but we never explicitly modify
        // flags within a critical session, and the only flags that may be changed
        // within a critical session are the arithmetic flags that are changed as
        // a side effect of arithmetic operations, etc., which LLVM recognizes,
        // so it is safe to clobber them here.
        // See also the discussion at https://github.com/taiki-e/portable-atomic/pull/40.
        //
        // Do not use `nomem` and `readonly` because prevent preceding memory accesses from being reordered after interrupts are enabled.
        // Do not use `preserves_flags` because MOV modifies the status register.
        // See "NOTE: Enable and Disable Interrupt" of User's Guide for NOP: https://www.ti.com/lit/ug/slau208q/slau208q.pdf#page=60
        asm!(
            "nop {{ mov {prev_sr}, r2 {{ nop", // SR = prev_sr
            prev_sr = in(reg) prev_sr,
            options(nostack),
        );
    }
}

macro_rules! atomic {
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
                        concat!("mov.", $size, " @{src}, {out}"), // atomic { out = *src }
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
                        concat!("mov.", $size, " {val}, 0({dst})"), // atomic { *dst = val }
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
                let s = disable();
                // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
                // On single-core systems, disabling interrupts is enough to prevent data race.
                let out = unsafe { dst.read() };
                // SAFETY: see dst.read()
                unsafe { dst.write(val) }
                // SAFETY: the state was retrieved by the previous `disable`.
                unsafe { restore(s) }
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
                let s = disable();
                // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
                // On single-core systems, disabling interrupts is enough to prevent data race.
                let out = unsafe { dst.read() };
                // SAFETY: calling xor is safe.
                let r = unsafe {
                    let r: $ty;
                    asm!(
                        concat!("xor.", $size, " {b}, {a}"), // a ^= b
                        a = inout(reg) old => r,
                        b = in(reg) out,
                        // Do not use `preserves_flags` because XOR modifies the V, N, Z, and C bits of the status register.
                        options(pure, nomem, nostack),
                    );
                    r == 0
                };
                if r {
                    // SAFETY: see dst.read()
                    unsafe { dst.write(new) }
                }
                // SAFETY: the state was retrieved by the previous `disable`.
                unsafe { restore(s) }
                (out, r)
            }
        }
    };
}

atomic!(i8, "b");
atomic!(u8, "b");
atomic!(i16, "w");
atomic!(u16, "w");
atomic!(isize, "w");
atomic!(usize, "w");
