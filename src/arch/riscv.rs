// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
RISC-V

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#risc-v

Refs:
- RISC-V Instruction Set Manual
  https://github.com/riscv/riscv-isa-manual
- RISC-V Atomics ABI Specification
  https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/draft-20240829-13bfa9f54634cb60d86b9b333e109f077805b4b3/riscv-atomic.adoc
- portable-atomic
  https://github.com/taiki-e/portable-atomic

Generated asm:
- riscv64gc https://godbolt.org/z/99KfT7Gjz
- riscv64gc (+zabha,+zacas) https://godbolt.org/z/43TaWGGKc
- riscv32imac https://godbolt.org/z/e57Tjc8E6
- riscv32imac (+zabha,+zacas) https://godbolt.org/z/fq36chW11
*/

// TODO:
// - 64-bit/128-bit atomics on RV32/RV64 with Zacas
// - {8,16}-bit swap/cas with Zacas without Zalrsc & Zabha (use amocas.w)

#[path = "cfgs/riscv.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
    target_feature = "zacas",
    atomic_maybe_uninit_target_feature = "zacas",
))]
use crate::raw::AtomicCompareExchange;
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zaamo",
    atomic_maybe_uninit_target_feature = "zaamo",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
))]
use crate::raw::AtomicSwap;
use crate::raw::{AtomicLoad, AtomicStore};

#[cfg(not(all(
    not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
    any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
))]
#[cfg(target_arch = "riscv32")]
macro_rules! w {
    () => {
        ""
    };
}
#[cfg(not(all(
    not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
    any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
))]
#[cfg(target_arch = "riscv64")]
macro_rules! w {
    () => {
        "w"
    };
}

