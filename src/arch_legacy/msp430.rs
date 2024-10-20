// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
MSP430

Refs:
- MSP430x5xx and MSP430x6xx Family User's Guide https://www.ti.com/lit/ug/slau208q/slau208q.pdf
- portable-atomic https://github.com/taiki-e/portable-atomic
*/

#[path = "../arch/cfgs/msp430.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

// See portable-atomic's interrupt module for more.
#[inline(always)]
fn disable() -> u16 {
    let sr: u16;
    // SAFETY: reading the status register and disabling interrupts are safe.
    unsafe {
        // Do not use `nomem` and `readonly` because prevent subsequent memory accesses from being reordered before interrupts are disabled.
        // Do not use `preserves_flags` because DINT modifies the GIE (global interrupt enable) bit of the status register.
        asm!(
            "mov r2, {0}",
            "dint {{ nop",
            out(reg) sr,
            options(nostack),
        );
    }
    sr
}
#[inline(always)]
unsafe fn restore(sr: u16) {
    // SAFETY: the caller must guarantee that the state was retrieved by the previous `disable`,
    unsafe {
        // This clobbers the entire status register, but we never explicitly modify
        // flags within a critical session, and the only flags that may be changed
        // within a critical session are the arithmetic flags that are changed as
        // a side effect of arithmetic operations, etc., which LLVM recognizes,
        // so it is safe to clobber them here.
        // See also the discussion at https://github.com/taiki-e/portable-atomic/pull/40.
        //
        // Do not use `nomem` and `readonly` because prevent preceding memory accesses from being reordered after interrupts are enabled.
        // Do not use `preserves_flags` because MOV modifies the status register.
        asm!("nop {{ mov {0}, r2 {{ nop", in(reg) sr, options(nostack));
    }
}

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
        impl AtomicSwap for $int_type {
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

atomic!(i8, ".b");
atomic!(u8, ".b");
atomic!(i16, ".w");
atomic!(u16, ".w");
atomic!(isize, ".w");
atomic!(usize, ".w");
