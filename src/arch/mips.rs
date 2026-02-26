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

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap},
    utils::RegSize,
};

macro_rules! sllv {
    ($val:expr, $shift:expr) => {{
        let mut val = $val;
        let shift: RegSize = $shift;
        #[allow(unused_unsafe)]
        // SAFETY: calling SLLV is safe
        unsafe {
            asm!(
                ".set push",
                ".set noat",
                "sllv {val}, {val}, {shift}", // val <<= shift & 31
                ".set pop",
                val = inout(reg) val,
                shift = in(reg) shift,
                options(pure, nomem, nostack, preserves_flags),
            );
        }
        val
    }};
}
#[inline(always)]
fn srlv(mut val: MaybeUninit<u32>, shift: RegSize) -> MaybeUninit<u32> {
    // SAFETY: calling SRLV is safe
    unsafe {
        asm!(
            ".set push",
            ".set noat",
            "srlv {val}, {val}, {shift}", // val >>= shift & 31
            ".set pop",
            val = inout(reg) val,
            shift = in(reg) shift,
            options(pure, nomem, nostack, preserves_flags),
        );
    }
    val
}

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

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $suffix:tt, $l_u_suffix:tt) => {
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
                                concat!("l", $suffix, " {out}, 0({src})"), // atomic { out = sign_extend(*src) }
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
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $suffix:tt, $ll_sc_suffix:tt) => {
        atomic_load_store!($ty, $suffix, "");
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
                                    concat!("ll", $ll_sc_suffix, " {out}, 0({dst})"), // atomic { out = sign_extend(*dst); LL = dst }
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
                    let mut r: RegSize = 0;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                $release,                                             // fence
                                "2:", // 'retry:
                                    concat!("ll", $ll_sc_suffix, " {out}, 0({dst})"), // atomic { out = sign_extend(*dst); LL = dst }
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
    ($ty:ident, $suffix:tt) => {
        atomic_load_store!($ty, $suffix, "u");
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                #[allow(clippy::cast_possible_truncation)]
                let mask = mask as u32;
                let mut out: MaybeUninit<u32>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                $release,                       // fence
                                "2:", // 'retry:
                                    "ll {out}, 0({dst})",       // atomic { out = sign_extend(*dst); LL = dst }
                                    "and {tmp}, {out}, {mask}", // tmp = out & mask
                                    "or {tmp}, {tmp}, {val}",   // tmp |= val
                                    "sc {tmp}, 0({dst})",       // atomic { if LL == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; LL = None }
                                    "beqz {tmp}, 2b",           // if tmp == 0 { jump 'retry }
                                $acquire,                       // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) sllv!(crate::utils::extend32::$ty::zero(val), shift),
                                out = out(reg) out,
                                mask = in(reg) !sllv!(mask, shift),
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
                crate::utils::extend32::$ty::extract(srlv(out, shift))
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
                let mut out: MaybeUninit<u32>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: RegSize = 0;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                $release,                       // fence
                                "2:", // 'retry:
                                    "ll {out}, 0({dst})",       // atomic { out = sign_extend(*dst); LL = dst }
                                    "and {tmp}, {out}, {mask}", // tmp = out & mask
                                    "bne {tmp}, {old}, 3f",     // if tmp != old { jump 'cmp-fail }
                                    "xor {r}, {out}, {new}",    // r = out ^ new
                                    "and {r}, {r}, {mask}",     // r &= mask
                                    "xor {r}, {r}, {out}",      // r ^= out
                                    "sc {r}, 0({dst})",         // atomic { if LL == dst { *dst = r; r = 1 } else { r = 0 }; LL = None }
                                    "beqz {r}, 2b",             // if r == 0 { jump 'retry }
                                "3:", // 'cmp-fail:
                                $acquire,                       // fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) sllv!(crate::utils::extend32::$ty::zero(old), shift),
                                new = in(reg) sllv!(crate::utils::extend32::$ty::zero(new), shift),
                                out = out(reg) out,
                                mask = in(reg) sllv!(mask, shift),
                                tmp = out(reg) _,
                                r = inout(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (crate::utils::extend32::$ty::extract(srlv(out, shift)), r != 0)
                }
            }
        }
    };
}

atomic_sub_word!(u8, "b");
atomic_sub_word!(u16, "h");
atomic!(u32, "w", "");
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
atomic!(u64, "d", "d");

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
