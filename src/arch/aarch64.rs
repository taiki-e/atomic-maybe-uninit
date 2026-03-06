// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
AArch64

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#aarch64

Refs:
- Arm A-profile A64 Instruction Set Architecture
  https://developer.arm.com/documentation/ddi0602/2025-06
- C/C++ Atomics Application Binary Interface Standard for the Arm® 64-bit Architecture
  https://github.com/ARM-software/abi-aa/blob/2025Q1/atomicsabi64/atomicsabi64.rst
- Arm® Compiler armasm User Guide
  https://developer.arm.com/documentation/dui0801/latest
- Arm® Architecture Reference Manual for A-profile architecture
  https://developer.arm.com/documentation/ddi0487/latest (PDF)
- Arm® Architecture Reference Manual Supplement Armv8, for R-profile AArch64 architecture
  https://developer.arm.com/documentation/ddi0600/latest (PDF)
- portable-atomic https://github.com/taiki-e/portable-atomic

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

delegate_size!(delegate_all);

pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap},
    utils::{MaybeUninit128, Pair},
};

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        atomic_rmw!($op, $order, write = $order)
    };
    ($op:ident, $order:ident, write = $write:ident) => {
        // op(acquire, release, msvc_fence)
        match $order {
            Ordering::Relaxed => $op!("", "", ""),
            Ordering::Acquire => $op!("a", "", ""),
            Ordering::Release => $op!("", "l", ""),
            Ordering::AcqRel => $op!("a", "l", ""),
            // In MSVC environments, SeqCst stores/writes needs fences after writes.
            // https://reviews.llvm.org/D141748
            #[cfg(target_env = "msvc")]
            Ordering::SeqCst if $write == Ordering::SeqCst => $op!("a", "l", "dmb ish"),
            // AcqRel and SeqCst RMWs are equivalent in non-MSVC environments.
            Ordering::SeqCst => $op!("a", "l", ""),
            _ => unreachable!(),
        }
    };
}

// -----------------------------------------------------------------------------
// Register-width or smaller atomics

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $($size:literal)?, $suffix:tt, $val_modifier:tt, $cmp_ext:tt) => {
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
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                concat!("ld", $acquire, "r", $suffix, " {out", $val_modifier, "}, [{src}]"), // atomic { out = zero_extend(*src) }
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // SAFETY: cfg guarantee that the CPU supports FEAT_LRCPC.
                        #[cfg(target_feature = "rcpc")]
                        Ordering::Acquire => atomic_load!("ap"),
                        #[cfg(not(target_feature = "rcpc"))]
                        Ordering::Acquire => atomic_load!("a"),
                        Ordering::SeqCst => atomic_load!("a"),
                        _ => crate::utils::unreachable_unchecked(),
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
                        ($release:tt, $msvc_fence:tt) => {
                            asm!(
                                concat!("st", $release, "r", $suffix, " {val", $val_modifier, "}, [{dst}]"), // atomic { *dst = val }
                                $msvc_fence,                                                                 // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("l", ""),
                        // AcqRel and SeqCst RMWs are equivalent in non-MSVC environments.
                        #[cfg(not(target_env = "msvc"))]
                        Ordering::SeqCst => atomic_store!("l", ""),
                        // In MSVC environments, SeqCst stores/writes needs fences after writes.
                        // https://reviews.llvm.org/D141748
                        #[cfg(target_env = "msvc")]
                        Ordering::SeqCst => atomic_store!("l", "dmb ish"),
                        _ => crate::utils::unreachable_unchecked(),
                    }
                }
            }
        }
        $(
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("ldr", $suffix, " {tmp0", $val_modifier, "}, [{src}], #", $size), // atomic { tmp0 = *src }; src = src.byte_add($size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("ldr", $suffix, " {tmp1", $val_modifier, "}, [{src}, #", $size, "]"), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("ldr", $suffix, " {tmp0", $val_modifier, "}, [{src}], #2*", $size),   // atomic { tmp0 = *src }; src = src.byte_add(2*$size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("str", $suffix, " {tmp0", $val_modifier, "}, [{dst}], #", $size), // atomic { *dst = tmp0 }; dst = dst.byte_add($size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("str", $suffix, " {tmp1", $val_modifier, "}, [{dst}, #", $size, "]"), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("str", $suffix, " {tmp0", $val_modifier, "}, [{dst}], #2*", $size),   // atomic { *dst = tmp0 }; dst = dst.byte_add(2*$size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
        }
        )?
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
                    #[cfg(target_feature = "lse")]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $_msvc_fence:tt) => {
                            // Refs:
                            // - https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/SWP--SWPA--SWPAL--SWPL--Swap-word-or-doubleword-in-memory-
                            // - https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/SWPB--SWPAB--SWPALB--SWPLB--Swap-byte-in-memory-
                            // - https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/SWPH--SWPAH--SWPALH--SWPLH--Swap-halfword-in-memory-
                            asm!(
                                concat!("swp", $acquire, $release, $suffix, " {val", $val_modifier, "}, {out", $val_modifier, "}, [{dst}]"), // atomic { _x = *dst; *dst = val; out = zero_extend(_x) }
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(not(target_feature = "lse"))]
                    macro_rules! swap {
                        ($acquire:tt, $release:tt, $msvc_fence:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "xr", $suffix, " {out", $val_modifier, "}, [{dst}]"),        // atomic { out = zero_extend(*dst); EXCLUSIVE = dst }
                                    concat!("st", $release, "xr", $suffix, " {r:w}, {val", $val_modifier, "}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = val; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cbnz {r:w}, 2b",                                                                    // if r != 0 { jump 'retry }
                                $msvc_fence,                                                                             // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                r = out(reg) _,
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
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;
                let mut r: i32;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    #[cfg(target_feature = "lse")]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $_msvc_fence:tt) => {{
                            // Refs:
                            // - https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/CAS--CASA--CASAL--CASL--Compare-and-swap-word-or-doubleword-in-memory-
                            // - https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/CASB--CASAB--CASALB--CASLB--Compare-and-swap-byte-in-memory-
                            // - https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/CASH--CASAH--CASALH--CASLH--Compare-and-swap-halfword-in-memory-
                            asm!(
                                // cas writes the current value to the first register,
                                // so copy the `old`'s value for later comparison.
                                concat!("mov {out", $val_modifier, "}, {old", $val_modifier, "}"),                                           // out = old
                                concat!("cas", $acquire, $release, $suffix, " {out", $val_modifier, "}, {new", $val_modifier, "}, [{dst}]"), // atomic { if *dst == out { *dst = new } else { out = zero_extend(*dst) } }
                                concat!("cmp {out", $val_modifier, "}, {old", $val_modifier, "}", $cmp_ext),                                 // if out == old { Z = 1 } else { Z = 0 }
                                "cset {r:w}, eq",                                                                                            // r = Z
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = lateout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            );
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                            (out, r != 0)
                        }};
                    }
                    #[cfg(not(target_feature = "lse"))]
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt, $msvc_fence:tt) => {{
                            asm!(
                                "2:", // 'retry:
                                    concat!("ld", $acquire, "xr", $suffix, " {out", $val_modifier, "}, [{dst}]"),        // atomic { out = zero_extend(*dst); EXCLUSIVE = dst }
                                    concat!("cmp {out", $val_modifier, "}, {old", $val_modifier, "}", $cmp_ext),         // if out == old { Z = 1 } else { Z = 0 }
                                    "b.ne 3f",                                                                           // if Z == 0 { jump 'cmp-fail }
                                    concat!("st", $release, "xr", $suffix, " {r:w}, {new", $val_modifier, "}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cbnz {r:w}, 2b",                                                                    // if r != 0 { jump 'retry }
                                    $msvc_fence,                                                                         // fence
                                    "b 4f",                                                                              // jump 'success
                                "3:", // 'cmp-fail:
                                    "mov {r:w}, #1",                                                                     // r = 1
                                    "clrex",                                                                             // EXCLUSIVE = None
                                "4:", // 'success:
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            );
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                            // 0 if the store was successful, 1 if no store was performed
                            (out, r == 0)
                        }};
                    }
                    atomic_rmw!(cmpxchg, order, write = success)
                }
            }
            #[cfg(not(target_feature = "lse"))]
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;
                let r: i32;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! cmpxchg_weak {
                        ($acquire:tt, $release:tt, $msvc_fence:tt) => {
                            asm!(
                                concat!("ld", $acquire, "xr", $suffix, " {out", $val_modifier, "}, [{dst}]"),        // atomic { out = zero_extend(*dst); EXCLUSIVE = dst }
                                concat!("cmp {out", $val_modifier, "}, {old", $val_modifier, "}", $cmp_ext),         // if out == old { Z = 1 } else { Z = 0 }
                                "b.ne 3f",                                                                           // if Z == 0 { jump 'cmp-fail }
                                concat!("st", $release, "xr", $suffix, " {r:w}, {new", $val_modifier, "}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                if_any!($msvc_fence, "cbnz {r:w}, 4f"),                                              // if r != 0 { jump 'end }
                                $msvc_fence,                                                                         // fence
                                "b 4f",                                                                              // jump 'end
                                "3:", // 'cmp-fail:
                                    "mov {r:w}, #1",                                                                 // r = 1
                                    "clrex",                                                                         // EXCLUSIVE = None
                                "4:", // 'end:
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg_weak, order, write = success);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                }
                // 0 if the store was successful, 1 if no store was performed
                (out, r == 0)
            }
        }
    };
}

