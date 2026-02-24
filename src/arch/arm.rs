// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Armv6, Armv7, and pre-v6 Arm Linux/Android

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#arm

Refs:
- ARM® Architecture Reference Manual ARMv7-A and ARMv7-R edition
  https://developer.arm.com/documentation/ddi0406/cb
  ARMv6 Differences
  https://developer.arm.com/documentation/ddi0406/cb/Appendixes/ARMv6-Differences
  ARMv4 and ARMv5 Differences
  https://developer.arm.com/documentation/ddi0406/cb/Appendixes/ARMv4-and-ARMv5-Differences
- ARM11 MPCore Processor Technical Reference Manual
  https://developer.arm.com/documentation/ddi0360/f
- Arm® v7-M Architecture Reference Manual
  https://developer.arm.com/documentation/ddi0403/d
- ARM® v6-M Architecture Reference Manual
  https://developer.arm.com/documentation/ddi0419/c
- Instruction Set Assembly Guide for Armv7 and earlier Arm architectures Reference Guide
  https://developer.arm.com/documentation/100076/0200
- Kernel-provided User Helpers
  https://github.com/torvalds/linux/blob/v6.19/Documentation/arch/arm/kernel_user_helpers.rst
- https://github.com/rust-lang/compiler-builtins/blob/compiler_builtins-v0.1.124/src/arm_linux.rs

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

use core::{
    arch::{asm, asm as asm_no_dmb},
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicLoad, AtomicStore};
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
use crate::utils::{MaybeUninit64, Pair};

#[cfg(any(
    atomic_maybe_uninit_test_prefer_kuser_memory_barrier,
    atomic_maybe_uninit_test_prefer_kuser_cmpxchg,
))]
#[cfg(not(any(target_os = "linux", target_os = "android")))]
compile_error!(
    "atomic_maybe_uninit_test_prefer_kuser_memory_barrier/atomic_maybe_uninit_test_prefer_kuser_cmpxchg can only be used on Linux/Android"
);
#[cfg(atomic_maybe_uninit_use_cp15_barrier)]
#[cfg(not(any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6")))]
compile_error!("atomic_maybe_uninit_use_cp15_barrier can only be used on Armv6+");

cfg_sel!({
    #[cfg(any(
        any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
        not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
    ))]
    {
        use crate::raw::{AtomicCompareExchange, AtomicSwap};

        delegate_size!(delegate_all);
        #[cfg(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"))]
        macro_rules! clrex {
            () => {
                "clrex"
            };
        }
        #[cfg(not(any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7")))]
        macro_rules! clrex {
            () => {
                ""
            };
        }
    }
    #[cfg(else)]
    {
        delegate_size!(delegate_load_store);
    }
});

