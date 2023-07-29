// PowerPC and PowerPC64
//
// Refs:
// - Power ISA https://openpowerfoundation.org/specifications/isa
// - AIX Assembler language reference https://www.ibm.com/docs/en/aix/7.3?topic=aix-assembler-language-reference
// - http://www.rdrop.com/users/paulmck/scalability/paper/N2745r.2010.02.19a.html
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - powerpc https://godbolt.org/z/PME7czo4P
// - powerpc64 https://godbolt.org/z/forK75PK4
// - powerpc64 (pwr8) https://godbolt.org/z/eGf47W164
// - powerpc64le https://godbolt.org/z/7f1b8WWd3
// - powerpc64le (pwr7) https://godbolt.org/z/bKxv6W3Mn

#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
#[path = "partword.rs"]
mod partword;

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
#[cfg(target_endian = "big")]
macro_rules! p128h {
    () => {
        "0"
    };
}
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
#[cfg(target_endian = "big")]
macro_rules! p128l {
    () => {
        "8"
    };
}
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
#[cfg(target_endian = "little")]
macro_rules! p128h {
    () => {
        "8"
    };
}
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
#[cfg(target_endian = "little")]
macro_rules! p128l {
    () => {
        "0"
    };
}

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

#[cfg(target_arch = "powerpc")]
type XSize = u32;
#[cfg(target_arch = "powerpc64")]
type XSize = u64;

use XSize as Cr;
// Extracts and checks the EQ bit of cr0.
#[inline]
fn extract_cr0(r: Cr) -> bool {
    r & 0x20000000 != 0
}

macro_rules! atomic_load_store {
    ($int_type:ident, $l_suffix:tt, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                #[cfg(target_arch = "powerpc64")]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load_acquire {
                        ($release:tt) => {
                            asm!(
                                $release,
                                // (atomic) load from src to tmp
                                concat!("l", $l_suffix, " {tmp}, 0({src})"),
                                // Lightweight acquire sync
                                // Refs: https://github.com/boostorg/atomic/blob/boost-1.79.0/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp#L47-L62
                                "cmpd %cr7, {tmp}, {tmp}",
                                "bne- %cr7, 2f",
                                "2:",
                                "isync",
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp = lateout(reg_nonzero) _,
                                out("cr7") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("l", $l_suffix, " {tmp}, 0({src})"),
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp = lateout(reg_nonzero) _,
                                options(nostack, preserves_flags),
                            )
                        }
                        Ordering::Acquire => atomic_load_acquire!(""),
                        Ordering::SeqCst =>  atomic_load_acquire!("sync"),
                        _ => unreachable!("{:?}", order),
                    }
                }
                #[cfg(target_arch = "powerpc")]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) load from src to tmp
                                $release,
                                concat!("l", $l_suffix, " {tmp}, 0({src})"),
                                $acquire,
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp = lateout(reg_nonzero) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("lwsync", ""),
                        Ordering::SeqCst => atomic_load!("lwsync", "sync"),
                        _ => unreachable!("{:?}", order),
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("l", $l_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                $release,
                                concat!("st", $asm_suffix, " {tmp}, 0({dst})"),
                                dst = inout(reg_nonzero) ptr_reg!(dst) => _,
                                val = in(reg_nonzero) ptr_reg!(val),
                                tmp = lateout(reg_nonzero) _,
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
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val (ptr) to val (val)
                                concat!("l", $l_suffix, " {val}, 0({val})"),
                                // (atomic) swap (LL/SC loop)
                                $release,
                                "2:",
                                    // load from dst to tmp
                                    concat!("l", $asm_suffix, "arx {tmp}, 0, {dst}"),
                                    // try to store val to dst
                                    concat!("st", $asm_suffix, "cx. {val}, 0, {dst}"),
                                    "bne %cr0, 2b",
                                $acquire,
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                val = inout(reg_nonzero) ptr_reg!(val) => _,
                                out = in(reg_nonzero) ptr_reg!(out),
                                tmp = out(reg_nonzero) _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: Cr;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from old/new (ptr) to old/new (val)
                                concat!("l", $l_suffix, " {old}, 0({old})"),
                                concat!("l", $l_suffix, " {new}, 0({new})"),
                                // (atomic) CAS (LL/SC loop)
                                $release,
                                "2:",
                                    concat!("l", $asm_suffix, "arx {tmp}, 0, {dst}"),
                                    concat!("cmp", $cmp_suffix, " {old}, {tmp}"),
                                    "bne %cr0, 3f", // jump if compare failed
                                    concat!("st", $asm_suffix, "cx. {new}, 0, {dst}"),
                                    "bne %cr0, 2b", // continue loop if store failed
                                "3:",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr {r}",
                                $acquire,
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = inout(reg_nonzero) ptr_reg!(old) => _,
                                new = inout(reg_nonzero) ptr_reg!(new) => _,
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp = out(reg_nonzero) _,
                                r = lateout(reg_nonzero) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    extract_cr0(r)
                }
            }
        }
    };
}