atomic!(u8, "1", "b", ":w", ", uxtb");
atomic!(u16, "2", "h", ":w", ", uxth");
atomic!(u32, "4", "", ":w", "");
atomic!(u64,    , "", "", "");

impl AtomicMemcpy for u64 {
    #[inline]
    unsafe fn atomic_load_memcpy<const DST_ALIGNED: bool>(
        mut dst: *mut MaybeUninit<Self>,
        src: *const MaybeUninit<Self>,
        count: NonZeroUsize,
    ) {
        load_memcpy_opt_pre! { u64, Align64, dst, count, last, |src, tmp0, tmp1|
            asm!(
                "ldr {tmp0}, [{src}], #8", // atomic { tmp0 = *src }; src = src.byte_add(8)
                src = inout(reg) src,
                tmp0 = out(reg) tmp0,
                options(nostack, preserves_flags),
            ),
            asm!(
                "ldr {tmp1}, [{src}, #8]",   // atomic { tmp1 = *src.byte_add(8) }
                "ldr {tmp0}, [{src}], #2*8", // atomic { tmp0 = *src }; src = src.byte_add(2*8)
                src = inout(reg) src,
                tmp0 = out(reg) tmp0,
                tmp1 = out(reg) tmp1,
                options(nostack, preserves_flags),
            ),
        }
        #[cfg(all(target_feature = "neon", not(atomic_maybe_uninit_test_prefer_scalar_over_neon)))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            loop {
                // asm!(
                //     "ldnp q2, q3, [{src}, #8*4]",
                //     "ldnp q0, q1, [{src}]",
                //     "stnp q2, q3, [{dst}, #8*4]",
                //     "stnp q0, q1, [{dst}]",
                //     dst = in(reg) dst,
                //     src = in(reg) src,
                //     out("q0") _,
                //     out("q1") _,
                //     out("q2") _,
                //     out("q3") _,
                //     options(nostack, preserves_flags),
                // );
                // src = src.add(8);
                // dst = dst.add(8);
                asm!(
                    "ldp q2, q3, [{src}, #8*4]",
                    "ldp q0, q1, [{src}], #8*8",
                    "stp q2, q3, [{dst}, #8*4]",
                    "stp q0, q1, [{dst}], #8*8",
                    dst = inout(reg) dst,
                    src = inout(reg) src,
                    out("q0") _,
                    out("q1") _,
                    out("q2") _,
                    out("q3") _,
                    options(nostack, preserves_flags),
                );
                count = count.wrapping_sub(1); // can use unchecked_sub
                if count == 0 {
                    break;
                }
            }
        }
        #[cfg(not(all(
            target_feature = "neon",
            not(atomic_maybe_uninit_test_prefer_scalar_over_neon),
        )))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            let mut tmp0: MaybeUninit<u64>;
            let mut tmp1: MaybeUninit<u64>;
            let mut tmp2: MaybeUninit<u64>;
            let mut tmp3: MaybeUninit<u64>;
            let mut tmp4: MaybeUninit<u64>;
            let mut tmp5: MaybeUninit<u64>;
            let mut tmp6: MaybeUninit<u64>;
            let mut tmp7: MaybeUninit<u64>;
            loop {
                // asm!(
                //     "ldp {tmp6}, {tmp7}, [{src}, #8*6]",
                //     "ldp {tmp4}, {tmp5}, [{src}, #8*4]",
                //     "ldp {tmp2}, {tmp3}, [{src}, #8*2]",
                //     "ldp {tmp0}, {tmp1}, [{src}]",
                //     src = in(reg) src,
                //     tmp0 = out(reg) tmp0,
                //     tmp1 = out(reg) tmp1,
                //     tmp2 = out(reg) tmp2,
                //     tmp3 = out(reg) tmp3,
                //     tmp4 = out(reg) tmp4,
                //     tmp5 = out(reg) tmp5,
                //     tmp6 = out(reg) tmp6,
                //     tmp7 = out(reg) tmp7,
                //     options(nostack, preserves_flags),
                // );
                // src = src.add(8);
                asm!(
                    "ldr {tmp7}, [{src}, #8*7]",    // tmp7 = src.byte_add(8*7).read()
                    "ldr {tmp6}, [{src}, #8*6]",    // tmp6 = src.byte_add(8*6).read()
                    "ldr {tmp5}, [{src}, #8*5]",    // tmp5 = src.byte_add(8*5).read()
                    "ldr {tmp4}, [{src}, #8*4]",    // tmp4 = src.byte_add(8*4).read()
                    "ldr {tmp3}, [{src}, #8*3]",    // tmp3 = src.byte_add(8*3).read()
                    "ldr {tmp2}, [{src}, #8*2]",    // tmp2 = src.byte_add(8*2).read()
                    "ldr {tmp1}, [{src}, #8*1]",    // tmp1 = src.byte_add(8*1).read()
                    "ldr {tmp0}, [{src}], #8*8",    // tmp0 = src.read(); src = src.byte_add(8*8)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    tmp2 = out(reg) tmp2,
                    tmp3 = out(reg) tmp3,
                    tmp4 = out(reg) tmp4,
                    tmp5 = out(reg) tmp5,
                    tmp6 = out(reg) tmp6,
                    tmp7 = out(reg) tmp7,
                    options(nostack, preserves_flags),
                );
                if DST_ALIGNED
                /*|| cfg!(not(target_os = "none"))*/
                {
                    // asm!(
                    //     "stnp {tmp6}, {tmp7}, [{dst}, #8*6]",
                    //     "stnp {tmp4}, {tmp5}, [{dst}, #8*4]",
                    //     "stnp {tmp2}, {tmp3}, [{dst}, #8*2]",
                    //     "stnp {tmp0}, {tmp1}, [{dst}]",
                    //     dst = in(reg) dst,
                    //     tmp0 = in(reg) tmp0,
                    //     tmp1 = in(reg) tmp1,
                    //     tmp2 = in(reg) tmp2,
                    //     tmp3 = in(reg) tmp3,
                    //     tmp4 = in(reg) tmp4,
                    //     tmp5 = in(reg) tmp5,
                    //     tmp6 = in(reg) tmp6,
                    //     tmp7 = in(reg) tmp7,
                    //     options(nostack, preserves_flags),
                    // );
                    dst.add(7).write(tmp7);
                    dst.add(6).write(tmp6);
                    dst.add(5).write(tmp5);
                    dst.add(4).write(tmp4);
                    dst.add(3).write(tmp3);
                    dst.add(2).write(tmp2);
                    dst.add(1).write(tmp1);
                    dst.write(tmp0);
                } else {
                    dst.add(7).write_unaligned(tmp7);
                    dst.add(6).write_unaligned(tmp6);
                    dst.add(5).write_unaligned(tmp5);
                    dst.add(4).write_unaligned(tmp4);
                    dst.add(3).write_unaligned(tmp3);
                    dst.add(2).write_unaligned(tmp2);
                    dst.add(1).write_unaligned(tmp1);
                    dst.write_unaligned(tmp0);
                }
                dst = dst.add(8);
                count = count.wrapping_sub(1); // can use unchecked_sub
                if count == 0 {
                    break;
                }
            }
        }
        load_memcpy_opt_post!(dst, last);
    }
    #[inline]
    unsafe fn atomic_store_memcpy<const SRC_ALIGNED: bool>(
        dst: *mut MaybeUninit<Self>,
        mut src: *const MaybeUninit<Self>,
        count: NonZeroUsize,
    ) {
        store_memcpy_opt_pre! { u64, Align64, src, count, last, |dst, tmp0, tmp1|
            asm!(
                "str {tmp0}, [{dst}], #8", // atomic { *dst = tmp0 }; dst = dst.byte_add(8)
                dst = inout(reg) dst,
                tmp0 = in(reg) tmp0,
                options(nostack, preserves_flags),
            ),
            asm!(
                "str {tmp1}, [{dst}, #8]",   // atomic { *dst.byte_add(8) = tmp1 }
                "str {tmp0}, [{dst}], #2*8", // atomic { *dst = tmp0 }; dst = dst.byte_add(2*8)
                dst = inout(reg) dst,
                tmp0 = in(reg) tmp0,
                tmp1 = in(reg) tmp1,
                options(nostack, preserves_flags),
            ),
        }
        #[cfg(all(target_feature = "neon", not(atomic_maybe_uninit_test_prefer_scalar_over_neon)))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            loop {
                // asm!(
                //     "ldnp q2, q3, [{src}, #8*4]",
                //     "ldnp q0, q1, [{src}]",
                //     "stnp q2, q3, [{dst}, #8*4]",
                //     "stnp q0, q1, [{dst}]",
                //     src = in(reg) src,
                //     dst = in(reg) dst,
                //     out("q0") _,
                //     out("q1") _,
                //     out("q2") _,
                //     out("q3") _,
                //     options(nostack, preserves_flags),
                // );
                // src = src.add(8);
                // dst = dst.add(8);
                asm!(
                    "ldp q2, q3, [{src}, #8*4]",
                    "ldp q0, q1, [{src}], #8*8",
                    "stp q2, q3, [{dst}, #8*4]",
                    "stp q0, q1, [{dst}], #8*8",
                    dst = inout(reg) dst,
                    src = inout(reg) src,
                    out("q0") _,
                    out("q1") _,
                    out("q2") _,
                    out("q3") _,
                    options(nostack, preserves_flags),
                );
                count = count.wrapping_sub(1); // can use unchecked_sub
                if count == 0 {
                    break;
                }
            }
        }
        #[cfg(not(all(
            target_feature = "neon",
            not(atomic_maybe_uninit_test_prefer_scalar_over_neon),
        )))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            let mut tmp0: MaybeUninit<u64>;
            let mut tmp1: MaybeUninit<u64>;
            let mut tmp2: MaybeUninit<u64>;
            let mut tmp3: MaybeUninit<u64>;
            let mut tmp4: MaybeUninit<u64>;
            let mut tmp5: MaybeUninit<u64>;
            let mut tmp6: MaybeUninit<u64>;
            let mut tmp7: MaybeUninit<u64>;
            loop {
                if SRC_ALIGNED
                /* || cfg!(not(target_os = "none")) */
                {
                    // asm!(
                    //     "ldnp {tmp6}, {tmp7}, [{src}, #8*6]",
                    //     "ldnp {tmp4}, {tmp5}, [{src}, #8*4]",
                    //     "ldnp {tmp2}, {tmp3}, [{src}, #8*2]",
                    //     "ldnp {tmp0}, {tmp1}, [{src}]",
                    //     src = in(reg) src,
                    //     tmp0 = out(reg) tmp0,
                    //     tmp1 = out(reg) tmp1,
                    //     tmp2 = out(reg) tmp2,
                    //     tmp3 = out(reg) tmp3,
                    //     tmp4 = out(reg) tmp4,
                    //     tmp5 = out(reg) tmp5,
                    //     tmp6 = out(reg) tmp6,
                    //     tmp7 = out(reg) tmp7,
                    //     options(nostack, preserves_flags),
                    // );
                    tmp7 = src.add(7).read();
                    tmp6 = src.add(6).read();
                    tmp5 = src.add(5).read();
                    tmp4 = src.add(4).read();
                    tmp3 = src.add(3).read();
                    tmp2 = src.add(2).read();
                    tmp1 = src.add(1).read();
                    tmp0 = src.read();
                } else {
                    tmp7 = src.add(7).read_unaligned();
                    tmp6 = src.add(6).read_unaligned();
                    tmp5 = src.add(5).read_unaligned();
                    tmp4 = src.add(4).read_unaligned();
                    tmp3 = src.add(3).read_unaligned();
                    tmp2 = src.add(2).read_unaligned();
                    tmp1 = src.add(1).read_unaligned();
                    tmp0 = src.read_unaligned();
                }
                src = src.add(8);
                // asm!(
                //     "stp {tmp6}, {tmp7}, [{dst}, #8*6]",
                //     "stp {tmp4}, {tmp5}, [{dst}, #8*4]",
                //     "stp {tmp2}, {tmp3}, [{dst}, #8*2]",
                //     "stp {tmp0}, {tmp1}, [{dst}]",
                //     dst = in(reg) dst,
                //     tmp0 = in(reg) tmp0,
                //     tmp1 = in(reg) tmp1,
                //     tmp2 = in(reg) tmp2,
                //     tmp3 = in(reg) tmp3,
                //     tmp4 = in(reg) tmp4,
                //     tmp5 = in(reg) tmp5,
                //     tmp6 = in(reg) tmp6,
                //     tmp7 = in(reg) tmp7,
                //     options(nostack, preserves_flags),
                // );
                // dst = dst.add(8);
                asm!(
                    "str {tmp7}, [{dst}, #8*7]",    // dst.byte_add(8*7).write(tmp7)
                    "str {tmp6}, [{dst}, #8*6]",    // dst.byte_add(8*6).write(tmp6)
                    "str {tmp5}, [{dst}, #8*5]",    // dst.byte_add(8*5).write(tmp5)
                    "str {tmp4}, [{dst}, #8*4]",    // dst.byte_add(8*4).write(tmp4)
                    "str {tmp3}, [{dst}, #8*3]",    // dst.byte_add(8*3).write(tmp3)
                    "str {tmp2}, [{dst}, #8*2]",    // dst.byte_add(8*2).write(tmp2)
                    "str {tmp1}, [{dst}, #8*1]",    // dst.byte_add(8*1).write(tmp1)
                    "str {tmp0}, [{dst}], #8*8",    // dst.write(tmp0); dst = dst.byte_add(8*8)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    tmp2 = in(reg) tmp2,
                    tmp3 = in(reg) tmp3,
                    tmp4 = in(reg) tmp4,
                    tmp5 = in(reg) tmp5,
                    tmp6 = in(reg) tmp6,
                    tmp7 = in(reg) tmp7,
                    options(nostack, preserves_flags),
                );
                count = count.wrapping_sub(1); // can use unchecked_sub
                if count == 0 {
                    break;
                }
            }
        }
        store_memcpy_opt_post!(src, last);
    }
}

