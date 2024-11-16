// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
RISC-V

This architecture provides the following atomic instructions:

- Load/Store Instructions (relaxed load/store)
  - All aligned {8,16,32}-bit (for RV32 & RV64) and 64-bit (for RV64) load/store instructions are atomic.
    Currently, there is no guaranteed 128-bit atomic load/store even on RV128.
    https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-8b9dc50-2024-08-30/src/rvwmo.adoc#memory-model-primitives
- Load-Acquire and Store-Release Instructions (acquire/seqcst load and release/seqcst store)
  - (experimental) Zalasr extension: {8,16,32}-bit (for RV32 & RV64) and 64-bit (for RV64)
    https://github.com/riscv/riscv-zalasr
- Load-Reserved/Store-Conditional (LR/SC) Instructions (aka LL/SC)
  - Zalrsc extension: 32-bit (for RV32 & RV64) and 64-bit (for RV64)
    https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-8b9dc50-2024-08-30/src/a-st-ext.adoc#zalrsc-extension-for-load-reservedstore-conditional-instructions
- Atomic Memory Operation (AMO) Instructions (RMW)
  - Zaamo extension: 32-bit (for RV32 & RV64) and 64-bit (for RV64) swap,fetch_{add,and,or,xor,max.min}
    https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-8b9dc50-2024-08-30/src/a-st-ext.adoc#zaamo-extension-for-atomic-memory-operations
  - Zabha extension: {8,16}-bit swap,fetch_{add,and,or,xor,max.min}
    https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-8b9dc50-2024-08-30/src/zabha.adoc
- Atomic Compare-and-Swap (CAS) Instructions
  - Zacas extension: {32,64}-bit (for RV32 & RV64) and 128-bit (for RV64)
    https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-8b9dc50-2024-08-30/src/zacas.adoc
  - Zacas and Zabha extensions: {8,16}-bit
    https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-8b9dc50-2024-08-30/src/zabha.adoc

Note: "A" extension comprises instructions provided by "Zalrsc" and "Zaamo" extensions,
"Zabha" and "Zacas" depends upon "Zaamo" extension.

Refs:
- RISC-V Instruction Set Manual
  https://github.com/riscv/riscv-isa-manual
- RISC-V Atomics ABI Specification
  https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/draft-20240829-13bfa9f54634cb60d86b9b333e109f077805b4b3/riscv-atomic.adoc
- portable-atomic https://github.com/taiki-e/portable-atomic

Generated asm:
- riscv64gc https://godbolt.org/z/4bzozeK8d
- riscv64gc (+zabha) https://godbolt.org/z/KEdoMn6re
- riscv32imac https://godbolt.org/z/9nT3qh33v
- riscv32imac (+zabha) https://godbolt.org/z/d1Tr7W3E3
*/

// TODO: Zacas extension, and Zalrsc extension without A extension

#[path = "cfgs/riscv.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
use crate::raw::AtomicCompareExchange;
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zaamo",
    atomic_maybe_uninit_target_feature = "zaamo",
))]
use crate::raw::AtomicSwap;
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

