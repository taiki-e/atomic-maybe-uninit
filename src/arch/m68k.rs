// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
M68k

Refs:
- M68000 FAMILY Programmer's Reference Manual https://www.nxp.com/docs/en/reference-manual/M68000PRM.pdf
- https://github.com/llvm/llvm-project/tree/7fe149cdf09d04fb8390b97c91bd9214c968cd3e/llvm/test/CodeGen/M68k/Atomics
*/

#[path = "cfgs/m68k.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

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
                        out = lateout(reg_data) out,
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
                        options(nostack),
                    );
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