cfg_sel!({
    #[cfg(all(
        any(
            target_feature = "v7",
            atomic_maybe_uninit_target_feature = "v7",
            target_feature = "mclass",
            atomic_maybe_uninit_target_feature = "mclass",
        ),
        not(any(
            atomic_maybe_uninit_test_prefer_kuser_memory_barrier,
            atomic_maybe_uninit_test_prefer_kuser_cmpxchg,
            atomic_maybe_uninit_use_cp15_barrier,
        )),
    ))]
    {
        // Only a full system barrier exists in the M-class architectures.
        #[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
        macro_rules! dmb {
            () => {
                "dmb sy"
            };
        }
        #[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
        macro_rules! dmb {
            () => {
                "dmb ish"
            };
        }
        macro_rules! asm_use_dmb {
            ($($asm:tt)*) => {
                asm!($($asm)*)
            };
        }
    }
    // We prefer __kuser_memory_barrier over cp15_barrier because cp15_barrier is
    // trapped and emulated by default on Linux/Android with Armv8+ (or Armv7+?).
    // https://github.com/rust-lang/rust/issues/60605
    #[cfg(all(
        any(target_os = "linux", target_os = "android"),
        not(atomic_maybe_uninit_use_cp15_barrier),
    ))]
    {
        // https://github.com/torvalds/linux/blob/v6.19/Documentation/arch/arm/kernel_user_helpers.rst
        // __kuser_helper_version
        const KUSER_HELPER_VERSION: usize = 0xFFFF0FFC;
        // __kuser_cmpxchg
        // __kuser_helper_version >= 2 (kernel version 2.6.12+)
        // https://github.com/torvalds/linux/blob/v2.6.12/arch/arm/kernel/entry-armv.S#L617-L660
        // https://github.com/torvalds/linux/blob/v6.19/arch/arm/kernel/entry-armv.S#L769-L827
        // Note:
        // - has SeqCst semantics (smp_dmb arm)
        // - push to the stack when kuser_cmpxchg32_fixup called
        // - inout: r0, in: r1, r2, lr, clobbered: r3, ip, flags
        const KUSER_CMPXCHG: usize = 0xFFFF0FC0;
        // __kuser_memory_barrier
        // __kuser_helper_version >= 3 (kernel version 2.6.15+)
        const KUSER_MEMORY_BARRIER: usize = 0xFFFF0FA0;
        // __kuser_cmpxchg64
        // __kuser_helper_version >= 5 (kernel version 3.1+)
        // https://github.com/torvalds/linux/blob/v3.1/arch/arm/kernel/entry-armv.S#L730-L814
        // https://github.com/torvalds/linux/blob/v6.19/arch/arm/kernel/entry-armv.S#L693-L761
        // Note:
        // - has SeqCst semantics (smp_dmb arm)
        // - push to the stack in both cases
        // - inout: r0, r1, lr, in: r2, clobbered: r3, flags
        const KUSER_CMPXCHG64: usize = 0xFFFF0F60;

        #[inline]
        fn kuser_helper_version() -> i32 {
            // SAFETY: core assumes that at least __kuser_memory_barrier (__kuser_helper_version >= 3) is
            // available on this platform. __kuser_helper_version is always available on such a platform.
            unsafe {
                crate::utils::ptr::with_exposed_provenance::<i32>(KUSER_HELPER_VERSION).read()
            }
        }

        // TODO: Since Rust 1.64, the Linux kernel requirement for Rust when using std is 3.2+, so it
        // should be possible to convert this to debug_assert if the std feature is enabled on Rust 1.64+.
        // https://blog.rust-lang.org/2022/08/01/Increasing-glibc-kernel-requirements
        #[inline]
        fn assert_has_kuser_cmpxchg64() {
            if kuser_helper_version() < 5 {
                #[cold]
                fn p() -> ! {
                    panic!("64-bit atomics on pre-v6 Arm requires Linux kernel version 3.1+")
                }
                p()
            }
        }

        cfg_sel!({
            // blx requires Armv5t
            #[cfg(all(
                any(target_feature = "v5te", atomic_maybe_uninit_target_feature = "v5te"),
                not(atomic_maybe_uninit_test_prefer_bx),
            ))]
            {
                macro_rules! blx {
                    ($addr:tt) => {
                        concat!("blx ", $addr)
                    };
                }
            }
            #[cfg(not(any(
                target_feature = "thumb-mode",
                atomic_maybe_uninit_target_feature = "thumb-mode",
            )))]
            {
                #[rustfmt::skip]
                macro_rules! blx {
                    ($addr:tt) => {
                        concat!(
                            "mov lr, pc", "\n",
                            "bx ", $addr
                        )
                    };
                }
            }
            #[cfg(else)]
            {
                #[rustfmt::skip]
                macro_rules! blx {
                    ($addr:tt) => {
                        concat!(
                            "bl 120f", "\n",
                            "b 121f", "\n",
                            "120:", "\n",
                            "bx ", $addr, "\n",
                            "121:",
                        )
                    };
                }
            }
        });

        macro_rules! dmb {
            () => {
                blx!("{kuser_memory_barrier}")
            };
        }
        macro_rules! asm_use_dmb {
            ($($asm:tt)*) => {
                // In this case, dmb! calls __kuser_memory_barrier.
                asm!(
                    $($asm)*
                    kuser_memory_barrier = inout(reg) KUSER_MEMORY_BARRIER => _,
                    out("lr") _,
                )
            };
        }
    }
    // Armv6 does not support DMB instruction, so use use special instruction equivalent to it.
    //
    // Refs:
    // - https://reviews.llvm.org/D5386
    // - https://developer.arm.com/documentation/ddi0360/f/control-coprocessor-cp15/register-descriptions/c7--cache-operations-register
    #[cfg(else)]
    {
        macro_rules! dmb {
            () => {
                "mcr p15, #0, {zero}, c7, c10, #5"
            };
        }
        macro_rules! asm_use_dmb {
            ($($asm:tt)*) => {
                // In this case, dmb! calls `mcr p15, 0, <Rd>, c7, c10, 5`, and
                // the value in the Rd register should be zero (SBZ).
                asm!(
                    $($asm)*
                    zero = inout(reg) 0_u32 => _,
                )
            };
        }
    }
});

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $suffix:tt) => {
        #[cfg(not(any(
            any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
            not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
        )))]
        delegate_signed!(delegate_load_store, $ty);
        #[cfg(any(
            any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
            not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
        ))]
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for cp15 barrier
            )]
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
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for cp15 barrier
            )]
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
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $suffix:tt) => {
        atomic_load_store!($ty, $suffix);
        #[cfg(any(
            any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
            not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
        ))]
        impl AtomicSwap for $ty {
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for LL/SC and cp15 barrier
            )]
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;

                #[cfg(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                ))]
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
                #[cfg(not(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                )))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // __kuser_cmpxchg has SeqCst semantics.
                    let _ = order;
                    asm!(
                        "2:", // 'retry:
                            "ldr {out}, [r2]",       // atomic { out = *r2 }
                            "mov r0, {out}",         // r0 = out
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                        out = out(reg) out,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") _, // old_val
                        in("r1") val, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg clobbers r3, ip, and flags.
                        out("r3") _,
                        out("ip") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because __kuser_cmpxchg modifies the condition flags.
                        // Do not use `nostack` because __kuser_cmpxchg may push to stack.
                    );
                }
                out
            }
        }
        #[cfg(any(
            any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
            not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
        ))]
        impl AtomicCompareExchange for $ty {
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for LL/SC and cp15 barrier
            )]
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

                #[cfg(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                ))]
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
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
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
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_acqrel {
                        ($skip_failure_fence:expr) => {
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
                                    $skip_failure_fence,                               // jump 'end
                                "4:", // 'success:
                                    dmb!(),                                            // fence
                                "5:", // 'end:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
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
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_acqrel!("b 5f"),
                        (AcqRel | SeqCst, _) => cmpxchg_acqrel!(""),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
                #[cfg(not(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                )))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // __kuser_cmpxchg has SeqCst semantics.
                    let _ = (success, failure);
                    let mut r: i32;
                    asm!(
                        "2:", // 'retry:
                            "ldr {out}, [r2]",       // atomic { out = *r2 }
                            "mov r0, {out}",         // r0 = out
                            "cmp {out}, {old}",      // if out == old { Z = 1 } else { Z = 0 }
                            "bne 3f",                // if Z == 0 { jump 'cmp-fail }
                            "mov r1, {new}",         // r1 = new
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                            "b 4f",                  // jump 'success
                        "3:", // 'cmp-fail:
                            // write back to synchronize
                            "mov r1, r0",            // r1 = r0
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                            "mov r0, #1",            // r0 = 1
                        "4:", // 'success:
                        old = in(reg) old,
                        new = in(reg) new,
                        out = out(reg) out,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") r, // old_val
                        out("r1") _, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg clobbers r3, ip, and flags.
                        out("r3") _,
                        out("ip") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP and __kuser_cmpxchg modify the condition flags.
                        // Do not use `nostack` because __kuser_cmpxchg may push to stack.
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
            #[cfg(all(
                any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
            ))]
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for LL/SC and cp15 barrier
            )]
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
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
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
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
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
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
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