/*
unsafe fn memcpy_neon(dst: *mut u8, src: *const u8, count: usize) {
    // SAFETY: the caller must uphold the safety contract.
    unsafe {
        asm!(
                "add {src_end}, {src}, {count}",
                "cmp {count}, #128",
                "bhi 129f", // 'copy_long
                "add {dst_end}, {dst_in}, {count}",
                "cmp {count}, #32",
                "bhi 33f", // 'copy32_128
                "nop",

                // Small copies: 0..32 bytes.
                "cmp {count}, #16",
                "blo 15f", // 'copy16
                "ldr q0, [{src}]",
                "ldr q1, [{src_end}, #-16]",
                "str q0, [{dst_in}]",
                "str q1, [{dst_end}, #-16]",
                "b 40f", // 'done

                ".p2align 4",
                // Medium copies: 33..128 bytes.
            "33:", // 'copy32_128:
                "ldp q0, q1, [{src}]",
                "ldp q2, q3, [{src_end}, #-32]",
                "cmp {count}, #64",
                "bhi 128f", // 'copy128
                "stp q0, q1, [{dst_in}]",
                "stp q2, q3, [{dst_end}, #-32]",
                "b 40f", // 'done

                ".p2align 4",
                // Copy 8-15 bytes.
            "15:", // 'copy16:
                "tbz {count}, #3, 7f",
                "ldr {a}, [{src}]",
                "ldr {b}, [{src_end}, #-8]",
                "str {a}, [{dst_in}]",
                "str {b}, [{dst_end}, #-8]",
                "b 40f", // 'done

                // Copy 4-7 bytes.
            "7:", // 'copy8:
                "tbz {count}, #2, 3f",
                "ldr {a:w}, [{src}]",
                "ldr {b:w}, [{src_end}, #-4]",
                "str {a:w}, [{dst_in}]",
                "str {b:w}, [{dst_end}, #-4]",
                "b 40f", // 'done

                // Copy 65..128 bytes.
            "128:", // 'copy128:
                "ldp q4, q5, [{src}, #32]",
                "cmp {count}, #96",
                "bls 96f", // 'copy96
                "ldp q6, q7, [{src_end}, #-64]",
                "stp q6, q7, [{dst_end}, #-64]",
            "96:", // 'copy96:
                "stp q0, q1, [{dst_in}]",
                "stp q4, q5, [{dst_in}, #32]",
                "stp q2, q3, [{dst_end}, #-32]",
                "b 40f", // 'done

                // Copy 0..3 bytes using a branchless sequence.
            "3:", // 'copy4:
                "lsr {tmp1}, {count}, #1",
                "ldrb {a:w}, [{src}]",
                "ldrb {c:w}, [{src_end}, #-1]",
                "ldrb {b:w}, [{src}, {tmp1}]",
                "strb {a:w}, [{dst_in}]",
                "strb {b:w}, [{dst_in}, {tmp1}]",
                "strb {c:w}, [{dst_end}, #-1]",
                "b 40f", // 'done

                ".p2align 3",
                // Copy more than 128 bytes.
            "129:", // 'copy_long:
                "add {dst_end}, {dst_in}, {count}",
                // Copy 16 bytes and then align src to 16-byte alignment.
                "ldr q3, [{src}]",
                "and {tmp1}, {src}, #15",
                "bic {src}, {src}, #15",
                "sub {dst}, {dst_in}, {tmp1}",
                "add {count}, {count}, {tmp1}", // Count is now 16 too large.
                "ldnp q0, q1, [{src}, #16]",
                "str q3, [{dst_in}]",
                "ldnp q2, q3, [{src}, #48]",
                "subs {count}, {count}, #128 + 16", // Test and readjust count.
                "bls 65f", // 'copy64_from_end
            "64:", // 'loop64:
                "stnp q0, q1, [{dst}, #16]",
                "ldnp q0, q1, [{src}, #80]",
                "stnp q2, q3, [{dst}, #48]",
                "ldnp q2, q3, [{src}, #112]",
                "add {src}, {src}, #64",
                "add {dst}, {dst}, #64",
                "subs {count}, {count}, #64",
                "bhi 64b", // 'loop64
                // Write the last iteration and copy 64 bytes from the end.
            "65:", // 'copy64_from_end:
                "ldnp q4, q5, [{src_end}, #-64]",
                "stnp q0, q1, [{dst}, #16]",
                "ldnp q0, q1, [{src_end}, #-32]",
                "stnp q2, q3, [{dst}, #48]",
                "stnp q4, q5, [{dst_end}, #-64]",
                "stnp q0, q1, [{dst_end}, #-32]",

            "40:", // 'done:

            dst_in = inout(reg) ptr_reg!(dst) => _,
            src = inout(reg) ptr_reg!(src) => _,
            count = inout(reg) count as u64 => _,
            dst = out(reg) _,
            dst_end = out(reg) _,
            src_end = out(reg) _,
            a = out(reg) _,
            b = out(reg) _,
            c = out(reg) _,
            tmp1 = out(reg) _,
            out("q0") _,
            out("q1") _,
            out("q2") _,
            out("q3") _,
            out("q4") _,
            out("q5") _,
            out("q6") _,
            out("q7") _,
            // Do not use `preserves_flags` because CMP and SUBS modify the condition flags.
            options(nostack),
        );
    }
}
*/

