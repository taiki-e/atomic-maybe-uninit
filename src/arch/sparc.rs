// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
SPARC

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#sparc

Refs:
- The SPARC Architecture Manual, Version 9
  The SPARC Architecture Manual, Version 8
  https://sparc.org/technical-documents
- The V8+ Technical Specification
  https://temlib.org/pub/SparcStation/Standards/V8plus.pdf

Generated asm:
- sparcv8+leoncasa https://godbolt.org/z/4TPGbfPo4
- sparcv8plus https://godbolt.org/z/rvnPono8j
- sparc64 https://godbolt.org/z/ejM3ooeec
*/

#[path = "cfgs/sparc.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

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
#[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
macro_rules! cas {
    ("", $rs1:tt, $rs2:tt, $rd:tt) => {
        concat!(leon_align!(), "casa ", $rs1, " 10, ", $rs2, ", ", $rd)
    };
}

// Bicc instructions are deprecated in V9.
#[cfg(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
))]
macro_rules! bne {
    ($cc:tt, $label:tt) => {
        concat!("bne ", $cc, ", ", $label, "\n", "nop")
    };
}
#[cfg(not(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
)))]
macro_rules! bne {
    ("%icc", $label:tt) => {
        concat!("bne ", $label, "\n", "nop")
    };
}

// MOVcc instructions are unavailable in V8.
#[cfg(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
))]
macro_rules! move_ {
    ($cc:tt, $val:tt, $rd:tt) => {
        concat!("move ", $cc, ", ", $val, ", ", $rd)
    };
}
#[cfg(not(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
)))]
macro_rules! move_ {
    ($cc:tt, $val:tt, $rd:tt) => {
        concat!(bne!($cc, "99f"), "\n", "mov ", $val, ", ", $rd, "\n", "99:")
    };
}

// Workaround for errata (GRLIB-TN-0009, GRLIB-TN-0010).
// https://www.gaisler.com/app-notes-tech-notes-and-white-papers
#[cfg(not(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa")))]
macro_rules! leon_nop {
    () => {
        ""
    };
}
#[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
macro_rules! leon_nop {
    () => {
        "nop\n"
    };
}
// Workaround for errata (GRLIB-TN-0011).
// https://www.gaisler.com/app-notes-tech-notes-and-white-papers
#[cfg(not(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
)))]
#[cfg(not(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa")))]
macro_rules! leon_align {
    () => {
        ""
    };
}
#[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
macro_rules! leon_align {
    () => {
        ".p2align 4\n"
    };
}

#[cfg(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
))]
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
#[cfg(not(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
)))]
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

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $suffix:tt, $load_sign:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
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
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $suffix:tt, $cc:tt) => {
        atomic_load_store!($ty, $suffix, "");
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                $release,                                       // fence
                                concat!("ld", $suffix, " [{dst}], {out}"),      // atomic { out = *dst }
                                "2:", // 'retry:
                                    "mov {out}, {tmp}",                         // tmp = out
                                    "mov {val}, {out}",                         // out = val
                                    cas!($suffix, "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = _x }
                                    "cmp {out}, {tmp}",                         // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne!($cc, "2b"),                            // if !cc.Z { jump 'retry }
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
    ($ty:ident, $suffix:tt) => {
        atomic_load_store!($ty, $suffix, "u");
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
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
                                "ld [{dst}], {out}",                       // atomic { out = *dst }
                                "2:", // 'retry:
                                    "mov {out}, {tmp}",                    // tmp = out
                                    "andn {out}, {mask}, {out}",           // out &= !mask
                                    "or {out}, {val}, {out}",              // out |= val
                                    cas!("", "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = _x }
                                    "cmp {out}, {tmp}",                    // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne!("%icc", "2b"),                    // if !cc.Z { jump 'retry }
                                "srl {out}, {shift}, {out}",               // out >>= shift & 31
                                $acquire,                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
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
                                    bne!("%icc", "3f"),                    // if !cc.Z { jump 'cmp-fail }
                                    "mov {out}, {tmp}",                    // tmp = out
                                    "andn {out}, {mask}, {out}",           // out &= !mask
                                    "or {out}, {new}, {out}",              // out |= new
                                    cas!("", "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = _x }
                                    "cmp {out}, {tmp}",                    // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne!("%icc", "2b"),                    // if !cc.Z { jump 'retry }
                                "3:", // 'cmp-fail:
                                "mov %g0, {tmp}",                          // tmp = 0
                                move_!("%icc", "1", "{tmp}"),              // if cc.Z { tmp = 1 }
                                "srl {out}, {shift}, {out}",               // out >>= shift & 31
                                $acquire,                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) crate::utils::ZeroExtend::zero_extend(old) => _,
                                new = inout(reg) crate::utils::ZeroExtend::zero_extend(new) => _,
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

atomic_sub_word!(i8, "b");
atomic_sub_word!(u8, "b");
atomic_sub_word!(i16, "h");
atomic_sub_word!(u16, "h");
atomic!(i32, "", "%icc");
atomic!(u32, "", "%icc");
// TODO: V8+ with 64-bit g/o reg
#[cfg(target_arch = "sparc64")]
atomic!(i64, "x", "%xcc");
// TODO: V8+ with 64-bit g/o reg
#[cfg(target_arch = "sparc64")]
atomic!(u64, "x", "%xcc");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "", "%icc");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "", "%icc");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "x", "%xcc");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "x", "%xcc");
