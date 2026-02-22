// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
SPARC and SPARC64

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#sparc

Refs:
- The SPARC Architecture Manual, Version 9
  The SPARC Architecture Manual, Version 8
  https://sparc.org/technical-documents
- The V8+ Technical Specification
  https://temlib.org/pub/SparcStation/Standards/V8plus.pdf

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

delegate_size!(delegate_all);

#[cfg(target_arch = "sparc64")]
use core::cell::UnsafeCell;
pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap};

cfg_sel!({
    #[cfg(any(
        target_arch = "sparc64",
        target_feature = "v9",
        atomic_maybe_uninit_target_feature = "v9",
    ))]
    {
        // Bicc instructions are deprecated in V9.
        macro_rules! bne {
            ($cc:tt, $label:tt) => {
                concat!("bne ", $cc, ", ", $label)
            };
        }
        macro_rules! bne_a {
            ($cc:tt, $label:tt) => {
                concat!("bne,a ", $cc, ", ", $label)
            };
        }
        // MOVcc instructions are unavailable in V8.
        macro_rules! move_ {
            ($cc:tt, $val:tt, $rd:tt) => {
                concat!("move ", $cc, ", ", $val, ", ", $rd)
            };
        }
        macro_rules! atomic_rmw {
            ($op:ident, $order:ident) => {
                match $order {
                    Ordering::Relaxed => $op!("", ""),
                    // 15 == #LoadLoad | #StoreLoad | #LoadStore | #StoreStore
                    Ordering::Acquire => $op!("membar 15", ""),
                    Ordering::Release => $op!("", "membar 15"),
                    Ordering::AcqRel | Ordering::SeqCst => $op!("membar 15", "membar 15"),
                    _ => unreachable!(),
                }
            };
        }
    }
    #[cfg(else)]
    {
        macro_rules! bne {
            ("%icc", $label:tt) => {
                concat!("bne ", $label)
            };
        }
        macro_rules! bne_a {
            ("%icc", $label:tt) => {
                concat!("bne,a ", $label)
            };
        }
        #[rustfmt::skip]
        macro_rules! move_ {
            ($cc:tt, $val:tt, $rd:tt) => {
                concat!(
                    bne!($cc, "99f"), "\n",
                    "nop", "\n",
                    "mov ", $val, ", ", $rd, "\n",
                    "99:"
                )
            };
        }
        macro_rules! atomic_rmw {
            ($op:ident, $order:ident) => {
                // GCC and LLVM use different types of memory barriers in SPARC-V8, and probably have
                // different semantics to obtain as a result. My experience with this platform is that LLVM
                // is often incomplete and GCC's is more likely to be correct, but I use code with both
                // semantics just to be safe.
                match $order {
                    Ordering::Relaxed => $op!("", ""),
                    Ordering::Acquire => $op!("stbar", ""),
                    Ordering::Release => {
                        $op!("", concat!("stbar\n", leon_align!(), "ldstub [%sp-1], %g0"))
                    }
                    Ordering::AcqRel | Ordering::SeqCst => {
                        $op!("stbar", concat!("stbar\n", leon_align!(), "ldstub [%sp-1], %g0"))
                    }
                    _ => unreachable!(),
                }
            };
        }
    }
});

