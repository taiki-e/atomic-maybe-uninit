// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
PowerPC and PowerPC64

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#powerpc

Refs:
- Power ISA
  https://openpowerfoundation.org/specifications/isa
- AIX Assembler language reference
  https://www.ibm.com/docs/en/aix/7.3?topic=aix-assembler-language-reference
- Example POWER Implementation for C/C++ Memory Model
  http://www.rdrop.com/users/paulmck/scalability/paper/N2745r.2010.02.19a.html
- portable-atomic
  https://github.com/taiki-e/portable-atomic

Generated asm:
- powerpc https://godbolt.org/z/6PMzWfhEM
- powerpc (+msync) https://godbolt.org/z/hsEGM66T9
- powerpc (pwr8) https://godbolt.org/z/5KvMh4Phn
- powerpc64 https://godbolt.org/z/exbfnjTW4
- powerpc64 (pwr8) https://godbolt.org/z/4r3xGo8ef
- powerpc64le (pwr7) https://godbolt.org/z/9zzaKcWbe
- powerpc64le https://godbolt.org/z/3cs6ennKG
*/

delegate_size!(delegate_all);

pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap};
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
use crate::utils::{MaybeUninit128, Pair};

// https://gcc.gnu.org/legacy-ml/gcc-patches/2006-11/msg01238.html
#[cfg(any(target_feature = "msync", atomic_maybe_uninit_target_feature = "msync"))]
macro_rules! lwsync {
    () => {
        "sync"
    };
}
#[cfg(not(any(target_feature = "msync", atomic_maybe_uninit_target_feature = "msync")))]
macro_rules! lwsync {
    () => {
        "lwsync"
    };
}

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("isync", ""),
            Ordering::Release => $op!("", lwsync!()),
            Ordering::AcqRel => $op!("isync", lwsync!()),
            Ordering::SeqCst => $op!("isync", "sync"),
            _ => unreachable!(),
        }
    };
}
macro_rules! atomic_cas {
    ($op:ident, $success:ident, $failure:ident) => {
        if $failure == Ordering::Relaxed {
            match $success {
                Ordering::Relaxed => $op!("", "", ""),
                Ordering::Acquire => $op!("", "isync", ""),
                Ordering::Release => $op!("", "", lwsync!()),
                Ordering::AcqRel => $op!("", "isync", lwsync!()),
                Ordering::SeqCst => $op!("", "isync", "sync"),
                _ => unreachable!(),
            }
        } else {
            let order = crate::utils::upgrade_success_ordering($success, $failure);
            match order {
                // Relaxed and Release are covered in $failure == Relaxed branch.
                Ordering::Acquire => $op!("isync", "", ""),
                Ordering::AcqRel => $op!("isync", "", lwsync!()),
                Ordering::SeqCst => $op!("isync", "", "sync"),
                _ => unreachable!(),
            }
        }
    };
}

// Extracts and checks the EQ bit of cr0.
#[inline(always)]
const fn test_cr0_eq(cr: crate::utils::RegSize) -> bool {
    cr & 0x20000000 != 0
}

