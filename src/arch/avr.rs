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

pub(crate) use core::sync::atomic::fence;
use core::{arch::asm, mem::MaybeUninit, num::NonZeroUsize, sync::atomic::Ordering};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap};

const OPT_FOR_SIZE: bool = false; // Currently only for bench

// See portable-atomic's interrupt module for more.
#[inline(always)]
fn disable() -> u8 {
    let sreg: u8;
    // SAFETY: reading the status register (SREG) and disabling interrupts are safe.
    unsafe {
        // Do not use `nomem` and `readonly` because prevent subsequent memory accesses from being reordered before interrupts are disabled.
        // Do not use `preserves_flags` because CLI modifies the I bit of the status register (SREG).
        asm!(
            "in {sreg}, 0x3F", // sreg = SREG
            "cli",             // SREG.I = 0
            sreg = out(reg) sreg,
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
        //
        // Do not use `nomem` and `readonly` because prevent preceding memory accesses from being reordered after interrupts are enabled.
        // Do not use `preserves_flags` because OUT modifies the status register (SREG).
        asm!(
            "out 0x3F, {prev_sreg}", // SREG = prev_sreg
            prev_sreg = in(reg) prev_sreg,
            options(nostack),
        );
    }
}

#[inline(always)]
fn xor8(a: MaybeUninit<u8>, b: MaybeUninit<u8>) -> u8 {
    let out;
    // SAFETY: calling eor is safe.
    unsafe {
        // Do not use `preserves_flags` because EOR modifies Z, N, V, and S bits in the status register (SREG).
        asm!(
            "eor {a}, {b}", // a ^= b
            a = inout(reg) a => out,
            b = in(reg) b,
            options(pure, nomem, nostack),
        );
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

macro_rules! atomic_swap {
    ($ty:ident) => {
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
    };
}
macro_rules! atomic_cas {
    ($ty:ident, $cmp:ident, $cmp_ty:ident) => {
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

macro_rules! atomic8 {
    ($ty:ident) => {
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
        atomic_swap!($ty);
        atomic_cas!($ty, cmp8, u8);
    };
}

macro_rules! atomic16 {
    ($ty:ident) => {
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
        atomic_swap!($ty);
        atomic_cas!($ty, cmp16, u16);
    };
}

atomic8!(i8);
atomic8!(u8);
atomic16!(i16);
atomic16!(u16);
atomic16!(isize);
atomic16!(usize);

impl AtomicMemcpy for u8 {
    #[inline]
    unsafe fn atomic_load_memcpy<const DST_ALIGNED: bool>(
        mut dst: *mut MaybeUninit<Self>,
        mut src: *const MaybeUninit<Self>,
        mut count: NonZeroUsize,
    ) {
        if OPT_FOR_SIZE {
            let mut tmp;
            // SAFETY: the caller must uphold the safety contract.
            unsafe {
                loop {
                    asm!(
                        "ld {tmp}, Z+", // atomic { tmp = *Z; Z = Z.byte_add(1) }
                        tmp = out(reg) tmp,
                        inout("Z") src,
                        options(nostack, preserves_flags),
                    );
                    dst.write(tmp);
                    dst = dst.add(1);
                    match NonZeroUsize::new(count.get() - 1) {
                        Some(v) => count = v,
                        None => return,
                    }
                }
            }
        } else {
            let mut tmp0;
            let mut tmp1;
            // SAFETY: the caller must uphold the safety contract.
            unsafe {
                if count.get() & 0x1 == 1 {
                    asm!(
                        "ld {tmp0}, Z+", // atomic { tmp0 = *Z; Z = Z.byte_add(1) }
                        tmp0 = out(reg) tmp0,
                        inout("Z") src,
                        options(nostack, preserves_flags),
                    );
                    if DST_ALIGNED {
                        dst.write(tmp0);
                    } else {
                        dst.write_unaligned(tmp0);
                    }
                    dst = dst.add(1);
                    match NonZeroUsize::new(count.get() - 1) {
                        Some(v) => count = v,
                        None => return,
                    }
                }
                loop {
                    asm!(
                        "ld {tmp0}, Z+", // atomic { tmp0 = *Z; Z = Z.byte_add(1) }
                        "ld {tmp1}, Z+", // atomic { tmp1 = *Z; Z = Z.byte_add(1) }
                        tmp0 = out(reg) tmp0,
                        tmp1 = out(reg) tmp1,
                        inout("Z") src,
                        options(nostack, preserves_flags),
                    );
                    dst.add(1).write(tmp1);
                    dst.write(tmp0);
                    dst = dst.add(2);
                    match NonZeroUsize::new(count.get() - 2) {
                        Some(v) => count = v,
                        None => return,
                    }
                }
            }
        }
    }
    #[inline]
    unsafe fn atomic_store_memcpy<const SRC_ALIGNED: bool>(
        mut dst: *mut MaybeUninit<Self>,
        mut src: *const MaybeUninit<Self>,
        mut count: NonZeroUsize,
    ) {
        if OPT_FOR_SIZE {
            let mut tmp;
            // SAFETY: the caller must uphold the safety contract.
            unsafe {
                loop {
                    tmp = src.read();
                    src = src.add(1);
                    asm!(
                        "st Z+, {tmp}", // atomic { *Z = tmp; dst = dst.byte_add(1) }
                        tmp = in(reg) tmp,
                        inout("Z") dst,
                        options(nostack, preserves_flags),
                    );
                    match NonZeroUsize::new(count.get() - 1) {
                        Some(v) => count = v,
                        None => return,
                    }
                }
            }
        } else {
            let mut tmp0;
            let mut tmp1;
            // SAFETY: the caller must uphold the safety contract.
            unsafe {
                if count.get() & 0x1 == 1 {
                    tmp0 = src.read();
                    src = src.add(1);
                    asm!(
                        "st Z+, {tmp0}", // atomic { *Z = tmp0; dst = dst.byte_add(1) }
                        tmp0 = in(reg) tmp0,
                        inout("Z") dst,
                        options(nostack, preserves_flags),
                    );
                    match NonZeroUsize::new(count.get() - 1) {
                        Some(v) => count = v,
                        None => return,
                    }
                }
                loop {
                    tmp1 = src.add(1).read();
                    tmp0 = src.read();
                    src = src.add(2);
                    asm!(
                        "st Z+, {tmp0}", // atomic { *Z = tmp0; dst = dst.byte_add(1) }
                        "st Z+, {tmp1}", // atomic { *Z = tmp1; dst = dst.byte_add(1) }
                        tmp0 = in(reg) tmp0,
                        tmp1 = in(reg) tmp1,
                        inout("Z") dst,
                        options(nostack, preserves_flags),
                    );
                    match NonZeroUsize::new(count.get() - 2) {
                        Some(v) => count = v,
                        None => return,
                    }
                }
            }
        }
    }
}

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