cfg_sel!({
    #[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
    {
        macro_rules! cas {
            ("", $rs1:tt, $rs2:tt, $rd:tt) => {
                concat!(leon_align!(), "casa ", $rs1, " 10, ", $rs2, ", ", $rd)
            };
        }
        // Workaround for errata (GRLIB-TN-0009, GRLIB-TN-0010).
        // https://www.gaisler.com/app-notes-tech-notes-and-white-papers
        macro_rules! leon_nop {
            () => {
                "nop\n"
            };
        }
        // Workaround for errata (GRLIB-TN-0011).
        // https://www.gaisler.com/app-notes-tech-notes-and-white-papers
        macro_rules! leon_align {
            () => {
                ".p2align 4\n"
            };
        }
    }
    #[cfg(else)]
    {
        #[cfg(any(
            target_arch = "sparc64",
            target_feature = "v9",
            atomic_maybe_uninit_target_feature = "v9",
        ))]
        macro_rules! cas {
            ($suffix:tt, $rs1:tt, $rs2:tt, $rd:tt) => {
                concat!("cas", $suffix, " ", $rs1, ", ", $rs2, ", ", $rd)
            };
        }
        macro_rules! leon_nop {
            () => {
                ""
            };
        }
        #[cfg(not(any(
            target_arch = "sparc64",
            target_feature = "v9",
            atomic_maybe_uninit_target_feature = "v9",
        )))]
        macro_rules! leon_align {
            () => {
                ""
            };
        }
    }
});

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $($size:literal)?, $suffix:tt, $load_sign:tt) => {
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
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                $release,                                              // fence
                                concat!("ld", $load_sign, $suffix, " [{src}], {out}"), // atomic { out = *src }
                                $acquire,                                              // fence
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(any(
                        target_arch = "sparc64",
                        target_feature = "v9",
                        atomic_maybe_uninit_target_feature = "v9",
                    ))]
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        // 3 == #LoadLoad | #StoreLoad
                        // 5 == #LoadLoad | #LoadStore
                        Ordering::Acquire => atomic_load!("membar 5", ""),
                        Ordering::SeqCst => atomic_load!("membar 5", "membar 3"),
                        _ => unreachable!(),
                    }
                    #[cfg(not(any(
                        target_arch = "sparc64",
                        target_feature = "v9",
                        atomic_maybe_uninit_target_feature = "v9",
                    )))]
                    // GCC and LLVM use different types of memory barriers in SPARC-V8, and probably have
                    // different semantics to obtain as a result. My experience with this platform is that LLVM
                    // is often incomplete and GCC's is more likely to be correct, but I use code with both
                    // semantics just to be safe.
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("stbar", ""),
                        Ordering::SeqCst => atomic_load!("stbar", concat!(leon_nop!(), leon_align!(), "ldstub [%sp-1], %g0")),
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
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
                                $release,                                  // fence
                                concat!("st", $suffix, " {val}, [{dst}]"), // atomic { *dst = val }
                                $acquire,                                  // fence
                                leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(any(
                        target_arch = "sparc64",
                        target_feature = "v9",
                        atomic_maybe_uninit_target_feature = "v9",
                    ))]
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        // 10 == #StoreLoad | #StoreStore
                        // 12 == #LoadStore | #StoreStore
                        Ordering::Release => atomic_store!("", "membar 12"),
                        Ordering::SeqCst => atomic_store!("membar 10", "membar 12"),
                        _ => unreachable!(),
                    }
                    #[cfg(not(any(
                        target_arch = "sparc64",
                        target_feature = "v9",
                        atomic_maybe_uninit_target_feature = "v9",
                    )))]
                    // GCC and LLVM use different types of memory barriers in SPARC-V8, and probably have
                    // different semantics to obtain as a result. My experience with this platform is that LLVM
                    // is often incomplete and GCC's is more likely to be correct, but I use code with both
                    // semantics just to be safe.
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "stbar"),
                        Ordering::SeqCst => atomic_store!(concat!("stbar\n", leon_align!(), "ldstub [%sp-1], %g0"), "stbar"),
                        _ => unreachable!(),
                    }
                }
            }
        }
        $(
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("ld", $load_sign, $suffix, " [{src}], {tmp0}"), // atomic { tmp0 = *src }
                    concat!("add {src}, ", $size, ", {src}"),               // src = src.byte_add($size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("ld", $load_sign, $suffix, " [{src} + ", $size, "], {tmp1}"), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("ld", $load_sign, $suffix, " [{src}], {tmp0}"),               // atomic { tmp0 = *src }
                    concat!("add {src}, 2*", $size, ", {src}"),                           // src = src.byte_add(2*$size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
                    concat!("st", $suffix, " {tmp0}, [{dst}]"), // atomic { *dst = tmp0 }
                    leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
                    concat!("add {dst}, ", $size, ", {dst}"),   // dst = dst.byte_add($size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
                    concat!("st", $suffix, " {tmp1}, [{dst} + ", $size, "]"), // atomic { *dst.byte_add($size) = tmp1 }
                    leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
                    concat!("st", $suffix, " {tmp0}, [{dst}]"),               // atomic { *dst = tmp0 }
                    leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
                    concat!("add {dst}, 2*", $size, ", {dst}"),               // src = src.byte_add(2*$size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
        }
        )?
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $($size:literal)?, $suffix:tt, $cc:tt) => {
        atomic_load_store!($ty, $($size)?, $suffix, "");
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
                                $release,                                       // fence
                                concat!("ld", $suffix, " [{dst}], {tmp}"),      // atomic { tmp = *dst }
                                "2:", // 'retry:
                                    "mov {val}, {out}",                         // out = val
                                    cas!($suffix, "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = _x }
                                    "cmp {out}, {tmp}",                         // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne_a!($cc, "2b"),                          // if !cc.Z {
                                        "mov {out}, {tmp}",                     //   tmp = out; jump 'retry }
                                $acquire,                                       // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                tmp = out(reg) _,
                                // Do not use `preserves_flags` because CMP modifies the condition codes.
                                options(nostack),
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
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                leon_nop!(), // Workaround for errata (GRLIB-TN-0010).
                                $release,                                   // fence
                                cas!($suffix, "[{dst}]", "{old}", "{out}"), // atomic { _x = *dst; if _x == old { *dst = out }; out = _x }
                                "cmp {out}, {old}",                         // if out == old { cc.Z = true } else { cc.Z = false }
                                "mov %g0, {r}",                             // r = 0
                                move_!($cc, "1", "{r}"),                    // if cc.Z { r = 1 }
                                $acquire,                                   // fence
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                out = inout(reg) new => out,
                                r = lateout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition codes.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($ty:ident, $size:literal, $suffix:tt) => {
        atomic_load_store!($ty, $size, $suffix, "u");
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
                    macro_rules! swap {
                        ($acquire:expr, $release:expr) => {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "sll {mask}, {shift}, {mask}",             // mask <<= shift & 31
                                "sll {val}, {shift}, {val}",               // val <<= shift & 31
                                $release,                                  // fence
                                "ld [{dst}], {tmp}",                       // atomic { tmp = *dst }
                                "2:", // 'retry:
                                    "andn {tmp}, {mask}, {out}",           // out = tmp & !mask
                                    "or {out}, {val}, {out}",              // out |= val
                                    cas!("", "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = _x }
                                    "cmp {out}, {tmp}",                    // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne_a!("%icc", "2b"),                  // if !cc.Z {
                                        "mov {out}, {tmp}",                //   tmp = out; jump 'retry }
                                "srl {out}, {shift}, {out}",               // out >>= shift & 31
                                $acquire,                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) crate::utils::extend32::$ty::zero(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) _,
                                // Do not use `preserves_flags` because CMP modifies the condition codes.
                                options(nostack),
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
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($acquire:expr, $release:expr) => {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "sll {mask}, {shift}, {mask}",             // mask <<= shift & 31
                                "sll {old}, {shift}, {old}",               // old <<= shift & 31
                                "sll {new}, {shift}, {new}",               // new <<= shift & 31
                                $release,                                  // fence
                                "ld [{dst}], {out}",                       // atomic { out = *dst }
                                "2:", // 'retry:
                                    "and {out}, {mask}, {tmp}",            // tmp = out & mask
                                    "cmp {old}, {tmp}",                    // if old == tmp { cc.Z = true } else { cc.Z = false }
                                    bne_a!("%icc", "3f"),                  // if !cc.Z {
                                        "mov %g0, {tmp}",                  //   tmp = 0; jump 'cmp-fail }
                                    "mov {out}, {tmp}",                    // tmp = out
                                    "andn {out}, {mask}, {out}",           // out &= !mask
                                    "or {out}, {new}, {out}",              // out |= new
                                    cas!("", "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = _x }
                                    "cmp {out}, {tmp}",                    // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne!("%icc", "2b"),                    // if !cc.Z {
                                        "mov 1, {tmp}",                    //   tmp = 1; jump 'retry } else { tmp = 1 }
                                "3:", // 'cmp-fail:
                                "srl {out}, {shift}, {out}",               // out >>= shift & 31
                                $acquire,                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) crate::utils::extend32::$ty::zero(old) => _,
                                new = inout(reg) crate::utils::extend32::$ty::zero(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition codes.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

atomic_sub_word!(u8, "1", "b");
atomic_sub_word!(u16, "2", "h");
atomic!(u32, "4", "", "%icc");
// TODO: V8+ with 64-bit g/o reg
#[cfg(target_arch = "sparc64")]
atomic!(u64,    , "x", "%xcc");

#[cfg(target_arch = "sparc64")]
impl AtomicMemcpy for u64 {
    load_memcpy_opt64! { |src, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7|
        asm!(
            "ldx [{src}], {tmp0}",  // atomic { tmp0 = *src }
            "add {src}, 8, {src}",  // src = src.byte_add(8)
            src = inout(reg) src,
            tmp0 = out(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            "ldx [{src} + 8], {tmp1}",  // atomic { tmp1 = *src.byte_add(8) }
            "ldx [{src}], {tmp0}",      // atomic { tmp0 = *src }
            "add {src}, 2*8, {src}",    // src = src.byte_add(2*8)
            src = inout(reg) src,
            tmp0 = out(reg) tmp0,
            tmp1 = out(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            "ldx [{src} + 8*7], {tmp7}",    // atomic { tmp7 = *src.byte_add(8*7) }
            "ldx [{src} + 8*6], {tmp6}",    // atomic { tmp6 = *src.byte_add(8*6) }
            "ldx [{src} + 8*5], {tmp5}",    // atomic { tmp5 = *src.byte_add(8*5) }
            "ldx [{src} + 8*4], {tmp4}",    // atomic { tmp4 = *src.byte_add(8*4) }
            "ldx [{src} + 8*3], {tmp3}",    // atomic { tmp3 = *src.byte_add(8*3) }
            "ldx [{src} + 8*2], {tmp2}",    // atomic { tmp2 = *src.byte_add(8*2) }
            "ldx [{src} + 8*1], {tmp1}",    // atomic { tmp1 = *src.byte_add(8*1) }
            "ldx [{src}], {tmp0}",          // atomic { tmp0 = *src }
            "add {src}, 8*8, {src}",        // src = src.byte_add(8*8)
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
        ),
    }
    store_memcpy_opt64! { |dst, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7|
        asm!(
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp0}, [{dst}]",  // atomic { *dst = tmp0 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "add {dst}, 8, {dst}",  // dst = dst.byte_add(8)
            dst = inout(reg) dst,
            tmp0 = in(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp1}, [{dst} + 8]",  // atomic { *dst.byte_add(8) = tmp1 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp0}, [{dst}]",      // atomic { *dst = tmp0 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "add {dst}, 2*8, {dst}",    // src = src.byte_add(2*8)
            dst = inout(reg) dst,
            tmp0 = in(reg) tmp0,
            tmp1 = in(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp7}, [{dst} + 8*7]",    // atomic { *dst.byte_add(8*7) = tmp7 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp6}, [{dst} + 8*6]",    // atomic { *dst.byte_add(8*6) = tmp6 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp5}, [{dst} + 8*5]",    // atomic { *dst.byte_add(8*5) = tmp5 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp4}, [{dst} + 8*4]",    // atomic { *dst.byte_add(8*4) = tmp4 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp3}, [{dst} + 8*3]",    // atomic { *dst.byte_add(8*3) = tmp3 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp2}, [{dst} + 8*2]",    // atomic { *dst.byte_add(8*2) = tmp2 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp1}, [{dst} + 8*1]",    // atomic { *dst.byte_add(8*1) = tmp1 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "stx {tmp0}, [{dst}]",          // atomic { *dst = tmp0 }
            leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
            "add {dst}, 8*8, {dst}",        // src = src.byte_add(8*8)
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
        ),
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
// TODO: V8+ with 64-bit g/o reg
#[cfg(target_arch = "sparc")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
// TODO: V8+ with 64-bit g/o reg
#[cfg(target_arch = "sparc")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "sparc64")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "sparc64")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
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