// -----------------------------------------------------------------------------
// 128-bit atomics
//
// There are a few ways to implement 128-bit atomic operations in AArch64.
//
// - LDXP/STXP loop (DW LL/SC)
// - CASP (DWCAS) added as Armv8.1 FEAT_LSE (optional from Armv8.0, mandatory from Armv8.1)
// - LDP/STP (DW load/store) if Armv8.4 FEAT_LSE2 (optional from Armv8.2, mandatory from Armv8.4) is available
// - LDIAPP/STILP (DW acquire-load/release-store) added as Armv8.9 FEAT_LRCPC3 (optional from Armv8.2) (if FEAT_LSE2 is also available)
// - LDCLRP/LDSETP/SWPP (DW RMW) added as Armv9.4 FEAT_LSE128 (optional from Armv9.3)
//
// If FEAT_LSE is available at compile-time, we use CASP for load/CAS. Otherwise, use LDXP/STXP loop.
// If FEAT_LSE2 is available at compile-time, we use LDP/STP for load/store.
// If FEAT_LSE128 is available at compile-time, we use SWPP for swap/{release,seqcst}-store.
// If FEAT_LSE2 and FEAT_LRCPC3 are available at compile-time, we use LDIAPP/STILP for acquire-load/release-store.
//
// Note: FEAT_LSE2 doesn't imply FEAT_LSE. FEAT_LSE128 implies FEAT_LSE but not FEAT_LSE2.
//
// Refs:
// - LDXP: https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/LDXP--Load-exclusive-pair-of-registers-
// - LDAXP: https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/LDAXP--Load-acquire-exclusive-pair-of-registers-
// - STXP: https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/STXP--Store-exclusive-pair-of-registers-
// - STLXP: https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/STLXP--Store-release-exclusive-pair-of-registers-
//
// Note: Load-Exclusive pair (by itself) does not guarantee atomicity; to complete an atomic
// operation (even load/store), a corresponding Store-Exclusive pair must succeed.
// See Arm Architecture Reference Manual for A-profile architecture
// Section B2.2.1 "Requirements for single-copy atomicity", and
// Section B2.9 "Synchronization and semaphores" for more.

