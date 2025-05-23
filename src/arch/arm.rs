// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Armv6 and Armv7

Refs:
- ARM Architecture Reference Manual ARMv7-A and ARMv7-R edition
  https://developer.arm.com/documentation/ddi0406/cb
- ARMv6 Differences
  https://developer.arm.com/documentation/ddi0406/cb/Appendixes/ARMv6-Differences
- ARM11 MPCore Processor Technical Reference Manual
  https://developer.arm.com/documentation/ddi0360/f
- ARMv7-M Architecture Reference Manual
  https://developer.arm.com/documentation/ddi0403/latest (PDF)
- Armv6-M Architecture Reference Manual
  https://developer.arm.com/documentation/ddi0419/latest (PDF)
- Instruction Set Assembly Guide for Armv7 and earlier Arm architectures Reference Guide
  https://developer.arm.com/documentation/100076/0200

Generated asm:
- armv7-a https://godbolt.org/z/qe34fzjs8
- armv7-m https://godbolt.org/z/d741vssoa
- armv6 (cp15_barrier) https://godbolt.org/z/aa7qb3jar
- armv6 (__kuser_memory_barrier) https://godbolt.org/z/efEMEre5q
- armv6-m https://godbolt.org/z/68jrzsW1v
*/

use core::{mem::MaybeUninit, sync::atomic::Ordering};

#[cfg(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
))]
use crate::raw::{AtomicCompareExchange, AtomicSwap};
use crate::raw::{AtomicLoad, AtomicStore};
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
use crate::utils::{MaybeUninit64, Pair};

#[cfg(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"))]
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
macro_rules! dmb {
    () => {
        "dmb ish"
    };
}
// Only a full system barrier exists in the M-class architectures.
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
macro_rules! dmb {
    () => {
        "dmb sy"
    };
}
// Armv6 does not support `dmb`, so use use special instruction equivalent to a DMB.
//
// Refs:
// - https://reviews.llvm.org/D5386
// - https://developer.arm.com/documentation/ddi0360/f/control-coprocessor-cp15/register-descriptions/c7--cache-operations-register
#[cfg(not(all(
    any(target_os = "linux", target_os = "android"),
    not(atomic_maybe_uninit_use_cp15_barrier),
)))]
#[cfg(not(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7")))]
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
macro_rules! dmb {
    () => {
        "mcr p15, #0, {zero}, c7, c10, #5"
    };
}
// We prefer __kuser_memory_barrier over cp15_barrier because cp15_barrier is
// trapped and emulated by default on Linux/Android with Armv8+ (or Armv7+?).
// https://github.com/rust-lang/rust/issues/60605
#[cfg(all(
    any(target_os = "linux", target_os = "android"),
    not(atomic_maybe_uninit_use_cp15_barrier),
))]
#[cfg(not(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7")))]
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
macro_rules! dmb {
    () => {
        "blx {kuser_memory_barrier}"
    };
}

#[cfg(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
))]
#[cfg(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"))]
macro_rules! clrex {
    () => {
        "clrex"
    };
}
#[cfg(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
))]
#[cfg(not(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7")))]
macro_rules! clrex {
    () => {
        ""
    };
}

