// SPDX-License-Identifier: Apache-2.0 OR MIT

// Hexagon
//
// Refs:
// - Hexagon V5x Programmer's Reference Manual
//   https://developer.qualcomm.com/download/hexagon/hexagon-v5x-programmers-reference-manual.pdf?referrer=node/6116

#[path = "cfgs/hexagon.rs"]
mod cfgs;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap},
    utils::{MaybeUninit64, Pair},
};

macro_rules! atomic_load_store {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        // (atomic) load from src to out
                        concat!("{out} = mem", $asm_u_suffix, $asm_suffix, "({src})"),
                        src = in(reg) src,
                        out = lateout(reg) out,
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
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        // (atomic) store val to dst
                        concat!("mem", $asm_suffix, "({dst}) = {val}"),
                        dst = in(reg) dst,
                        val = in(reg) val,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident) => {
        atomic_load_store!($int_type, "w", "");
        impl AtomicSwap for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "2:",
                            "{out} = memw_locked({dst})",
                            "memw_locked({dst},p0) = {val}",
                            "if (!p0) jump 2b",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        out = out(reg) out,
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32 = 1;
                    asm!(
                        "2:",
                            "{out} = memw_locked({dst})",
                            "{{ p0 = cmp.eq({out},{old})",
                                "if (!p0.new) jump:nt 3f }}",
                            "memw_locked({dst},p0) = {new}",
                            "if (!p0) jump 2b",
                            "jump 4f",
                        "3:",
                            "{r} = #0",
                        "4:",
                        dst = in(reg) dst,
                        old = in(reg) old,
                        new = in(reg) new,
                        out = out(reg) out,
                        r = inout(reg) r,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    (out, r != 0)
                }
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, $asm_u_suffix);
        impl AtomicSwap for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "{val} = asl({val},{shift})",
                        "{val} = and({val},{mask})",
                        "2:",
                            "{out} = memw_locked({dst})",
                            "{tmp} = and({out},{inv_mask})",
                            "{tmp} = or({tmp},{val})",
                            "memw_locked({dst},p0) = {tmp}",
                            "if (!p0) jump 2b",
                        "{out} = asr({out},{shift})",
                        dst = in(reg) dst,
                        val = inout(reg) crate::utils::zero_extend(val) => _,
                        out = out(reg) out,
                        shift = in(reg) shift,
                        mask = in(reg) mask,
                        inv_mask = in(reg) !mask,
                        tmp = out(reg) _,
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32 = 1;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "{old} = asl({old},{shift})",
                        "{new} = asl({new},{shift})",
                        "{old} = and({old},{mask})",
                        "{new} = and({new},{mask})",
                        "2:",
                            "{tmp} = memw_locked({dst})",
                            "{out} = and({tmp},{mask})",
                            "{{ p0 = cmp.eq({out},{old})",
                                "if (!p0.new) jump:nt 3f }}",
                            "{tmp} = and({tmp},{inv_mask})",
                            "{tmp} = or({tmp},{new})",
                            "memw_locked({dst},p0) = {tmp}",
                            "if (!p0) jump 2b",
                            "jump 4f",
                        "3:",
                            "{r} = #0",
                        "4:",
                        "{out} = asr({out},{shift})",
                        dst = in(reg) dst,
                        old = inout(reg) crate::utils::zero_extend(old) => _,
                        new = inout(reg) crate::utils::zero_extend(new) => _,
                        out = out(reg) out,
                        shift = in(reg) shift,
                        mask = in(reg) mask,
                        inv_mask = in(reg) !mask,
                        tmp = out(reg) _,
                        r = inout(reg) r,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    (out, r != 0)
                }
            }
        }
    };
}

atomic_sub_word!(i8, "b", "u");
atomic_sub_word!(u8, "b", "u");
atomic_sub_word!(i16, "h", "u");
atomic_sub_word!(u16, "h", "u");
atomic!(i32);
atomic!(u32);
atomic!(isize);
atomic!(usize);

macro_rules! atomic64 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let (prev_lo, prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        // (atomic) load from src to prev pair
                        "{{ r3:2 = memd({src}) }}",
                        src = in(reg) src,
                        out("r2") prev_lo,
                        out("r3") prev_hi,
                        options(nostack, preserves_flags),
                    );
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) {
                let val = MaybeUninit64 { $int_type: val };

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        // (atomic) store val pair to dst
                        "memd({dst}) = r3:2",
                        dst = in(reg) dst,
                        in("r2") val.pair.lo,
                        in("r3") val.pair.hi,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
        impl AtomicSwap for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let val = MaybeUninit64 { $int_type: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "2:",
                            "{{ r5:4 = memd_locked({dst}) }}",
                            "memd_locked({dst},p0) = r3:2",
                            "if (!p0) jump 2b",
                        dst = in(reg) dst,
                        in("r2") val.pair.lo,
                        in("r3") val.pair.hi,
                        out("r4") prev_lo,
                        out("r5") prev_hi,
                        options(nostack),
                    );
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                let old = MaybeUninit64 { $int_type: old };
                let new = MaybeUninit64 { $int_type: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32 = 1;
                    asm!(
                        "2:",
                            "{{ r7:6 = memd_locked({dst}) }}",
                            // TODO: merge two cmp?
                            "{{ p0 = cmp.eq(r6,r2)",
                                "if (!p0.new) jump:nt 3f }}",
                            "{{ p0 = cmp.eq(r7,r3)",
                                "if (!p0.new) jump:nt 3f }}",
                            "memd_locked({dst},p0) = r5:4",
                            "if (!p0) jump 2b",
                            "jump 4f",
                        "3:",
                            "{r} = #0",
                        "4:",
                        dst = in(reg) dst,
                        r = inout(reg) r,
                        in("r2") old.pair.lo,
                        in("r3") old.pair.hi,
                        in("r4") new.pair.lo,
                        in("r5") new.pair.hi,
                        out("r6") prev_lo,
                        out("r7") prev_hi,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type, r != 0)
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);
