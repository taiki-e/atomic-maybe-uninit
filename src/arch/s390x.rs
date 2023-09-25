// SPDX-License-Identifier: Apache-2.0 OR MIT

// s390x
//
// Refs:
// - z/Architecture Principles of Operation https://publibfp.dhe.ibm.com/epubs/pdf/a227832d.pdf
// - z/Architecture Reference Summary https://www.ibm.com/support/pages/zarchitecture-reference-summary
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - s390x https://godbolt.org/z/WMa8541M5
// - s390x (z196) https://godbolt.org/z/86d5fPhEW

#[path = "cfgs/s390x.rs"]
mod cfgs;

#[path = "partword.rs"]
mod partword;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap},
    utils::{MaybeUninit128, Pair},
};

type XSize = u64;

// Extracts and checks condition code.
#[inline]
fn extract_cc(r: i64) -> bool {
    let r = r.wrapping_add(-268435456) & (1 << 31);
    debug_assert!(r == 0 || r == 2147483648, "r={r}");
    r != 0
}

#[inline]
fn complement(v: u32) -> u32 {
    (v ^ !0).wrapping_add(1)
}

macro_rules! atomic_load_store {
    ($int_type:ident, $l_suffix:tt, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // (atomic) load from src to r0
                        concat!("l", $l_suffix, " %r0, 0({src})"),
                        src = in(reg) ptr_reg!(src),
                        out("r0") out,
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
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($fence:tt) => {
                            asm!(
                                // (atomic) store r0 to dst
                                concat!("st", $asm_suffix, " %r0, 0({dst})"),
                                $fence,
                                dst = in(reg) ptr_reg!(dst),
                                in("r0") val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => atomic_store!(""),
                        // bcr 14,0 (fast-BCR-serialization) requires z196 or later.
                        #[cfg(any(
                            target_feature = "fast-serialization",
                            atomic_maybe_uninit_target_feature = "fast-serialization",
                        ))]
                        Ordering::SeqCst => atomic_store!("bcr 14, 0"),
                        #[cfg(not(any(
                            target_feature = "fast-serialization",
                            atomic_maybe_uninit_target_feature = "fast-serialization",
                        )))]
                        Ordering::SeqCst => atomic_store!("bcr 15, 0"),
                        _ => unreachable!("{:?}", order),
                    }
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, $asm_suffix);
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // (atomic) swap (CAS loop)
                        concat!("l", $asm_suffix, " %r0, 0({dst})"),
                        "2:",
                            concat!("cs", $asm_suffix, " %r0, {val}, 0({dst})"),
                            "jl 2b",
                        dst = in(reg) ptr_reg!(dst),
                        val = in(reg) val,
                        out("r0") out,
                        // Do not use `preserves_flags` because CS modifies the condition code.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i64;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // (atomic) CAS
                        concat!("cs", $asm_suffix, " %r0, {new}, 0({dst})"),
                        // store condition code
                        "ipm {r}",
                        dst = in(reg) ptr_reg!(dst),
                        new = in(reg) new,
                        r = lateout(reg) r,
                        inout("r0") old => out,
                        // Do not use `preserves_flags` because CS modifies the condition code.
                        options(nostack),
                    );
                    (out, extract_cc(r))
                }
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($int_type:ident, $l_suffix:tt, $asm_suffix:tt, $bits:tt, $risbg_swap:tt, $risbg_cas:tt) => {
        atomic_load_store!($int_type, $l_suffix, $asm_suffix);
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (aligned_ptr, shift, _mask) = partword::create_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized CAS loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also partword.rs.
                    asm!(
                        "l %r0, 0({dst})",
                        "2:",
                            "rll {tmp}, %r0, 0({shift})",
                            concat!("risbg {tmp}, {val}, 32, ", $risbg_swap),
                            "rll {tmp}, {tmp}, 0({shift_c})",
                            "cs %r0, {tmp}, 0({dst})",
                            "jl 2b",
                        concat!("rll {out}, %r0, ", $bits ,"({shift})"),
                        dst = in(reg) ptr_reg!(aligned_ptr),
                        val = in(reg) val,
                        out = lateout(reg) out,
                        shift = in(reg) shift as u32,
                        shift_c = in(reg) complement(shift as u32),
                        tmp = out(reg) _,
                        out("r0") _, // prev
                        // Do not use `preserves_flags` because CS modifies the condition code.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (aligned_ptr, shift, _mask) = partword::create_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i64;
                    // Implement sub-word atomic operations using word-sized CAS loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also partword.rs.
                    asm!(
                        "l {prev}, 0({dst})",
                        "2:",
                            concat!("rll %r0, {prev}, ", $bits ,"({shift})"),
                            concat!("risbg {new}, %r0, 32, ", $risbg_cas, ", 0"),
                            concat!("ll", $asm_suffix, "r %r0, %r0"),
                            "cr %r0, {old}",
                            "jlh 3f",
                            concat!("rll {tmp}, {new}, -", $bits ,"({shift_c})"),
                            "cs {prev}, {tmp}, 0({dst})",
                            "jl 2b",
                        "3:",
                        // store condition code
                        "ipm {r}",
                        dst = in(reg) ptr_reg!(aligned_ptr),
                        prev = out(reg) _,
                        old = in(reg) crate::utils::zero_extend(old),
                        new = inout(reg) new => _,
                        shift = in(reg) shift as u32,
                        shift_c = in(reg) complement(shift as u32),
                        tmp = out(reg) _,
                        r = lateout(reg) r,
                        out("r0") out,
                        // Do not use `preserves_flags` because CS modifies the condition code.
                        options(nostack),
                    );
                    (out, extract_cc(r))
                }
            }
        }
    };
}

