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
- armv7-a https://godbolt.org/z/P93x9TjWs
- armv7-m https://godbolt.org/z/WozEfbMbx
- armv6 https://godbolt.org/z/T5M337jYK
- armv6-m https://godbolt.org/z/q88qPah4W
*/

#[path = "../arch/cfgs/arm.rs"]
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
        "mcr p15, #0, r0, c7, c10, #5"
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
        "blx r0"
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
    (options($($options:tt)*), $($asm:tt)*) => {
        core::arch::asm!(
            $($asm)*
            options($($options)*),
        )
    };
}
#[cfg(any(
    target_feature = "v7",
    atomic_maybe_uninit_target_feature = "v7",
    target_feature = "mclass",
    atomic_maybe_uninit_target_feature = "mclass",
))]
macro_rules! asm_use_dmb {
    (options($($options:tt)*), $($asm:tt)*) => {
        core::arch::asm!(
            $($asm)*
            options($($options)*),
        )
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
    (options($($options:tt)*), $($asm:tt)*) => {
        // In this case, dmb! calls `mcr p15, 0, <Rd>, c7, c10, 5`, and the value in the Rd register should be zero (SBZ).
        core::arch::asm!(
            $($asm)*
            inout("r0") 0_u32 => _,
            options($($options)*),
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
    (options($($options:tt)*), $($asm:tt)*) => {
        // In this case, dmb! calls __kuser_memory_barrier.
        core::arch::asm!(
            $($asm)*
            // __kuser_memory_barrier (see also arm_linux.rs)
            // https://github.com/torvalds/linux/blob/v6.12/Documentation/arch/arm/kernel_user_helpers.rst
            inout("r0") 0xFFFF0FA0_usize => _,
            out("lr") _,
            options($($options)*),
        )
    };
}

macro_rules! atomic {
    ($ty:ident, $asm_suffix:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($asm:ident, $acquire:expr) => {
                            $asm!(
                                options(nostack, preserves_flags),
                                // (atomic) load from src to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{src}]"),
                                $acquire, // acquire fence
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                src = in(reg) src,
                                out = inout(reg) out_ptr => _,
                                tmp = lateout(reg) _,
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                options(nostack, preserves_flags),
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{val}]"),
                                // (atomic) store tmp to dst
                                $release, // release fence
                                concat!("str", $asm_suffix, " {tmp}, [{dst}]"),
                                $acquire, // acquire fence
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_swap {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                                // load from val (ptr) to val (val)
                                concat!("ldr", $asm_suffix, " {val}, [{val}]"),
                                // (atomic) swap (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to tmp
                                    concat!("ldrex", $asm_suffix, " {tmp}, [{dst}]"),
                                    // try to store val to dst
                                    concat!("strex", $asm_suffix, " {r}, {val}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b",
                                $acquire, // acquire fence
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                dst = in(reg) dst,
                                val = inout(reg) val => _,
                                out = in(reg) out_ptr,
                                r = out(reg) _,
                                tmp = out(reg) _,
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
        #[rustfmt::skip]
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_store_relaxed {
                        ($asm:ident, $acquire_success:expr, $acquire_failure:expr) => {
                            $asm!(
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                                // load from old/new (ptr) to old/new (val)
                                concat!("ldr", $asm_suffix, " {old}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new}, [{new}]"),
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    concat!("ldrex", $asm_suffix, " {tmp}, [{dst}]"),
                                    "cmp {tmp}, {old}",
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
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                dst = in(reg) dst,
                                r = out(reg) r,
                                old = inout(reg) old => _,
                                new = inout(reg) new => _,
                                out = in(reg) out_ptr,
                                tmp = out(reg) _,
                            )
                        };
                    }
                    macro_rules! cmpxchg_release {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                                // load from old/new (ptr) to old/new (val)
                                concat!("ldr", $asm_suffix, " {old}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new}, [{new}]"),
                                // (atomic) CAS (LL/SC loop)
                                concat!("ldrex", $asm_suffix, " {tmp}, [{dst}]"),
                                "cmp {tmp}, {old}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    concat!("strex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    concat!("ldrex", $asm_suffix, " {tmp}, [{dst}]"),
                                    "cmp {tmp}, {old}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1
                                    "mov {r}, #1",
                                    clrex!(),
                                    $acquire_failure,
                                "4:",
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                dst = in(reg) dst,
                                r = out(reg) r,
                                old = inout(reg) old => _,
                                new = inout(reg) new => _,
                                out = in(reg) out_ptr,
                                tmp = out(reg) _,
                            )
                        };
                    }
                    macro_rules! cmpxchg_acqrel {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                                // load from old/new (ptr) to old/new (val)
                                concat!("ldr", $asm_suffix, " {old}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new}, [{new}]"),
                                // (atomic) CAS (LL/SC loop)
                                concat!("ldrex", $asm_suffix, " {tmp}, [{dst}]"),
                                "cmp {tmp}, {old}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    concat!("strex", $asm_suffix, " {r}, {new}, [{dst}]"),
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    concat!("ldrex", $asm_suffix, " {tmp}, [{dst}]"),
                                    "cmp {tmp}, {old}",
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
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                dst = in(reg) dst,
                                r = out(reg) r,
                                old = inout(reg) old => _,
                                new = inout(reg) new => _,
                                out = in(reg) out_ptr,
                                tmp = out(reg) _,
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                                // load from old/new (ptr) to old/new (val)
                                concat!("ldr", $asm_suffix, " {old}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new}, [{new}]"),
                                concat!("ldrex", $asm_suffix, " {tmp}, [{dst}]"),
                                "cmp {tmp}, {old}",
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
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                dst = in(reg) dst,
                                r = out(reg) r,
                                old = inout(reg) old => _,
                                new = inout(reg) new => _,
                                out = in(reg) out_ptr,
                                tmp = out(reg) _,
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_fail_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                                // load from old/new (ptr) to old/new (val)
                                concat!("ldr", $asm_suffix, " {old}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new}, [{new}]"),
                                concat!("ldrex", $asm_suffix, " {tmp}, [{dst}]"),
                                "cmp {tmp}, {old}",
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
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                dst = in(reg) dst,
                                r = out(reg) r,
                                old = inout(reg) old => _,
                                new = inout(reg) new => _,
                                out = in(reg) out_ptr,
                                tmp = out(reg) _,
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_success_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                                // load from old/new (ptr) to old/new (val)
                                concat!("ldr", $asm_suffix, " {old}, [{old}]"),
                                concat!("ldr", $asm_suffix, " {new}, [{new}]"),
                                concat!("ldrex", $asm_suffix, " {tmp}, [{dst}]"),
                                "cmp {tmp}, {old}",
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
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                dst = in(reg) dst,
                                r = out(reg) r,
                                old = inout(reg) old => _,
                                new = inout(reg) new => _,
                                out = in(reg) out_ptr,
                                tmp = out(reg) _,
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
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($asm:ident, $acquire:expr) => {
                            $asm!(
                                options(nostack, preserves_flags),
                                // (atomic) load from src to tmp pair
                                "ldrexd r2, r3, [{src}]",
                                clrex!(),
                                $acquire, // acquire fence
                                // store tmp pair to out
                                "strd r2, r3, [{out}]",
                                src = in(reg) src,
                                out = in(reg) out_ptr,
                                // tmp pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
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
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                                // load from val to val pair
                                "ldrd r2, r3, [{val}]",
                                // (atomic) store val pair to dst (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to tmp pair
                                    "ldrexd r4, r5, [{dst}]",
                                    // try to store val pair to dst
                                    "strexd {r}, r2, r3, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b",
                                $acquire, // acquire fence
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                r = lateout(reg) _,
                                // val pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // tmp pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_swap {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                                // load from val to val pair
                                "ldrd r2, r3, [{val}]",
                                // (atomic) swap (LL/SC loop)
                                $release, // release fence
                                "2:",
                                    // load from dst to out pair
                                    "ldrexd r4, r5, [{dst}]",
                                    // try to store val pair to dst
                                    "strexd {r}, r2, r3, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "bne 2b",
                                $acquire, // acquire fence
                                // store out pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out = inout(reg) out_ptr => _,
                                r = lateout(reg) _,
                                // val pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
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
                }
                out
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_store_relaxed {
                        ($asm:ident, $acquire_success:expr, $acquire_failure:expr) => {
                            $asm!(
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                // (atomic) CAS (LL/SC loop)
                                "2:",
                                    "ldrexd r4, r5, [{dst}]",
                                    "eor {tmp}, r5, r3",
                                    "eor {r}, r4, r2",
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
                                // store out pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = in(reg) new,
                                out = inout(reg) out_ptr => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
                                // new pair - must be even-numbered and not R14
                                out("r8") _,
                                out("r9") _,
                            )
                        };
                    }
                    macro_rules! cmpxchg_release {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                // (atomic) CAS (LL/SC loop)
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    "strexd {r}, r8, r9, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    "ldrexd r4, r5, [{dst}]",
                                    "eor {tmp}, r5, r3",
                                    "eor {r}, r4, r2",
                                    "orrs {r}, {r}, {tmp}",
                                    "beq 2b", // continue loop if compare succeed
                                "3:",
                                    // compare failed, set r to 1 and clear exclusive
                                    "mov {r}, #1",
                                    clrex!(),
                                    $acquire_failure,
                                "4:",
                                // store out pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = in(reg) new,
                                out = inout(reg) out_ptr => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
                                // new pair - must be even-numbered and not R14
                                out("r8") _,
                                out("r9") _,
                            )
                        };
                    }
                    macro_rules! cmpxchg_acqrel {
                        ($acquire_failure:expr) => {
                            asm_use_dmb!(
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                // (atomic) CAS (LL/SC loop)
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
                                "orrs {r}, {r}, {tmp}",
                                "bne 3f", // jump if compare failed
                                dmb!(), // release
                                "2:",
                                    "strexd {r}, r8, r9, [{dst}]",
                                    // 0 if the store was successful, 1 if no store was performed
                                    "cmp {r}, #0",
                                    "beq 4f", // jump if store succeed
                                    "ldrexd r4, r5, [{dst}]",
                                    "eor {tmp}, r5, r3",
                                    "eor {r}, r4, r2",
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
                                // store out pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = in(reg) new,
                                out = inout(reg) out_ptr => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
                                // new pair - must be even-numbered and not R14
                                out("r8") _,
                                out("r9") _,
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
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let mut r: i32;
                    macro_rules! cmpxchg_weak {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                // Do not use `preserves_flags` because ORRS modifies the condition flags.
                                options(nostack),
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
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
                                // store out pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = in(reg) new,
                                out = inout(reg) out_ptr => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
                                // new pair - must be even-numbered and not R14
                                out("r8") _,
                                out("r9") _,
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_fail_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
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
                                // store out pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = in(reg) new,
                                out = inout(reg) out_ptr => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
                                // new pair - must be even-numbered and not R14
                                out("r8") _,
                                out("r9") _,
                            )
                        };
                    }
                    macro_rules! cmpxchg_weak_success_load_relaxed {
                        ($release:expr) => {
                            asm_use_dmb!(
                                // Do not use `preserves_flags` because CMP and ORRS modify the condition flags.
                                options(nostack),
                                "ldrd r2, r3, [{old}]",
                                "ldrd r8, r9, [{new}]",
                                "ldrexd r4, r5, [{dst}]",
                                "eor {tmp}, r5, r3",
                                "eor {r}, r4, r2",
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
                                // store out pair to out
                                "strd r4, r5, [{out}]",
                                dst = inout(reg) dst => _,
                                r = lateout(reg) r,
                                old = in(reg) old,
                                new = in(reg) new,
                                out = inout(reg) out_ptr => _,
                                tmp = out(reg) _,
                                // old pair - must be even-numbered and not R14
                                out("r2") _,
                                out("r3") _,
                                // out pair - must be even-numbered and not R14
                                out("r4") _,
                                out("r5") _,
                                // new pair - must be even-numbered and not R14
                                out("r8") _,
                                out("r9") _,
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

atomic64!(i64);
atomic64!(u64);