macro_rules! atomic_sub_word {
    ($ty:ident, $suffix:tt) => {
        cfg_sel!({
            #[cfg(all(
                any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
            ))]
            {
                atomic!($ty, $suffix);
            }
            #[cfg(else)]
            {
                atomic_load_store!($ty, $suffix);
                impl AtomicSwap for $ty {
                    #[inline]
                    unsafe fn atomic_swap(
                        dst: *mut MaybeUninit<Self>,
                        val: MaybeUninit<Self>,
                        _order: Ordering,
                    ) -> MaybeUninit<Self> {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                        let mut out: MaybeUninit<Self>;

                        // SAFETY: the caller must uphold the safety contract.
                        // __kuser_cmpxchg has SeqCst semantics.
                        unsafe {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "lsl {val}, {val}, {shift}",  // val <<= shift
                                "2:", // 'retry:
                                    "ldr {out}, [r2]",        // atomic { out = *r2 }
                                    "mov r0, {out}",          // r0 = out
                                    "and r1, r0, {inv_mask}", // r1 = r0 & inv_mask
                                    "orr r1, r1, {val}",      // r1 |= val
                                    blx!("{kuser_cmpxchg}"),  // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                                    "bcc 2b",                 // if C == 0 { jump 'retry }
                                "lsr {out}, {out}, {shift}",  // out >>= shift
                                val = inout(reg) crate::utils::extend32::$ty::zero(val) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                inv_mask = in(reg) !mask,
                                kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                                out("r0") _, // old_val
                                out("r1") _, // new_val
                                in("r2") dst, // ptr
                                // __kuser_cmpxchg clobbers r3, ip, and flags.
                                out("r3") _,
                                out("ip") _,
                                out("lr") _,
                                // Do not use `preserves_flags` because __kuser_cmpxchg modifies the condition flags.
                                // Do not use `nostack` because __kuser_cmpxchg may push to stack.
                            );
                        }
                        out
                    }
                }
                impl AtomicCompareExchange for $ty {
                    #[inline]
                    unsafe fn atomic_compare_exchange(
                        dst: *mut MaybeUninit<Self>,
                        old: MaybeUninit<Self>,
                        new: MaybeUninit<Self>,
                        _success: Ordering,
                        _failure: Ordering,
                    ) -> (MaybeUninit<Self>, bool) {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                        let mut out: MaybeUninit<Self>;

                        // SAFETY: the caller must uphold the safety contract.
                        // __kuser_cmpxchg has SeqCst semantics.
                        unsafe {
                            let mut r: i32;
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "lsl {old}, {old}, {shift}",  // old <<= shift
                                "lsl {new}, {new}, {shift}",  // new <<= shift
                                "2:", // 'retry:
                                    "ldr r0, [r2]",          // atomic { r0 = *r2 }
                                    "and {out}, r0, {mask}", // out = r0 & mask
                                    "cmp {out}, {old}",      // if out == old { Z = 1 } else { Z = 0 }
                                    "bne 3f",                // if Z == 0 { jump 'cmp-fail }
                                    "mvn r1, {mask}",        // r1 = !mask
                                    "and r1, r0, r1",        // r1 &= r0
                                    "orr r1, r1, {new}",     // r1 |= new
                                    blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                                    "bcc 2b",                // if C == 0 { jump 'retry }
                                    "b 4f",                  // jump 'success
                                "3:", // 'cmp-fail:
                                    // write back to synchronize
                                    "mov r1, r0",            // r1 = r0
                                    blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                                    "bcc 2b",                // if C == 0 { jump 'retry }
                                    "mov r0, #1",            // r0 = 1
                                "4:", // 'success:
                                "lsr {out}, {out}, {shift}",  // out >>= shift
                                old = inout(reg) crate::utils::extend32::$ty::zero(old) => _,
                                new = inout(reg) crate::utils::extend32::$ty::zero(new) => _,
                                out = out(reg) out,
                                shift = in(reg) shift,
                                mask = in(reg) mask,
                                // We cannot create inv_mask here because there are no available registers
                                // inv_mask = in(reg) !mask,
                                kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                                out("r0") r, // old_val
                                out("r1") _, // new_val
                                in("r2") dst, // ptr
                                // __kuser_cmpxchg clobbers r3, ip, and flags.
                                out("r3") _,
                                out("ip") _,
                                out("lr") _,
                                // Do not use `preserves_flags` because CMP and __kuser_cmpxchg modify the condition flags.
                                // Do not use `nostack` because __kuser_cmpxchg may push to stack.
                            );
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                            // 0 if the store was successful, 1 if no store was performed
                            (out, r == 0)
                        }
                    }
                }
            }
        });
    };
}

