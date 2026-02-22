// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Xtensa

Refs:
- Xtensa Instruction Set Architecture (ISA) Summary for all Xtensa LX Processors
  https://www.cadence.com/content/dam/cadence-www/global/en_US/documents/tools/silicon-solutions/compute-ip/isa-summary.pdf
- https://github.com/espressif/llvm-project/blob/xtensa_release_19.1.2/llvm/test/CodeGen/Xtensa/atomic-load-store.ll
- https://github.com/espressif/llvm-project/blob/xtensa_release_19.1.2/llvm/test/CodeGen/Xtensa/atomicrmw.ll
  Note that LLVM's codegen for sub-word atomics seem to be suboptimal (extra branch, memw, l32i.n, etc.).

Note that l32ai (acquire load), s32ri (release store), and l32ex/s32ex/getex (LL/SC) are not yet supported in LLVM.
https://github.com/espressif/llvm-project/blob/xtensa_release_19.1.2/llvm/lib/Target/Xtensa/XtensaInstrInfo.td
*/

#[cfg(not(target_feature = "s32c1i"))]
delegate_size!(delegate_load_store);
#[cfg(target_feature = "s32c1i")]
delegate_size!(delegate_all);

pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

#[cfg(target_feature = "s32c1i")]
use crate::raw::{AtomicCompareExchange, AtomicSwap};
use crate::raw::{AtomicLoad, AtomicMemcpy, AtomicStore};

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("memw", ""),
            Ordering::Release => $op!("", "memw"),
            Ordering::AcqRel | Ordering::SeqCst => $op!("memw", "memw"),
            _ => unreachable!(),
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $size:literal, $bits:tt, $narrow:tt, $unsigned:tt) => {
        #[cfg(not(target_feature = "s32c1i"))]
        delegate_signed!(delegate_load_store, $ty);
        #[cfg(target_feature = "s32c1i")]
        delegate_signed!(delegate_all, $ty);
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
                        ($acquire:tt) => {
                            asm!(
                                concat!("l", $bits, $unsigned, "i", $narrow, " {out}, {src}, 0"), // atomic { out = *src }
                                $acquire,                                                         // fence
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("memw"),
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
                    macro_rules! store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                              // fence
                                concat!("s", $bits, "i", $narrow, " {val}, {dst}, 0"), // atomic { *dst = val }
                                $acquire,                                              // fence
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
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("l", $bits, $unsigned, "i", $narrow, " {tmp0}, {src}, 0"), // atomic { tmp0 = *src }
                    src = in(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("l", $bits, $unsigned, "i", $narrow, " {tmp1}, {src}, ", $size), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("l", $bits, $unsigned, "i", $narrow, " {tmp0}, {src}, 0"),       // atomic { tmp0 = *src }
                    src = in(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("s", $bits, "i", $narrow, " {tmp0}, {dst}, 0"), // atomic { *dst = tmp0 }
                    dst = in(reg) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("s", $bits, "i", $narrow, " {tmp1}, {dst}, ", $size), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("s", $bits, "i", $narrow, " {tmp0}, {dst}, 0"),       // atomic { *dst = tmp0 }
                    dst = in(reg) dst,
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
    ($ty:ident, $size:literal) => {
        atomic_load_store!($ty, $size, "32", ".n", "");
        #[cfg(target_feature = "s32c1i")]
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
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                     // fence
                                "l32i.n {out}, {dst}, 0",     // atomic { out = *dst }
                                "2:", // 'retry:
                                    "mov.n {tmp}, {out}",     // tmp = out
                                    "wsr {tmp}, scompare1",   // scompare1 = tmp
                                    "mov.n {out}, {val}",     // out = val
                                    "s32c1i {out}, {dst}, 0", // atomic { _x = *dst; if _x == scompare1 { *dst = out }; out = _x }
                                    "bne {tmp}, {out}, 2b",   // if tmp != out { jump 'retry }
                                $acquire,                     // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                tmp = out(reg) _,
                                out("scompare1") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
                out
            }
        }
        #[cfg(target_feature = "s32c1i")]
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
                    let mut r: u32 = 1;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                 // fence
                                "wsr {old}, scompare1",   // scompare1 = old
                                "s32c1i {out}, {dst}, 0", // atomic { _x = *dst; if _x == scompare1 { *dst = out }; out = _x }
                                $acquire,                 // fence
                                "beq {old}, {out}, 2f",   // if old == out { jump 'success }
                                "movi {r}, 0",            // r = 0
                                "2:", // 'success:
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                out = inout(reg) new => out,
                                r = inout(reg) r,
                                out("scompare1") _,
                                options(nostack, preserves_flags),
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
    ($ty:ident, $size:literal, $bits:tt) => {
        atomic_load_store!($ty, $size, $bits, "", "u");
        #[cfg(target_feature = "s32c1i")]
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
                        ($acquire:tt, $release:tt) => {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "ssl {shift}",                  // sar = for_sll(shift & 31)
                                "sll {mask}, {mask}",           // mask <<= sar
                                "sll {val}, {val}",             // val <<= sar
                                $release,                       // fence
                                "l32i.n {out}, {dst}, 0",       // atomic { out = *dst }
                                "2:", // 'retry:
                                    "mov.n {tmp}, {out}",       // tmp = out
                                    "wsr {tmp}, scompare1",     // scompare1 = tmp
                                    "xor {out}, {tmp}, {val}",  // out = tmp ^ val
                                    "and {out}, {out}, {mask}", // out &= mask
                                    "xor {out}, {out}, {tmp}",  // out ^= out
                                    "s32c1i {out}, {dst}, 0",   // atomic { _x = *dst; if _x == scompare1 { *dst = out }; out = _x }
                                    "bne {tmp}, {out}, 2b",     // if tmp != out { jump 'retry }
                                "ssr {shift}",                  // sar = for_srl(shift & 31)
                                "srl {out}, {out}",             // out >>= sar
                                $acquire,                       // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) crate::utils::extend32::$ty::zero(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) _,
                                out("scompare1") _,
                                out("sar") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
                out
            }
        }
        #[cfg(target_feature = "s32c1i")]
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
                    let mut r: u32 = 0;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "ssl {shift}",                  // sar = for_sll(shift & 31)
                                "sll {mask}, {mask}",           // mask <<= sar
                                "sll {old}, {old}",             // old <<= sar
                                "sll {new}, {new}",             // new <<= sar
                                $release,                       // fence
                                "l32i.n {out}, {dst}, 0",       // atomic { out = *dst }
                                "2:", // 'retry:
                                    "and {tmp}, {out}, {mask}", // tmp = out & mask
                                    "bne {tmp}, {old}, 3f",     // if tmp != old { jump 'cmp-fail }
                                    "mov.n {tmp}, {out}",       // tmp = out
                                    "wsr {tmp}, scompare1",     // scompare1 = tmp
                                    "xor {out}, {tmp}, {new}",  // out = tmp ^ new
                                    "and {out}, {out}, {mask}", // out &= mask
                                    "xor {out}, {out}, {tmp}",  // out ^= tmp
                                    "s32c1i {out}, {dst}, 0",   // atomic { _x = *dst; if _x == scompare1 { *dst = out }; out = _x }
                                    "bne {tmp}, {out}, 2b",     // if tmp != out { jump 'retry }
                                    "movi {r}, 1",              // r = 1
                                "3:", // 'cmp-fail:
                                "ssr {shift}",                  // sar = for_srl(shift & 31)
                                "srl {out}, {out}",             // out >>= sar
                                $acquire,                       // fence
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) crate::utils::extend32::$ty::zero(old) => _,
                                new = inout(reg) crate::utils::extend32::$ty::zero(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) _,
                                r = inout(reg) r,
                                out("scompare1") _,
                                out("sar") _,
                                options(nostack, preserves_flags),
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

atomic_sub_word!(u8, "1", "8");
atomic_sub_word!(u16, "2", "16");
atomic!(u32, "4");

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
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_feature = "s32c1i")]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_feature = "s32c1i")]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(target_feature = "s32c1i"))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(target_feature = "s32c1i"))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_memcpy {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_memcpy {
    ($($tt:tt)*) => {};
}
