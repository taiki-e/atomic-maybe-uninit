// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
PowerPC and PowerPC64

This architecture provides the following atomic instructions:

- Load/Store Instructions (relaxed load/store)
  - All aligned {8,16,32}-bit and 64-bit (for PowerPC64) single load/store instructions
    other than Move Assist instruction are atomic.
  - ISA 2.07 or later: 128-bit for PowerPC64 (lq, stq, lqarx, stqcx.)
  (Section 1.4 "Single-Copy Atomicity" of Power ISA 3.1C Book II)
- Load And Reserve and Store Conditional Instructions (aka LL/SC)
  - PowerPC Architecture prior to v2.00, or later: 32-bit, 64-bit (for PowerPC64)
  - ISA 2.06 or later: {8,16}-bit for PowerPC64
  - ISA 2.07 or later: 128-bit for PowerPC64
  (Section 4.6.2 "Load And Reserve and Store Conditional Instructions" of Power ISA 3.1C Book II)
- Atomic Memory Operation (AMO) Instructions (RMW)
  - ISA 3.0 or later: {32,64}-bit swap,fetch_{add,and,or,xor,max,min},add,max,min for PowerPC64
  (Section 4.5 "Atomic Memory Operations" of Power ISA 3.1C Book II)

Refs:
- Power ISA https://openpowerfoundation.org/specifications/isa
- AIX Assembler language reference https://www.ibm.com/docs/en/aix/7.3?topic=aix-assembler-language-reference
- Example POWER Implementation for C/C++ Memory Model http://www.rdrop.com/users/paulmck/scalability/paper/N2745r.2010.02.19a.html
- portable-atomic https://github.com/taiki-e/portable-atomic

Generated asm:
- powerpc https://godbolt.org/z/1MTdM6qKj
- powerpc64 https://godbolt.org/z/E7453fxnn
- powerpc64 (pwr8) https://godbolt.org/z/ccW95s1Ex
- powerpc64le https://godbolt.org/z/dv1E9qac6
- powerpc64le (pwr7) https://godbolt.org/z/d6cnYrMq5
*/

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

#[cfg(target_arch = "powerpc")]
macro_rules! cmp {
    () => {
        "cmpw"
    };
}
#[cfg(target_arch = "powerpc64")]
macro_rules! cmp {
    () => {
        "cmpd"
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
            _ => unreachable!(),
        }
    };
}

