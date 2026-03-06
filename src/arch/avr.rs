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

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

delegate_size!(delegate_all);

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

// -----------------------------------------------------------------------------
// 8-bit atomics

delegate_signed!(delegate_all, u8);
impl AtomicLoad for u8 {
    #[inline]
    unsafe fn atomic_load(src: *const MaybeUninit<Self>, _order: Ordering) -> MaybeUninit<Self> {
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
impl AtomicStore for u8 {
    #[inline]
    unsafe fn atomic_store(dst: *mut MaybeUninit<Self>, val: MaybeUninit<Self>, _order: Ordering) {
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
impl AtomicSwap for u8 {
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
impl AtomicCompareExchange for u8 {
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

// -----------------------------------------------------------------------------
// 16-bit atomics

delegate_signed!(delegate_all, u16);
impl AtomicLoad for u16 {
    #[inline]
    unsafe fn atomic_load(src: *const MaybeUninit<Self>, _order: Ordering) -> MaybeUninit<Self> {
        let out: MaybeUninit<Self>;

        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            #[cfg(not(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            )))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "ld {out:l}, Z",    //   out.lo = *Z
                "ldd {out:h}, Z+1", //   out.hi = *Z.byte_add(1)
                "out 0x3F, {sreg}", //   SREG = sreg }
                out = out(reg_pair) out,
                sreg = out(reg) _,
                in("Z") src,
                options(nostack, preserves_flags),
            );
            #[cfg(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            ))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "ld {out:l}, Z+",   //   out.lo = *Z; Z = Z.byte_add(1)
                "ld {out:h}, Z",    //   out.hi = *Z
                "out 0x3F, {sreg}", //   SREG = sreg }
                out = out(reg_pair) out,
                sreg = out(reg) _,
                inout("Z") src => _,
                options(nostack, preserves_flags),
            );
        }
        out
    }
}
impl AtomicStore for u16 {
    #[inline]
    unsafe fn atomic_store(dst: *mut MaybeUninit<Self>, val: MaybeUninit<Self>, _order: Ordering) {
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            #[cfg(not(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            )))]
            #[cfg(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            ))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "st Z, {val:l}",    //   *Z = val.lo
                "std Z+1, {val:h}", //   *Z.byte_add(1) = val.hi
                "out 0x3F, {sreg}", //   SREG = sreg }
                val = in(reg_pair) val,
                sreg = out(reg) _,
                in("Z") dst,
                options(nostack, preserves_flags),
            );
            #[cfg(not(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            )))]
            #[cfg(not(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            )))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "std Z+1, {val:h}", //   *Z.byte_add(1) = val.hi
                "st Z, {val:l}",    //   *Z = val.lo
                "out 0x3F, {sreg}", //   SREG = sreg }
                val = in(reg_pair) val,
                sreg = out(reg) _,
                in("Z") dst,
                options(nostack, preserves_flags),
            );
            #[cfg(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            ))]
            #[cfg(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            ))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "st Z+, {val:l}",   //   *Z = val.lo; Z = Z.byte_add(1)
                "st Z, {val:h}",    //   *Z = val.hi
                "out 0x3F, {sreg}", //   SREG = sreg }
                val = in(reg_pair) val,
                sreg = out(reg) _,
                inout("Z") dst => _,
                options(nostack, preserves_flags),
            );
            #[cfg(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            ))]
            #[cfg(not(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            )))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "st Z, {val:h}",    //   *Z = val.hi
                "st -Z, {val:l}",   //   Z = Z.byte_sub(1); *Z = val.lo
                "out 0x3F, {sreg}", //   SREG = sreg }
                val = in(reg_pair) val,
                sreg = out(reg) _,
                inout("Z") dst.cast::<u8>().add(1) => _,
                options(nostack, preserves_flags),
            );
        }
    }
}
impl AtomicSwap for u16 {
    #[inline]
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: MaybeUninit<Self>,
        _order: Ordering,
    ) -> MaybeUninit<Self> {
        let out: MaybeUninit<Self>;

        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            #[cfg(not(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            )))]
            #[cfg(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            ))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "ld {out:l}, Z",    //   out.lo = *Z
                "ldd {out:h}, Z+1", //   out.hi = *Z.byte_add(1)
                "st Z, {val:l}",    //   *Z = val.lo
                "std Z+1, {val:h}", //   *Z.byte_add(1) = val.hi
                "out 0x3F, {sreg}", //   SREG = sreg }
                val = in(reg_pair) val,
                out = out(reg_pair) out,
                sreg = out(reg) _,
                in("Z") dst,
                options(nostack, preserves_flags),
            );
            #[cfg(not(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            )))]
            #[cfg(not(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            )))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "ld {out:l}, Z",    //   out.lo = *Z
                "ldd {out:h}, Z+1", //   out.hi = *Z.byte_add(1)
                "std Z+1, {val:h}", //   *Z.byte_add(1) = val.hi
                "st Z, {val:l}",    //   *Z = val.lo
                "out 0x3F, {sreg}", //   SREG = sreg }
                val = in(reg_pair) val,
                out = out(reg_pair) out,
                sreg = out(reg) _,
                in("Z") dst,
                options(nostack, preserves_flags),
            );
            #[cfg(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            ))]
            #[cfg(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            ))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "ld {out:l}, Z+",   //   out.lo = *Z; Z = Z.byte_add(1);
                "ld {out:h}, Z",    //   out.hi = *Z
                "subi r30, 0x01",   //   Z.lo -= 1
                "sbci r31, 0x00",   //   Z.hi -= borrow
                "st Z+, {val:l}",   //   Z = Z.byte_sub(1); *Z = val.lo
                "st Z, {val:h}",    //   *Z = val.hi
                "out 0x3F, {sreg}", //   SREG = sreg }
                val = in(reg_pair) val,
                out = out(reg_pair) out,
                sreg = out(reg) _,
                inout("Z") dst => _,
                // Do not use `preserves_flags` because SUBI modifies the status register (SREG).
                options(nostack),
            );
            #[cfg(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            ))]
            #[cfg(not(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            )))]
            asm!(
                "in {sreg}, 0x3F",  // sreg = SREG
                "cli",              // atomic { SREG.I = 0
                "ld {out:l}, Z+",   //   out.lo = *Z; Z = Z.byte_add(1);
                "ld {out:h}, Z",    //   out.hi = *Z
                "st Z, {val:h}",    //   *Z = val.hi
                "st -Z, {val:l}",   //   Z = Z.byte_sub(1); *Z = val.lo
                "out 0x3F, {sreg}", //   SREG = sreg }
                val = in(reg_pair) val,
                out = out(reg_pair) out,
                sreg = out(reg) _,
                in("Z") dst,
                options(nostack, preserves_flags),
            );
        }
        out
    }
}
impl AtomicCompareExchange for u16 {
    #[inline]
    unsafe fn atomic_compare_exchange(
        dst: *mut MaybeUninit<Self>,
        old: MaybeUninit<Self>,
        new: MaybeUninit<Self>,
        _success: Ordering,
        _failure: Ordering,
    ) -> (MaybeUninit<Self>, bool) {
        let out: MaybeUninit<Self>;
        let mut r: u8 = 0;

        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            #[cfg(not(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            )))]
            #[cfg(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            ))]
            asm!(
                "in {sreg}, 0x3F",      // sreg = SREG
                "cli",                  // atomic { SREG.I = 0
                "ld {out:l}, Z",        //   out.lo = *Z
                "ldd {out:h}, Z+1",     //   out.hi = *Z.byte_add(1)
                "eor {old:l}, {out:l}", //   old.lo ^= out.lo; if old.lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "eor {old:h}, {out:h}", //   old.hi ^= out.hi; if old.hi == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "or {old:l}, {old:h}",  //   old.lo ^= old.hi; if old.lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "brne 2f",              //   if SREG.Z == 0 { jump 'cmp-fail }
                "ldi {r}, 1",           //   r = 1
                "st Z, {new:l}",        //   *Z = new.lo
                "std Z+1, {new:h}",     //   *Z.byte_add(1) = new.hi
                "2:", // 'cmp-fail:
                "out 0x3F, {sreg}",     //   SREG = sreg }
                old = inout(reg_pair) old => _,
                new = in(reg_pair) new,
                out = out(reg_pair) out,
                // ldi requires r[16-31]
                r = inout(reg_upper) r,
                sreg = out(reg) _,
                in("Z") dst,
                // EOR and OR modify the status register (SREG), but preserves_flags is okay since SREG is restored at the end.
                options(nostack, preserves_flags),
            );
            #[cfg(not(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            )))]
            #[cfg(not(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            )))]
            asm!(
                "in {sreg}, 0x3F",      // sreg = SREG
                "cli",                  // atomic { SREG.I = 0
                "ld {out:l}, Z",        //   out.lo = *Z
                "ldd {out:h}, Z+1",     //   out.hi = *Z.byte_add(1)
                "eor {old:l}, {out:l}", //   old.lo ^= out.lo; if old.lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "eor {old:h}, {out:h}", //   old.hi ^= out.hi; if old.hi == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "or {old:l}, {old:h}",  //   old.lo ^= old.hi; if old.lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "brne 2f",              //   if SREG.Z == 0 { jump 'cmp-fail }
                "ldi {r}, 1",           //   r = 1
                "std Z+1, {new:h}",     //   *Z.byte_add(1) = new.hi
                "st Z, {new:l}",        //   *Z = new.lo
                "2:", // 'cmp-fail:
                "out 0x3F, {sreg}",     //   SREG = sreg }
                old = inout(reg_pair) old => _,
                new = in(reg_pair) new,
                out = out(reg_pair) out,
                // ldi requires r[16-31]
                r = inout(reg_upper) r,
                sreg = out(reg) _,
                in("Z") dst,
                // EOR and OR modify the status register (SREG), but preserves_flags is okay since SREG is restored at the end.
                options(nostack, preserves_flags),
            );
            #[cfg(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            ))]
            #[cfg(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            ))]
            asm!(
                "in {sreg}, 0x3F",      // sreg = SREG
                "cli",                  // atomic { SREG.I = 0
                "ld {out:l}, Z+",       //   out.lo = *Z; Z = Z.byte_add(1);
                "ld {out:h}, Z",        //   out.hi = *Z
                "eor {old:l}, {out:l}", //   old.lo ^= out.lo; if old.lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "eor {old:h}, {out:h}", //   old.hi ^= out.hi; if old.hi == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "or {old:l}, {old:h}",  //   old.lo ^= old.hi; if old.lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "brne 2f",              //   if SREG.Z == 0 { jump 'cmp-fail }
                "ldi {r}, 1",           //   r = 1
                "subi r30, 0x01",       //   Z.lo -= 1
                "sbci r31, 0x00",       //   Z.hi -= borrow
                "st Z+, {new:l}",       //   Z = Z.byte_sub(1); *Z = new.lo
                "st Z, {new:h}",        //   *Z = new.hi
                "2:", // 'cmp-fail:
                "out 0x3F, {sreg}",     //   SREG = sreg }
                old = inout(reg_pair) old => _,
                new = in(reg_pair) new,
                out = out(reg_pair) out,
                // ldi requires r[16-31]
                r = inout(reg_upper) r,
                sreg = out(reg) _,
                inout("Z") dst => _,
                // EOR, OR, and SUBI modify the status register (SREG), but preserves_flags is okay since SREG is restored at the end.
                options(nostack, preserves_flags),
            );
            #[cfg(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            ))]
            #[cfg(not(any(
                target_feature = "lowbytefirst",
                atomic_maybe_uninit_target_feature = "lowbytefirst",
            )))]
            asm!(
                "in {sreg}, 0x3F",      // sreg = SREG
                "cli",                  // atomic { SREG.I = 0
                "ld {out:l}, Z+",       //   out.lo = *Z; Z = Z.byte_add(1);
                "ld {out:h}, Z",        //   out.hi = *Z
                "eor {old:l}, {out:l}", //   old.lo ^= out.lo; if old.lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "eor {old:h}, {out:h}", //   old.hi ^= out.hi; if old.hi == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "or {old:l}, {old:h}",  //   old.lo ^= old.hi; if old.lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "brne 2f",              //   if SREG.Z == 0 { jump 'cmp-fail }
                "ldi {r}, 1",           //   r = 1
                "st Z, {new:h}",        //   *Z = new.hi
                "st -Z, {new:l}",       //   Z = Z.byte_sub(1); *Z = new.lo
                "2:", // 'cmp-fail:
                "out 0x3F, {sreg}",     //   SREG = sreg }
                old = inout(reg_pair) old => _,
                new = in(reg_pair) new,
                out = out(reg_pair) out,
                // ldi requires r[16-31]
                r = inout(reg_upper) r,
                sreg = out(reg) _,
                inout("Z") dst => _,
                // EOR and OR modify the status register (SREG), but preserves_flags is okay since SREG is restored at the end.
                options(nostack, preserves_flags),
            );
            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
            (out, r != 0)
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
