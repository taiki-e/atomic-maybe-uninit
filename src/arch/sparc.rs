// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
SPARC

This architecture provides the following atomic instructions:

- Load/Store Instructions
  - V7-V9: {8,16,32}-bit
  - V8+,V9: 64-bit (LDX, STX)
  (Section 8.4.4 "Memory Models" of the SPARC Architecture Manual, Version 9)
- Compare-and-Swap Instructions (CAS)
  - V8+,V9: {32,64}-bit
  - V8 with CAS (e.g., LEON4): 32-bit
  (Section 8.4.6 "Hardware Primitives for Mutual Exclusion" of the SPARC Architecture Manual, Version 9)
- SWAP Instructions (RMW)
  - V8-V9: 32-bit (deprecated in V9)
  (Section 8.4.6 "Hardware Primitives for Mutual Exclusion" and A.57 "Swap Register with Memory" of the SPARC Architecture Manual, Version 9)
- Load Store Unsigned Byte Instructions (RMW)
  - V7-V9: 8-bit
  (Section 8.4.6 "Hardware Primitives for Mutual Exclusion" of the SPARC Architecture Manual, Version 9)

Refs:
- The SPARC Architecture Manual, Version 9
  The SPARC Architecture Manual, Version 8
  https://sparc.org/technical-documents
- The V8+ Technical Specification
  https://temlib.org/pub/SparcStation/Standards/V8plus.pdf

Generated asm:
- sparcv8+leoncasa https://godbolt.org/z/n96j1W87s
- sparcv8plus https://godbolt.org/z/qse81K1M5
- sparc64 https://godbolt.org/z/PbxqToxj4
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
    ($size:tt, $rs1:tt, $rs2:tt, $rd:tt) => {
        concat!("cas", $size, " ", $rs1, ", ", $rs2, ", ", $rd)
    };
}
#[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
macro_rules! cas {
    ("", $rs1:tt, $rs2:tt, $rd:tt) => {
        // .p2align 4 is workaround for errata (GRLIB-TN-0011).
        concat!(".p2align 4", "\n", "casa ", $rs1, " 10, ", $rs2, ", ", $rd)
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
// https://www.gaisler.com/index.php/information/app-tech-notes
#[cfg(not(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa")))]
macro_rules! leon_nop {
    () => {
        ""
    };
}
#[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
macro_rules! leon_nop {
    () => {
        "nop"
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
            Ordering::Acquire => {
                $op!("membar #LoadLoad | #StoreLoad | #LoadStore | #StoreStore", "")
            }
            Ordering::Release => {
                $op!("", "membar #LoadLoad | #StoreLoad | #LoadStore | #StoreStore")
            }
            Ordering::AcqRel | Ordering::SeqCst => $op!(
                "membar #LoadLoad | #StoreLoad | #LoadStore | #StoreStore",
                "membar #LoadLoad | #StoreLoad | #LoadStore | #StoreStore"
            ),
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
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("stbar", ""),
            Ordering::Release => $op!("", "stbar"),
            Ordering::AcqRel | Ordering::SeqCst => $op!("stbar", "stbar"),
            _ => unreachable!(),
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($int_type:ident, $size:tt, $load_sign:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                concat!("ld", $load_sign, $size, " [{src}], {out}"), // atomic { out = *src }
                                $acquire,                                            // fence
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
                        Ordering::Relaxed => atomic_load!(""),
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("membar #LoadLoad | #StoreLoad | #LoadStore | #StoreStore"),
                        _ => unreachable!(),
                    }
                    #[cfg(not(any(
                        target_arch = "sparc64",
                        target_feature = "v9",
                        atomic_maybe_uninit_target_feature = "v9",
                    )))]
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("stbar"),
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
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
                                $release,                                // fence
                                concat!("st", $size, " {val}, [{dst}]"), // atomic { *dst = val }
                                $acquire,                                // fence
                                leon_nop!(), // Workaround for for errata (GRLIB-TN-0009).
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(store, order);
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($int_type:ident, $size:tt, $cc:tt) => {
        atomic_load_store!($int_type, $size, "");
        impl AtomicSwap for $int_type {
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
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                     // fence
                                concat!("ld", $size, " [{dst}], {out}"),      // atomic { out = *dst }
                                "2:", // 'retry:
                                    "mov {out}, {tmp}",                       // tmp = out
                                    "mov {val}, {out}",                       // out = val
                                    cas!($size, "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = _x }
                                    "cmp {out}, {tmp}",                       // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne!($cc, "2b"),                          // if !cc.Z { jump 'retry }
                                $acquire,                                     // fence
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
        impl AtomicCompareExchange for $int_type {
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
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                leon_nop!(), // Workaround for errata (GRLIB-TN-0010).
                                $release,                                 // fence
                                cas!($size, "[{dst}]", "{old}", "{out}"), // atomic { _x = *dst; if _x == old { *dst = out }; out = _x }
                                "cmp {out}, {old}",                       // if out == old { cc.Z = true } else { cc.Z = false }
                                "mov %g0, {r}",                           // r = 0
                                move_!($cc, "1", "{r}"),                  // if cc.Z { r = 1 }
                                $acquire,                                 // fence
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
    ($int_type:ident, $size:tt) => {
        atomic_load_store!($int_type, $size, "u");
        impl AtomicSwap for $int_type {
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
                        ($acquire:tt, $release:tt) => {
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
        impl AtomicCompareExchange for $int_type {
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
                        ($acquire:tt, $release:tt) => {
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