macro_rules! atomic_load_store {
    ($ty:ident, $size:literal, $suffix:tt, $load_ext:tt) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load_acquire {
                        ($release:expr) => {
                            asm!(
                                $release,
                                concat!("l", $suffix, $load_ext, " {out}, 0({src})"), // atomic { out = *src }
                                "cmpw {out}, {out}",                                  // if out == out { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                "bne- %cr0, 2f",                                      // if unlikely(cr0.EQ == 0) { jump 'never }
                                "2:", // 'never:
                                "isync",                                              // fence (works in combination with a branch that depends on the loaded value)
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = lateout(reg) out,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("l", $suffix, $load_ext, " {out}, 0({src})"), // atomic { out = *src }
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Acquire => atomic_load_acquire!(""),
                        Ordering::SeqCst => atomic_load_acquire!("sync"),
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:expr) => {
                            asm!(
                                $release,                                   // fence
                                concat!("st", $suffix, " {val}, 0({dst})"), // atomic { *dst = val }
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        Ordering::Release => atomic_store!(lwsync!()),
                        Ordering::SeqCst => atomic_store!("sync"),
                        _ => unreachable!(),
                    }
                }
            }
        }
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("l", $suffix, $load_ext, " {tmp0}, 0({src})"), // atomic { tmp0 = *src }
                    concat!("addi {src}, {src}, ", $size),                // src = src.byte_add($size)
                    src = inout(reg_nonzero) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("l", $suffix, $load_ext, " {tmp1}, ", $size, "({src})"), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("l", $suffix, $load_ext, " {tmp0}, 0({src})"),           // atomic { tmp0 = *src }
                    concat!("addi {src}, {src}, 2*", $size),                         // src = src.byte_add(2*$size)
                    src = inout(reg_nonzero) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("st", $suffix, " {tmp0}, 0({dst})"), // atomic { *dst = tmp0 }
                    concat!("addi {dst}, {dst}, ", $size),       // dst = dst.byte_add($size)
                    dst = inout(reg_nonzero) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("st", $suffix, " {tmp1}, ", $size, "({dst})"), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("st", $suffix, " {tmp0}, 0({dst})"),           // atomic { *dst = tmp0 }
                    concat!("addi {dst}, {dst}, 2*", $size),               // dst = dst.byte_add(2*$size)
                    dst = inout(reg_nonzero) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $size:literal, $suffix:tt, $load_ext:tt, $cmp_size:tt) => {
        atomic_load_store!($ty, $size, $suffix, $load_ext);
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                $release,                                          // fence
                                "2:", // 'retry:
                                    concat!("l", $suffix, "arx {out}, 0, {dst}"),  // atomic { RESERVE = (dst, size_of($ty)); out = *dst }
                                    concat!("st", $suffix, "cx. {val}, 0, {dst}"), // atomic { if RESERVE == (dst, size_of($ty)) { *dst = val; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                    "bne %cr0, 2b",                                // if cr0.EQ == 0 { jump 'retry }
                                $acquire,                                          // fence
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
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;
                let mut r;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! cmpxchg {
                        ($acquire_always:expr, $acquire_success:expr, $release:expr) => {
                            asm!(
                                $release,                                          // fence
                                "2:", // 'retry:
                                    concat!("l", $suffix, "arx {out}, 0, {dst}"),  // atomic { RESERVE = (dst, size_of($ty)); out = *dst }
                                    concat!("cmp", $cmp_size, " {old}, {out}"),    // if old == out { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                    "bne %cr0, 3f",                                // if cr0.EQ == 0 { jump 'cmp-fail }
                                    concat!("st", $suffix, "cx. {new}, 0, {dst}"), // atomic { if RESERVE == (dst, size_of($ty)) { *dst = new; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                    "bne %cr0, 2b",                                // if cr0.EQ == 0 { jump 'retry }
                                    $acquire_success,                              // fence
                                "3:", // 'cmp-fail:
                                $acquire_always,                                   // fence
                                "mfcr {r}",                                        // r = zero_extend(cr)
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = lateout(reg) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_cas!(cmpxchg, success, failure);
                    // if compare failed EQ bit is cleared, if store succeeds EQ bit is set.
                    (out, test_cr0_eq(r))
                }
            }
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;
                let mut r;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! cmpxchg_weak {
                        ($acquire_always:expr, $acquire_success:expr, $release:expr) => {
                            asm!(
                                $release,                                      // fence
                                concat!("l", $suffix, "arx {out}, 0, {dst}"),  // atomic { RESERVE = (dst, size_of($ty)); out = *dst }
                                concat!("cmp", $cmp_size, " {old}, {out}"),    // if old == out { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                "bne %cr0, 3f",                                // if cr0.EQ == 0 { jump 'cmp-fail }
                                concat!("st", $suffix, "cx. {new}, 0, {dst}"), // atomic { if RESERVE == (dst, size_of($ty)) { *dst = new; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                $acquire_success,                              // fence
                                "3:", // 'cmp-fail:
                                $acquire_always,                               // fence
                                "mfcr {r}",                                    // r = zero_extend(cr)
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = lateout(reg) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_cas!(cmpxchg_weak, success, failure);
                    // if compare or store failed EQ bit is cleared, if store succeeds EQ bit is set.
                    (out, test_cr0_eq(r))
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($ty:ident, $size:literal, $suffix:tt) => {
        #[cfg(any(
            target_feature = "partword-atomics",
            atomic_maybe_uninit_target_feature = "partword-atomics",
        ))]
        atomic!($ty, $size, $suffix, "z", "w");
        #[cfg(not(any(
            target_feature = "partword-atomics",
            atomic_maybe_uninit_target_feature = "partword-atomics",
        )))]
        atomic_load_store!($ty, $size, $suffix, "z");
        #[cfg(not(any(
            target_feature = "partword-atomics",
            atomic_maybe_uninit_target_feature = "partword-atomics",
        )))]
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                "slw {val}, {val}, {shift}",     // val <<= shift
                                $release,                        // fence
                                "2:", // 'retry:
                                    "lwarx {out}, 0, {dst}",     // atomic { RESERVE = (dst, 4); out = *dst }
                                    "andc {tmp}, {out}, {mask}", // tmp = out & !mask
                                    "or {tmp}, {val}, {tmp}",    // tmp |= val
                                    "stwcx. {tmp}, 0, {dst}",    // atomic { if RESERVE == (dst, 4) { *dst = tmp; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                    "bne %cr0, 2b",              // if cr0.EQ == 0 { jump 'retry }
                                $acquire,                        // fence
                                "srw {out}, {out}, {shift}",     // out >>= shift
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                val = inout(reg) crate::utils::extend32::$ty::zero(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = in(reg) mask,
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
        #[cfg(not(any(
            target_feature = "partword-atomics",
            atomic_maybe_uninit_target_feature = "partword-atomics",
        )))]
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;
                let mut r;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($acquire_always:expr, $acquire_success:expr, $release:expr) => {
                            asm!(
                                "slw {old}, {old}, {shift}",     // old <<= shift
                                "slw {new}, {new}, {shift}",     // new <<= shift
                                $release,                        // fence
                                "2:", // 'retry:
                                    "lwarx {out}, 0, {dst}",     // atomic { RESERVE = (dst, 4); out = *dst }
                                    "and {tmp}, {out}, {mask}",  // tmp = out & mask
                                    "cmpw {tmp}, {old}",         // if tmp == old { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                    "bne %cr0, 3f",              // if cr0.EQ == 0 { jump 'cmp-fail }
                                    "andc {tmp}, {out}, {mask}", // tmp = out & !mask
                                    "or {tmp}, {tmp}, {new}",    // tmp |= new
                                    "stwcx. {tmp}, 0, {dst}",    // atomic { if RESERVE == (dst, size_of($ty)) { *dst = tmp; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                    "bne %cr0, 2b",              // if cr0.EQ == 0 { jump 'retry }
                                    $acquire_success,            // fence
                                "3:", // 'cmp-fail:
                                $acquire_always,                 // fence
                                "srw {out}, {out}, {shift}",     // out >>= shift
                                "mfcr {tmp}",                    // r = zero_extend(cr)
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = inout(reg) crate::utils::extend32::$ty::zero(old) => _,
                                new = inout(reg) crate::utils::extend32::$ty::zero(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = in(reg) mask,
                                tmp = out(reg) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_cas!(cmpxchg, success, failure);
                    // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                    (out, test_cr0_eq(r))
                }
            }
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;
                let mut r;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg_weak {
                        ($acquire_always:expr, $acquire_success:expr, $release:expr) => {
                            asm!(
                                "slw {old}, {old}, {shift}", // old <<= shift
                                "slw {new}, {new}, {shift}", // new <<= shift
                                $release,                    // fence
                                "lwarx {out}, 0, {dst}",     // atomic { RESERVE = (dst, 4); out = *dst }
                                "and {tmp}, {out}, {mask}",  // tmp = out & mask
                                "cmpw {tmp}, {old}",         // if tmp == old { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                "bne %cr0, 3f",              // if cr0.EQ == 0 { jump 'cmp-fail }
                                "andc {tmp}, {out}, {mask}", // tmp = out & !mask
                                "or {tmp}, {tmp}, {new}",    // tmp |= new
                                "stwcx. {tmp}, 0, {dst}",    // atomic { if RESERVE == (dst, size_of($ty)) { *dst = tmp; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                $acquire_success,            // fence
                                "3:", // 'cmp-fail:
                                $acquire_always,             // fence
                                "srw {out}, {out}, {shift}", // out >>= shift
                                "mfcr {tmp}",                // r = zero_extend(cr)
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = inout(reg) crate::utils::extend32::$ty::zero(old) => _,
                                new = inout(reg) crate::utils::extend32::$ty::zero(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = in(reg) mask,
                                tmp = out(reg) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_cas!(cmpxchg_weak, success, failure);
                    // if compare or store failed EQ bit is cleared, if store succeeds EQ bit is set.
                    (out, test_cr0_eq(r))
                }
            }
        }
    };
}

