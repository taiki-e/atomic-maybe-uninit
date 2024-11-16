// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
AVR

Refs:
- AVR Instruction Set Manual https://ww1.microchip.com/downloads/en/DeviceDoc/AVR-InstructionSet-Manual-DS40002198.pdf
- portable-atomic https://github.com/taiki-e/portable-atomic

Generated asm:
- avr https://godbolt.org/z/Yn6s3hcGf
*/

#[path = "cfgs/avr.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

// See portable-atomic's interrupt module for more.
#[inline(always)]
fn disable() -> u8 {
    let sreg: u8;
    // SAFETY: reading the status register (SREG) and disabling interrupts are safe.
    unsafe {
        // Do not use `nomem` and `readonly` because prevent subsequent memory accesses from being reordered before interrupts are disabled.
        // Do not use `preserves_flags` because CLI modifies the I bit of the status register (SREG).
        asm!(
            "in {0}, 0x3F",
            "cli",
            out(reg) sreg,
            options(nostack),
        );
    }
    sreg
}
#[inline(always)]
unsafe fn restore(sreg: u8) {
    // SAFETY: the caller must guarantee that the state was retrieved by the previous `disable`,
    unsafe {
        // This clobbers the entire status register. See msp430.rs to safety on this.
        //
        // Do not use `nomem` and `readonly` because prevent preceding memory accesses from being reordered after interrupts are enabled.
        // Do not use `preserves_flags` because OUT modifies the status register (SREG).
        asm!("out 0x3F, {0}", in(reg) sreg, options(nostack));
    }
}

#[inline(always)]
fn xor8(a: MaybeUninit<u8>, b: MaybeUninit<u8>) -> u8 {
    let out;
    // SAFETY: calling eor is safe.
    unsafe {
        // Do not use `preserves_flags` because EOR modifies Z, N, V, and S bits in the status register (SREG).
        asm!("eor {a}, {b}", a = inout(reg) a => out, b = in(reg) b, options(pure, nomem, nostack));
    }
    out
}
// TODO: use Z bits in SREG instead of == 0?
#[inline(always)]
fn cmp8(a: MaybeUninit<u8>, b: MaybeUninit<u8>) -> bool {
    xor8(a, b) == 0
}
#[inline(always)]
fn cmp16(a: MaybeUninit<u16>, b: MaybeUninit<u16>) -> bool {
    // SAFETY: same layout.
    let [a1, a2] = unsafe { core::mem::transmute::<MaybeUninit<u16>, [MaybeUninit<u8>; 2]>(a) };
    // SAFETY: same layout.
    let [b1, b2] = unsafe { core::mem::transmute::<MaybeUninit<u16>, [MaybeUninit<u8>; 2]>(b) };
    xor8(a1, b1) | xor8(a2, b2) == 0
}

macro_rules! atomic {
    ($ty:ident, $cmp:ident, $cmp_ty:ident) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let s = disable();
                // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
                // On single-core systems, disabling interrupts is enough to prevent data race.
                let out = unsafe { src.read() };
                // SAFETY: the state was retrieved by the previous `disable`.
                unsafe { restore(s) }
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
                let s = disable();
                // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
                // On single-core systems, disabling interrupts is enough to prevent data race.
                unsafe { dst.write(val) }
                // SAFETY: the state was retrieved by the previous `disable`.
                unsafe { restore(s) }
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
                // transmute from MaybeUninit<{i,u}{8,16,size}> to MaybeUninit<u{8,16}>
                #[allow(clippy::useless_transmute)] // only useless when Self is u{8,16}
                // SAFETY: Self and $cmp_ty has the same layout
                let r = unsafe {
                    $cmp(
                        core::mem::transmute::<MaybeUninit<Self>, MaybeUninit<$cmp_ty>>(old),
                        core::mem::transmute::<MaybeUninit<Self>, MaybeUninit<$cmp_ty>>(out),
                    )
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

atomic!(i8, cmp8, u8);
atomic!(u8, cmp8, u8);
atomic!(i16, cmp16, u16);
atomic!(u16, cmp16, u16);
atomic!(isize, cmp16, u16);
atomic!(usize, cmp16, u16);
