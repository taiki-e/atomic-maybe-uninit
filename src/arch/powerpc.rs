// SPDX-License-Identifier: Apache-2.0 OR MIT

// PowerPC and PowerPC64
//
// Refs:
// - Power ISA https://openpowerfoundation.org/specifications/isa
// - AIX Assembler language reference https://www.ibm.com/docs/en/aix/7.3?topic=aix-assembler-language-reference
// - http://www.rdrop.com/users/paulmck/scalability/paper/N2745r.2010.02.19a.html
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - powerpc https://godbolt.org/z/s7zvz8TWz
// - powerpc64 https://godbolt.org/z/8GTKnn9vG
// - powerpc64 (pwr8) https://godbolt.org/z/n55d5EGe9
// - powerpc64le https://godbolt.org/z/r3xa399MP
// - powerpc64le (pwr7) https://godbolt.org/z/TYsbsWGe3

#[path = "cfgs/powerpc.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
use crate::utils::{MaybeUninit128, Pair};

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("lwsync", ""),
            Ordering::Release => $op!("", "lwsync"),
            Ordering::AcqRel => $op!("lwsync", "lwsync"),
            Ordering::SeqCst => $op!("lwsync", "sync"),
            _ => unreachable!("{:?}", $order),
        }
    };
}

use crate::utils::RegSize as Cr;
// Extracts and checks the EQ bit of cr0.
#[inline]
fn extract_cr0(r: Cr) -> bool {
    r & 0x20000000 != 0
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($int_type:ident, $l_suffix:tt, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) load from src to out
                                $release,
                                concat!("l", $l_suffix, " {out}, 0({src})"),
                                $acquire,
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(target_arch = "powerpc64")]
                    macro_rules! atomic_load_acquire {
                        ($release:tt) => {
                            asm!(
                                $release,
                                // (atomic) load from src to out
                                concat!("l", $l_suffix, " {out}, 0({src})"),
                                // Lightweight acquire sync
                                // Refs: https://github.com/boostorg/atomic/blob/boost-1.79.0/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp#L47-L62
                                "cmpd %cr7, {out}, {out}",
                                "bne- %cr7, 2f",
                                "2:",
                                "isync",
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = lateout(reg) out,
                                out("cr7") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        #[cfg(target_arch = "powerpc64")]
                        Ordering::Acquire => atomic_load_acquire!(""),
                        #[cfg(target_arch = "powerpc64")]
                        Ordering::SeqCst => atomic_load_acquire!("sync"),
                        #[cfg(target_arch = "powerpc")]
                        Ordering::Acquire => atomic_load!("lwsync", ""),
                        #[cfg(target_arch = "powerpc")]
                        Ordering::SeqCst => atomic_load!("lwsync", "sync"),
                        _ => unreachable!("{:?}", order),
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // (atomic) store val to dst
                                $release,
                                concat!("st", $asm_suffix, " {val}, 0({dst})"),
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        Ordering::Release => atomic_store!("lwsync"),
                        Ordering::SeqCst => atomic_store!("sync"),
                        _ => unreachable!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($int_type:ident, $l_suffix:tt, $asm_suffix:tt, $cmp_suffix:tt) => {
        atomic_load_store!($int_type, $l_suffix, $asm_suffix);
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) swap (LL/SC loop)
                                $release,
                                "2:",
                                    // load from dst to out
                                    concat!("l", $asm_suffix, "arx {out}, 0, {dst}"),
                                    // try to store val to dst
                                    concat!("st", $asm_suffix, "cx. {val}, 0, {dst}"),
                                    "bne %cr0, 2b",
                                $acquire,
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
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
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: Cr;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) CAS (LL/SC loop)
                                $release,
                                "2:",
                                    concat!("l", $asm_suffix, "arx {out}, 0, {dst}"),
                                    concat!("cmp", $cmp_suffix, " {old}, {out}"),
                                    "bne %cr0, 3f", // jump if compare failed
                                    concat!("st", $asm_suffix, "cx. {new}, 0, {dst}"),
                                    "bne %cr0, 2b", // continue loop if store failed
                                "3:",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr {r}",
                                $acquire,
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = in(reg) crate::utils::zero_extend(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = lateout(reg) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    (out, extract_cr0(r))
                }
            }
        }
    };
}

#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($int_type:ident, $l_suffix:tt, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $l_suffix, $asm_suffix);
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (aligned_ptr, shift, mask) = crate::utils::create_partword_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_partword_mask_values.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "slw {mask}, {mask}, {shift}",
                                "slw {val}, {val}, {shift}",
                                "and {val}, {val}, {mask}",
                                // (atomic) swap (LL/SC loop)
                                $release,
                                "2:",
                                    "lwarx {out}, 0, {dst}",
                                    "andc {tmp}, {out}, {mask}",
                                    "or {tmp}, {val}, {tmp}",
                                    "stwcx. {tmp}, 0, {dst}",
                                    "bne %cr0, 2b",
                                "srw {out}, {out}, {shift}",
                                $acquire,
                                dst = in(reg_nonzero) ptr_reg!(aligned_ptr),
                                val = inout(reg) crate::utils::zero_extend(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
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
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let (aligned_ptr, shift, mask) = crate::utils::create_partword_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: Cr;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_partword_mask_values.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "slw {mask}, {mask}, {shift}",
                                "slw {old}, {old}, {shift}",
                                "slw {new}, {new}, {shift}",
                                "and {old}, {old}, {mask}",
                                "and {new}, {new}, {mask}",
                                // (atomic) CAS (LL/SC loop)
                                $release,
                                "2:",
                                    "lwarx {tmp}, 0, {dst}",
                                    "and {out}, {tmp}, {mask}",
                                    "cmpw {out}, {old}",
                                    "bne %cr0, 3f",
                                    "andc {tmp}, {tmp}, {mask}",
                                    "or {tmp}, {tmp}, {new}",
                                    "stwcx. {tmp}, 0, {dst}",
                                    "bne %cr0, 2b",
                                "3:",
                                "srw {out}, {out}, {shift}",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr {r}",
                                $acquire,
                                dst = in(reg_nonzero) ptr_reg!(aligned_ptr),
                                old = inout(reg) crate::utils::zero_extend(old) => _,
                                new = inout(reg) crate::utils::zero_extend(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                r = lateout(reg) r,
                                tmp = out(reg) _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    (out, extract_cr0(r))
                }
            }
        }
    };
}