#[cfg(not(all(
    target_arch = "powerpc64",
    any(target_feature = "partword-atomics", atomic_maybe_uninit_target_feature = "partword-atomics"),
)))]
#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($int_type:ident, $l_suffix:tt, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $l_suffix, $asm_suffix);
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
                let (aligned_ptr, shift, mask) = partword::create_mask_values(dst);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also partword.rs.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("l", $l_suffix, " {val}, 0({val})"),
                                "slw {mask}, {mask}, {shift}",
                                "slw {val}, {val}, {shift}",
                                "and {val}, {val}, {mask}",
                                // (atomic) swap (LL/SC loop)
                                $release,
                                "2:",
                                    "lwarx {tmp1}, 0, {dst}",
                                    "andc {tmp2}, {tmp1}, {mask}",
                                    "or {tmp2}, {val}, {tmp2}",
                                    "stwcx. {tmp2}, 0, {dst}",
                                    "bne %cr0, 2b",
                                "srw {tmp1}, {tmp1}, {shift}",
                                $acquire,
                                concat!("st", $asm_suffix, " {tmp1}, 0({out})"),
                                dst = in(reg_nonzero) ptr_reg!(aligned_ptr),
                                val = inout(reg_nonzero) ptr_reg!(val) => _,
                                out = in(reg_nonzero) ptr_reg!(out),
                                shift = in(reg_nonzero) shift,
                                mask = inout(reg_nonzero) mask => _,
                                tmp1 = out(reg_nonzero) _,
                                tmp2 = out(reg_nonzero) _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
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
                let (aligned_ptr, shift, mask) = partword::create_mask_values(dst);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: Cr;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also partword.rs.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("l", $l_suffix, " {old}, 0({old})"),
                                concat!("l", $l_suffix, " {new}, 0({new})"),
                                "slw {mask}, {mask}, {shift}",
                                "slw {old}, {old}, {shift}",
                                "slw {new}, {new}, {shift}",
                                "and {old}, {old}, {mask}",
                                "and {new}, {new}, {mask}",
                                // (atomic) CAS (LL/SC loop)
                                $release,
                                "2:",
                                    "lwarx {tmp2}, 0, {dst}",
                                    "and {tmp1}, {tmp2}, {mask}",
                                    "cmpw {tmp1}, {old}",
                                    "bne %cr0, 3f",
                                    "andc {tmp2}, {tmp2}, {mask}",
                                    "or {tmp2}, {tmp2}, {new}",
                                    "stwcx. {tmp2}, 0, {dst}",
                                    "bne %cr0, 2b",
                                "3:",
                                "srw {tmp1}, {tmp1}, {shift}",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr {r}",
                                $acquire,
                                concat!("st", $asm_suffix, " {tmp1}, 0({out})"),
                                dst = in(reg_nonzero) ptr_reg!(aligned_ptr),
                                old = inout(reg_nonzero) ptr_reg!(old) => _,
                                new = inout(reg_nonzero) ptr_reg!(new) => _,
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                shift = in(reg_nonzero) shift,
                                mask = inout(reg_nonzero) mask => _,
                                r = lateout(reg_nonzero) r,
                                tmp1 = out(reg_nonzero) _,
                                tmp2 = out(reg_nonzero) _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    extract_cr0(r)
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
// https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/PowerPC/atomics-i128-ldst.ll
// https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/PowerPC/atomics-i128.ll
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
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load_acquire {
                        ($release:tt) => {
                            asm!(
                                // (atomic) load from src to out pair
                                $release,
                                "lq %r4, 0({src})",
                                // Refs: https://github.com/boostorg/atomic/blob/boost-1.79.0/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp#L47-L62
                                "cmpd %cr7, %r4, %r4",
                                "bne- %cr7, 2f",
                                "2:",
                                "isync",
                                // store out pair to out
                                concat!("std %r4, ", p128h!(), "({out})"),
                                concat!("std %r5, ", p128l!(), "({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // out (hi)
                                out("r5") _, // out (lo)
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
                                // store out pair to out
                                concat!("std %r4, ", p128h!(), "({out})"),
                                concat!("std %r5, ", p128l!(), "({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // out (hi)
                                out("r5") _, // out (lo)
                                options(nostack, preserves_flags),
                            )
                        }
                        Ordering::Acquire => atomic_load_acquire!(""),
                        Ordering::SeqCst =>  atomic_load_acquire!("sync"),
                        _ => unreachable!("{:?}", order),
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // load from val to val pair
                                concat!("ld %r4, ", p128h!(), "({val})"),
                                concat!("ld %r5, ", p128l!(), "({val})"),
                                // (atomic) store val pair to dst
                                $release,
                                "stq %r4, 0({dst})",
                                dst = inout(reg_nonzero) ptr_reg!(dst) => _,
                                val = in(reg_nonzero) ptr_reg!(val),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // val (hi)
                                lateout("r5") _, // val (lo)
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
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to val pair
                                concat!("ld %r4, ", p128h!(), "({val})"),
                                concat!("ld %r5, ", p128l!(), "({val})"),
                                // (atomic) swap (LL/SC loop)
                                $release,
                                "2:",
                                    // load from dst to out pair
                                    "lqarx %r6, 0, {dst}",
                                    // try to store val pair to dst
                                    "stqcx. %r4, 0, {dst}",
                                    "bne %cr0, 2b",
                                $acquire,
                                // store out pair to out
                                concat!("std %r6, ", p128h!(), "({out})"),
                                concat!("std %r7, ", p128l!(), "({out})"),
                                dst = inout(reg_nonzero) ptr_reg!(dst) => _,
                                val = in(reg_nonzero) ptr_reg!(val),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // val (hi)
                                lateout("r5") _, // val (lo)
                                out("r6") _, // out (hi)
                                out("r7") _, // out (lo)
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: Cr;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from old/new to old/new pairs
                                concat!("ld %r4, ", p128h!(), "({old})"),
                                concat!("ld %r5, ", p128l!(), "({old})"),
                                concat!("ld %r6, ", p128h!(), "({new})"),
                                concat!("ld %r7, ", p128l!(), "({new})"),
                                // (atomic) CAS (LL/SC loop)
                                $release,
                                "2:",
                                    "lqarx %r8, 0, {dst}",
                                    "xor {tmp_lo}, %r9, %r5",
                                    "xor {tmp_hi}, %r8, %r4",
                                    "or. {tmp_lo}, {tmp_lo}, {tmp_hi}",
                                    "bne %cr0, 3f", // jump if compare failed
                                    "stqcx. %r6, 0, {dst}",
                                    "bne %cr0, 2b", // continue loop if store failed
                                "3:",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr {tmp_lo}",
                                $acquire,
                                // store out pair to out
                                concat!("std %r8, ", p128h!(), "({out})"),
                                concat!("std %r9, ", p128l!(), "({out})"),
                                dst = inout(reg_nonzero) ptr_reg!(dst) => _,
                                old = in(reg_nonzero) ptr_reg!(old),
                                new = in(reg_nonzero) ptr_reg!(new),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp_hi = out(reg_nonzero) _,
                                tmp_lo = out(reg_nonzero) r,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // old (hi)
                                out("r5") _, // old (lo)
                                out("r6") _, // new (hi)
                                lateout("r7") _, // new (lo)
                                lateout("r8") _, // out (hi)
                                lateout("r9") _, // out (lo)
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    extract_cr0(r)
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

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);
    test_atomic!(i32);
    test_atomic!(u32);
    #[cfg(target_arch = "powerpc64")]
    test_atomic!(i64);
    #[cfg(target_arch = "powerpc64")]
    test_atomic!(u64);
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ))]
    test_atomic!(i128);
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ))]
    test_atomic!(u128);

    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
    stress_test!(u16);
    stress_test!(u32);
    #[cfg(target_arch = "powerpc64")]
    stress_test!(u64);
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ))]
    stress_test!(u128);
}
