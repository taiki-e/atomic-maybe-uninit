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

#[path = "cfgs/m68k.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore};
#[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
use crate::{
    raw::{AtomicCompareExchange, AtomicSwap},
    utils::{MaybeUninit64, Pair},
};

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

/* Unsupported as of LLVM 20: https://godbolt.org/z/eWaT9Mbfe
error: unexpected token parsing operands
  |
note: instantiated into assembly here
 --> <inline asm>:4:8
  |
4 | cas2.l %d2:%d3, %d1:%d0, (%a0):(%a1)
  |        ^
*/
macro_rules! atomic64 {
    ($ty:ident) => {
        #[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let (prev_hi, prev_lo);
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let src1 = src.cast::<u32>();
                    let src2 = src1.add(1);
                    asm!(
                        "cas2.l {out1}:{out2}, {new1}:{new2}, ({src1}):({src2})", // atomic { if *dst1 == out1 && *dst2 == out2 { cc.Z = 1; *dst1 = new1; *dst2 = new2 } else { cc.Z = 0; out1 = *dst1; out2 = *dst2 } }
                        src1 = in(reg_addr) ptr_reg!(src1),
                        src2 = in(reg_addr) ptr_reg!(src2),
                        new1 = in(reg_data) 0_u32,
                        new2 = in(reg_data) 0_u32,
                        out1 = inout(reg_data) 0_u32 => prev_hi,
                        out2 = inout(reg_data) 0_u32 => prev_lo,
                        // Do not use `preserves_flags` because CAS2 modifies N, Z, V, and C bits in the condition codes.
                        options(nostack),
                    );
                    MaybeUninit64 { pair: Pair { hi: prev_hi, lo: prev_lo } }.$ty
                }
            }
        }
        #[cfg(any(target_feature = "isa-68020", atomic_maybe_uninit_target_feature = "isa-68020"))]
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) {
                let val = MaybeUninit64 { $ty: val };
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let dst1 = dst.cast::<u32>();
                    let dst2 = dst1.add(1);
                    asm!(
                        "move.l ({dst1}), {out1}",                                    // atomic { out1 = *dst1 }
                        "move.l ({dst2}), {out2}",                                    // atomic { out2 = *dst2 }
                        "2:", // 'retry:
                            "cas2.l {out1}:{out2}, {val1}:{val2}, ({dst1}):({dst2})", // atomic { if *dst1 == out1 && *dst2 == out2 { cc.Z = 1; *dst1 = val1; *dst2 = val2 } else { cc.Z = 0; out1 = *dst1; out2 = *dst2 } }
                            "bne 2b",                                                 // if cc.Z == 0 { jump 'retry }
                        dst1 = in(reg_addr) ptr_reg!(dst1),
                        dst2 = in(reg_addr) ptr_reg!(dst2),
                        val1 = in(reg_data) val.pair.hi,
                        val2 = in(reg_data) val.pair.lo,
                        out1 = out(reg_data) _,
                        out2 = out(reg_data) _,
                        // Do not use `preserves_flags` because MOVE and CAS2 modify N, Z, V, and C bits in the condition codes.
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
                let val = MaybeUninit64 { $ty: val };
                let (mut prev_lo, mut prev_hi);
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let dst1 = dst.cast::<u32>();
                    let dst2 = dst1.add(1);
                    asm!(
                        "move.l ({dst1}), {out1}",                                    // atomic { out1 = *dst1 }
                        "move.l ({dst2}), {out2}",                                    // atomic { out2 = *dst2 }
                        "2:", // 'retry:
                            "cas2.l {out1}:{out2}, {val1}:{val2}, ({dst1}):({dst2})", // atomic { if *dst1 == out1 && *dst2 == out2 { cc.Z = 1; *dst1 = val1; *dst2 = val2 } else { cc.Z = 0; out1 = *dst1; out2 = *dst2 } }
                            "bne 2b",                                                 // if cc.Z == 0 { jump 'dst }
                        dst1 = in(reg_addr) ptr_reg!(dst1),
                        dst2 = in(reg_addr) ptr_reg!(dst2),
                        val1 = in(reg_data) val.pair.hi,
                        val2 = in(reg_data) val.pair.lo,
                        out1 = out(reg_data) prev_hi,
                        out2 = out(reg_data) prev_lo,
                        // Do not use `preserves_flags` because MOVE and CAS2 modify N, Z, V, and C bits in the condition codes.
                        options(nostack),
                    );
                    MaybeUninit64 { pair: Pair { hi: prev_hi, lo: prev_lo } }.$ty
                }
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
                let old = MaybeUninit64 { $ty: old };
                let new = MaybeUninit64 { $ty: new };
                let (prev_hi, prev_lo);
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let dst1 = dst.cast::<u32>();
                    let dst2 = dst1.add(1);
                    let r: u8;
                    asm!(
                        "cas2.l {out1}:{out2}, {new1}:{new2}, ({dst1}):({dst2})", // atomic { if *dst1 == out1 && *dst2 == out2 { cc.Z = 1; *dst1 = new1; *dst2 = new2 } else { cc.Z = 0; out1 = *dst1; out2 = *dst2 } }
                        "seq {r}",                                                // r = cc.Z
                        dst1 = in(reg_addr) ptr_reg!(dst1),
                        dst2 = in(reg_addr) ptr_reg!(dst2),
                        new1 = in(reg_data) new.pair.hi,
                        new2 = in(reg_data) new.pair.lo,
                        out1 = inout(reg_data) old.pair.hi => prev_hi,
                        out2 = inout(reg_data) old.pair.lo => prev_lo,
                        r = lateout(reg_data) r,
                        // Do not use `preserves_flags` because CAS2 modifies N, Z, V, and C bits in the condition codes.
                        options(nostack),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (MaybeUninit64 { pair: Pair { hi: prev_hi, lo: prev_lo } }.$ty, r != 0)
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);