delegate_signed!(delegate_all, u128);
impl AtomicLoad for u128 {
    #[inline]
    unsafe fn atomic_load(src: *const MaybeUninit<Self>, order: Ordering) -> MaybeUninit<Self> {
        debug_assert_atomic_unsafe_precondition!(src, u128);
        let (mut prev_lo, mut prev_hi);

        #[cfg(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"))]
        // SAFETY: the caller must guarantee that `dst` is valid for reads,
        // 16-byte aligned, that there are no concurrent non-atomic operations.
        // the above cfg guarantee that the CPU supports FEAT_LSE2.
        //
        // Refs:
        // - LDP https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/LDP--Load-pair-of-registers-
        // - LDIAPP https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/LDIAPP--Load-Acquire-RCpc-ordered-pair-of-registers-
        unsafe {
            macro_rules! atomic_load_relaxed {
                ($iap:tt, $dmb_ishld:tt) => {
                    asm!(
                        concat!("ld", $iap, "p {prev_lo}, {prev_hi}, [{src}]"), // atomic { prev_lo:prev_hi = *src }
                        $dmb_ishld,                                             // fence
                        src = in(reg) ptr_reg!(src),
                        prev_hi = lateout(reg) prev_hi,
                        prev_lo = lateout(reg) prev_lo,
                        options(nostack, preserves_flags),
                    )
                };
            }
            match order {
                // if FEAT_LRCPC3 && order != relaxed => ldiapp
                // SAFETY: cfg guarantee that the CPU supports FEAT_LRCPC3.
                #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                Ordering::Acquire => atomic_load_relaxed!("iap", ""),
                #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                Ordering::SeqCst => {
                    asm!(
                        // ldar (or dmb ishld) is required to prevent reordering with preceding stlxp.
                        // https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108891
                        "ldar {tmp}, [{src}]",                  // atomic { tmp = *src }
                        "ldiapp {prev_lo}, {prev_hi}, [{src}]", // atomic { prev_lo:prev_hi = *src }
                        src = in(reg) ptr_reg!(src),
                        prev_hi = lateout(reg) prev_hi,
                        prev_lo = lateout(reg) prev_lo,
                        tmp = out(reg) _,
                        options(nostack, preserves_flags),
                    );
                }

                // else => ldp
                Ordering::Relaxed => atomic_load_relaxed!("", ""),
                #[cfg(not(any(
                    target_feature = "rcpc3",
                    atomic_maybe_uninit_target_feature = "rcpc3"
                )))]
                Ordering::Acquire => atomic_load_relaxed!("", "dmb ishld"),
                #[cfg(not(any(
                    target_feature = "rcpc3",
                    atomic_maybe_uninit_target_feature = "rcpc3"
                )))]
                Ordering::SeqCst => {
                    asm!(
                        // ldar (or dmb ishld) is required to prevent reordering with preceding stlxp.
                        // https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108891
                        "ldar {tmp}, [{src}]",               // atomic { tmp = *src }
                        "ldp {prev_lo}, {prev_hi}, [{src}]", // atomic { prev_lo:prev_hi = *src }
                        "dmb ishld",                         // fence
                        src = in(reg) ptr_reg!(src),
                        prev_hi = lateout(reg) prev_hi,
                        prev_lo = lateout(reg) prev_lo,
                        tmp = out(reg) _,
                        options(nostack, preserves_flags),
                    );
                }
                _ => crate::utils::unreachable_unchecked(),
            }
            MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
        }
        #[cfg(not(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2")))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            #[cfg(target_feature = "lse")]
            macro_rules! atomic_load {
                ($acquire:tt, $release:tt) => {
                    asm!(
                        // Refs: https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/CASP--CASPA--CASPAL--CASPL--Compare-and-swap-pair-of-words-or-doublewords-in-memory-
                        concat!("casp", $acquire, $release, " x2, x3, x2, x3, [{src}]"), // atomic { if *src == x2:x3 { *dst = x2:x3 } else { x2:x3 = *dst } }
                        src = in(reg) ptr_reg!(src),
                        // must be allocated to even/odd register pair
                        inout("x2") 0_u64 => prev_lo,
                        inout("x3") 0_u64 => prev_hi,
                        options(nostack, preserves_flags),
                    )
                };
            }
            #[cfg(not(target_feature = "lse"))]
            macro_rules! atomic_load {
                ($acquire:tt, $release:tt) => {
                    asm!(
                        "2:", // 'retry:
                            concat!("ld", $acquire, "xp {prev_lo}, {prev_hi}, [{src}]"),        // atomic { prev_lo:prev_hi = *src; EXCLUSIVE = src }
                            // write back to ensure atomicity
                            concat!("st", $release, "xp {r:w}, {prev_lo}, {prev_hi}, [{src}]"), // atomic { if EXCLUSIVE == src { *src = prev_lo:prev_hi; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                            "cbnz {r:w}, 2b",                                                   // if r != 0 { jump 'retry }
                        src = in(reg) ptr_reg!(src),
                        prev_lo = out(reg) prev_lo,
                        prev_hi = out(reg) prev_hi,
                        r = out(reg) _,
                        options(nostack, preserves_flags),
                    )
                };
            }
            match order {
                Ordering::Relaxed => atomic_load!("", ""),
                Ordering::Acquire => atomic_load!("a", ""),
                Ordering::SeqCst => atomic_load!("a", "l"),
                _ => crate::utils::unreachable_unchecked(),
            }
            MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
        }
    }
}
impl AtomicStore for u128 {
    #[inline]
    unsafe fn atomic_store(dst: *mut MaybeUninit<Self>, val: MaybeUninit<Self>, order: Ordering) {
        debug_assert_atomic_unsafe_precondition!(dst, u128);
        let val = MaybeUninit128 { whole: val };

        #[cfg(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"))]
        // SAFETY: the caller must guarantee that `dst` is valid for writes,
        // 16-byte aligned, that there are no concurrent non-atomic operations.
        // the above cfg guarantee that the CPU supports FEAT_LSE2.
        //
        // Refs:
        // - STP: https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/STP--Store-pair-of-registers-
        // - STILP: https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/STILP--Store-release-ordered-pair-of-registers-
        unsafe {
            macro_rules! atomic_store {
                ($il:tt, $acquire:tt, $release:tt) => {
                    asm!(
                        $release,                                            // fence
                        concat!("st", $il, "p {val_lo}, {val_hi}, [{dst}]"), // atomic { *dst = val_lo:val_hi }
                        $acquire,                                            // fence
                        dst = in(reg) ptr_reg!(dst),
                        val_lo = in(reg) val.pair.lo,
                        val_hi = in(reg) val.pair.hi,
                        options(nostack, preserves_flags),
                    )
                };
            }
            // Use swpp if stp requires fences.
            // https://reviews.llvm.org/D143506
            #[cfg(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128"))]
            macro_rules! atomic_store_swpp {
                ($acquire:tt, $release:tt, $_msvc_fence:tt) => {
                    asm!(
                        concat!("swpp", $acquire, $release, " {val_lo}, {val_hi}, [{dst}]"), // atomic { _x = *dst; *dst = val_lo:val_hi; val_lo:val_hi = _x }
                        dst = in(reg) ptr_reg!(dst),
                        val_lo = inout(reg) val.pair.lo => _,
                        val_hi = inout(reg) val.pair.hi => _,
                        options(nostack, preserves_flags),
                    )
                };
            }
            match order {
                // if FEAT_LSE128 && order == seqcst => swpp
                // Prefer swpp if stp requires fences. https://reviews.llvm.org/D143506
                // SAFETY: cfg guarantee that the CPU supports FEAT_LSE128.
                #[cfg(any(
                    target_feature = "lse128",
                    atomic_maybe_uninit_target_feature = "lse128",
                ))]
                Ordering::SeqCst => atomic_rmw!(atomic_store_swpp, order),

