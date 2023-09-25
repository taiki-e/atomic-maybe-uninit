// SPDX-License-Identifier: Apache-2.0 OR MIT

// MSP430
//
// Refs: https://www.ti.com/lit/ug/slau208q/slau208q.pdf

#[path = "../arch/cfgs/msp430.rs"]
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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // TODO: use mem to mem mov?
                        // (atomic) load from src to tmp
                        concat!("mov", $asm_suffix, " @{src}, {tmp}"),
                        // store tmp to out
                        concat!("mov", $asm_suffix, " {tmp}, 0({out})"),
                        src = in(reg) src,
                        out = inout(reg) out_ptr => _,
                        tmp = lateout(reg) _,
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
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        // TODO: use mem to mem mov?
                        // load from val to tmp
                        concat!("mov", $asm_suffix, " @{val}, {tmp}"),
                        // (atomic) store tmp to dst
                        concat!("mov", $asm_suffix, " {tmp}, 0({dst})"),
                        dst = inout(reg) dst => _,
                        val = in(reg) val,
                        tmp = lateout(reg) _,
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
