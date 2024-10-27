// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Xtensa

Refs:
- Xtensa Instruction Set Architecture (ISA) Reference Manual https://web.archive.org/web/20241005102231/https://0x04.net/~mwk/doc/xtensa.pdf
- https://github.com/espressif/llvm-project/blob/xtensa_release_18.1.2/llvm/test/CodeGen/Xtensa/atomic-load-store.ll
*/

#[path = "cfgs/xtensa.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore};

macro_rules! atomic {
    ($int_type:ident, $asm_size:tt, $asm_suffix:tt, $asm_load_ext:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                concat!("l", $asm_size, $asm_load_ext, "i", $asm_suffix, " {out}, {src}, 0"),
                                $acquire,
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("memw"),
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,
                                concat!("s", $asm_size, "i", $asm_suffix, " {val}, {dst}, 0"),
                                $acquire,
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "memw"),
                        Ordering::SeqCst => atomic_store!("memw", "memw"),
                        _ => unreachable!(),
                    }
                }
            }
        }
    };
}

atomic!(i8, "8", "", "u");
atomic!(u8, "8", "", "u");
atomic!(i16, "16", "", "u");
atomic!(u16, "16", "", "u");
atomic!(i32, "32", ".n", "");
atomic!(u32, "32", ".n", "");
atomic!(isize, "32", ".n", "");
atomic!(usize, "32", ".n", "");