                // if FEAT_LRCPC3 && order != relaxed => stilp
                // SAFETY: cfg guarantee that the CPU supports FEAT_LRCPC3.
                #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                Ordering::Release => atomic_store!("il", "", ""),
                // LLVM uses store-release (dmb ish; stp); dmb ish, GCC (libatomic) and Atomics ABI Standard
                // uses store-release (stilp) without fence for SeqCst store
                // (https://github.com/gcc-mirror/gcc/commit/7107574958e2bed11d916a1480ef1319f15e5ffe).
                // Considering https://reviews.llvm.org/D141748, LLVM's lowering seems
                // to be the safer option here (I'm not convinced that the libatomic's implementation is wrong).
                #[cfg(any(target_feature = "rcpc3", atomic_maybe_uninit_target_feature = "rcpc3"))]
                #[cfg(not(any(
                    target_feature = "lse128",
                    atomic_maybe_uninit_target_feature = "lse128",
                )))]
                Ordering::SeqCst => atomic_store!("il", "dmb ish", ""),

                // if FEAT_LSE128 && order != relaxed => swpp
                // Prefer swpp if stp requires fences. https://reviews.llvm.org/D143506
                // SAFETY: cfg guarantee that the CPU supports FEAT_LSE128.
                #[cfg(not(any(
                    target_feature = "rcpc3",
                    atomic_maybe_uninit_target_feature = "rcpc3",
                )))]
                #[cfg(any(
                    target_feature = "lse128",
                    atomic_maybe_uninit_target_feature = "lse128",
                ))]
                Ordering::Release => atomic_rmw!(atomic_store_swpp, order),

                // else => stp
                Ordering::Relaxed => atomic_store!("", "", ""),
                #[cfg(not(any(
                    target_feature = "rcpc3",
                    atomic_maybe_uninit_target_feature = "rcpc3",
                )))]
                #[cfg(not(any(
                    target_feature = "lse128",
                    atomic_maybe_uninit_target_feature = "lse128",
                )))]
                Ordering::Release => atomic_store!("", "", "dmb ish"),
                #[cfg(not(any(
                    target_feature = "rcpc3",
                    atomic_maybe_uninit_target_feature = "rcpc3",
                )))]
                #[cfg(not(any(
                    target_feature = "lse128",
                    atomic_maybe_uninit_target_feature = "lse128",
                )))]
                Ordering::SeqCst => atomic_store!("", "dmb ish", "dmb ish"),
                _ => crate::utils::unreachable_unchecked(),
            }
        }
        #[cfg(not(any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2")))]
        // SAFETY: the caller must uphold the safety contract.
        // Do not use atomic_swap because it needs extra registers to implement store.
        unsafe {
            macro_rules! store {
                ($acquire:tt, $release:tt, $msvc_fence:tt) => {
                    asm!(
                        "2:", // 'retry:
                            concat!("ld", $acquire, "xp xzr, {tmp}, [{dst}]"),                  // atomic { xzr:tmp = *dst; EXCLUSIVE = dst }
                            concat!("st", $release, "xp {tmp:w}, {val_lo}, {val_hi}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = val_lo:val_hi; tmp = 0 } else { tmp = 1 }; EXCLUSIVE = None }
                            "cbnz {tmp:w}, 2b",                                                 // if tmp != 0 { jump 'retry }
                        $msvc_fence,                                                            // fence
                        dst = in(reg) ptr_reg!(dst),
                        val_lo = in(reg) val.pair.lo,
                        val_hi = in(reg) val.pair.hi,
                        tmp = out(reg) _,
                        options(nostack, preserves_flags),
                    )
                };
            }
            atomic_rmw!(store, order);
        }
    }
}
impl AtomicSwap for u128 {
    #[inline]
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: MaybeUninit<Self>,
        order: Ordering,
    ) -> MaybeUninit<Self> {
        debug_assert_atomic_unsafe_precondition!(dst, u128);
        let val = MaybeUninit128 { whole: val };
        let (mut prev_lo, mut prev_hi);

        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            #[cfg(any(target_feature = "lse128", atomic_maybe_uninit_target_feature = "lse128"))]
            macro_rules! swap {
                ($acquire:tt, $release:tt, $_msvc_fence:tt) => {
                    asm!(
                        concat!("swpp", $acquire, $release, " {val_lo}, {val_hi}, [{dst}]"), // atomic { _x = *dst; *dst = val_lo:val_hi; val_lo:val_hi = _x }
                        dst = in(reg) ptr_reg!(dst),
                        val_lo = inout(reg) val.pair.lo => prev_lo,
                        val_hi = inout(reg) val.pair.hi => prev_hi,
                        options(nostack, preserves_flags),
                    )
                };
            }
            #[cfg(not(any(
                target_feature = "lse128",
                atomic_maybe_uninit_target_feature = "lse128",
            )))]
            macro_rules! swap {
                ($acquire:tt, $release:tt, $msvc_fence:tt) => {
                    asm!(
                        "2:", // 'retry:
                            concat!("ld", $acquire, "xp {prev_lo}, {prev_hi}, [{dst}]"),      // atomic { prev_lo:prev_hi = *dst; EXCLUSIVE = dst }
                            concat!("st", $release, "xp {r:w}, {val_lo}, {val_hi}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = val_lo:val_hi; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                            "cbnz {r:w}, 2b",                                                 // if r != 0 { jump 'retry }
                        $msvc_fence,                                                          // fence
                        dst = in(reg) ptr_reg!(dst),
                        val_lo = in(reg) val.pair.lo,
                        val_hi = in(reg) val.pair.hi,
                        prev_lo = out(reg) prev_lo,
                        prev_hi = out(reg) prev_hi,
                        r = out(reg) _,
                        options(nostack, preserves_flags),
                    )
                };
            }
            atomic_rmw!(swap, order);
            MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
        }
    }
}
impl AtomicCompareExchange for u128 {
    #[inline]
    unsafe fn atomic_compare_exchange(
        dst: *mut MaybeUninit<Self>,
        old: MaybeUninit<Self>,
        new: MaybeUninit<Self>,
        success: Ordering,
        failure: Ordering,
    ) -> (MaybeUninit<Self>, bool) {
        debug_assert_atomic_unsafe_precondition!(dst, u128);
        let order = crate::utils::upgrade_success_ordering(success, failure);
        let old = MaybeUninit128 { whole: old };
        let new = MaybeUninit128 { whole: new };
        let (mut prev_lo, mut prev_hi);
        let mut r: i32;

        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            #[cfg(target_feature = "lse")]
            macro_rules! cmpxchg {
                ($acquire:tt, $release:tt, $_msvc_fence:tt) => {
                    // Refs: https://developer.arm.com/documentation/ddi0602/2025-06/Base-Instructions/CASP--CASPA--CASPAL--CASPL--Compare-and-swap-pair-of-words-or-doublewords-in-memory-
                    asm!(
                        // casp writes the current value to the first register pair,
                        // so copy the `old`'s value for later comparison.
                        "mov x8, {old_lo}",                                              // x8 = old_lo
                        "mov x9, {old_hi}",                                              // x9 = old_hi
                        concat!("casp", $acquire, $release, " x8, x9, x4, x5, [{dst}]"), // atomic { if *src == x8:x9 { *dst = x4:x5 } else { x8:x9 = *dst } }
                        "cmp x8, {old_lo}",                                              // if x8 == old_lo { Z = 1 } else { Z = 0 }
                        "ccmp x9, {old_hi}, #0, eq",                                     // if Z == 1 { if x9 == old_hi { Z = 1 } else { Z = 0 } } else { Z = 0 }
                        "cset {r:w}, eq",                                                // r = Z
                        dst = in(reg) ptr_reg!(dst),
                        old_lo = in(reg) old.pair.lo,
                        old_hi = in(reg) old.pair.hi,
                        r = lateout(reg) r,
                        // new pair - must be allocated to even/odd register pair
                        in("x4") new.pair.lo,
                        in("x5") new.pair.hi,
                        // prev pair - must be allocated to even/odd register pair
                        out("x8") prev_lo,
                        out("x9") prev_hi,
                        // Do not use `preserves_flags` because CMP and CCMP modify the condition flags.
                        options(nostack),
                    )
                };
            }
            #[cfg(not(target_feature = "lse"))]
            macro_rules! cmpxchg {
                ($acquire:tt, $release:tt, $msvc_fence:tt) => {
                    asm!(
                        "2:", // 'retry:
                            concat!("ld", $acquire, "xp {prev_lo}, {prev_hi}, [{dst}]"),      // atomic { prev_lo:prev_hi = *dst; EXCLUSIVE = dst }
                            "cmp {prev_lo}, {old_lo}",                                        // if prev_lo == old_lo { Z = 1 } else { Z = 0 }
                            "ccmp {prev_hi}, {old_hi}, #0, eq",                               // if Z == 1 { if prev_hi == old_hi { Z = 1 } else { Z = 0 } } else { Z = 0 }
                            // write back to ensure atomicity
                            "csel {tmp_lo}, {new_lo}, {prev_lo}, eq",                         // if Z == 1 { tmp_lo = new_lo } else { tmp_lo = prev_lo }
                            "csel {tmp_hi}, {new_hi}, {prev_hi}, eq",                         // if Z == 1 { tmp_hi = new_hi } else { tmp_hi = prev_hi }
                            concat!("st", $release, "xp {r:w}, {tmp_lo}, {tmp_hi}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = tmp_lo:tmp_hi; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                            "cbnz {r:w}, 2b",                                                 // if r != 0 { jump 'retry }
                        "cset {r:w}, eq",                                                     // r = Z
                        $msvc_fence,                                                          // fence
                        dst = in(reg) ptr_reg!(dst),
                        old_lo = in(reg) old.pair.lo,
                        old_hi = in(reg) old.pair.hi,
                        new_lo = in(reg) new.pair.lo,
                        new_hi = in(reg) new.pair.hi,
                        prev_lo = out(reg) prev_lo,
                        prev_hi = out(reg) prev_hi,
                        r = out(reg) r,
                        tmp_lo = out(reg) _,
                        tmp_hi = out(reg) _,
                        // Do not use `preserves_flags` because CMP and CCMP modify the condition flags.
                        options(nostack),
                    )
                };
            }
            atomic_rmw!(cmpxchg, order, write = success);
            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
            (MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole, r != 0)
        }
    }
}

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
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
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
