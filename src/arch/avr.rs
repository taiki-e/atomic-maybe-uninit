// SPDX-License-Identifier: Apache-2.0 OR MIT

// AVR
//
// Refs:
// - AVR Instruction Set Manual https://ww1.microchip.com/downloads/en/DeviceDoc/AVR-InstructionSet-Manual-DS40002198.pdf
// - portable-atomic https://github.com/taiki-e/portable-atomic

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore};

// See portable-atomic's interrupt module for more.
#[inline]
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
#[inline]
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

macro_rules! atomic {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let s = disable();
                    let out = src.read();
                    restore(s);
                    out
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let s = disable();
                    dst.write(val);
                    restore(s);
                }
            }
        }
    };
}

atomic!(i8);
atomic!(u8);
atomic!(i16);
atomic!(u16);
atomic!(isize);
atomic!(usize);

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
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
