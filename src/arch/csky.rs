// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
C-SKY

Refs:
- CSKY Architecture user_guide
  https://github.com/c-sky/csky-doc/blob/9f7121f7d40970ba5cc0f15716da033db2bb9d07/CSKY%20Architecture%20user_guide.pdf
- Linux kernel's C-SKY atomic implementation
  https://github.com/torvalds/linux/blob/v6.16/arch/csky/include/asm/atomic.h
  https://github.com/torvalds/linux/blob/v6.16/arch/csky/include/asm/barrier.h
  https://github.com/torvalds/linux/blob/v6.16/arch/csky/include/asm/cmpxchg.h

Generated asm:
- csky https://godbolt.org/z/jK4c68WeG
*/

#[cfg(atomic_maybe_uninit_no_ldex_stex)]
delegate_size!(delegate_load_store);
#[cfg(not(atomic_maybe_uninit_no_ldex_stex))]
delegate_size!(delegate_all);

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

#[cfg(not(atomic_maybe_uninit_no_ldex_stex))]
use crate::raw::{AtomicCompareExchange, AtomicSwap};
use crate::{
    consume::Dependent,
    raw::{AtomicLoad, AtomicStore},
};

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("sync32", ""),
            Ordering::Release => $op!("", "sync32"),
            Ordering::AcqRel | Ordering::SeqCst => $op!("sync32", "sync32"),
            _ => unreachable!(),
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $suffix:tt) => {
        #[cfg(atomic_maybe_uninit_no_ldex_stex)]
        delegate_signed!(delegate_load_store, $ty);
        #[cfg(not(atomic_maybe_uninit_no_ldex_stex))]
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
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                          // fence
                                concat!("ld32.", $suffix, " {out}, ({src}, 0x0)"), // atomic { out = *src }
                                $acquire,                                          // fence
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("sync32", ""),
                        Ordering::SeqCst => atomic_load!("sync32", "sync32"),
                        _ => unreachable!(),
                    }
                }
                out
            }
            #[inline]
            unsafe fn atomic_load_consume(
                src: *const MaybeUninit<Self>,
            ) -> Dependent<MaybeUninit<Self>> {
                let out: MaybeUninit<Self>;
                let dep;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("ld32.", $suffix, " {out}, ({src}, 0)"), // atomic { out = *src }
                        "xor32 {dep}, {out}, {out}",                     // dep = out ^ out
                        src = in(reg) src,
                        out = lateout(reg) out,
                        dep = lateout(reg) dep,
                        options(nostack, preserves_flags),
                    );
                }
                Dependent::from_parts(out, dep)
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
                                $release,                                          // fence
                                concat!("st32.", $suffix, " {val}, ({dst}, 0x0)"), // atomic { *dst = val }
                                $acquire,                                          // fence
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
    ($ty:ident) => {
        atomic_load_store!($ty, "w");
        #[cfg(not(atomic_maybe_uninit_no_ldex_stex))]
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
                                $release,                         // fence
                                "2:", // 'retry:
                                    "ldex32.w {out}, ({dst}, 0)", // atomic { out = *dst; EXCLUSIVE = dst }
                                    "or32 {tmp}, {val}, {val}",   // tmp = val
                                    "stex32.w {tmp}, ({dst}, 0)", // atomic { if EXCLUSIVE == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; EXCLUSIVE = None }
                                    "bez32 {tmp}, 2b",            // if tmp == 0 { jump 'retry }
                                $acquire,                         // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
                out
            }
        }
        #[cfg(not(atomic_maybe_uninit_no_ldex_stex))]
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
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: u32 = 0;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                         // fence
                                "2:", // 'retry:
                                    "ldex32.w {out}, ({dst}, 0)", // atomic { out = *dst; EXCLUSIVE = dst }
                                    "cmpne32 {out}, {old}",       // if out != old { C = 1 } else { C = 0 }
                                    "bt32 3f",                    // if C == 1 { jump 'cmp-fail }
                                    "or32 {tmp}, {new}, {new}",   // tmp = new
                                    "stex32.w {tmp}, ({dst}, 0)", // atomic { if EXCLUSIVE == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; EXCLUSIVE = None }
                                    "bez32 {tmp}, 2b",            // if tmp == 0 { jump 'retry }
                                "3:", // 'cmp-fail:
                                $acquire,                         // fence
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                tmp = inout(reg) r,
                                // Do not use `preserves_flags` because CMPNE modifies condition bit C.
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
        atomic_load_store!($ty, $suffix);
        #[cfg(not(atomic_maybe_uninit_no_ldex_stex))]
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
                            // Implement sub-word atomic operations using word-sized LL/SC loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "lsl32 {val}, {val}, {shift}",     // val <<= shift
                                $release,                          // fence
                                "2:", // 'retry:
                                    "ldex32.w {out}, ({dst}, 0)",  // atomic { out = *dst; EXCLUSIVE = dst }
                                    "andn32 {tmp}, {out}, {mask}", // tmp = out & !mask
                                    "or32 {tmp}, {tmp}, {val}",    // tmp |= val
                                    "stex32.w {tmp}, ({dst}, 0)",  // atomic { if EXCLUSIVE == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; EXCLUSIVE = None }
                                    "bez32 {tmp}, 2b",             // if tmp == 0 { jump 'retry }
                                $acquire,                          // fence
                                "lsr32 {out}, {out}, {shift}",     // out >>= shift
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) crate::utils::zero_extend32::$ty(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = in(reg) mask,
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
                out
            }
        }
        #[cfg(not(atomic_maybe_uninit_no_ldex_stex))]
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
                    let mut r: u32;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            // Implement sub-word atomic operations using word-sized LL/SC loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "lsl32 {old}, {old}, {shift}",     // old <<= shift
                                "lsl32 {new}, {new}, {shift}",     // new <<= shift
                                $release,                          // fence
                                "2:", // 'retry:
                                    "ldex32.w {tmp}, ({dst}, 0)",  // atomic { tmp = *dst; EXCLUSIVE = dst }
                                    "and32 {out}, {tmp}, {mask}",  // out = tmp & mask
                                    "cmpne32 {out}, {old}",        // if out != old { C = 1 } else { C = 0 }
                                    "bt32 3f",                     // if C == 1 { jump 'cmp-fail }
                                    "andn32 {tmp}, {tmp}, {mask}", // tmp &= !mask
                                    "or32 {tmp}, {tmp}, {new}",    // tmp |= new
                                    "stex32.w {tmp}, ({dst}, 0)",  // atomic { if EXCLUSIVE == dst { *dst = tmp; tmp = 1 } else { tmp = 0 }; EXCLUSIVE = None }
                                    "bez32 {tmp}, 2b",             // if tmp == 0 { jump 'retry }
                                    "br32 4f",                     // jump 'success
                                "3:", // 'cmp-fail:
                                    "movi32 {tmp}, 0",             // tmp = 0
                                "4:", // 'success:
                                $acquire,                          // fence
                                "lsr32 {out}, {out}, {shift}",     // out >>= shift
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) crate::utils::zero_extend32::$ty(old) => _,
                                new = inout(reg) crate::utils::zero_extend32::$ty(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = in(reg) mask,
                                tmp = out(reg) r,
                                // Do not use `preserves_flags` because CMPNE modifies condition bit C.
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

atomic_sub_word!(u8, "b");
atomic_sub_word!(u16, "h");
atomic!(u32);

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
#[cfg(not(atomic_maybe_uninit_no_ldex_stex))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(atomic_maybe_uninit_no_ldex_stex))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(atomic_maybe_uninit_no_ldex_stex)]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(atomic_maybe_uninit_no_ldex_stex)]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_fast_consume {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_fast_consume {
    ($($tt:tt)*) => {};
}