macro_rules! asm_no_dmb {
    ($($asm:tt)*) => {
        core::arch::asm!($($asm)*)
    };
}
#[cfg(any(
    target_feature = "v7",
    atomic_maybe_uninit_target_feature = "v7",
    target_feature = "mclass",
    atomic_maybe_uninit_target_feature = "mclass",
))]
macro_rules! asm_use_dmb {
    ($($asm:tt)*) => {
        core::arch::asm!($($asm)*)
    };
}
#[cfg(not(all(
    any(target_os = "linux", target_os = "android"),
    not(atomic_maybe_uninit_use_cp15_barrier),
)))]
#[cfg(not(any(
    target_feature = "v7",
    atomic_maybe_uninit_target_feature = "v7",
    target_feature = "mclass",
    atomic_maybe_uninit_target_feature = "mclass",
)))]
macro_rules! asm_use_dmb {
    ($($asm:tt)*) => {
        // In this case, dmb! calls `mcr p15, 0, <Rd>, c7, c10, 5`, and the value in the Rd register should be zero (SBZ).
        core::arch::asm!(
            $($asm)*
            zero = inout(reg) 0_u32 => _,
        )
    };
}
#[cfg(all(
    any(target_os = "linux", target_os = "android"),
    not(atomic_maybe_uninit_use_cp15_barrier),
))]
#[cfg(not(any(
    target_feature = "v7",
    atomic_maybe_uninit_target_feature = "v7",
    target_feature = "mclass",
    atomic_maybe_uninit_target_feature = "mclass",
)))]
macro_rules! asm_use_dmb {
    ($($asm:tt)*) => {
        // In this case, dmb! calls __kuser_memory_barrier.
        core::arch::asm!(
            $($asm)*
            // __kuser_memory_barrier (see also arm_linux.rs)
            // https://github.com/torvalds/linux/blob/v6.13/Documentation/arch/arm/kernel_user_helpers.rst
            kuser_memory_barrier = inout(reg) 0xFFFF0FA0_usize => _,
            out("lr") _,
        )
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $suffix:tt) => {
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
                        ($asm:ident, $acquire:expr) => {
                            $asm!(
                                concat!("ldr", $suffix, " {out}, [{src}]"), // atomic { out = *src }
                                $acquire,                                   // fence
                                src = in(reg) src,
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(asm_no_dmb, ""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!(asm_use_dmb, dmb!()),
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
                    macro_rules! atomic_store {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                $release,                                   // fence
                                concat!("str", $suffix, " {val}, [{dst}]"), // atomic { *dst = val }
                                $acquire,                                   // fence
                                dst = in(reg) dst,
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(asm_no_dmb, "", ""),
                        Ordering::Release => atomic_store!(asm_use_dmb, "", dmb!()),
                        Ordering::SeqCst => atomic_store!(asm_use_dmb, dmb!(), dmb!()),
                        _ => unreachable!(),
                    }
                }
            }
        }
        #[cfg(any(
            any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
            not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
        ))]
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
                    macro_rules! atomic_swap {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                $release,                                              // fence
                                "2:", // 'retry:
                                    concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                    concat!("strex", $suffix, " {r}, {val}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = val; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                     // if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                                          // if Z == 0 { jump 'retry }
                                $acquire,                                              // fence
                                dst = in(reg) dst,
                                val = in(reg) val,
                                out = out(reg) out,
                                r = out(reg) _,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!(asm_no_dmb, "", ""),
                        Ordering::Acquire => atomic_swap!(asm_use_dmb, dmb!(), ""),
                        Ordering::Release => atomic_swap!(asm_use_dmb, "", dmb!()),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => {
                            atomic_swap!(asm_use_dmb, dmb!(), dmb!());
                        }
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
        #[cfg(any(
            any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
            not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
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
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_store_relaxed {
                        ($asm:ident, $acquire_success:expr, $acquire_failure:expr) => {
                            $asm!(
                                "2:", // 'retry:
                                    concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                    "cmp {out}, {old}",                                // if out == old { Z = 1 } else { Z = 0 }
                                    "bne 3f",                                          // if Z == 0 { jump 'cmp-fail }
                                    concat!("strex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                     // if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                                          // if Z == 0 { jump 'retry }
                                    $acquire_success,                                  // fence
                                    "b 4f",                                            // jump 'success
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",                                     // r = 1
                                    clrex!(),                                          // EXCLUSIVE = None
                                    $acquire_failure,                                  // fence
                                "4:", // 'success:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_release {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                concat!("ldrex", $suffix, " {out}, [{dst}]"),          // atomic { out = *dst; EXCLUSIVE = dst }
                                "cmp {out}, {old}",                                    // if out == old { Z = 1 } else { Z = 0 }
                                "bne 3f",                                              // if Z == 0 { jump 'cmp-fail }
                                dmb!(),                                                // fence
                                "2:", // 'retry:
                                    concat!("strex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                     // if r == 0 { Z = 1 } else { Z = 0 }
                                    "beq 4f",                                          // if Z == 1 { jump 'success }
                                    concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                    "cmp {out}, {old}",                                // if out == old { Z = 1 } else { Z = 0 }
                                    "beq 2b",                                          // if Z == 1 { jump 'retry }
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",                                     // r = 1
                                    clrex!(),                                          // EXCLUSIVE = None
                                    $acquire_failure,                                  // fence
                                "4:", // 'success:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_acqrel {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                concat!("ldrex", $suffix, " {out}, [{dst}]"),          // atomic { out = *dst; EXCLUSIVE = dst }
                                "cmp {out}, {old}",                                    // if out == old { Z = 1 } else { Z = 0 }
                                "bne 3f",                                              // if Z == 0 { jump 'cmp-fail }
                                dmb!(),                                                // fence
                                "2:", // 'retry:
                                    concat!("strex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                     // if r == 0 { Z = 1 } else { Z = 0 }
                                    "beq 4f",                                          // if Z == 1 { jump 'success }
                                    concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                    "cmp {out}, {old}",                                // if out == old { Z = 1 } else { Z = 0 }
                                    "beq 2b",                                          // if Z == 1 { jump 'retry }
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",                                     // r = 1
                                    clrex!(),                                          // EXCLUSIVE = None
                                    $acquire_failure,                                  // fence
                                    "b 5f",                                            // jump 'end
                                "4:", // 'success:
                                    dmb!(),                                            // fence
                                "5:", // 'end:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match (success, failure) {
                        (Relaxed, Relaxed) => cmpxchg_store_relaxed!(asm_no_dmb, "", ""),
                        (Relaxed, Acquire | SeqCst) => {
                            cmpxchg_store_relaxed!(asm_use_dmb, "", dmb!());
                        }
                        (Acquire, Relaxed) => cmpxchg_store_relaxed!(asm_use_dmb, dmb!(), ""),
                        (Acquire, Acquire | SeqCst) => {
                            cmpxchg_store_relaxed!(asm_use_dmb, dmb!(), dmb!());
                        }
                        (Release, Relaxed) => cmpxchg_release!(""),
                        (Release, Acquire | SeqCst) => cmpxchg_release!(dmb!()),
                        // AcqRel and SeqCst compare_exchange are equivalent.
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_acqrel!(""),
                        (AcqRel | SeqCst, _) => cmpxchg_acqrel!(dmb!()),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                "cmp {out}, {old}",                                // if out == old { Z = 1 } else { Z = 0 }
                                "bne 3f",                                          // if Z == 0 { jump 'cmp-fail }
                                $release,                                          // fence
                                concat!("strex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                "b 4f",                                            // jump 'success
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",                                 // r = 1
                                    clrex!(),                                      // EXCLUSIVE = None
                                "4:", // 'success:
                                $acquire,                                          // fence
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_fail_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                "cmp {out}, {old}",                                // if out == old { Z = 1 } else { Z = 0 }
                                "bne 3f",                                          // if Z == 0 { jump 'cmp-fail }
                                $release,                                          // fence
                                concat!("strex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                "cmp {r}, #0",                                     // if r == 0 { Z = 1 } else { Z = 0 }
                                "beq 4f",                                          // if Z == 1 { jump 'success }
                                "b 5f",                                            // jump 'end
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",                                 // r = 1
                                    clrex!(),                                      // EXCLUSIVE = None
                                    "b 5f",                                        // jump 'end
                                "4:", // 'success:
                                    dmb!(),                                        // fence
                                "5:", // 'end:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_success_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = *dst; EXCLUSIVE = dst }
                                "cmp {out}, {old}",                                // if out == old { Z = 1 } else { Z = 0 }
                                "bne 3f",                                          // if Z == 0 { jump 'cmp-fail }
                                $release,                                          // fence
                                concat!("strex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                "cmp {r}, #0",                                     // if r == 0 { Z = 1 } else { Z = 0 }
                                "beq 5f",                                          // if Z == 1 { jump 'success }
                                "b 4f",                                            // jump 'store-fail
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",                                 // r = 1
                                    clrex!(),                                      // EXCLUSIVE = None
                                "4:", // 'store-fail:
                                    dmb!(),                                        // fence
                                "5:", // 'success:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::ZeroExtend::zero_extend(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match (success, failure) {
                        (Relaxed, Relaxed) => cmpxchg_weak!(asm_no_dmb, "", ""),
                        (Relaxed, Acquire | SeqCst) => cmpxchg_weak_success_load_relaxed!(""),
                        (Acquire, Relaxed) => cmpxchg_weak_fail_load_relaxed!(""),
                        (Acquire, Acquire | SeqCst) => cmpxchg_weak!(asm_use_dmb, dmb!(), ""),
                        (Release, Relaxed) => cmpxchg_weak!(asm_use_dmb, "", dmb!()),
                        (Release, Acquire | SeqCst) => cmpxchg_weak_success_load_relaxed!(dmb!()),
                        // AcqRel and SeqCst compare_exchange_weak are equivalent.
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_weak_fail_load_relaxed!(dmb!()),
                        (AcqRel | SeqCst, _) => cmpxchg_weak!(asm_use_dmb, dmb!(), dmb!()),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
        }
    };
}

atomic!(i8, "b");
atomic!(u8, "b");
atomic!(i16, "h");
atomic!(u16, "h");
atomic!(i32, "");
atomic!(u32, "");
atomic!(isize, "");
atomic!(usize, "");

// Refs:
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/LDREXD
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/STREXD
#[rustfmt::skip]
macro_rules! atomic64 {
    ($ty:ident) => {
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let (prev_lo, prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($asm:ident, $acquire:expr) => {
                            $asm!(
                                "ldrexd r0, r1, [{src}]", // atomic { r0:r1 = *src; EXCLUSIVE = src }
                                clrex!(),                 // EXCLUSIVE = None
                                $acquire,                 // fence
                                src = in(reg) src,
                                // prev pair - must be even-numbered and not R14
                                lateout("r0") prev_lo,
                                lateout("r1") prev_hi,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(asm_no_dmb, ""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!(asm_use_dmb, dmb!()),
                        _ => unreachable!(),
                    }
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit64 { $ty: val };

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                $release,                         // fence
                                "2:", // 'retry:
                                    "ldrexd r4, r5, [{dst}]",     // atomic { r4:r5 = *dst; EXCLUSIVE = dst }
                                    "strexd r4, r2, r3, [{dst}]", // atomic { if EXCLUSIVE == dst { *dst = r2:r3; r4 = 0 } else { r4 = 1 }; EXCLUSIVE = None }
                                    "cmp r4, #0",                 // if r4 == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                     // if Z == 0 { jump 'retry }
                                $acquire,                         // fence
                                dst = in(reg) dst,
                                // val pair - must be even-numbered and not R14
                                in("r2") val.pair.lo,
                                in("r3") val.pair.hi,
                                // tmp pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(asm_no_dmb, "", ""),
                        Ordering::Release => atomic_store!(asm_use_dmb, "", dmb!()),
                        Ordering::SeqCst => atomic_store!(asm_use_dmb, dmb!(), dmb!()),
                        _ => unreachable!(),
                    }
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit64 { $ty: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_swap {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                $release,                          // fence
                                "2:", // 'retry:
                                    "ldrexd r0, r1, [{dst}]",      // atomic { r0:r1 = *dst; EXCLUSIVE = dst }
                                    "strexd {r}, r2, r3, [{dst}]", // atomic { if EXCLUSIVE == dst { *dst = r2:r3; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                 // if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                      // if Z == 0 { jump 'retry }
                                $acquire,                          // fence
                                dst = in(reg) dst,
                                r = out(reg) _,
                                // val pair - must be even-numbered and not R14
                                in("r2") val.pair.lo,
                                in("r3") val.pair.hi,
                                // prev pair - must be even-numbered and not R14
                                out("r0") prev_lo,
                                out("r1") prev_hi,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!(asm_no_dmb, "", ""),
                        Ordering::Acquire => atomic_swap!(asm_use_dmb, dmb!(), ""),
                        Ordering::Release => atomic_swap!(asm_use_dmb, "", dmb!()),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!(asm_use_dmb, dmb!(), dmb!()),
                        _ => unreachable!(),
                    }
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
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
                let old = MaybeUninit64 { $ty: old };
                let new = MaybeUninit64 { $ty: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_store_relaxed {
                        ($asm:ident, $acquire_success:expr, $acquire_failure:expr) => {
                            $asm!(
                                "2:", // 'retry:
                                    "ldrexd r2, r3, [{dst}]",      // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                    "eor {tmp}, r3, {old_hi}",     // tmp = r3 ^ old_hi
                                    "eor {r}, r2, {old_lo}",       // r = r2 ^ old_lo
                                    "orrs {r}, {r}, {tmp}",        // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 3f",                      // if Z == 0 { jump 'cmp-fail }
                                    "strexd {r}, r4, r5, [{dst}]", // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                 // if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                      // if Z == 0 { jump 'retry }
                                    $acquire_success,              // fence
                                    "b 4f",                        // jump 'success
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",                 // r = 1
                                    clrex!(),                      // EXCLUSIVE = None
                                    $acquire_failure,              // fence
                                "4:", // 'success:
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                in("r4") new.pair.lo,
                                in("r5") new.pair.hi,
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_release {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                "ldrexd r2, r3, [{dst}]",          // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                "eor {tmp}, r3, {old_hi}",         // tmp = r3 ^ old_hi
                                "eor {r}, r2, {old_lo}",           // r = r2 ^ old_lo
                                "orrs {r}, {r}, {tmp}",            // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                "bne 3f",                          // if Z == 0 { jump 'cmp-fail }
                                dmb!(),                            // fence
                                "2:", // 'retry:
                                    "strexd {r}, r4, r5, [{dst}]", // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                 // if r == 0 { Z = 1 } else { Z = 0 }
                                    "beq 4f",                      // if Z == 1 { jump 'success }
                                    "ldrexd r2, r3, [{dst}]",      // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                    "eor {tmp}, r3, {old_hi}",     // tmp = r3 ^ old_hi
                                    "eor {r}, r2, {old_lo}",       // r = r2 ^ old_lo
                                    "orrs {r}, {r}, {tmp}",        // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                    "beq 2b",                      // if Z == 1 { jump 'retry }
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",                 // r = 1
                                    clrex!(),                      // EXCLUSIVE = None
                                    $acquire_failure,              // fence
                                "4:", // 'success:
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                in("r4") new.pair.lo,
                                in("r5") new.pair.hi,
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_acqrel {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                "ldrexd r2, r3, [{dst}]",          // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                "eor {tmp}, r3, {old_hi}",         // tmp = r3 ^ old_hi
                                "eor {r}, r2, {old_lo}",           // r = r2 ^ old_lo
                                "orrs {r}, {r}, {tmp}",            // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                "bne 3f",                          // if Z == 0 { jump 'cmp-fail }
                                dmb!(),                            // fence
                                "2:", // 'retry:
                                    "strexd {r}, r4, r5, [{dst}]", // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                 // if r == 0 { Z = 1 } else { Z = 0 }
                                    "beq 4f",                      // if Z == 1 { jump 'success }
                                    "ldrexd r2, r3, [{dst}]",      // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                    "eor {tmp}, r3, {old_hi}",     // tmp = r3 ^ old_hi
                                    "eor {r}, r2, {old_lo}",       // r = r2 ^ old_lo
                                    "orrs {r}, {r}, {tmp}",        // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                    "beq 2b",                      // if Z == 1 { jump 'retry }
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",                 // r = 1
                                    clrex!(),                      // EXCLUSIVE = None
                                    $acquire_failure,              // fence
                                    "b 5f",                        // jump 'end
                                "4:", // 'success:
                                    dmb!(),                        // fence
                                "5:", // 'end
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                in("r4") new.pair.lo,
                                in("r5") new.pair.hi,
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match (success, failure) {
                        (Relaxed, Relaxed) => cmpxchg_store_relaxed!(asm_no_dmb, "", ""),
                        (Relaxed, Acquire | SeqCst) => cmpxchg_store_relaxed!(asm_use_dmb, "", dmb!()),
                        (Acquire, Relaxed) => cmpxchg_store_relaxed!(asm_use_dmb, dmb!(), ""),
                        (Acquire, Acquire | SeqCst) => cmpxchg_store_relaxed!(asm_use_dmb, dmb!(), dmb!()),
                        (Release, Relaxed) => cmpxchg_release!(""),
                        (Release, Acquire | SeqCst) => cmpxchg_release!(dmb!()),
                        // AcqRel and SeqCst compare_exchange are equivalent.
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_acqrel!(""),
                        (AcqRel | SeqCst, _) => cmpxchg_acqrel!(dmb!()),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty, r == 0)
                }
            }
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let old = MaybeUninit64 { $ty: old };
                let new = MaybeUninit64 { $ty: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                "ldrexd r2, r3, [{dst}]",      // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                "eor {tmp}, r3, {old_hi}",     // tmp = r3 ^ old_hi
                                "eor {r}, r2, {old_lo}",       // r = r2 ^ old_lo
                                "orrs {r}, {r}, {tmp}",        // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                "bne 3f",                      // if Z == 0 { jump 'cmp-fail }
                                $release,                      // fence
                                "strexd {r}, r4, r5, [{dst}]", // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                "b 4f",                        // jump 'end
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",             // r = 1
                                    clrex!(),                  // EXCLUSIVE = None
                                "4:", // 'end:
                                $acquire,
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                in("r4") new.pair.lo,
                                in("r5") new.pair.hi,
                                // Do not use `preserves_flags` because ORRS modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_fail_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                "ldrexd r2, r3, [{dst}]",      // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                "eor {tmp}, r3, {old_hi}",     // tmp = r3 ^ old_hi
                                "eor {r}, r2, {old_lo}",       // r = r2 ^ old_lo
                                "orrs {r}, {r}, {tmp}",        // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                "bne 3f",                      // if Z == 0 { jump 'cmp-fail }
                                $release,                      // fence
                                "strexd {r}, r4, r5, [{dst}]", // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                "cmp {r}, #0",                 // if r == 0 { Z = 1 } else { Z = 0 }
                                "beq 4f",                      // if Z == 1 { jump 'success }
                                "b 5f",                        // jump 'end
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",             // r = 1
                                    clrex!(),                  // EXCLUSIVE = None
                                    "b 5f",                    // jump 'end
                                "4:", // 'success:
                                    dmb!(),                    // fence
                                "5:", // 'end:
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                in("r4") new.pair.lo,
                                in("r5") new.pair.hi,
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_success_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                "ldrexd r2, r3, [{dst}]",      // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                                "eor {tmp}, r3, {old_hi}",     // tmp = r3 ^ old_hi
                                "eor {r}, r2, {old_lo}",       // r = r2 ^ old_lo
                                "orrs {r}, {r}, {tmp}",        // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                                "bne 3f",                      // if Z == 0 { jump 'cmp-fail }
                                $release,                      // fence
                                "strexd {r}, r4, r5, [{dst}]", // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                "cmp {r}, #0",                 // if r == 0 { Z = 1 } else { Z = 0 }
                                "beq 5f",                      // if Z == 1 { jump 'success }
                                "b 4f",                        // jump 'store-fail
                                "3:", // 'cmp-fail:
                                    "mov {r}, #1",             // r = 1
                                    clrex!(),                  // EXCLUSIVE = None
                                "4:", // 'store-fail:
                                    dmb!(),                    // fence
                                "5:", // 'success:
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                // new pair - must be even-numbered and not R14
                                in("r4") new.pair.lo,
                                in("r5") new.pair.hi,
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    match (success, failure) {
                        (Relaxed, Relaxed) => cmpxchg_weak!(asm_no_dmb, "", ""),
                        (Relaxed, Acquire | SeqCst) => cmpxchg_weak_success_load_relaxed!(""),
                        (Acquire, Relaxed) => cmpxchg_weak_fail_load_relaxed!(""),
                        (Acquire, Acquire | SeqCst) => cmpxchg_weak!(asm_use_dmb, dmb!(), ""),
                        (Release, Relaxed) => cmpxchg_weak!(asm_use_dmb, "", dmb!()),
                        (Release, Acquire | SeqCst) => cmpxchg_weak_success_load_relaxed!(dmb!()),
                        // AcqRel and SeqCst compare_exchange_weak are equivalent.
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_weak_fail_load_relaxed!(dmb!()),
                        (AcqRel | SeqCst, _) => cmpxchg_weak!(asm_use_dmb, dmb!(), dmb!()),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$ty, r == 0)
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);

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
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
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
#[cfg(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
)))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
)))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
