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

pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap},
    utils::MaybeUninit16,
};

#[rustfmt::skip]
macro_rules! disable {
    () => {
        concat!(
            "in {sreg}, 0x3F", "\n", // sreg = SREG
            "cli",                   // atomic { SREG.I = 0
        )
    };
}
macro_rules! restore {
    () => {
        "out 0x3F, {sreg}" //   SREG = sreg }
    };
}

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
impl AtomicMemcpy for u8 {
    load_memcpy! { u8, |src, tmp0, tmp1|
        asm!(
            "ld {tmp0}, Z+", // atomic { tmp0 = *Z; Z = Z.byte_add(1) }
            tmp0 = out(reg) tmp0,
            inout("Z") src,
            options(nostack, preserves_flags),
        ),
        asm!(
            "ld {tmp0}, Z+", // atomic { tmp0 = *Z; Z = Z.byte_add(1) }
            "ld {tmp1}, Z+", // atomic { tmp1 = *Z; Z = Z.byte_add(1) }
            tmp0 = out(reg) tmp0,
            tmp1 = out(reg) tmp1,
            inout("Z") src,
            options(nostack, preserves_flags),
        ),
    }
    store_memcpy! { u8, |dst, tmp0, tmp1|
        asm!(
            "st Z+, {tmp0}", // atomic { *Z = tmp0; Z = Z.byte_add(1) }
            tmp0 = in(reg) tmp0,
            inout("Z") dst,
            options(nostack, preserves_flags),
        ),
        asm!(
            "st Z+, {tmp0}", // atomic { *Z = tmp0; Z = Z.byte_add(1) }
            "st Z+, {tmp1}", // atomic { *Z = tmp1; Z = Z.byte_add(1) }
            tmp0 = in(reg) tmp0,
            tmp1 = in(reg) tmp1,
            inout("Z") dst,
            options(nostack, preserves_flags),
        ),
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

        #[cfg(any(target_feature = "rmw", atomic_maybe_uninit_target_feature = "rmw"))]
        // SAFETY: the caller must uphold the safety contract.
        // cfg guarantees that the CPU supports RMW instructions.
        unsafe {
            asm!(
                "xch Z, {val}", // atomic { _x = *Z; *Z = val; val = _x }
                val = inout(reg) val => out,
                in("Z") dst,
                options(nostack, preserves_flags),
            );
        }
        #[cfg(not(any(target_feature = "rmw", atomic_maybe_uninit_target_feature = "rmw")))]
        // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
        // On single-core systems, disabling interrupts is enough to prevent data race.
        unsafe {
            asm!(
                disable!(),    // atomic {
                "ld {out}, Z", //   out = *Z
                "st Z, {val}", //   *Z = val
                restore!(),    // }
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

        // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
        // On single-core systems, disabling interrupts is enough to prevent data race.
        unsafe {
            asm!(
                disable!(),         // atomic {
                "ld {out}, Z",      //   out = *Z
                "eor {old}, {out}", //   old ^= out; if old == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "brne 2f",          //   if SREG.Z == 0 { jump 'cmp-fail }
                "st Z, {new}",      //   *Z = new
                "2:", // 'cmp-fail:
                restore!(),         // }
                old = inout(reg) old => r,
                new = in(reg) new,
                out = out(reg) out,
                sreg = out(reg) _,
                in("Z") dst,
                // EOR modifies the status register (SREG), but `preserves_flags` is okay since SREG is restored at the end.
                options(nostack, preserves_flags),
            );
        }
        (out, r == 0)
    }
}

// -----------------------------------------------------------------------------
// 16-bit atomics

delegate_signed!(delegate_all, u16);
impl AtomicLoad for u16 {
    #[inline]
    unsafe fn atomic_load(src: *const MaybeUninit<Self>, _order: Ordering) -> MaybeUninit<Self> {
        let out: MaybeUninit<Self>;

        // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
        // On single-core systems, disabling interrupts is enough to prevent data race.
        unsafe {
            #[cfg(not(any(
                target_feature = "tinyencoding",
                atomic_maybe_uninit_target_feature = "tinyencoding",
            )))]
            asm!(
                disable!(),         // atomic {
                "ld {out:l}, Z",    //   out.lo = *Z
                "ldd {out:h}, Z+1", //   out.hi = *Z.byte_add(1)
                restore!(),         // }
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
                disable!(),       // atomic {
                "ld {out:l}, Z+", //   out.lo = *Z; Z = Z.byte_add(1)
                "ld {out:h}, Z",  //   out.hi = *Z
                restore!(),       // }
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
        // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
        // On single-core systems, disabling interrupts is enough to prevent data race.
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
                disable!(),         // atomic {
                "st Z, {val:l}",    //   *Z = val.lo
                "std Z+1, {val:h}", //   *Z.byte_add(1) = val.hi
                restore!(),         // }
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
                disable!(),         // atomic {
                "std Z+1, {val:h}", //   *Z.byte_add(1) = val.hi
                "st Z, {val:l}",    //   *Z = val.lo
                restore!(),         // }
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
                disable!(),       // atomic {
                "st Z+, {val:l}", //   *Z = val.lo; Z = Z.byte_add(1)
                "st Z, {val:h}",  //   *Z = val.hi
                restore!(),       // }
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
                disable!(),       // atomic {
                "st Z, {val:h}",  //   *Z = val.hi
                "st -Z, {val:l}", //   Z = Z.byte_sub(1); *Z = val.lo
                restore!(),       // }
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

        // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
        // On single-core systems, disabling interrupts is enough to prevent data race.
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
                disable!(),         // atomic {
                "ld {out:l}, Z",    //   out.lo = *Z
                "ldd {out:h}, Z+1", //   out.hi = *Z.byte_add(1)
                "st Z, {val:l}",    //   *Z = val.lo
                "std Z+1, {val:h}", //   *Z.byte_add(1) = val.hi
                restore!(),         // }
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
                disable!(),         // atomic {
                "ld {out:l}, Z",    //   out.lo = *Z
                "ldd {out:h}, Z+1", //   out.hi = *Z.byte_add(1)
                "std Z+1, {val:h}", //   *Z.byte_add(1) = val.hi
                "st Z, {val:l}",    //   *Z = val.lo
                restore!(),         // }
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
                disable!(),       // atomic {
                "ld {out:l}, Z+", //   out.lo = *Z; Z = Z.byte_add(1);
                "ld {out:h}, Z",  //   out.hi = *Z
                "subi r30, 0x01", //   Z.lo -= 1
                "sbci r31, 0x00", //   Z.hi -= borrow
                "st Z+, {val:l}", //   Z = Z.byte_sub(1); *Z = val.lo
                "st Z, {val:h}",  //   *Z = val.hi
                restore!(),       // }
                val = in(reg_pair) val,
                out = out(reg_pair) out,
                sreg = out(reg) _,
                inout("Z") dst => _,
                // SUBI and SBCI modify the status register (SREG), but `preserves_flags` is okay since SREG is restored at the end.
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
                disable!(),       // atomic {
                "ld {out:l}, Z+", //   out.lo = *Z; Z = Z.byte_add(1);
                "ld {out:h}, Z",  //   out.hi = *Z
                "st Z, {val:h}",  //   *Z = val.hi
                "st -Z, {val:l}", //   Z = Z.byte_sub(1); *Z = val.lo
                restore!(),       // }
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
        let old = MaybeUninit16 { whole: old };
        let mut r: u8;

        // SAFETY: the caller must guarantee that pointer is valid and properly aligned.
        // On single-core systems, disabling interrupts is enough to prevent data race.
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
                disable!(),              // atomic {
                "ld {out:l}, Z",         //   out.lo = *Z
                "ldd {out:h}, Z+1",      //   out.hi = *Z.byte_add(1)
                "eor {old_lo}, {out:l}", //   old_lo ^= out.lo; if old_lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "eor {old_hi}, {out:h}", //   old_hi ^= out.hi; if old_hi == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "or {old_lo}, {old_hi}", //   old_lo ^= old_hi; if old_lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "brne 2f",               //   if SREG.Z == 0 { jump 'cmp-fail }
                "st Z, {new:l}",         //   *Z = new.lo
                "std Z+1, {new:h}",      //   *Z.byte_add(1) = new.hi
                "2:", // 'cmp-fail:
                restore!(),              // }
                old_lo = inout(reg) old.pair.lo => r,
                old_hi = inout(reg) old.pair.hi => _,
                new = in(reg_pair) new,
                out = out(reg_pair) out,
                sreg = out(reg) _,
                in("Z") dst,
                // EOR and OR modify the status register (SREG), but `preserves_flags` is okay since SREG is restored at the end.
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
                disable!(),              // atomic {
                "ld {out:l}, Z",         //   out.lo = *Z
                "ldd {out:h}, Z+1",      //   out.hi = *Z.byte_add(1)
                "eor {old_lo}, {out:l}", //   old_lo ^= out.lo; if old_lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "eor {old_hi}, {out:h}", //   old_hi ^= out.hi; if old_hi == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "or {old_lo}, {old_hi}", //   old_lo ^= old_hi; if old_lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "brne 2f",               //   if SREG.Z == 0 { jump 'cmp-fail }
                "std Z+1, {new:h}",      //   *Z.byte_add(1) = new.hi
                "st Z, {new:l}",         //   *Z = new.lo
                "2:", // 'cmp-fail:
                restore!(),              // }
                old_lo = inout(reg) old.pair.lo => r,
                old_hi = inout(reg) old.pair.hi => _,
                new = in(reg_pair) new,
                out = out(reg_pair) out,
                sreg = out(reg) _,
                in("Z") dst,
                // EOR and OR modify the status register (SREG), but `preserves_flags` is okay since SREG is restored at the end.
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
                disable!(),              // atomic {
                "ld {out:l}, Z+",        //   out.lo = *Z; Z = Z.byte_add(1);
                "ld {out:h}, Z",         //   out.hi = *Z
                "eor {old_lo}, {out:l}", //   old_lo ^= out.lo; if old_lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "eor {old_hi}, {out:h}", //   old_hi ^= out.hi; if old_hi == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "or {old_lo}, {old_hi}", //   old_lo ^= old_hi; if old_lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "brne 2f",               //   if SREG.Z == 0 { jump 'cmp-fail }
                "subi r30, 0x01",        //   Z.lo -= 1
                "sbci r31, 0x00",        //   Z.hi -= borrow
                "st Z+, {new:l}",        //   Z = Z.byte_sub(1); *Z = new.lo
                "st Z, {new:h}",         //   *Z = new.hi
                "2:", // 'cmp-fail:
                restore!(),              // }
                old_lo = inout(reg) old.pair.lo => r,
                old_hi = inout(reg) old.pair.hi => _,
                new = in(reg_pair) new,
                out = out(reg_pair) out,
                sreg = out(reg) _,
                inout("Z") dst => _,
                // EOR, OR, SUBI, and SUBI modify the status register (SREG), but `preserves_flags` is okay since SREG is restored at the end.
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
                disable!(),              // atomic {
                "ld {out:l}, Z+",        //   out.lo = *Z; Z = Z.byte_add(1);
                "ld {out:h}, Z",         //   out.hi = *Z
                "eor {old_lo}, {out:l}", //   old_lo ^= out.lo; if old_lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "eor {old_hi}, {out:h}", //   old_hi ^= out.hi; if old_hi == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "or {old_lo}, {old_hi}", //   old_lo ^= old_hi; if old_lo == 0 { SREG.Z = 1 } else { SREG.Z = 0 }
                "brne 2f",               //   if SREG.Z == 0 { jump 'cmp-fail }
                "st Z, {new:h}",         //   *Z = new.hi
                "st -Z, {new:l}",        //   Z = Z.byte_sub(1); *Z = new.lo
                "2:", // 'cmp-fail:
                restore!(),              // }
                old_lo = inout(reg) old.pair.lo => r,
                old_hi = inout(reg) old.pair.hi => _,
                new = in(reg_pair) new,
                out = out(reg_pair) out,
                sreg = out(reg) _,
                inout("Z") dst => _,
                // EOR and OR modify the status register (SREG), but `preserves_flags` is okay since SREG is restored at the end.
                options(nostack, preserves_flags),
            );
        }
        (out, r == 0)
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