atomic_sub_word!(u8, "1", "b");
atomic_sub_word!(u16, "2", "h");
atomic!(u32, "4", "w", "z", "w");
#[cfg(target_arch = "powerpc64")]
atomic!(u64, "8", "d", "", "d");

#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
macro_rules! atomic128 {
    ($ty:ident) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let (out_hi, out_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load_acquire {
                        ($release:expr) => {
                            asm!(
                                $release,
                                "lq %r4, 0({src})", // atomic { r4:r5 = *src }
                                "cmpw %r4, %r4",    // if r4 == r4 { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                "bne- %cr0, 2f",    // if unlikely(cr0.EQ == 0) { jump 'never }
                                "2:", // 'never:
                                "isync",            // fence (works in combination with a branch that depends on the loaded value)
                                src = in(reg_nonzero) ptr_reg!(src),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") out_hi,
                                out("r5") out_lo,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                "lq %r4, 0({src})", // atomic { r4:r5 = *src }
                                src = in(reg_nonzero) ptr_reg!(src),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") out_hi,
                                out("r5") out_lo,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Acquire => atomic_load_acquire!(""),
                        Ordering::SeqCst => atomic_load_acquire!("sync"),
                        _ => unreachable!(),
                    }
                    MaybeUninit128 { pair: Pair { lo: out_lo, hi: out_hi } }.whole
                }
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit128 { whole: val };

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:expr) => {
                            asm!(
                                $release,            // fence
                                "stq %r4, 0({dst})", // atomic { *dst = r4:r5 }
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
                        Ordering::Release => atomic_store!(lwsync!()),
                        Ordering::SeqCst => atomic_store!("sync"),
                        _ => unreachable!(),
                    }
                }
            }
        }
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit128 { whole: val };
                let (mut prev_hi, mut prev_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                $release,                   // fence
                                "2:", // 'retry:
                                    "lqarx %r6, 0, {dst}",  // atomic { RESERVE = (dst, 16); r6:r7 = *dst }
                                    "stqcx. %r8, 0, {dst}", // atomic { if RESERVE == (dst, 16) { *dst = r8:r9; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                    "bne %cr0, 2b",         // if cr0.EQ == 0 { jump 'retry }
                                $acquire,                   // fence
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
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                }
            }
        }
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let old = MaybeUninit128 { whole: old };
                let new = MaybeUninit128 { whole: new };
                let (mut prev_hi, mut prev_lo);
                let mut r;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! cmpxchg {
                        ($acquire_always:expr, $acquire_success:expr, $release:expr) => {
                            asm!(
                                $release,                               // fence
                                "2:", // 'retry:
                                    "lqarx %r8, 0, {dst}",              // atomic { RESERVE = (dst, 16); r8:r9 = *dst }
                                    "xor {tmp_lo}, %r9, {old_lo}",      // tmp_lo = r9 ^ old_lo
                                    "xor {tmp_hi}, %r8, {old_hi}",      // tmp_hi = r8 ^ old_hi
                                    "or. {tmp_lo}, {tmp_lo}, {tmp_hi}", // tmp_lo |= tmp_hi; if tmp_lo == 0 { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                    "bne %cr0, 3f",                     // if cr0.EQ == 0 { jump 'cmp-fail }
                                    "stqcx. %r6, 0, {dst}",             // atomic { if RESERVE == (dst, 16) { *dst = r6:r7; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                    "bne %cr0, 2b",                     // if cr0.EQ == 0 { jump 'retry }
                                    $acquire_success,                   // fence
                                "3:", // 'cmp-fail:
                                $acquire_always,                        // fence
                                "mfcr {tmp_lo}",                        // tmp_lo = zero_extend(cr)
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
                    atomic_cas!(cmpxchg, success, failure);
                    // if compare failed EQ bit is cleared, if store succeeds EQ bit is set.
                    (
                        MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole,
                        test_cr0_eq(r)
                    )
                }
            }
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let old = MaybeUninit128 { whole: old };
                let new = MaybeUninit128 { whole: new };
                let (mut prev_hi, mut prev_lo);
                let mut r;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! cmpxchg_weak {
                        ($acquire_always:expr, $acquire_success:expr, $release:expr) => {
                            asm!(
                                $release,                           // fence
                                "lqarx %r8, 0, {dst}",              // atomic { RESERVE = (dst, 16); r8:r9 = *dst }
                                "xor {tmp_lo}, %r9, {old_lo}",      // tmp_lo = r9 ^ old_lo
                                "xor {tmp_hi}, %r8, {old_hi}",      // tmp_hi = r8 ^ old_hi
                                "or. {tmp_lo}, {tmp_lo}, {tmp_hi}", // tmp_lo |= tmp_hi; if tmp_lo == 0 { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                "bne %cr0, 3f",                     // if cr0.EQ == 0 { jump 'cmp-fail }
                                "stqcx. %r6, 0, {dst}",             // atomic { if RESERVE == (dst, 16) { *dst = r6:r7; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                $acquire_success,                   // fence
                                "3:", // 'cmp-fail:
                                $acquire_always,                    // fence
                                "mfcr {tmp_lo}",                    // tmp_lo = zero_extend(cr)
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
                    atomic_cas!(cmpxchg_weak, success, failure);
                    // if compare or store failed EQ bit is cleared, if store succeeds EQ bit is set.
                    (
                        MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole,
                        test_cr0_eq(r)
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
atomic128!(u128);

// -----------------------------------------------------------------------------
// cfg macros

#[macro_export]
macro_rules! cfg_has_atomic_8 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_8 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_16 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_16 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => {};
}
#[cfg(target_arch = "powerpc")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(target_arch = "powerpc")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "powerpc64")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "powerpc64")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ),
)))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ),
)))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "powerpc64",
    any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ),
))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "powerpc64",
    any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ),
))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_memcpy {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_memcpy {
    ($($tt:tt)*) => {};
}
