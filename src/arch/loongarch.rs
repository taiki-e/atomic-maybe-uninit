// SPDX-License-Identifier: Apache-2.0 OR MIT

// LoongArch
//
// Generated asm:
// - loongarch64 https://godbolt.org/z/r98136r1b

#[path = "cfgs/loongarch.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

#[rustfmt::skip]
macro_rules! atomic_load {
    ($int_type:ident, $asm_suffix:tt) => {
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
                                // (atomic) load from src to out
                                concat!("ld.", $asm_suffix, " {out}, {src}, 0"),
                                $acquire,
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        Ordering::Acquire => atomic_load!("dbar 20"),
                        Ordering::SeqCst => atomic_load!("dbar 16"),
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load!($int_type, $asm_suffix);
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
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // (atomic) store val to dst
                                concat!("st.", $asm_suffix, " {val}, {dst}, 0"),
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Release | Ordering::SeqCst => {
                            asm!(
                                // (atomic) store val to dst
                                concat!("amswap_db.", $asm_suffix, " $zero, {val}, {dst}"),
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        }
                        _ => unreachable!(),
                    }
                }
            }
        }
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // AMO is always SeqCst.
                    asm!(
                        // (atomic) swap (AMO)
                        // - load value from dst and store it to out
                        // - store value of val to dst
                        concat!("amswap_db.", $asm_suffix, " {out}, {val}, {dst}"),
                        dst = in(reg) ptr_reg!(dst),
                        val = in(reg) val,
                        out = out(reg) out,
                        options(nostack, preserves_flags),
                    )
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
                _success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($failure_fence:tt) => {
                            asm!(
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    concat!("ll.", $asm_suffix, " {out}, {dst}, 0"),
                                    "bne {out}, {old}, 3f", // compare and jump if compare failed
                                    "move {r}, {new}",
                                    concat!("sc.", $asm_suffix, " {r}, {dst}, 0"),
                                    "beqz {r}, 2b", // continue loop if store failed
                                    "b 4f",
                                "3:",
                                    $failure_fence,
                                "4:",
                                "xor {r}, {out}, {old}",
                                "sltui {r}, {r}, 1",
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    // LL/SC is always SeqCst, and fence is needed for branch that doesn't call sc.
                    match failure {
                        Ordering::Relaxed => cmpxchg!("dbar 1792"),
                        Ordering::Acquire => cmpxchg!("dbar 20"),
                        // TODO: LLVM uses dbar 20 (Acquire) here, but should it not be dbar 16 (SeqCst)?
                        Ordering::SeqCst => cmpxchg!("dbar 16"),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load!($int_type, $asm_suffix);
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
                    macro_rules! atomic_store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) store val to dst
                                $release,
                                concat!("st.", $asm_suffix, " {val}, {dst}, 0"),
                                $acquire,
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "dbar 18"),
                        Ordering::SeqCst => atomic_store!("dbar 16", "dbar 16"),
                        _ => unreachable!(),
                    }
                }
            }
        }
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "sll.w {mask}, {mask}, {shift}",
                        "addi.w {mask}, {mask}, 0",
                        "sll.w {val}, {val}, {shift}",
                        "addi.w {val}, {val}, 0",
                        // (atomic) swap (LL/SC loop)
                        "2:",
                            "ll.w {out}, {dst}, 0",
                            "addi.w {tmp}, {val}, 0",
                            "xor {tmp}, {out}, {tmp}",
                            "and {tmp}, {tmp}, {mask}",
                            "xor {tmp}, {out}, {tmp}",
                            "sc.w {tmp}, {dst}, 0",
                            "beqz {tmp}, 2b",
                        "srl.w {out}, {out}, {shift}",
                        dst = in(reg) ptr_reg!(dst),
                        val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
                        out = out(reg) out,
                        shift = in(reg) shift,
                        mask = inout(reg) mask => _,
                        tmp = out(reg) _,
                        options(nostack, preserves_flags),
                    );
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
                _success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($failure_fence:tt) => {
                            asm!(
                                "sll.w {new}, {new}, {shift}",
                                "addi.w {new}, {new}, 0",
                                "sll.w {old}, {old}, {shift}",
                                "addi.w $a7, {old}, 0",
                                "sll.w {mask}, {mask}, {shift}",
                                "addi.w $a6, {mask}, 0",
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    "ll.w $t0, {dst}, 0",
                                    "and $t1, $t0, $a6",
                                    "bne $t1, $a7, 3f",
                                    "andn $t1, $t0, $a6",
                                    "or $t1, $t1, {new}",
                                    "sc.w $t1, {dst}, 0",
                                    "beqz $t1, 2b",
                                    "b 4f",
                                "3:",
                                    $failure_fence,
                                "4:",
                                "srl.w $a6, $t0, {shift}",
                                "and {r}, $t0, {mask}",
                                "addi.w {r}, {r}, 0",
                                "xor {r}, {old}, {r}",
                                "sltui {r}, {r}, 1",
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) crate::utils::ZeroExtend::zero_extend(old) => _,
                                new = inout(reg) crate::utils::ZeroExtend::zero_extend(new) => _,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                r = lateout(reg) r,
                                out("$a6") out,
                                out("$a7") _,
                                out("$t0") _,
                                out("$t1") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    // LL/SC is always SeqCst, and fence is needed for branch that doesn't call sc.
                    match failure {
                        Ordering::Relaxed => cmpxchg!("dbar 1792"),
                        Ordering::Acquire => cmpxchg!("dbar 20"),
                        // TODO: LLVM uses dbar 20 (Acquire) here, but should it not be dbar 16 (SeqCst)?
                        Ordering::SeqCst => cmpxchg!("dbar 16"),
                        _ => unreachable!(),
                    }
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
atomic!(i32, "w");
atomic!(u32, "w");
#[cfg(target_arch = "loongarch64")]
atomic!(i64, "d");
#[cfg(target_arch = "loongarch64")]
atomic!(u64, "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "w");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "w");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d");
