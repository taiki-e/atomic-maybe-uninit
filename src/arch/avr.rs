// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
AVR

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#avr

Refs:
- AVR® Instruction Set Manual, Rev. DS40002198B
  https://ww1.microchip.com/downloads/en/DeviceDoc/AVR-InstructionSet-Manual-DS40002198.pdf
- portable-atomic
  https://github.com/taiki-e/portable-atomic

Generated asm:
- avr https://godbolt.org/z/5TYW8x6T9
*/

delegate_size!(delegate_all);

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

// See portable-atomic's interrupt module for more.
#[inline(always)]
fn disable() -> u8 {
    let sreg: u8;
    // SAFETY: reading the status register (SREG) and disabling interrupts are safe.
    unsafe {
        asm!(
            "in {sreg}, 0x3F", // sreg = SREG
            "cli",             // SREG.I = 0
            sreg = out(reg) sreg,
            // Do not use `nomem` and `readonly` because prevent subsequent memory accesses from being reordered before interrupts are disabled.
            // Do not use `preserves_flags` because CLI modifies the I bit of the status register (SREG).
            options(nostack),
        );
    }
    sreg
}
#[inline(always)]
unsafe fn restore(prev_sreg: u8) {
    // SAFETY: the caller must guarantee that the state was retrieved by the previous `disable`,
    unsafe {
        // This clobbers the entire status register. See msp430.rs to safety on this.
        asm!(
            "out 0x3F, {prev_sreg}", // SREG = prev_sreg
            prev_sreg = in(reg) prev_sreg,
            // Do not use `nomem` and `readonly` because prevent preceding memory accesses from being reordered after interrupts are enabled.
            // Do not use `preserves_flags` because OUT modifies the status register (SREG).
            options(nostack),
        );
    }
}

#[inline(always)]
fn xor8(a: MaybeUninit<u8>, b: MaybeUninit<u8>) -> u8 {
    let out;
    // SAFETY: calling EOR is safe.
    unsafe {
        asm!(
            "eor {a}, {b}", // a ^= b
            a = inout(reg) a => out,
            b = in(reg) b,
            // Do not use `preserves_flags` because EOR modifies Z, N, V, and S bits in the status register (SREG).
            options(pure, nomem, nostack),
        );
    }
    out
}
#[inline(always)]
fn cmp16(a: MaybeUninit<u16>, b: MaybeUninit<u16>) -> bool {
    // SAFETY: same layout.
    let [a1, a2] = unsafe { mem::transmute::<MaybeUninit<u16>, [MaybeUninit<u8>; 2]>(a) };
    // SAFETY: same layout.
    let [b1, b2] = unsafe { mem::transmute::<MaybeUninit<u16>, [MaybeUninit<u8>; 2]>(b) };
    xor8(a1, b1) | xor8(a2, b2) == 0
}

macro_rules! atomic8 {
    ($ty:ident) => {
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
                        "ld {out}, Z", // atomic { out = *Z }
                        out = out(reg) out,
                        in("Z") src,
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
                        "st Z, {val}", // atomic { *Z = val }
                        val = in(reg) val,
                        in("Z") dst,
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(any(target_feature = "rmw", atomic_maybe_uninit_target_feature = "rmw"))]
                    asm!(
                        "xch Z, {val}", // atomic { _x = *Z; *Z = val; val = _x }
                        val = inout(reg) val => out,
                        in("Z") dst,
                        options(nostack, preserves_flags),
                    );
                    #[cfg(not(any(target_feature = "rmw", atomic_maybe_uninit_target_feature = "rmw")))]
                    asm!(
                        "in {sreg}, 0x3F",  // sreg = SREG
                        "cli",              // atomic { SREG.I = 0
                        "ld {out}, Z",      //   out = *Z
                        "st Z, {val}",      //   *Z = val
                        "out 0x3F, {sreg}", //   SREG = sreg }
                        val = in(reg) val,
                        out = out(reg) out,
                        sreg = out(reg) _,
                        in("Z") dst,
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
                let mut r: u8;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "in {sreg}, 0x3F",  // sreg = SREG
                        "cli",              // atomic { SREG.I = 0
                        "ld {out}, Z",      //   out = *Z
                        "eor {old}, {out}", //   old ^= out; if old == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                        "brne 2f",          //   if SREG.Z == 0 { jump 'cmp-fail }
                        "st Z, {new}",      //   *Z = new
                        "2:", // 'cmp-fail:
                        "out 0x3F, {sreg}", //   SREG = sreg }
                        old = inout(reg) old => r,
                        new = in(reg) new,
                        out = out(reg) out,
                        sreg = out(reg) _,
                        in("Z") dst,
                        // EOR modifies the status register (SREG), but `preserves_flags` is okay since SREG is restored at the end.
                        options(nostack, preserves_flags),
                    );
                    (out, r == 0)
                }
            }
        }
    };
}

macro_rules! atomic16 {
    ($ty:ident) => {
        delegate_signed!(delegate_all, $ty);
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
                // transmute from MaybeUninit<{i,u}{16,size}> to MaybeUninit<u16>
                #[allow(clippy::useless_transmute)] // only useless when Self is u16
                // SAFETY: Self and $cmp_ty has the same layout
                let r = unsafe {
                    cmp16(
                        mem::transmute::<MaybeUninit<Self>, MaybeUninit<u16>>(old),
                        mem::transmute::<MaybeUninit<Self>, MaybeUninit<u16>>(out),
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

atomic8!(u8);
atomic16!(u16);

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
macro_rules! cfg_has_fast_consume {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_fast_consume {
    ($($tt:tt)*) => { $($tt)* };
}
