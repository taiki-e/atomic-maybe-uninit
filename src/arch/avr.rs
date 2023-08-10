// AVR
//
// Refs:
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
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let s = disable();
                    let v = src.read();
                    restore(s);
                    out.write(v);
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let v = val.read();
                    let s = disable();
                    dst.write(v);
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

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);
}