// Extracts and checks the EQ bit of cr0.
#[inline(always)]
fn extract_cr0(r: crate::utils::RegSize) -> bool {
    r & 0x20000000 != 0
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($int_type:ident, $l_suffix:tt, $suffix:tt) => {
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
                    macro_rules! atomic_load_acquire {
                        ($release:tt) => {
                            asm!(
                                $release,
                                concat!("l", $l_suffix, " {out}, 0({src})"), // atomic { out = *src }
                                // Lightweight acquire sync
                                // Refs: https://github.com/boostorg/atomic/blob/boost-1.79.0/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp#L47-L62
                                concat!(cmp!(), " %cr7, {out}, {out}"),
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
                        Ordering::Relaxed => {
                            asm!(
                                concat!("l", $l_suffix, " {out}, 0({src})"), // atomic { out = *src }
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
                        Ordering::Release => atomic_store!("lwsync"),
                        Ordering::SeqCst => atomic_store!("sync"),
                        _ => unreachable!(),
                    }
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($int_type:ident, $l_suffix:tt, $suffix:tt, $cmp_suffix:tt) => {
        atomic_load_store!($int_type, $l_suffix, $suffix);
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
                                $release,                                          // fence
                                "2:", // 'retry:
                                    concat!("l", $suffix, "arx {out}, 0, {dst}"),  // atomic { RESERVE = (dst, size_of($int_type)); out = *dst }
                                    concat!("st", $suffix, "cx. {val}, 0, {dst}"), // atomic { if RESERVE == (dst, size_of($int_type)) { *dst = val; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
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
                    let mut r;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                          // fence
                                "2:", // 'retry:
                                    concat!("l", $suffix, "arx {out}, 0, {dst}"),  // atomic { RESERVE = (dst, size_of($int_type)); out = *dst }
                                    concat!("cmp", $cmp_suffix, " {old}, {out}"),  // if old == out { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                    "bne %cr0, 3f",                                // if cr0.EQ == 0 { jump 'cmp-fail }
                                    concat!("st", $suffix, "cx. {new}, 0, {dst}"), // atomic { if RESERVE == (dst, size_of($int_type)) { *dst = new; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                    "bne %cr0, 2b",                                // if cr0.EQ == 0 { jump 'retry }
                                "3:", // 'cmp-fail:
                                "mfcr {r}",                                        // r = zero_extend(cr)
                                $acquire,                                          // fence
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = lateout(reg) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    // if compare failed EQ bit is cleared, if store succeeds EQ bit is set.
                    (out, extract_cr0(r))
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r;
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                      // fence
                                concat!("l", $suffix, "arx {out}, 0, {dst}"),  // atomic { RESERVE = (dst, size_of($int_type)); out = *dst }
                                concat!("cmp", $cmp_suffix, " {old}, {out}"),  // if old == out { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                "bne %cr0, 3f",                                // if cr0.EQ == 0 { jump 'cmp-fail }
                                concat!("st", $suffix, "cx. {new}, 0, {dst}"), // atomic { if RESERVE == (dst, size_of($int_type)) { *dst = new; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                "3:", // 'cmp-fail:
                                "mfcr {r}",                                    // r = zero_extend(cr)
                                $acquire,                                      // fence
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = lateout(reg) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg_weak, order);
                    // if compare or store failed EQ bit is cleared, if store succeeds EQ bit is set.
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
    ($int_type:ident, $l_suffix:tt, $suffix:tt) => {
        atomic_load_store!($int_type, $l_suffix, $suffix);
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "slw {val}, {val}, {shift}",     // val <<= shift
                                $release,                        // fence
                                "2:", // 'retry:
                                    "lwarx {out}, 0, {dst}",     // atomic { RESERVE = (dst, 4); out = *dst }
                                    "andc {tmp}, {out}, {mask}", // tmp = out & !mask
                                    "or {tmp}, {val}, {tmp}",    // tmp |= val
                                    "stwcx. {tmp}, 0, {dst}",    // atomic { if RESERVE == (dst, 4) { *dst = tmp; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                    "bne %cr0, 2b",              // if cr0.EQ == 0 { jump 'retry }
                                "srw {out}, {out}, {shift}",     // out >>= shift
                                $acquire,                        // fence
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
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
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
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
                                    "stwcx. {tmp}, 0, {dst}",    // atomic { if RESERVE == (dst, size_of($int_type)) { *dst = tmp; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                    "bne %cr0, 2b",              // if cr0.EQ == 0 { jump 'retry }
                                "3:", // 'cmp-fail:
                                "srw {out}, {out}, {shift}",     // out >>= shift
                                "mfcr {tmp}",                    // r = zero_extend(cr)
                                $acquire,                        // fence
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = inout(reg) crate::utils::ZeroExtend::zero_extend(old) => _,
                                new = inout(reg) crate::utils::ZeroExtend::zero_extend(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = in(reg) mask,
                                tmp = out(reg) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
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

// powerpc64 on pwr8+ support 128-bit atomics (load/store/LL/SC):
// See https://github.com/taiki-e/portable-atomic/blob/HEAD/src/imp/atomic128/README.md for details.
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
                                $release,
                                "lq %r4, 0({src})", // atomic { r4:r5 = *src }
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
                                "lq %r4, 0({src})", // atomic { r4:r5 = *src }
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
                        _ => unreachable!(),
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
                        Ordering::Release => atomic_store!("lwsync"),
                        Ordering::SeqCst => atomic_store!("sync"),
                        _ => unreachable!(),
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
                    let mut r;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
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
                                "3:", // 'cmp-fail:
                                "mfcr {tmp_lo}",                        // tmp_lo = zero_extend(cr)
                                $acquire,                               // fence
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
                    // if compare failed EQ bit is cleared, if store succeeds EQ bit is set.
                    (
                        MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type,
                        extract_cr0(r)
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let old = MaybeUninit128 { $int_type: old };
                let new = MaybeUninit128 { $int_type: new };
                let (mut prev_hi, mut prev_lo);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r;
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                           // fence
                                "lqarx %r8, 0, {dst}",              // atomic { RESERVE = (dst, 16); r8:r9 = *dst }
                                "xor {tmp_lo}, %r9, {old_lo}",      // tmp_lo = r9 ^ old_lo
                                "xor {tmp_hi}, %r8, {old_hi}",      // tmp_hi = r8 ^ old_hi
                                "or. {tmp_lo}, {tmp_lo}, {tmp_hi}", // tmp_lo |= tmp_hi; if tmp_lo == 0 { cr0.EQ = 1 } else { cr0.EQ = 0 }
                                "bne %cr0, 3f",                     // if cr0.EQ == 0 { jump 'cmp-fail }
                                "stqcx. %r6, 0, {dst}",             // atomic { if RESERVE == (dst, 16) { *dst = r6:r7; cr0.EQ = 1 } else { cr0.EQ = 0 }; RESERVE = None }
                                "3:", // 'cmp-fail:
                                "mfcr {tmp_lo}",                    // tmp_lo = zero_extend(cr)
                                $acquire,                           // fence
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
                    atomic_rmw!(cmpxchg_weak, order);
                    // if compare or store failed EQ bit is cleared, if store succeeds EQ bit is set.
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
