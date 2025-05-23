// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
M68k

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#m68k

Refs:
- M68000 FAMILY Programmer's Reference Manual
  https://www.nxp.com/docs/en/reference-manual/M68000PRM.pdf
- M68060 User’s Manual
  https://www.nxp.com/docs/en/data-sheet/MC68060UM.pdf

Generated asm:
- m68k (M68020) https://godbolt.org/z/87Wxq1Wdj
*/

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

#[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
use crate::raw::{AtomicCompareExchange, AtomicSwap};
use crate::raw::{AtomicLoad, AtomicStore};

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
                        concat!("move.", $size, " ({src}), {out}"), // atomic { out = *src }
                        src = in(reg_addr) ptr_reg!(src),
                        out = out(reg_data) out,
                        // Do not use `preserves_flags` because MOVE modifies N, Z, V, and C bits in the condition codes.
                        options(nostack),
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
                        concat!("move.", $size, " {val}, ({dst})"), // atomic { *dst = val }
                        dst = in(reg_addr) ptr_reg!(dst),
                        val = in(reg_data) val,
                        // Do not use `preserves_flags` because MOVE modifies N, Z, V, and C bits in the condition codes.
                        options(nostack),
                    );
                }
            }
        }
        #[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let mut out: MaybeUninit<Self>;
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("move.", $size, " ({dst}), {out}"),           // atomic { out = *dst }
                        "2:", // 'retry:
                            concat!("cas.", $size, " {out}, {val}, ({dst})"), // atomic { if *dst == out { cc.Z = 1; *dst = val } else { cc.Z = 0; out = *dst } }
                            "bne 2b",                                         // if cc.Z == 0 { jump 'retry }
                        dst = in(reg_addr) ptr_reg!(dst),
                        val = in(reg_data) val,
                        out = out(reg_data) out,
                        // Do not use `preserves_flags` because MOVE and CAS modify N, Z, V, and C bits in the condition codes.
                        options(nostack),
                    );
                }
                out
            }
        }
        #[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
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
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let r: u8;
                    asm!(
                        concat!("cas.", $size, " {out}, {new}, ({dst})"), // atomic { if *dst == out { cc.Z = 1; *dst = new } else { cc.Z = 0; out = *dst } }
                        "seq {r}",                                        // r = cc.Z
                        dst = in(reg_addr) ptr_reg!(dst),
                        new = in(reg_data) new,
                        out = inout(reg_data) old => out,
                        r = lateout(reg_data) r,
                        // Do not use `preserves_flags` because CAS modifies N, Z, V, and C bits in the condition codes.
                        options(nostack),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

atomic!(i8, "b");
atomic!(u8, "b");
atomic!(i16, "w");
atomic!(u16, "w");
atomic!(i32, "l");
atomic!(u32, "l");
atomic!(isize, "l");
atomic!(usize, "l");

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
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => {};
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
#[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020")))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020")))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