atomic_sub_word!(i8, "b", "c", "8", "39, 24", "55");
atomic_sub_word!(u8, "b", "c", "8", "39, 24", "55");
atomic_sub_word!(i16, "h", "h", "16", "47, 16", "47");
atomic_sub_word!(u16, "h", "h", "16", "47, 16", "47");
atomic!(i32, "");
atomic!(u32, "");
atomic!(i64, "g");
atomic!(u64, "g");
atomic!(isize, "g");
atomic!(usize, "g");

// https://github.com/llvm/llvm-project/commit/a11f63a952664f700f076fd754476a2b9eb158cc
macro_rules! atomic128 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let (prev_hi, prev_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // (atomic) load from src to out pair
                        "lpq %r0, 0({src})",
                        src = in(reg) ptr_reg!(src),
                        // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                        out("r0") prev_hi,
                        out("r1") prev_lo,
                        options(nostack, preserves_flags),
                    );
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit128 { $int_type: val };

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($fence:tt) => {
                            asm!(
                                // (atomic) store val pair to dst
                                "stpq %r0, 0({dst})",
                                $fence,
                                dst = in(reg) ptr_reg!(dst),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                in("r0") val.pair.hi,
                                in("r1") val.pair.lo,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => atomic_store!(""),
                        // bcr 14,0 (fast-BCR-serialization) requires z196 or later.
                        #[cfg(any(
                            target_feature = "fast-serialization",
                            atomic_maybe_uninit_target_feature = "fast-serialization",
                        ))]
                        Ordering::SeqCst => atomic_store!("bcr 14, 0"),
                        #[cfg(not(any(
                            target_feature = "fast-serialization",
                            atomic_maybe_uninit_target_feature = "fast-serialization",
                        )))]
                        Ordering::SeqCst => atomic_store!("bcr 15, 0"),
                        _ => unreachable!("{:?}", order),
                    }
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit128 { $int_type: val };
                let (mut prev_hi, mut prev_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // (atomic) swap (CAS loop)
                        "lpq %r0, 0({dst})",
                        "2:",
                            "cdsg %r0, %r12, 0({dst})",
                            "jl 2b",
                        dst = inout(reg) ptr_reg!(dst) => _,
                        // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                        out("r0") prev_hi,
                        out("r1") prev_lo,
                        in("r12") val.pair.hi,
                        in("r13") val.pair.lo,
                        // Do not use `preserves_flags` because CDSG modifies the condition code.
                        options(nostack),
                    );
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let old = MaybeUninit128 { $int_type: old };
                let new = MaybeUninit128 { $int_type: new };
                let (prev_hi, prev_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i64;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // (atomic) CAS
                        "cdsg %r0, %r12, 0({dst})",
                        // store condition code
                        "ipm {r}",
                        dst = in(reg) ptr_reg!(dst),
                        r = lateout(reg) r,
                        // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                        inout("r0") old.pair.hi => prev_hi,
                        inout("r1") old.pair.lo => prev_lo,
                        in("r12") new.pair.hi,
                        in("r13") new.pair.lo,
                        // Do not use `preserves_flags` because CDSG modifies the condition code.
                        options(nostack),
                    );
                    (
                        MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type,
                        extract_cc(r)
                    )
                }
            }
        }
    };
}

atomic128!(i128);
atomic128!(u128);
