// SPDX-License-Identifier: Apache-2.0 OR MIT

// ARMv6 and ARMv7
//
// Refs:
// - ARM Architecture Reference Manual ARMv7-A and ARMv7-R edition
//   https://developer.arm.com/documentation/ddi0406/cb
// - ARMv6 Differences
//   https://developer.arm.com/documentation/ddi0406/cb/Appendixes/ARMv6-Differences?lang=en
//
// Generated asm:
// - armv7-a https://godbolt.org/z/Ws6o5ff6x
// - armv7-r https://godbolt.org/z/EasKf9c3q
// - armv7-m https://godbolt.org/z/Ef3hbfx7f
// - armv6 (cp15_barrier) https://godbolt.org/z/EMvbbTcGx
// - armv6 (__kuser_memory_barrier) https://godbolt.org/z/83z7oxxoh
// - armv6-m https://godbolt.org/z/7nnaEq5zP

#[path = "cfgs/arm.rs"]
mod cfgs;

use core::{
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

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
// ARMv6 does not support `dmb`, so use use special instruction equivalent to a DMB.
//
// Refs:
// - https://reviews.llvm.org/D5386
// - https://developer.arm.com/documentation/ddi0360/e/control-coprocessor-cp15/register-descriptions/c7--cache-operations-register?lang=en
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
// trapped and emulated by default on Linux/Android with ARMv8+ (or ARMv7+?).
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
            // https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt
            kuser_memory_barrier = inout(reg) 0xFFFF0FA0_usize => _,
            out("lr") _,
        )
    };
}

