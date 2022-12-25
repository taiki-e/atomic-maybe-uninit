// Refs:
// - https://docs.nvidia.com/cuda/parallel-thread-execution/index.html#data-movement-and-conversion-instructions-ld
// - https://docs.nvidia.com/cuda/parallel-thread-execution/index.html#parallel-synchronization-and-communication-instructions-atom
// - https://docs.nvidia.com/cuda/parallel-thread-execution/index.html#parallel-synchronization-and-communication-instructions-membar
// - User Guide for NVPTX Back-end (LLVM documentation) https://llvm.org/docs/NVPTXUsage.html
//
// Generated asm:
// - nvptx64 https://godbolt.org/z/nKrG89hxY

// PTX ISA: requires PTX ISA 6.3+ due to `atom.cas.b16`. PTX ISA 6.0+ due to `.sem` qualifier of `atom`, `.relaxed`/`.acquire`/`.release` qualifier of `ld`/`st`, and `fence`
// Target ISA: requires sm_70+ due to `atom.cas.b16`, `.sem` qualifier of `atom`, `.relaxed`/`.acquire`/`.release` qualifier of `ld`/`st`, and `fence`
//
// TODO: fallback on pre-sm_70

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

// NVPTX's seqcst atomic op is preceding seqcst fence + acquire op.
macro_rules! fence_sc {
    () => {
        "fence.sc.gl;"
    };
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($int_type:ident, $bits:tt, $val_reg:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    macro_rules! atomic_load {
                        ($sem:tt, $fence_sc:expr) => {
                            asm!(
                                // (atomic) load from src to tmp
                                $fence_sc,
                                concat!("ld.", $sem, ".gpu.b", $bits, " {tmp}, [{src}];"),
                                // store tmp to out
                                concat!("st.b", $bits, " [{out}], {tmp};"),
                                src = in(reg64) src,
                                out = in(reg64) out,
                                tmp = out($val_reg) _,
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("relaxed", ""),
                        Ordering::Acquire => atomic_load!("acquire", ""),
                        Ordering::SeqCst => atomic_load!("acquire", fence_sc!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($sem:tt, $fence_sc:expr) => {
                            asm!(
                                // load from val to tmp
                                concat!("ld.b", $bits, " {tmp}, [{val}];"),
                                // (atomic) store tmp to dst
                                $fence_sc,
                                concat!("st.", $sem, ".gpu.b", $bits, " [{dst}], {tmp};"),
                                dst = in(reg64) dst,
                                val = in(reg64) val,
                                tmp = out($val_reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("relaxed", ""),
                        Ordering::Release => atomic_store!("release", ""),
                        Ordering::SeqCst => atomic_store!("relaxed", fence_sc!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $bits:tt, $val_reg:ident) => {
        atomic_load_store!($int_type, $bits, $val_reg);
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($sem:tt, $fence_sc:expr) => {
                            asm!(
                                // load from val to tmp
                                concat!("ld.b", $bits, " {val_tmp}, [{val}];"),
                                // (atomic) swap
                                $fence_sc,
                                concat!("atom.", $sem, ".gpu.exch.b", $bits, " {out_tmp}, [{dst}], {val_tmp};"),
                                // store tmp to out
                                concat!("st.b", $bits, " [{out}], {out_tmp};"),
                                dst = in(reg64) dst,
                                val = in(reg64) val,
                                val_tmp = out($val_reg) _,
                                out = in(reg64) out,
                                out_tmp = out($val_reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("relaxed", ""),
                        Ordering::Acquire => atomic_swap!("acquire", ""),
                        Ordering::Release => atomic_swap!("release", ""),
                        Ordering::AcqRel => atomic_swap!("acqrel", ""),
                        Ordering::SeqCst => atomic_swap!("acquire", fence_sc!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                unsafe {
                    let mut r: u32;
                    macro_rules! atomic_cmpxchg {
                        ($sem:tt, $fence_sc:expr) => {
                            asm!(
                                "{{",
                                ".reg .pred %p<3>;", // create a predicate register
                                // load from old/new to tmp
                                concat!("ld.b", $bits, " {old_tmp}, [{old}];"),
                                concat!("ld.b", $bits, " {new_tmp}, [{new}];"),
                                // (atomic) compare and exchange
                                $fence_sc,
                                concat!("atom.", $sem, ".gpu.cas.b", $bits, " {out_tmp}, [{dst}], {old_tmp}, {new_tmp};"),
                                // store tmp to out
                                concat!("st.b", $bits, " [{out}], {out_tmp};"),
                                concat!("setp.eq.s", $bits, " %p1, {out_tmp}, {old_tmp};"),
                                "selp.u32 {r}, 1, 0, %p1;",
                                "}}",
                                dst = in(reg64) dst,
                                old = in(reg64) old,
                                old_tmp = out($val_reg) _,
                                new = in(reg64) new,
                                new_tmp = out($val_reg) _,
                                out = in(reg64) out,
                                out_tmp = out($val_reg) _,
                                r = lateout(reg32) r,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("relaxed", ""),
                        Ordering::Acquire => atomic_cmpxchg!("acquire", ""),
                        Ordering::Release => atomic_cmpxchg!("release", ""),
                        Ordering::AcqRel => atomic_cmpxchg!("acqrel", ""),
                        Ordering::SeqCst => atomic_cmpxchg!("acquire", fence_sc!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                    r != 0
                }
            }
        }
    };
}

macro_rules! atomic16 {
    ($int_type:ident, $bits:tt, $val_reg:ident) => {
        atomic_load_store!($int_type, $bits, $val_reg);
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($sem:tt, $fence_sc:expr) => {
                            asm!(
                                "{{",
                                ".reg .pred %p<3>;", // create a predicate register
                                // load from val to tmp
                                concat!("ld.b", $bits, " {val_tmp}, [{val}];"),
                                // (atomic) swap
                                $fence_sc,
                                concat!("ld.gpu.b", $bits, " {old}, [{dst}];"),
                                "2:",
                                    concat!("atom.", $sem, ".gpu.cas.b", $bits, " {out_tmp}, [{dst}], {old}, {val_tmp};"),
                                    concat!("setp.ne.s", $bits, " %p1, {out_tmp}, {old};"),
                                    concat!("mov.u", $bits, " {old}, {out_tmp};"),
                                    "@%p1 bra 2b",
                                // store tmp to out
                                concat!("st.b", $bits, " [{out}], {out_tmp};"),
                                "}}",
                                dst = in(reg64) dst,
                                val = in(reg64) val,
                                val_tmp = out($val_reg) _,
                                out = in(reg64) out,
                                out_tmp = out($val_reg) _,
                                old = out($val_reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("relaxed", ""),
                        Ordering::Acquire => atomic_swap!("acquire", ""),
                        Ordering::Release => atomic_swap!("release", ""),
                        Ordering::AcqRel => atomic_swap!("acqrel", ""),
                        Ordering::SeqCst => atomic_swap!("acquire", fence_sc!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                unsafe {
                    let mut r: u32;
                    macro_rules! atomic_cmpxchg {
                        ($sem:tt, $fence_sc:expr) => {
                            asm!(
                                "{{",
                                ".reg .pred %p<3>;", // create a predicate register
                                // load from old/new to tmp
                                concat!("ld.b", $bits, " {old_tmp}, [{old}];"),
                                concat!("ld.b", $bits, " {new_tmp}, [{new}];"),
                                // (atomic) compare and exchange
                                $fence_sc,
                                concat!("atom.", $sem, ".gpu.cas.b", $bits, " {out_tmp}, [{dst}], {old_tmp}, {new_tmp};"),
                                // store tmp to out
                                concat!("st.b", $bits, " [{out}], {out_tmp};"),
                                concat!("setp.eq.s", $bits, " %p1, {out_tmp}, {old_tmp};"),
                                "selp.u32 {r}, 1, 0, %p1;",
                                "}}",
                                dst = in(reg64) dst,
                                old = in(reg64) old,
                                old_tmp = out($val_reg) _,
                                new = in(reg64) new,
                                new_tmp = out($val_reg) _,
                                out = in(reg64) out,
                                out_tmp = out($val_reg) _,
                                r = lateout(reg32) r,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("relaxed", ""),
                        Ordering::Acquire => atomic_cmpxchg!("acquire", ""),
                        Ordering::Release => atomic_cmpxchg!("release", ""),
                        Ordering::AcqRel => atomic_cmpxchg!("acqrel", ""),
                        Ordering::SeqCst => atomic_cmpxchg!("acquire", fence_sc!()),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                    r != 0
                }
            }
        }
    };
}

atomic_load_store!(i8, "8", reg16);
atomic_load_store!(u8, "16", reg16);
atomic16!(i16, "16", reg16);
atomic16!(u16, "16", reg16);
atomic!(i32, "32", reg32);
atomic!(u32, "32", reg32);
atomic!(i64, "64", reg64);
atomic!(u64, "64", reg64);
atomic!(isize, "64", reg64);
atomic!(usize, "64", reg64);

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic_load_store!(i8);
    test_atomic_load_store!(u8);
    test_atomic!(i16);
    test_atomic!(u16);
    test_atomic!(i32);
    test_atomic!(u32);
    test_atomic!(i64);
    test_atomic!(u64);

    stress_test_load_store!();
    stress_test_load_swap!();
}
