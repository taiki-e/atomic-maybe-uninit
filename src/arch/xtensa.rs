// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Xtensa

Refs:
- Xtensa Instruction Set Architecture (ISA) Summary for all Xtensa LX Processors
  https://www.cadence.com/content/dam/cadence-www/global/en_US/documents/tools/silicon-solutions/compute-ip/isa-summary.pdf
- https://github.com/espressif/llvm-project/blob/xtensa_release_18.1.2/llvm/test/CodeGen/Xtensa/atomic-load-store.ll
- https://github.com/espressif/llvm-project/blob/xtensa_release_18.1.2/llvm/test/CodeGen/Xtensa/atomicrmw.ll
  Note that LLVM's codegen for sub-word atomics seem to be suboptimal (extra branch, memw, l32i.n, etc.).

Note that l32ai (acquire load), s32ri (release store), and l32ex/s32ex/getex (LL/SC) are not yet supported in LLVM.
https://github.com/espressif/llvm-project/blob/xtensa_release_18.1.2/llvm/lib/Target/Xtensa/XtensaInstrInfo.td
*/

#[path = "cfgs/xtensa.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

#[cfg(target_feature = "s32c1i")]
use crate::raw::{AtomicCompareExchange, AtomicSwap};
use crate::raw::{AtomicLoad, AtomicStore};

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($int_type:ident, $bits:tt, $narrow:tt, $unsigned:tt) => {
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
                                concat!("l", $bits, $unsigned, "i", $narrow, " {out}, {src}, 0"), // atomic { out = *src }
                                $acquire,                                                         // fence
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
                                $release,                                              // fence
                                concat!("s", $bits, "i", $narrow, " {val}, {dst}, 0"), // atomic { *dst = val }
                                $acquire,                                              // fence
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

#[rustfmt::skip]
macro_rules! atomic {
    ($int_type:ident) => {
        atomic_load_store!($int_type, "32", ".n", "");
        #[cfg(target_feature = "s32c1i")]
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                     // fence
                                "l32i.n {out}, {dst}, 0",     // atomic { out = *dst }
                                "2:",
                                    "mov.n {tmp}, {out}",     // tmp = out
                                    "wsr {tmp}, scompare1",   // scompare1 = tmp
                                    "mov.n {out}, {val}",     // out = val
                                    "s32c1i {out}, {dst}, 0", // atomic { _x = *dst; if _x == scompare1 { *dst = out }; out = _x }
                                    "bne {tmp}, {out}, 2b",   // if tmp != out { jump '2 }
                                $acquire,                     // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                tmp = out(reg) _,
                                out("scompare1") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("memw", ""),
                        Ordering::Release => atomic_swap!("", "memw"),
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!("memw", "memw"),
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
        #[cfg(target_feature = "s32c1i")]
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: u32 = 1;
                    macro_rules! atomic_cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                 // fence
                                "wsr {old}, scompare1",   // scompare1 = old
                                "s32c1i {out}, {dst}, 0", // atomic { _x = *dst; if _x == scompare1 { *dst = out }; out = _x }
                                $acquire,                 // fence
                                "beq {old}, {out}, 2f",   // if old == out { jump '2 }
                                "movi {r}, 0",            // r = 0
                                "2:",
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                out = inout(reg) new => out,
                                r = inout(reg) r,
                                out("scompare1") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("", ""),
                        Ordering::Acquire => atomic_cmpxchg!("memw", ""),
                        Ordering::Release => atomic_cmpxchg!("", "memw"),
                        Ordering::AcqRel | Ordering::SeqCst => atomic_cmpxchg!("memw", "memw"),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($int_type:ident, $bits:tt) => {
        atomic_load_store!($int_type, $bits, "", "u");
        #[cfg(target_feature = "s32c1i")]
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "ssl {shift}",                      // sar = 32 - shift
                                "sll {val}, {val}",                 // val <<= shift
                                $release,                           // fence
                                "l32i.n {out}, {dst}, 0",           // atomic { out = *dst }
                                "2:",
                                    "mov.n {tmp}, {out}",           // tmp = out
                                    "wsr {tmp}, scompare1",         // scompare1 = tmp
                                    "and {out}, {out}, {inv_mask}", // out &= inv_mask
                                    "or {out}, {out}, {val}",       // out |= val
                                    "s32c1i {out}, {dst}, 0",       // atomic { _x = *dst; if _x == scompare1 { *dst = out }; out = _x }
                                    "bne {tmp}, {out}, 2b",         // if tmp != out { jump '2 }
                                "and {out}, {out}, {mask}",         // out &= mask
                                "ssr {shift}",                      // sar = shift
                                "srl {out}, {out}",                 // out >>= shift
                                $acquire,                           // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = in(reg) mask,
                                inv_mask = in(reg) !mask,
                                tmp = out(reg) _,
                                out("scompare1") _,
                                out("sar") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("memw", ""),
                        Ordering::Release => atomic_swap!("", "memw"),
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!("memw", "memw"),
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
        #[cfg(target_feature = "s32c1i")]
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: u32;
                    macro_rules! atomic_cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "ssl {shift}",                        // sar = 32 - shift
                                "sll {old}, {old}",                   // old <<= shift
                                "sll {new}, {new}",                   // new <<= shift
                                $release,                             // fence
                                "l32i.n {prev}, {dst}, 0",            // atomic { prev = *dst }
                                "and {out}, {prev}, {mask}",          // out = prev & mask
                                "2:",
                                    "bne {out}, {old}, 3f",           // if out != old { jump '3 }
                                    "mov.n {tmp}, {prev}",            // tmp = prev
                                    "wsr {tmp}, scompare1",           // scompare1 = tmp
                                    "and {prev}, {prev}, {inv_mask}", // prev &= inv_mask
                                    "or {prev}, {prev}, {new}",       // prev |= new
                                    "s32c1i {prev}, {dst}, 0",        // atomic { _x = *dst; if _x == scompare1 { *dst = prev }; prev = _x }
                                    "and {out}, {prev}, {mask}",      // out = prev & mask
                                    "bne {tmp}, {prev}, 2b",          // if tmp != prev { jump '2 }
                                    "movi {tmp}, 1",                  // tmp = 1
                                    "j 4f",                           // jump '4
                                "3:",
                                    "movi {tmp}, 0",                  // tmp = 0
                                "4:",
                                "ssr {shift}",                        // sar = shift
                                "srl {out}, {out}",                   // out >>= shift
                                $acquire,                             // fence
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) crate::utils::ZeroExtend::zero_extend(old) => _,
                                new = inout(reg) crate::utils::ZeroExtend::zero_extend(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = in(reg) mask,
                                inv_mask = in(reg) !mask,
                                tmp = out(reg) r,
                                prev = out(reg) _,
                                out("scompare1") _,
                                out("sar") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("", ""),
                        Ordering::Acquire => atomic_cmpxchg!("memw", ""),
                        Ordering::Release => atomic_cmpxchg!("", "memw"),
                        Ordering::AcqRel | Ordering::SeqCst => atomic_cmpxchg!("memw", "memw"),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

atomic_sub_word!(i8, "8");
atomic_sub_word!(u8, "8");
atomic_sub_word!(i16, "16");
atomic_sub_word!(u16, "16");
atomic!(i32);
atomic!(u32);
atomic!(isize);
atomic!(usize);