macro_rules! atomic {
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
                        ($asm:ident, $acquire:expr) => {
                            $asm!(
                                // (atomic) load from src to out
                                concat!("ldr", $asm_suffix, " {out}, [{src}]"),
                                $acquire, // acquire fence
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
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                // (atomic) store val to dst
                                $release, // release fence
                                concat!("str", $asm_suffix, " {val}, [{dst}]"),
                                $acquire, // acquire fence
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
                        _ => unreachable!("{:?}", order),
                    }
                }
            }
        }
        #[cfg(any(
            any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
            not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
        ))]
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
                    macro_rules! atomic_swap {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                // (atomic) swap (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to out
                                    concat!("ldrex", $asm_suffix, " {out}, [{dst}]"),
                                    // try to store val to dst
                                    concat!("strex", $asm_suffix, " {r}, {val}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, 0x0",
                                    "bne 2b",
                                $acquire, // acquire fence
                                dst = in(reg) dst,
                                val = inout(reg) val => _,
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
                        _ => unreachable!("{:?}", order),
                    }
                }
                out
            }
        }
        #[rustfmt::skip]
        #[cfg(any(
            any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
            not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
        ))]
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
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_store_relaxed {
                        ($asm:ident, $acquire_success:expr, $acquire_failure:expr) => {
                            $asm!(
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    concat!("ldrex", $asm_suffix, " {out}, [{dst}]"),
                                    "cmp {out}, {old}",
                                    "bne 3f", // jump if compare failed
                                    concat!("strex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b", // continue loop if store failed
                                    $acquire_success,
                                    "b 4f",
                                "3:",
                                    // compare failed, set r to 1
                                    "mov {r}, #1",
                                    clrex!(),
                                    $acquire_failure,
                                "4:",
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::zero_extend(old),
                                new = inout(reg) new => _,
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
                                // (atomic) CAS (LL/SC loop)
                                concat!("ldrex", $asm_suffix, " {out}, [{dst}]"),
                                "cmp {out}, {old}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    concat!("strex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    concat!("ldrex", $asm_suffix, " {out}, [{dst}]"),
                                    "cmp {out}, {old}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1
                                    "mov {r}, #1",
                                    clrex!(),
                                    $acquire_failure,
                                "4:",
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::zero_extend(old),
                                new = inout(reg) new => _,
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
                                // (atomic) CAS (LL/SC loop)
                                concat!("ldrex", $asm_suffix, " {out}, [{dst}]"),
                                "cmp {out}, {old}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    concat!("strex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    concat!("ldrex", $asm_suffix, " {out}, [{dst}]"),
                                    "cmp {out}, {old}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1
                                    "mov {r}, #1",
                                    clrex!(),
                                    $acquire_failure,
                                    "b 5f",
                                "4:", // store succeed
                                    dmb!(), // acquire_success
                                "5:",
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::zero_extend(old),
                                new = inout(reg) new => _,
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
                        _ => unreachable!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                concat!("ldrex", $asm_suffix, " {out}, [{dst}]"),
                                "cmp {out}, {old}",
                                "bne 3f", // jump if compare failed
                                $release,
                                concat!("strex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                "b 4f",
                                "3:",
                                    // compare failed, set r to 1
                                    "mov {r}, #1",
                                    clrex!(),
                                "4:",
                                $acquire,
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::zero_extend(old),
                                new = inout(reg) new => _,
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
                                concat!("ldrex", $asm_suffix, " {out}, [{dst}]"),
                                "cmp {out}, {old}",
                                "bne 3f", // jump if compare failed
                                $release,
                                concat!("strex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                // 0 if the store was successful, 1 if no store was performed
                                "cmp {r}, #0",
                                "beq 4f", // jump if store succeed
                                "b 5f", // jump (store failed)
                                "3:",
                                    // compare failed, set r to 1
                                    "mov {r}, #1",
                                    clrex!(),
                                    "b 5f",
                                "4:", // store succeed
                                    dmb!(), // acquire_success
                                "5:",
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::zero_extend(old),
                                new = inout(reg) new => _,
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
                                concat!("ldrex", $asm_suffix, " {out}, [{dst}]"),
                                "cmp {out}, {old}",
                                "bne 3f", // jump if compare failed
                                $release,
                                concat!("strex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                // 0 if the store was successful, 1 if no store was performed
                                "cmp {r}, #0",
                                "beq 5f", // jump if store succeed
                                "b 4f", // jump (store failed)
                                "3:",
                                    // compare failed, set r to 1
                                    "mov {r}, #1",
                                    clrex!(),
                                "4:", // compare or store failed
                                    dmb!(), // acquire_failure
                                "5:",
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::zero_extend(old),
                                new = inout(reg) new => _,
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
                        _ => unreachable!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
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
    ($int_type:ident) => {
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let (prev_lo, prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($asm:ident, $acquire:expr) => {
                            $asm!(
                                // (atomic) load from src to tmp pair
                                "ldrexd r2, r3, [{src}]",
                                clrex!(),
                                $acquire, // acquire fence
                                src = in(reg) src,
                                // prev pair - must be even-numbered and not R14
                                out("r2") prev_lo,
                                out("r3") prev_hi,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(asm_no_dmb, ""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!(asm_use_dmb, dmb!()),
                        _ => unreachable!("{:?}", order),
                    }
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit64 { $int_type: val };

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                // (atomic) store val pair to dst (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to tmp pair
                                    "ldrexd r4, r5, [{dst}]",
                                    // try to store val pair to dst
                                    "strexd r4, r2, r3, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp r4, 0x0",
                                    "bne 2b",
                                $acquire, // acquire fence
                                dst = in(reg) dst,
                                // val pair - must be even-numbered and not R14
                                inout("r2") val.pair.lo => _,
                                inout("r3") val.pair.hi => _,
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
                        _ => unreachable!("{:?}", order),
                    }
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit64 { $int_type: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_swap {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                // (atomic) swap (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to prev pair
                                    "ldrexd r4, r5, [{dst}]",
                                    // try to store val pair to dst
                                    "strexd {r}, r2, r3, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, 0x0",
                                    "bne 2b",
                                $acquire, // acquire fence
                                dst = in(reg) dst,
                                r = out(reg) _,
                                // val pair - must be even-numbered and not R14
                                inout("r2") val.pair.lo => _,
                                inout("r3") val.pair.hi => _,
                                // prev pair - must be even-numbered and not R14
                                out("r4") prev_lo,
                                out("r5") prev_hi,
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
                        _ => unreachable!("{:?}", order),
                    }
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
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
                let old = MaybeUninit64 { $int_type: old };
                let new = MaybeUninit64 { $int_type: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_store_relaxed {
                        ($asm:ident, $acquire_success:expr, $acquire_failure:expr) => {
                            $asm!(
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    "ldrexd r4, r5, [{dst}]",
                                    "eor {tmp}, r5, {old_hi}",
                                    "eor {r}, r4, {old_lo}",
                                    "orrs {r}, {r}, {tmp}",
                                    "bne 3f", // jump if compare failed
                                    "strexd {r}, r8, r9, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b", // continue loop if store failed
                                    $acquire_success,
                                    "b 4f",
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    clrex!(),
                                    $acquire_failure,
                                "4:",
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r4") prev_lo,
                                out("r5") prev_hi,
                                // new pair - must be even-numbered and not R14
                                inout("r8") new.pair.lo => _,
                                inout("r9") new.pair.hi => _,
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_release {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                // (atomic) CAS (LL/SC loop)
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, {old_hi}",
                                "eor {r}, r4, {old_lo}",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    "strexd {r}, r8, r9, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    "ldrexd r4, r5, [{dst}]",
                                    "eor {tmp}, r5, {old_hi}",
                                    "eor {r}, r4, {old_lo}",
                                    "orrs {r}, {r}, {tmp}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    clrex!(),
                                    $acquire_failure,
                                "4:",
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r4") prev_lo,
                                out("r5") prev_hi,
                                // new pair - must be even-numbered and not R14
                                inout("r8") new.pair.lo => _,
                                inout("r9") new.pair.hi => _,
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_acqrel {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                // (atomic) CAS (LL/SC loop)
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, {old_hi}",
                                "eor {r}, r4, {old_lo}",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    "strexd {r}, r8, r9, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    "ldrexd r4, r5, [{dst}]",
                                    "eor {tmp}, r5, {old_hi}",
                                    "eor {r}, r4, {old_lo}",
                                    "orrs {r}, {r}, {tmp}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    clrex!(),
                                    $acquire_failure,
                                    "b 5f",
                                "4:", // store succeed
                                    dmb!(), // acquire_success
                                "5:",
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r4") prev_lo,
                                out("r5") prev_hi,
                                // new pair - must be even-numbered and not R14
                                inout("r8") new.pair.lo => _,
                                inout("r9") new.pair.hi => _,
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
                        _ => unreachable!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type, r == 0)
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let old = MaybeUninit64 { $int_type: old };
                let new = MaybeUninit64 { $int_type: new };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, {old_hi}",
                                "eor {r}, r4, {old_lo}",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                $release,
                                "strexd {r}, r8, r9, [{dst}]",
                                "b 4f",
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    clrex!(),
                                "4:",
                                $acquire,
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r4") prev_lo,
                                out("r5") prev_hi,
                                // new pair - must be even-numbered and not R14
                                inout("r8") new.pair.lo => _,
                                inout("r9") new.pair.hi => _,
                                // Do not use `preserves_flags` because ORRS modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_fail_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, {old_hi}",
                                "eor {r}, r4, {old_lo}",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                $release,
                                "strexd {r}, r8, r9, [{dst}]",
                                // 0 if the store was successful, 1 if no store was performed
                                "cmp {r}, #0",
                                "beq 4f", // jump if store succeed
                                "b 5f", // jump (store failed)
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    clrex!(),
                                    "b 5f",
                                "4:", // store succeed
                                    dmb!(), // acquire_success
                                "5:",
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r4") prev_lo,
                                out("r5") prev_hi,
                                // new pair - must be even-numbered and not R14
                                inout("r8") new.pair.lo => _,
                                inout("r9") new.pair.hi => _,
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_success_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, {old_hi}",
                                "eor {r}, r4, {old_lo}",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                $release,
                                "strexd {r}, r8, r9, [{dst}]",
                                // 0 if the store was successful, 1 if no store was performed
                                "cmp {r}, #0",
                                "beq 5f", // jump if store succeed
                                "b 4f", // jump (store failed)
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    clrex!(),
                                    "4:", // compare or store failed
                                    dmb!(), // acquire_failure
                                "5:",
                                dst = in(reg) dst,
                                old_lo = in(reg) old.pair.lo,
                                old_hi = in(reg) old.pair.hi,
                                r = out(reg) r,
                                tmp = out(reg) _,
                                // prev pair - must be even-numbered and not R14
                                out("r4") prev_lo,
                                out("r5") prev_hi,
                                // new pair - must be even-numbered and not R14
                                inout("r8") new.pair.lo => _,
                                inout("r9") new.pair.hi => _,
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
                        _ => unreachable!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type, r == 0)
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);
