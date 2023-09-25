// SPDX-License-Identifier: Apache-2.0 OR MIT

// MIPS32 and MIPS64
//
// Generated asm:
// - mips https://godbolt.org/z/hbK74Y17c
// - mipsel https://godbolt.org/z/aoazd4rjY
// - mips64 https://godbolt.org/z/18ees8xqx
// - mips64el https://godbolt.org/z/rrcP1o19q

#[path = "partword.rs"]
mod partword;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

// TODO: we can add options(preserves_flags) to some of asm!

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("sync", ""),
            Ordering::Release => $op!("", "sync"),
            // AcqRel and SeqCst RMWs are equivalent.
            Ordering::AcqRel | Ordering::SeqCst => $op!("sync", "sync"),
            _ => unreachable!("{:?}", $order),
        }
    };
}

#[cfg(any(target_arch = "mips", target_arch = "mips32r6"))]
type XSize = u32;
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
type XSize = u64;

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($int_type:ident, $asm_suffix:tt, $l_u_suffix:tt) => {
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
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // (atomic) load from src to out
                                concat!("l", $asm_suffix, " {out}, 0({src})"),
                                $acquire,
                                ".set pop",
                                src = in(reg) ptr_reg!(src),
                                out = out(reg) out,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("sync"),
                        _ => unreachable!("{:?}", order),
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
                    macro_rules! store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // (atomic) store val to dst
                                $release, // release fence
                                concat!("s", $asm_suffix, " {val}, 0({dst})"),
                                $acquire, // acquire fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack),
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
    ($int_type:ident, $asm_suffix:tt, $ll_sc_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, "");
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
                                ".set push",
                                ".set noat",
                                // (atomic) swap (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to out
                                    concat!("ll", $ll_sc_suffix, " {out}, 0({dst})"),
                                    "move {r}, {val}",
                                    // try to store val to dst
                                    concat!("sc", $ll_sc_suffix, " {r}, 0({dst})"),
                                    // 1 if the store was successful, 0 if no store was performed
                                    "beqz {r}, 2b",
                                $acquire, // acquire fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                r = out(reg) _,
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: XSize;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // (atomic) CAS (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to out
                                    concat!("ll", $ll_sc_suffix, " {out}, 0({dst})"),
                                    "bne {out}, {old}, 3f", // compare and jump if compare failed
                                    "move {r}, {new}",
                                    // try to store new to dst
                                    concat!("sc", $ll_sc_suffix, " {r}, 0({dst})"),
                                    // 1 if the store was successful, 0 if no store was performed
                                    "beqz {r}, 2b", // continue loop if store failed
                                "3:",
                                $acquire, // acquire fence
                                "xor {new}, {out}, {old}",
                                "sltiu {r}, {new}, 1",
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = out(reg) out,
                                r = out(reg) r,
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    (out, r != 0)
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($int_type:ident, $asm_suffix:tt, $max:tt) => {
        atomic_load_store!($int_type, $asm_suffix, "u");
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (aligned_ptr, shift, mask) = partword::create_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also partword.rs.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                "sllv {mask}, {mask}, {shift}",
                                "sllv {val}, {val}, {shift}",
                                "and {val}, {val}, {mask}",
                                "nor {inv_mask}, $zero, {mask}",
                                // (atomic) swap (LL/SC loop)
                                $release,
                                "2:",
                                    "ll {out}, 0({dst})",
                                    "and {tmp}, {out}, {inv_mask}",
                                    "or {tmp}, {tmp}, {val}",
                                    "sc {tmp}, 0({dst})",
                                    "beqz {tmp}, 2b",
                                "and {out}, {out}, {mask}",
                                "srlv {out}, {out}, {shift}",
                                concat!("se", $asm_suffix, " {out}, {out}"),
                                $acquire,
                                ".set pop",
                                dst = in(reg) ptr_reg!(aligned_ptr),
                                val = inout(reg) crate::utils::zero_extend(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                inv_mask = out(reg) _,
                                tmp = out(reg) _,
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let (aligned_ptr, shift, _mask) = partword::create_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: XSize = 1;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also partword.rs.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                concat!("ori {mask}, $zero, ", $max),
                                concat!("andi {old}, {old}, ", $max),
                                concat!("andi {new}, {new}, ", $max),
                                "sllv {mask}, {mask}, {shift}",
                                "sllv {old}, {old}, {shift}",
                                "sllv {new}, {new}, {shift}",
                                "nor {inv_mask}, $zero, {mask}",
                                // (atomic) CAS (LL/SC loop)
                                $release,
                                "2:",
                                    "ll {tmp}, 0({dst})",
                                    "and {out}, {tmp}, {mask}",
                                    "bne {out}, {old}, 3f",
                                    "and {tmp}, {tmp}, {inv_mask}",
                                    "or {tmp}, {tmp}, {new}",
                                    "sc {tmp}, 0({dst})",
                                    "beqz {tmp}, 2b",
                                    "b 4f",
                                "3:",
                                    "li {r}, 0",
                                "4:",
                                "srlv {out}, {out}, {shift}",
                                concat!("se", $asm_suffix, " {out}, {out}"),
                                $acquire,
                                ".set pop",
                                dst = in(reg) ptr_reg!(aligned_ptr),
                                old = inout(reg) old => _,
                                new = inout(reg) crate::utils::zero_extend(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = out(reg) _,
                                inv_mask = out(reg) _,
                                tmp = out(reg) _,
                                r = inout(reg) r,
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    (out, r != 0)
                }
            }
        }
    };
}

atomic_sub_word!(i8, "b", "255");
atomic_sub_word!(u8, "b", "255");
atomic_sub_word!(i16, "h", "65535");
atomic_sub_word!(u16, "h", "65535");
atomic!(i32, "w", "");
atomic!(u32, "w", "");
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
atomic!(i64, "d", "d");
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
atomic!(u64, "d", "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "w", "");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "w", "");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d", "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d", "d");

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