#[cfg(all(
    not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
    any(
        target_feature = "a",
        atomic_maybe_uninit_target_feature = "a",
        target_feature = "zaamo",
        atomic_maybe_uninit_target_feature = "zaamo",
    ),
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
#[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
macro_rules! atomic_rmw_amocas {
    ($op:ident, $order:ident) => {
        atomic_rmw_amocas!($op, $order, failure = $order)
    };
    ($op:ident, $order:ident, failure = $failure:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("", ".aq"),
            Ordering::Release => $op!("", ".rl"),
            Ordering::AcqRel => $op!("", ".aqrl"),
            Ordering::SeqCst if $failure == Ordering::SeqCst => $op!("fence rw,rw", ".aqrl"),
            Ordering::SeqCst => $op!("", ".aqrl"),
            _ => unreachable!(),
        }
    };
}
#[cfg(not(all(
    not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
    any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
))]
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
    ($ty:ident, $size:tt) => {
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
                                $release,                                // fence
                                concat!("l", $size, " {out}, 0({src})"), // atomic { out = *src }
                                $acquire,                                // fence
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
                                $release,                                // fence
                                concat!("s", $size, " {val}, 0({dst})"), // atomic { *dst = val }
                                $acquire,                                // fence
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

#[cfg(all(
    not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
    any(
        target_feature = "a",
        atomic_maybe_uninit_target_feature = "a",
        target_feature = "zaamo",
        atomic_maybe_uninit_target_feature = "zaamo",
    ),
))]
#[rustfmt::skip]
macro_rules! atomic_zaamo {
    ($ty:ident, $size:tt) => {
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zaamo extension.
                unsafe {
                    macro_rules! swap {
                        ($order:tt) => {
                            asm!(
                                concat!("amoswap.", $size, $order, " {out}, {val}, 0({dst})"), // atomic { _x = *dst; *dst = val; out = _x }
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
    ($ty:ident, $size:tt) => {
        atomic_load_store!($ty, $size);

        // swap
        #[cfg(all(
            not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
            any(
                target_feature = "a",
                atomic_maybe_uninit_target_feature = "a",
                target_feature = "zaamo",
                atomic_maybe_uninit_target_feature = "zaamo",
            ),
        ))]
        atomic_zaamo!($ty, $size);
        #[cfg(not(all(
            not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
            any(
                target_feature = "a",
                atomic_maybe_uninit_target_feature = "a",
                target_feature = "zaamo",
                atomic_maybe_uninit_target_feature = "zaamo",
            ),
        )))]
        #[cfg(any(
            target_feature = "a",
            atomic_maybe_uninit_target_feature = "a",
            target_feature = "zalrsc",
            atomic_maybe_uninit_target_feature = "zalrsc",
        ))]
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zalrsc extension.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("lr.", $size, $acquire, " {out}, 0({dst})"),      // atomic { out = *dst; RS = dst }
                                    concat!("sc.", $size, $release, " {r}, {val}, 0({dst})"), // atomic { if RS == dst { *dst = val; r = 0 } else { r = nonzero }; RS = None }
                                    "bnez {r}, 2b",                                           // if r != 0 { jump 'retry }
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                r = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_lr_sc!(swap, order);
                }
                out
            }
        }

        // compare_exchange
        #[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
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

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zacas extension.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($fence:tt, $asm_order:tt) => {
                            asm!(
                                $fence,                                                           // fence
                                // old will be used for later comparison.
                                "mv {out}, {old}",                                                // out = old
                                concat!("amocas.", $size, $asm_order, " {out}, {new}, 0({dst})"), // atomic { if *dst == old { *dst = new } else { old = *dst } }
                                "xor {r}, {out}, {old}",                                          // r = out ^ old
                                "seqz {r}, {r}",                                                  // if r == 0 { r = 1 } else { r = 0 }
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = lateout(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_amocas!(cmpxchg, order, failure = failure);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
        #[cfg(not(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas")))]
        #[cfg(any(
            target_feature = "a",
            atomic_maybe_uninit_target_feature = "a",
            target_feature = "zalrsc",
            atomic_maybe_uninit_target_feature = "zalrsc",
        ))]
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

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zalrsc extension.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "2:", // 'retry:
                                    concat!("lr.", $size, $acquire, " {out}, 0({dst})"),      // atomic { out = *dst; RS = dst }
                                    "bne {out}, {old}, 3f",                                   // if out != old { jump 'cmp-fail }
                                    concat!("sc.", $size, $release, " {r}, {new}, 0({dst})"), // atomic { if RS == dst { *dst = new; r = 0 } else { r = nonzero }; RS = None }
                                    "bnez {r}, 2b",                                           // if r != 0 { jump 'retry }
                                "3:", // 'cmp-fail:
                                "xor {r}, {out}, {old}",                                      // r = out ^ old
                                "seqz {r}, {r}",                                              // if r == 0 { r = 1 } else { r = 0 }
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
    ($ty:ident, $size:tt, $shift:tt) => {
        atomic_load_store!($ty, $size);

        // swap
        #[cfg(all(
            not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
            any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
        ))]
        atomic_zaamo!($ty, $size);
        #[cfg(not(all(
            not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
            any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
        )))]
        #[cfg(any(
            target_feature = "a",
            atomic_maybe_uninit_target_feature = "a",
            target_feature = "zalrsc",
            atomic_maybe_uninit_target_feature = "zalrsc",
        ))]
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

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zalrsc extension.
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

        // compare_exchange
        #[cfg(all(
            any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
            any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
        ))]
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

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zacas extension.
                unsafe {
                    let mut r: crate::utils::RegSize;
                    macro_rules! cmpxchg {
                        ($fence:tt, $asm_order:tt) => {
                            asm!(
                                $fence,                                                           // fence
                                // old will be used for later comparison.
                                "mv {out}, {old}",                                                // out = old
                                concat!("slli {old}, {old}, ", $shift),                           // old <<= $shift
                                concat!("amocas.", $size, $asm_order, " {out}, {new}, 0({dst})"), // atomic { if *dst == old { *dst = new } else { old = *dst } }
                                concat!("srai {old}, {old}, ", $shift),                           // old >>= $shift
                                "xor {r}, {out}, {old}",                                          // r = out ^ old
                                "seqz {r}, {r}",                                                  // if r == 0 { r = 1 } else { r = 0 }
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) old => _,
                                new = in(reg) new,
                                out = out(reg) out,
                                r = lateout(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_amocas!(cmpxchg, order, failure = failure);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
        #[cfg(not(all(
            any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
            any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
        )))]
        #[cfg(any(
            target_feature = "a",
            atomic_maybe_uninit_target_feature = "a",
            target_feature = "zalrsc",
            atomic_maybe_uninit_target_feature = "zalrsc",
        ))]
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

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zalrsc extension.
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

#[cfg(target_arch = "riscv32")]
atomic_sub_word!(i8, "b", "24");
#[cfg(target_arch = "riscv32")]
atomic_sub_word!(u8, "b", "24");
#[cfg(target_arch = "riscv32")]
atomic_sub_word!(i16, "h", "16");
#[cfg(target_arch = "riscv32")]
atomic_sub_word!(u16, "h", "16");
#[cfg(target_arch = "riscv64")]
atomic_sub_word!(i8, "b", "56");
#[cfg(target_arch = "riscv64")]
atomic_sub_word!(u8, "b", "56");
#[cfg(target_arch = "riscv64")]
atomic_sub_word!(i16, "h", "48");
#[cfg(target_arch = "riscv64")]
atomic_sub_word!(u16, "h", "48");
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