atomic_sub_word!(u8, "b");
atomic_sub_word!(u16, "h");
atomic!(u32, "");

// Refs:
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/LDREXD
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/STREXD
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
#[rustfmt::skip]
macro_rules! atomic64 {
    ($ty:ident) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for LL and cp15 barrier
            )]
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);

                #[cfg(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let (prev_lo, prev_hi);
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
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                }
                #[cfg(not(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                )))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    assert_has_kuser_cmpxchg64();
                    // __kuser_cmpxchg64 has SeqCst semantics.
                    let _ = order;
                    let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                    asm!(
                        "2:", // 'retry:
                            "ldr r0, [r2]",            // atomic { r0 = *r2 }
                            "ldr r1, [r2, #4]",        // atomic { r1 = *r2.byte_add(4) }
                            "str r0, [{out}]",         // *out = r0
                            "str r1, [{out}, #4]",     // *out.byte_add(4) = r1
                            "mov r0, {out}",           // r0 = out
                            "mov r1, {out}",           // r1 = out
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                        out = in(reg) out.as_mut_ptr(),
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") _, // old_val
                        out("r1") _, // new_val
                        in("r2") src, // ptr
                        // __kuser_cmpxchg64 clobbers r3, lr, and flags.
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because __kuser_cmpxchg64 modifies the condition flags.
                        // Do not use `nostack` because __kuser_cmpxchg64 push to stack.
                    );
                    out
                }
            }
        }
        impl AtomicStore for $ty {
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for LL/SC and cp15 barrier
            )]
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

                #[cfg(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let val = MaybeUninit64 { whole: val };
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
                #[cfg(not(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                )))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    assert_has_kuser_cmpxchg64();
                    // __kuser_cmpxchg64 has SeqCst semantics.
                    let _ = order;
                    let mut out_tmp = MaybeUninit::<Self>::uninit();
                    asm!(
                        "2:", // 'retry:
                            "ldr r0, [r2]",            // atomic { r0 = *r2 }
                            "ldr r1, [r2, #4]",        // atomic { r1 = *r2.byte_add(4) }
                            "str r0, [{out}]",         // *out = r0
                            "str r1, [{out}, #4]",     // *out.byte_add(4) = r1
                            "mov r0, {out}",           // r0 = out
                            "mov r1, {val}",           // r1 = val
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                        out = in(reg) out_tmp.as_mut_ptr(),
                        val = in(reg) val.as_ptr(),
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") _, // old_val
                        out("r1") _, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg64 clobbers r3, lr, and flags.
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because __kuser_cmpxchg64 modifies the condition flags.
                        // Do not use `nostack` because __kuser_cmpxchg64 push to stack.
                    );
                }
            }
        }
        impl AtomicSwap for $ty {
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for LL/SC and cp15 barrier
            )]
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

                #[cfg(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let val = MaybeUninit64 { whole: val };
                    let (mut prev_lo, mut prev_hi);
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
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                }
                #[cfg(not(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                )))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    assert_has_kuser_cmpxchg64();
                    // __kuser_cmpxchg64 has SeqCst semantics.
                    let _ = order;
                    let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                    asm!(
                        "2:", // 'retry:
                            "ldr r0, [r2]",            // atomic { r0 = *r2 }
                            "ldr r1, [r2, #4]",        // atomic { r1 = *r2.byte_add(4) }
                            "str r0, [{out}]",         // *out = r0
                            "str r1, [{out}, #4]",     // *out.byte_add(4) = r1
                            "mov r0, {out}",           // r0 = out
                            "mov r1, {val}",           // r1 = val
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                        out = in(reg) out.as_mut_ptr(),
                        val = in(reg) val.as_ptr(),
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") _, // old_val
                        out("r1") _, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg64 clobbers r3, lr, and flags.
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because __kuser_cmpxchg64 modifies the condition flags.
                        // Do not use `nostack` because __kuser_cmpxchg64 push to stack.
                    );
                    out
                }
            }
        }
        impl AtomicCompareExchange for $ty {
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for LL/SC and cp15 barrier
            )]
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let old = MaybeUninit64 { whole: old };

                #[cfg(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                    let new = MaybeUninit64 { whole: new };
                    let (mut prev_lo, mut prev_hi);
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
                        ($skip_failure_fence:expr) => {
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
                                    $skip_failure_fence,           // jump 'end
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
                        (AcqRel | SeqCst, Relaxed) => cmpxchg_acqrel!("b 5f"),
                        (AcqRel | SeqCst, _) => cmpxchg_acqrel!(""),
                        _ => unreachable!(),
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole, r == 0)
                }
                #[cfg(not(all(
                    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
                )))]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    assert_has_kuser_cmpxchg64();
                    // __kuser_cmpxchg64 has SeqCst semantics.
                    let _ = (success, failure);
                    let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                    let out_ptr = out.as_mut_ptr();
                    let new = new.as_ptr();
                    let mut r: i32;
                    asm!(
                        "2:", // 'retry:
                            "ldr r0, [r2]",            // atomic { r0 = *r2 }
                            "ldr r1, [r2, #4]",        // atomic { r1 = *r2.byte_add(4) }
                            "str r0, [{out}]",         // *out = r0
                            "str r1, [{out}, #4]",     // *out.byte_add(4) = r1
                            "eor r0, r0, {old_lo}",    // r0 ^= old_lo
                            "eor r1, r1, {old_hi}",    // r1 ^= old_hi
                            "orrs r0, r0, r1",         // r0 |= r1; if r0 == 0 { Z = 1 } else { Z = 0 }
                            "mov r0, {out}",           // r0 = out
                            "bne 3f",                  // if Z == 0 { jump 'cmp-fail }
                            "mov r1, {new}",           // r1 = new
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                            "b 4f",                    // jump 'success
                        "3:", // 'cmp-fail:
                            // write back to ensure atomicity
                            "mov r1, {out}",           // r1 = out
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                            "mov r0, #1",              // r0 = 1
                        "4:", // 'success:
                        new = in(reg) new,
                        out = in(reg) out_ptr,
                        old_lo = in(reg) old.pair.lo,
                        old_hi = in(reg) old.pair.hi,
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") r, // old_val
                        out("r1") _, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg64 clobbers r3, lr, and flags.
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP, ORRS, and __kuser_cmpxchg64 modify the condition flags.
                        // Do not use `nostack` because __kuser_cmpxchg64 push to stack.
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
            #[cfg(all(
                any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
                not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
            ))]
            #[cfg_attr(
                all(
                    any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode"),
                    not(any(
                        target_feature = "v7",
                        atomic_maybe_uninit_target_feature = "v7",
                        target_feature = "mclass",
                        atomic_maybe_uninit_target_feature = "mclass",
                    )),
                    any(
                        atomic_maybe_uninit_use_cp15_barrier,
                        not(any(target_os = "linux", target_os = "android")),
                    ),
                ),
                instruction_set(arm::a32) // needed for LL/SC and cp15 barrier
            )]
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let old = MaybeUninit64 { whole: old };
                let new = MaybeUninit64 { whole: new };
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
                    (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole, r == 0)
                }
            }
        }
    };
}

#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
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
#[cfg(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
))]
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
))]
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
))]
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
))]
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
)))]
// TODO: set has_atomic_64 to true
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
)))]
// TODO: set has_atomic_64 to true
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

#[cfg(not(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
)))]
#[cfg(test)]
mod tests {
    #[test]
    fn kuser_helper_version() {
        let version = super::kuser_helper_version();
        assert!(version >= 5, "{version:?}");
    }

    // TODO: set has_atomic_64 to true
    test_atomic!(i64);
    test_atomic!(u64);
    stress_test!(u64);
}
