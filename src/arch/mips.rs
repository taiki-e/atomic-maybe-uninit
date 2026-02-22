// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
MIPS32 and MIPS64

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#mips

Refs:
- The MIPS32® Instruction Set Manual, Revision 6.06 (MD00086)
  https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00086-2B-MIPS32BIS-AFP-6.06.pdf
- The MIPS64® Instruction Set Reference Manual, Revision 6.06 (MD00087)
  https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00087-2B-MIPS64BIS-AFP-6.06.pdf
- MIPS® Coherence Protocol Specification, Revision 01.01 (MD00605)
  https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00605-2B-CMPCOHERE-AFP-01.01.pdf

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

delegate_size!(delegate_all);

#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
use core::cell::UnsafeCell;
pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap};

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("sync", ""),
            Ordering::Release => $op!("", "sync"),
            // AcqRel and SeqCst RMWs are equivalent.
            Ordering::AcqRel | Ordering::SeqCst => $op!("sync", "sync"),
            _ => unreachable!(),
        }
    };
}

#[cfg(any(target_arch = "mips", target_arch = "mips32r6"))]
macro_rules! daddiu {
    () => {
        "addiu"
    };
}
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
macro_rules! daddiu {
    () => {
        "daddiu"
    };
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $($size:literal)?, $suffix:tt, $l_u_suffix:tt) => {
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
                                ".set push",
                                ".set noat",
                                concat!("l", $suffix, " {out}, 0({src})"), // atomic { out = *src }
                                $acquire,                                  // fence
                                ".set pop",
                                src = in(reg) ptr_reg!(src),
                                out = out(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("sync"),
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
                    macro_rules! store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                $release,                                  // fence
                                concat!("s", $suffix, " {val}, 0({dst})"), // atomic { *dst = val }
                                $acquire,                                  // fence
                                ".set pop",
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
        $(
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    ".set push",
                    ".set noat",
                    concat!("l", $suffix, " {tmp0}, 0({src})"),   // atomic { tmp0 = *src }
                    concat!(daddiu!(), " {src}, {src}, ", $size), // src = src.byte_add($size)
                    ".set pop",
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    ".set push",
                    ".set noat",
                    concat!("l", $suffix, " {tmp1}, ", $size, "({src})"), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("l", $suffix, " {tmp0}, 0({src})"),           // atomic { tmp0 = *src }
                    concat!(daddiu!(), " {src}, {src}, 2*", $size),       // src = src.byte_add(2*$size)
                    ".set pop",
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    ".set push",
                    ".set noat",
                    concat!("s", $suffix, " {tmp0}, 0({dst})"),   // atomic { *dst = tmp0 }
                    concat!(daddiu!(), " {dst}, {dst}, ", $size), // dst = dst.byte_add($size)
                    ".set pop",
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    ".set push",
                    ".set noat",
                    concat!("s", $suffix, " {tmp1}, ", $size, "({dst})"), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("s", $suffix, " {tmp0}, 0({dst})"),           // atomic { *dst = tmp0 }
                    concat!(daddiu!(), " {dst}, {dst}, 2*", $size),       // dst = dst.byte_add(2*$size)
                    ".set pop",
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
    ($ty:ident, $($size:literal)?, $suffix:tt, $ll_sc_suffix:tt) => {
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
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                $release,                                             // fence
                                "2:", // 'retry:
                                    concat!("ll", $ll_sc_suffix, " {out}, 0({dst})"), // atomic { out = *dst; LL = dst }
                                    "move {r}, {val}",                                // r = val
                                    concat!("sc", $ll_sc_suffix, " {r}, 0({dst})"),   // atomic { if LL == dst { *dst = r; r = 1 } else { r = 0 }; LL = None }
                                    "beqz {r}, 2b",                                   // if r == 0 { jump 'retry }
                                $acquire,                                             // fence
                                ".set pop",
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize = 0;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                $release,                                             // fence
                                "2:", // 'retry:
                                    concat!("ll", $ll_sc_suffix, " {out}, 0({dst})"), // atomic { out = *dst; LL = dst }
                                    "bne {out}, {old}, 3f",                           // if out != old { jump 'cmp-fail }
                                    "move {r}, {new}",                                // r = new
                                    concat!("sc", $ll_sc_suffix, " {r}, 0({dst})"),   // atomic { if LL == dst { *dst = r; r = 1 } else { r = 0 }; LL = None }
                                    "beqz {r}, 2b",                                   // if r == 0 { jump 'retry }
                                "3:", // 'cmp-fail:
                                $acquire,                                             // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = inout(reg) r,
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
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                "sllv {mask}, {mask}, {shift}", // mask <<= shift & 31
                                "sllv {val}, {val}, {shift}",   // val <<= shift & 31
                                "nor {mask}, {mask}, $zero",    // mask = !mask
                                $release,                       // fence
                                "2:", // 'retry:
                                    "ll {out}, 0({dst})",       // atomic { out = *dst; LL = dst }
                                    "and {r}, {out}, {mask}",   // r = out & mask
                                    "or {r}, {r}, {val}",       // r |= val
                                    "sc {r}, 0({dst})",         // atomic { if LL == dst { *dst = r; r = 1 } else { r = 0 }; LL = None }
                                    "beqz {r}, 2b",             // if r == 0 { jump 'retry }
                                "srlv {out}, {out}, {shift}",   // out >>= shift & 31
                                $acquire,                       // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) crate::utils::extend32::$ty::zero(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
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
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize = 0;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                "sllv {mask}, {mask}, {shift}", // mask <<= shift & 31
                                "sllv {old}, {old}, {shift}",   // old <<= shift & 31
                                "sllv {new}, {new}, {shift}",   // new <<= shift & 31
                                $release,                       // fence
                                "2:", // 'retry:
                                    "ll {out}, 0({dst})",       // atomic { out = *dst; LL = dst }
                                    "and {tmp}, {out}, {mask}", // tmp = out & mask
                                    "bne {tmp}, {old}, 3f",     // if tmp != old { jump 'cmp-fail }
                                    "xor {r}, {out}, {new}",    // r = out ^ new
                                    "and {r}, {r}, {mask}",     // r &= mask
                                    "xor {r}, {r}, {out}",      // r ^= out
                                    "sc {r}, 0({dst})",         // atomic { if LL == dst { *dst = r; r = 1 } else { r = 0 }; LL = None }
                                    "beqz {r}, 2b",             // if r == 0 { jump 'retry }
                                "3:", // 'cmp-fail:
                                "srlv {out}, {out}, {shift}",   // out >>= shift & 31
                                $acquire,                       // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) crate::utils::extend32::$ty::zero(old) => _,
                                new = inout(reg) crate::utils::extend32::$ty::zero(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) _,
                                r = inout(reg) r,
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

atomic_sub_word!(u8, "1", "b");
atomic_sub_word!(u16, "2", "h");
atomic!(u32, "4", "w", "");
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
atomic!(u64,    , "d", "d");

#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
impl AtomicMemcpy for u64 {
    load_memcpy_opt64! { |src, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7|
        asm!(
            ".set push",
            ".set noat",
            "ld {tmp0}, 0({src})",      // atomic { tmp0 = *src }
            "daddiu {src}, {src}, 8",   // src = src.byte_add(8)
            ".set pop",
            src = inout(reg) src,
            tmp0 = out(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            ".set push",
            ".set noat",
            "ld {tmp1}, 8({src})",      // atomic { tmp1 = *src.byte_add(8) }
            "ld {tmp0}, 0({src})",      // atomic { tmp0 = *src }
            "daddiu {src}, {src}, 2*8", // src = src.byte_add(2*8)
            ".set pop",
            src = inout(reg) src,
            tmp0 = out(reg) tmp0,
            tmp1 = out(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            ".set push",
            ".set noat",
            "ld {tmp7}, 8*7({src})",    // atomic { tmp7 = *src.byte_add(8*7) }
            "ld {tmp6}, 8*6({src})",    // atomic { tmp6 = *src.byte_add(8*6) }
            "ld {tmp5}, 8*5({src})",    // atomic { tmp5 = *src.byte_add(8*5) }
            "ld {tmp4}, 8*4({src})",    // atomic { tmp4 = *src.byte_add(8*4) }
            "ld {tmp3}, 8*3({src})",    // atomic { tmp3 = *src.byte_add(8*3) }
            "ld {tmp2}, 8*2({src})",    // atomic { tmp2 = *src.byte_add(8*2) }
            "ld {tmp1}, 8*1({src})",    // atomic { tmp1 = *src.byte_add(8*1) }
            "ld {tmp0}, 0({src})",      // atomic { tmp0 = *src }
            "daddiu {src}, {src}, 8*8", // src = src.byte_add(8*8)
            ".set pop",
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
            ".set push",
            ".set noat",
            "sd {tmp0}, 0({dst})",      // atomic { *dst = tmp0 }
            "daddiu {dst}, {dst}, 8",   // dst = dst.byte_add(8)
            ".set pop",
            dst = inout(reg) dst,
            tmp0 = in(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            ".set push",
            ".set noat",
            "sd {tmp1}, 8({dst})",      // atomic { *dst.byte_add(8) = tmp1 }
            "sd {tmp0}, 0({dst})",      // atomic { *dst = tmp0 }
            "daddiu {dst}, {dst}, 2*8", // dst = dst.byte_add(2*8)
            ".set pop",
            dst = inout(reg) dst,
            tmp0 = in(reg) tmp0,
            tmp1 = in(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            ".set push",
            ".set noat",
            "sd {tmp7}, 8*7({dst})",    // atomic { *dst.byte_add(8*7) = tmp7 }
            "sd {tmp6}, 8*6({dst})",    // atomic { *dst.byte_add(8*6) = tmp6 }
            "sd {tmp5}, 8*5({dst})",    // atomic { *dst.byte_add(8*5) = tmp5 }
            "sd {tmp4}, 8*4({dst})",    // atomic { *dst.byte_add(8*4) = tmp4 }
            "sd {tmp3}, 8*3({dst})",    // atomic { *dst.byte_add(8*3) = tmp3 }
            "sd {tmp2}, 8*2({dst})",    // atomic { *dst.byte_add(8*2) = tmp2 }
            "sd {tmp1}, 8*1({dst})",    // atomic { *dst.byte_add(8*1) = tmp1 }
            "sd {tmp0}, 0({dst})",      // atomic { *dst = tmp0 }
            "daddiu {dst}, {dst}, 8*8", // dst = dst.byte_add(8*8)
            ".set pop",
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
#[cfg(any(target_arch = "mips", target_arch = "mips32r6"))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(any(target_arch = "mips", target_arch = "mips32r6"))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
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