#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "partword-atomics",
    atomic_maybe_uninit_target_feature = "partword-atomics",
))]
atomic!(i8, "bz", "b", "w");
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "partword-atomics",
    atomic_maybe_uninit_target_feature = "partword-atomics",
))]
atomic!(u8, "bz", "b", "w");
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "partword-atomics",
    atomic_maybe_uninit_target_feature = "partword-atomics",
))]
atomic!(i16, "hz", "h", "w");
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "partword-atomics",
    atomic_maybe_uninit_target_feature = "partword-atomics",
))]
atomic!(u16, "hz", "h", "w");
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
atomic_sub_word!(i8, "bz", "b");
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
atomic_sub_word!(u8, "bz", "b");
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
atomic_sub_word!(i16, "hz", "h");
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
atomic_sub_word!(u16, "hz", "h");
atomic!(i32, "wz", "w", "w");
atomic!(u32, "wz", "w", "w");
#[cfg(target_arch = "powerpc64")]
atomic!(i64, "d", "d", "d");
#[cfg(target_arch = "powerpc64")]
atomic!(u64, "d", "d", "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "wz", "w", "w");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "wz", "w", "w");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d", "d", "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d", "d", "d");

// https://github.com/llvm/llvm-project/commit/549e118e93c666914a1045fde38a2cac33e1e445
// https://github.com/llvm/llvm-project/blob/llvmorg-17.0.0-rc2/llvm/test/CodeGen/PowerPC/atomics-i128-ldst.ll
// https://github.com/llvm/llvm-project/blob/llvmorg-17.0.0-rc2/llvm/test/CodeGen/PowerPC/atomics-i128.ll
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
macro_rules! atomic128 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let (prev_hi, prev_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load_acquire {
                        ($release:tt) => {
                            asm!(
                                // (atomic) load from src to out pair
                                $release,
                                "lq %r4, 0({src})",
                                // Lightweight acquire sync
                                // Refs: https://github.com/boostorg/atomic/blob/boost-1.79.0/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp#L47-L62
                                "cmpd %cr7, %r4, %r4",
                                "bne- %cr7, 2f",
                                "2:",
                                "isync",
                                src = in(reg_nonzero) ptr_reg!(src),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") prev_hi,
                                out("r5") prev_lo,
                                out("cr7") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // (atomic) load from src to out pair
                                "lq %r4, 0({src})",
                                src = in(reg_nonzero) ptr_reg!(src),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") prev_hi,
                                out("r5") prev_lo,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Acquire => atomic_load_acquire!(""),
                        Ordering::SeqCst => atomic_load_acquire!("sync"),
                        _ => unreachable!("{:?}", order),
                    }
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
                        ($release:tt) => {
                            asm!(
                                // (atomic) store val pair to dst
                                $release,
                                "stq %r4, 0({dst})",
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                in("r4") val.pair.hi,
                                in("r5") val.pair.lo,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        Ordering::Release => atomic_store!("lwsync"),
                        Ordering::SeqCst => atomic_store!("sync"),
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
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit128 { $int_type: val };
                let (mut prev_hi, mut prev_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) swap (LL/SC loop)
                                $release,
                                "2:",
                                    // load from dst to out pair
                                    "lqarx %r6, 0, {dst}",
                                    // try to store val pair to dst
                                    "stqcx. %r8, 0, {dst}",
                                    "bne %cr0, 2b",
                                $acquire,
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r6") prev_hi,
                                out("r7") prev_lo,
                                in("r8") val.pair.hi,
                                in("r9") val.pair.lo,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
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
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let old = MaybeUninit128 { $int_type: old };
                let new = MaybeUninit128 { $int_type: new };
                let (mut prev_hi, mut prev_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: Cr;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) CAS (LL/SC loop)
                                $release,
                                "2:",
                                    "lqarx %r8, 0, {dst}",
                                    "xor {tmp_lo}, %r9, {old_lo}",
                                    "xor {tmp_hi}, %r8, {old_hi}",
                                    "or. {tmp_lo}, {tmp_lo}, {tmp_hi}",
                                    "bne %cr0, 3f", // jump if compare failed
                                    "stqcx. %r6, 0, {dst}",
                                    "bne %cr0, 2b", // continue loop if store failed
                                "3:",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr {tmp_lo}",
                                $acquire,
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old_hi = in(reg) old.pair.hi,
                                old_lo = in(reg) old.pair.lo,
                                tmp_hi = out(reg) _,
                                tmp_lo = out(reg) r,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                in("r6") new.pair.hi,
                                in("r7") new.pair.lo,
                                out("r8") prev_hi,
                                out("r9") prev_lo,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    (
                        MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type,
                        extract_cr0(r)
                    )
                }
            }
        }
    };
}

#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
atomic128!(i128);
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
atomic128!(u128);