#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zaamo",
    atomic_maybe_uninit_target_feature = "zaamo",
))]
macro_rules! atomic_rmw_amo {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!(""),
            Ordering::Acquire => $op!(".aq"),
            Ordering::Release => $op!(".rl"),
            // AcqRel and SeqCst RMWs are equivalent.
            Ordering::AcqRel | Ordering::SeqCst => $op!(".aqrl"),
            _ => unreachable!(),
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
            _ => unreachable!(),
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $suffix:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                  // fence
                                concat!("l", $suffix, " {out}, 0({src})"), // atomic { out = *src }
                                $acquire,                                  // fence
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                  // fence
                                concat!("s", $suffix, " {val}, 0({dst})"), // atomic { *dst = val }
                                $acquire,                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "fence rw, w"),
                        // https://github.com/llvm/llvm-project/commit/3ea8f2526541884e03d5bd4f4e46f4eb190990b6
                        Ordering::SeqCst => atomic_store!("fence rw, rw", "fence rw, w"),
                        _ => unreachable!(),
                    }
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_swap {
    ($ty:ident, $suffix:tt) => {
        #[cfg(any(
            target_feature = "a",
            atomic_maybe_uninit_target_feature = "a",
            target_feature = "zaamo",
            atomic_maybe_uninit_target_feature = "zaamo",
        ))]
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($order:tt) => {
                            asm!(
                                concat!("amoswap.", $suffix, $order, " {out}, {val}, 0({dst})"), // atomic { _x = *dst; *dst = val; out = _x }
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
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
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $suffix:tt) => {
        atomic_load_store!($ty, $suffix);
        atomic_swap!($ty, $suffix);
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("lr.", $suffix, $acquire, " {out}, 0({dst})"),      // atomic { out = *dst; RS = dst }
                                    "bne {out}, {old}, 3f",                                     // if out != old { jump 'cmp-fail }
                                    concat!("sc.", $suffix, $release, " {r}, {new}, 0({dst})"), // atomic { if RS == dst { *dst = new; r = 0 } else { r = nonzero }; RS = None }
                                    "bnez {r}, 2b",                                             // if r != 0 { jump 'retry }
                                "3:", // 'cmp-fail:
                                "xor {r}, {out}, {old}",                                        // r = out ^ old
                                "seqz {r}, {r}",                                                // if r == 0 { r = 1 } else { r = 0 }
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
        #[cfg(any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"))]
        atomic_swap!($ty, $suffix);
        #[cfg(not(any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha")))]
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("sll", w!(), " {mask}, {mask}, {shift}"),         // mask <<= shift & 31
                                concat!("sll", w!(), " {val}, {val}, {shift}"),           // val <<= shift & 31
                                "2:", // 'retry:
                                    concat!("lr.w", $acquire, " {out}, 0({dst})"),        // atomic { out = *dst; RS = dst }
                                    "xor {tmp}, {val}, {out}",                            // tmp = val ^ out
                                    "and {tmp}, {tmp}, {mask}",                           // tmp &= mask
                                    "xor {tmp}, {tmp}, {out}",                            // tmp ^= out
                                    concat!("sc.w", $release, " {tmp}, {tmp}, 0({dst})"), // atomic { if RS == dst { *dst = tmp; tmp = 0 } else { tmp = nonzero }; RS = None }
                                    "bnez {tmp}, 2b",                                     // if tmp != 0 { jump 'retry }
                                concat!("srl", w!(), " {out}, {out}, {shift}"),           // out >>= shift & 31
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
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
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also create_sub_word_mask_values.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("sll", w!(), " {mask}, {mask}, {shift}"),         // mask <<= shift & 31
                                concat!("sll", w!(), " {old}, {old}, {shift}"),           // old <<= shift & 31
                                concat!("sll", w!(), " {new}, {new}, {shift}"),           // new <<= shift & 31
                                "2:", // 'retry:
                                    concat!("lr.w", $acquire, " {tmp}, 0({dst})"),        // atomic { tmp = *dst; RS = dst }
                                    "and {out}, {tmp}, {mask}",                           // out = tmp & mask
                                    "bne {out}, {old}, 3f",                               // if out != old { jump 'cmp-fail }
                                    "xor {out}, {tmp}, {new}",                            // out = tmp ^ new
                                    "and {out}, {out}, {mask}",                           // out &= mask
                                    "xor {out}, {out}, {tmp}",                            // out ^= tmp
                                    concat!("sc.w", $release, " {out}, {out}, 0({dst})"), // atomic { if RS == dst { *dst = out; out = 0 } else { out = nonzero }; RS = None }
                                    "bnez {out}, 2b",                                     // if out != 0 { jump 'retry }
                                "3:", // 'cmp-fail:
                                concat!("srl", w!(), " {out}, {tmp}, {shift}"),           // out = tmp >> shift & 31
                                "and {tmp}, {tmp}, {mask}",                               // tmp &= mask
                                "xor {tmp}, {old}, {tmp}",                                // tmp ^= old
                                "seqz {tmp}, {tmp}",                                      // if tmp == 0 { tmp = 1 } else { tmp = 0 }
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) crate::utils::ZeroExtend::zero_extend(old) => _,
                                new = inout(reg) crate::utils::ZeroExtend::zero_extend(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp = out(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_lr_sc!(cmpxchg, order);
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
