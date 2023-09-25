// SPDX-License-Identifier: Apache-2.0 OR MIT

// RISC-V
//
// Refs:
// - RISC-V Atomics ABI Specification
//   https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/HEAD/riscv-atomic.adoc
// - "Mappings from C/C++ primitives to RISC-V primitives." table in RISC-V Instruction Set Manual:
//   https://five-embeddev.com/riscv-isa-manual/latest/memory.html#sec:memory:porting
// - RISC-V Instruction Set Specifications https://msyksphinz-self.github.io/riscv-isadoc/html/index.html
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - riscv64gc https://godbolt.org/z/b8M8njGE5
// - riscv32imac https://godbolt.org/z/en6ThT6h9

#[path = "cfgs/riscv.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
use crate::raw::{AtomicCompareExchange, AtomicSwap};
use crate::raw::{AtomicLoad, AtomicStore};

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv32")]
macro_rules! w {
    () => {
        ""
    };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv64")]
macro_rules! w {
    () => {
        "w"
    };
}

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
macro_rules! atomic_rmw_amo {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!(""),
            Ordering::Acquire => $op!(".aq"),
            Ordering::Release => $op!(".rl"),
            // AcqRel and SeqCst RMWs are equivalent.
            Ordering::AcqRel | Ordering::SeqCst => $op!(".aqrl"),
            _ => unreachable!("{:?}", $order),
        }
    };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
macro_rules! atomic_rmw_lr_sc {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!(".aq", ""),
            Ordering::Release => $op!("", ".rl"),
            Ordering::AcqRel => $op!(".aq", ".rl"),
            Ordering::SeqCst => $op!(".aqrl", ".rl"),
            _ => unreachable!("{:?}", $order),
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
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
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) load from src to out
                                $release,
                                concat!("l", $asm_suffix, " {out}, 0({src})"),
                                $acquire,
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("fence r, rw", ""),
                        Ordering::SeqCst => atomic_load!("fence r, rw", "fence rw, rw"),
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
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // (atomic) store val to dst
                                $release,
                                concat!("s", $asm_suffix, " {val}, 0({dst})"),
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        // Release and SeqCst stores are equivalent.
                        Ordering::Release | Ordering::SeqCst => atomic_store!("fence rw, w"),
                        _ => unreachable!("{:?}", order),
                    }
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix);
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($order:tt) => {
                            asm!(
                                // (atomic) swap (AMO)
                                // - load value from dst and store it to out
                                // - store value of val to dst
                                concat!("amoswap.", $asm_suffix, $order, " {out}, {val}, 0({dst})"),
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) val => _,
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_amo!(swap, order);
                }
                out
            }
        }
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
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
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) CAS (LR/SC loop)
                                "2:",
                                    concat!("lr.", $asm_suffix, $acquire, " {out}, 0({dst})"),
                                    "bne {out}, {old}, 3f", // compare and jump if compare failed
                                    concat!("sc.", $asm_suffix, $release, " {r}, {new}, 0({dst})"),
                                    "bnez {r}, 2b", // continue loop if store failed
                                "3:",
                                "xor {r}, {out}, {old}",
                                "seqz {r}, {r}",
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_lr_sc!(cmpxchg, order);
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    (out, r != 0)
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix);
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let (aligned_ptr, shift, mask) = crate::utils::create_partword_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_partword_mask_values.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("sll", w!(), " {mask}, {mask}, {shift}"),
                                concat!("sll", w!(), " {val}, {val}, {shift}"),
                                // (atomic) swap (LR/SC loop)
                                "2:",
                                    concat!("lr.w", $acquire, " {out}, 0({dst})"),
                                    "mv {tmp}, {val}",
                                    "xor {tmp}, {tmp}, {out}",
                                    "and {tmp}, {tmp}, {mask}",
                                    "xor {tmp}, {tmp}, {out}",
                                    concat!("sc.w", $release, " {tmp}, {tmp}, 0({dst})"),
                                    "bnez {tmp}, 2b",
                                concat!("srl", w!(), " {out}, {out}, {shift}"),
                                dst = in(reg) ptr_reg!(aligned_ptr),
                                val = inout(reg) crate::utils::zero_extend(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_lr_sc!(swap, order);
                }
                out
            }
        }
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
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
                let (aligned_ptr, shift, mask) = crate::utils::create_partword_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_partword_mask_values.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("sll", w!(), " {mask}, {mask}, {shift}"),
                                concat!("sll", w!(), " {old}, {old}, {shift}"),
                                concat!("sll", w!(), " {new}, {new}, {shift}"),
                                // (atomic) CAS (LR/SC loop)
                                "2:",
                                    concat!("lr.w", $acquire, " {tmp}, 0({dst})"),
                                    "and {out}, {tmp}, {mask}",
                                    "bne {out}, {old}, 3f",
                                    "xor {out}, {tmp}, {new}",
                                    "and {out}, {out}, {mask}",
                                    "xor {out}, {out}, {tmp}",
                                    concat!("sc.w", $release, " {out}, {out}, 0({dst})"),
                                    "bnez {out}, 2b",
                                "3:",
                                concat!("srl", w!(), " {out}, {tmp}, {shift}"),
                                "and {tmp}, {tmp}, {mask}",
                                "xor {r}, {old}, {tmp}",
                                "seqz {r}, {r}",
                                dst = in(reg) ptr_reg!(aligned_ptr),
                                old = inout(reg) crate::utils::zero_extend(old) => _,
                                new = inout(reg) crate::utils::zero_extend(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                r = lateout(reg) r,
                                tmp = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_lr_sc!(cmpxchg, order);
                    debug_assert!(r == 0 || r == 1, "r={}", r);
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
#[cfg(target_arch = "riscv64")]
atomic!(i64, "d");
#[cfg(target_arch = "riscv64")]
atomic!(u64, "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "w");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "w");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d");
