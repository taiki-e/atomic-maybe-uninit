// SPDX-License-Identifier: Apache-2.0 OR MIT

// MSP430
//
// Refs: https://www.ti.com/lit/ug/slau208q/slau208q.pdf

#[path = "cfgs/msp430.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore};

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // (atomic) load from src to out
                        concat!("mov", $asm_suffix, " @{src}, {out}"),
                        src = in(reg) src,
                        out = lateout(reg) out,
                        options(nostack, preserves_flags),
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
                    // atomic store is always SeqCst.
                    asm!(
                        // (atomic) store val to dst
                        concat!("mov", $asm_suffix, " {val}, 0({dst})"),
                        dst = in(reg) dst,
                        val = in(reg) val,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
    };
}

atomic!(i8, ".b");
atomic!(u8, ".b");
atomic!(i16, ".w");
atomic!(u16, ".w");
atomic!(isize, ".w");
atomic!(usize, ".w");
