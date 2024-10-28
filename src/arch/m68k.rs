// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
M68k

Refs:
- M68000 FAMILY Programmer's Reference Manual
  https://www.nxp.com/docs/en/reference-manual/M68000PRM.pdf
- M68060 User’s Manual
  https://www.nxp.com/docs/en/data-sheet/MC68060UM.pdf
*/

#[path = "cfgs/m68k.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

#[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
use crate::raw::{AtomicCompareExchange, AtomicSwap};
use crate::raw::{AtomicLoad, AtomicStore};

macro_rules! atomic {
    ($int_type:ident, $asm_size:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("move.", $asm_size, " ({src}), {out}"),
                        src = in(reg_addr) ptr_reg!(src),
                        out = out(reg_data) out,
                        // Do not use `preserves_flags` because MOVE modifies N, Z, V, and C bits in the condition codes.
                        options(nostack),
                    );
                }
                out
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
                    asm!(
                        concat!("move.", $asm_size, " {val}, ({dst})"),
                        dst = in(reg_addr) ptr_reg!(dst),
                        val = in(reg_data) val,
                        // Do not use `preserves_flags` because MOVE modifies N, Z, V, and C bits in the condition codes.
                        options(nostack),
                    );
                }
            }
        }
        #[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
        impl AtomicSwap for $int_type {
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
                        concat!("move.", $asm_size, " ({dst}), {out}"),           // out = *dst
                        "2:",
                            concat!("cas.", $asm_size, " {out}, {val}, ({dst})"), // atomic { if *dst == out { cc.z = 1; *dst = val } else { cc.z = 0; out = *dst } }
                            "bne 2b",                                             // if cc.z == 0 { continue '2 }
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
        impl AtomicCompareExchange for $int_type {
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
                        concat!("cas.", $asm_size, " {out}, {new}, ({dst})"), // atomic { if *dst == out { cc.z = 1; *dst = new } else { cc.z = 0; out = *dst } }
                        "seq {r}",                                            // r = cc.z
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
