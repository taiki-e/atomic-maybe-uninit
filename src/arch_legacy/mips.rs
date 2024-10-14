// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
MIPS32 and MIPS64

Generated asm:
- mips https://godbolt.org/z/38oKcY5bj
- mipsel https://godbolt.org/z/M18x694zh
- mips64 https://godbolt.org/z/GMMda9rM8
- mips64el https://godbolt.org/z/31ovT3vzW
*/

#[path = "../arch/cfgs/mips.rs"]
mod cfgs;

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
            _ => unreachable!(),
        }
    };
}

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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // (atomic) load from src to tmp
                                concat!("l", $asm_suffix, " {tmp}, 0({src})"),
                                $acquire,
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                ".set pop",
                                src = in(reg) ptr_reg!(src),
                                out = in(reg) ptr_reg!(out_ptr),
                                tmp = out(reg) _,
                                options(nostack),
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
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // load from val to tmp
                                concat!("l", $asm_suffix, $l_u_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                $release, // release fence
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                $acquire, // acquire fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) ptr_reg!(val),
                                tmp = out(reg) _,
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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // load from val to val_tmp
                                concat!("l", $asm_suffix, " {val_tmp}, 0({val})"),
                                // (atomic) swap (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ll", $ll_sc_suffix, " {out_tmp}, 0({dst})"),
                                    "move {r}, {val_tmp}",
                                    // try to store val to dst
                                    concat!("sc", $ll_sc_suffix, " {r}, 0({dst})"),
                                    // 1 if the store was successful, 0 if no store was performed
                                    "beqz {r}, 2b",
                                $acquire, // acquire fence
                                // store out_tmp to out
                                concat!("s", $asm_suffix, " {out_tmp}, 0({out})"),
                                ".set pop",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                val_tmp = out(reg) _,
                                out_tmp = out(reg) _,
                                r = lateout(reg) _,
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
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // load from old/new to old_tmp/new_tmp
                                concat!("l", $asm_suffix, " {old_tmp}, 0({old})"),
                                concat!("l", $asm_suffix, " {new_tmp}, 0({new})"),
                                // (atomic) CAS (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ll", $ll_sc_suffix, " {out_tmp}, 0({dst})"),
                                    "bne {out_tmp}, {old_tmp}, 3f", // compare and jump if compare failed
                                    "move {r}, {new_tmp}",
                                    // try to store new to dst
                                    concat!("sc", $ll_sc_suffix, " {r}, 0({dst})"),
                                    // 1 if the store was successful, 0 if no store was performed
                                    "beqz {r}, 2b", // continue loop if store failed
                                "3:",
                                $acquire, // acquire fence
                                "xor {new_tmp}, {out_tmp}, {old_tmp}",
                                // store out_tmp to out
                                concat!("s", $asm_suffix, " {out_tmp}, 0({out})"),
                                "sltiu {r}, {new_tmp}, 1",
                                ".set pop",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                old = in(reg) ptr_reg!(old),
                                new = in(reg) ptr_reg!(new),
                                out = inout(reg) ptr_reg!(out_ptr) => _,
                                new_tmp = out(reg) _,
                                old_tmp = out(reg) _,
                                out_tmp = out(reg) _,
                                r = lateout(reg) r,
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
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                concat!("l", $asm_suffix, "u {tmp}, 0($5)"),
                                "sllv $7, {tmp}, {shift}",
                                "nor $5, $zero, {mask}",
                                // (atomic) swap (LL/SC loop)
                                $release,
                                "2:",
                                    "ll $8, 0({dst})",
                                    "and $9, $7, {mask}",
                                    "and $10, $8, $5",
                                    "or $10, $10, $9",
                                    "sc $10, 0({dst})",
                                    "beqz $10, 2b",
                                "and {tmp}, $8, {mask}",
                                "srlv {tmp}, {tmp}, {shift}",
                                concat!("se", $asm_suffix, " {tmp}, {tmp}"),
                                $acquire,
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                out = in(reg) ptr_reg!(out_ptr),
                                shift = in(reg) shift,
                                mask = in(reg) mask,
                                tmp = out(reg) _,
                                inout("$5") ptr_reg!(val) => _, // val => inv_mask
                                out("$7") _,
                                out("$8") _,
                                out("$9") _,
                                out("$10") _,
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
                let (dst, shift, _mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                concat!("l", $asm_suffix, "u $2, 0($6)"), // new
                                concat!("l", $asm_suffix, " {tmp}, 0($5)"),  // old
                                concat!("ori $5, $zero, ", $max),
                                concat!("andi $8, {tmp}, ", $max),
                                concat!("andi $2, $2, ", $max),
                                "sllv $5, $5, {shift}",
                                "sllv $8, $8, {shift}",
                                "sllv $9, $2, {shift}",
                                "nor $6, $zero, $5",
                                // (atomic) CAS (LL/SC loop)
                                $release,
                                "2:",
                                    "ll $10, 0({dst})",
                                    "and $11, $10, $5",
                                    "bne $11, $8, 3f",
                                    "and $10, $10, $6",
                                    "or $10, $10, $9",
                                    "sc $10, 0({dst})",
                                    "beqz $10, 2b",
                                "3:",
                                "srlv $2, $11, {shift}",
                                concat!("se", $asm_suffix, " $2, $2"),
                                $acquire,
                                "xor {tmp}, $2, {tmp}",
                                concat!("s", $asm_suffix, " $2, 0({out})"),
                                "sltiu $2, {tmp}, 1",
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                out = in(reg) ptr_reg!(out_ptr),
                                shift = in(reg) shift,
                                tmp = out(reg) _,
                                out("$2") r,
                                inout("$5") ptr_reg!(old) => _, // old => mask
                                inout("$6") ptr_reg!(new) => _, // new => inv_mask
                                out("$8") _,
                                out("$9") _,
                                out("$10") _,
                                out("$11") _,
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
