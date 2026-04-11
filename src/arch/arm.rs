// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Armv6, Armv7, and pre-v6 Arm Linux/Android

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#arm

LLVM emits CLREX for Armv7 for (minor) performance (https://github.com/llvm/llvm-project/commit/07a844d758f09e1dd07ca17eb38a22d69d63fae3),
but we don't emit it for now to work around Cortex-A15 erratum 830321.
Not all CPUs require workarounds, but since we currently have no way to accurately catch
the flag that tells LLVM to enable workarounds for these (see comments in build script),
we always do it for now.
See also https://github.com/torvalds/linux/commit/2c32c65e3726c773760038910be30cce1b4d4149.
Also, GCC 15 doesn't emit CLREX: https://godbolt.org/z/hW3sjnn1T

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
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicLoad, AtomicStore};
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
use crate::utils::MaybeUninit64;
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
#[cfg(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
))]
use crate::utils::Pair;

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

        #[cfg(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        ))]
        macro_rules! atomic_rmw {
            ($op:ident, $order:ident) => {
                // op(asm, acquire, release)
                match $order {
                    Ordering::Relaxed => $op!(asm, "", ""),
                    Ordering::Acquire => $op!(asm_use_dmb, dmb!(), ""),
                    Ordering::Release => $op!(asm_use_dmb, "", dmb!()),
                    // AcqRel and SeqCst swaps are equivalent.
                    Ordering::AcqRel | Ordering::SeqCst => $op!(asm_use_dmb, dmb!(), dmb!()),
                    _ => unreachable!(),
                }
            };
        }
        #[cfg(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        ))]
        #[rustfmt::skip]
        macro_rules! atomic_cmpxchg {
            ($cmpxchg:ident, $cmpxchg_cond_release:ident, $success:ident, $failure:ident) => {{
                use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                // cmpxchg(asm, acquire, fail_label, skip_success_fence)
                // cmpxchg_cond_release(acquire, fail_label, success_label, skip_fail_fence)
                match ($success, $failure) {
                    (Relaxed, Relaxed) => $cmpxchg!(asm, "", "4f", ""),
                    (Relaxed, _) => $cmpxchg!(asm_use_dmb, dmb!(), "3f" /* emit-fence-on-fail */, "b 4f" /* skip-fence-on-success */),
                    (Acquire, Relaxed) => $cmpxchg!(asm_use_dmb, dmb!(), "4f" /* skip-fence-on-fail */, ""),
                    (Acquire, _) => $cmpxchg!(asm_use_dmb, dmb!(), "3f" /* emit-fence-on-fail */, ""),
                    (Release, Relaxed) => $cmpxchg_cond_release!("", "4f", "4f", ""),
                    (Release, _) => $cmpxchg_cond_release!(dmb!(), "3f" /* emit-fence-on-fail */, "4f" /* skip-fence-on-success */, "" /* emit-fence-on-fail */),
                    // AcqRel and SeqCst compare_exchange are equivalent.
                    (AcqRel | SeqCst, Relaxed) => $cmpxchg_cond_release!(dmb!(), "4f" /* skip-fence-on-fail */, "3f" /* emit-fence-on-success */, "b 4f" /* skip-fence-on-fail */),
                    (AcqRel | SeqCst, _) => $cmpxchg_cond_release!(dmb!(), "3f" /* emit-fence-on-fail */, "3f" /* emit-fence-on-success */, "" /* emit-fence-on-fail */),
                    _ => crate::utils::unreachable_unchecked(),
                }
            }};
        }
        #[cfg(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        ))]
        #[rustfmt::skip]
        macro_rules! atomic_cmpxchg_weak {
            ($cmpxchg_weak:ident, $success:ident, $failure:ident) => {{
                use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                // cmpxchg_weak(asm:ident, acquire, release, cmp_fail_label, branch_after_sc)
                match ($success, $failure) {
                    (Relaxed, Relaxed) => $cmpxchg_weak!(asm, "", "", "4f", ""),
                    (Relaxed, _) => $cmpxchg_weak!(asm_use_dmb, dmb!(), "", "3f" /* emit-fence-on-fail */, "beq 4f" /* skip-fence-on-success */),
                    (Acquire, Relaxed) => $cmpxchg_weak!(asm_use_dmb, dmb!(), "", "4f" /* skip-fence-on-fail */, "bne 4f" /* skip-fence-on-fail */),
                    (Acquire, _) => $cmpxchg_weak!(asm_use_dmb, dmb!(), "", "3f" /* emit-fence-on-fail */, "" /* emit-fence-on-both */),
                    (Release, Relaxed) => $cmpxchg_weak!(asm_use_dmb, "", dmb!(), "4f", ""),
                    (Release, _) => $cmpxchg_weak!(asm_use_dmb, dmb!(), dmb!(), "3f" /* emit-fence-on-fail */, "beq 4f" /* skip-fence-on-success */),
                    // AcqRel and SeqCst compare_exchange_weak are equivalent.
                    (AcqRel | SeqCst, Relaxed) => $cmpxchg_weak!(asm_use_dmb, dmb!(), dmb!(), "4f" /* skip-fence-on-fail */, "bne 4f" /* skip-fence-on-fail */),
                    (AcqRel | SeqCst, _) => $cmpxchg_weak!(asm_use_dmb, dmb!(), dmb!(), "3f" /* emit-fence-on-fail */, "" /* emit-fence-on-both */),
                    _ => crate::utils::unreachable_unchecked(),
                }
            }};
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
        use core::arch::asm as asm_use_dmb;

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
        #[cfg(not(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        )))]
        const KUSER_HELPER_VERSION: usize = 0xFFFF0FFC;
        // __kuser_cmpxchg
        // https://github.com/torvalds/linux/blob/v2.6.12/arch/arm/kernel/entry-armv.S#L567-L660
        // https://github.com/torvalds/linux/blob/v6.19/arch/arm/kernel/entry-armv.S#L769-L827
        // https://github.com/torvalds/linux/blob/v6.19/arch/arm64/kernel/kuser32.S#L44-L52
        // Note:
        // - __kuser_helper_version >= 2 (kernel version 2.6.12+)
        // - has SeqCst semantics (smp_dmb arm)
        // - push to the stack when kuser_cmpxchg32_fixup called or NEEDS_SYSCALL_FOR_CMPXCHG
        //   (removed in kernel version 4.4: https://github.com/torvalds/linux/commit/db695c0509d6ec9046ee5e4c520a19fa17d9fce2)
        //   is enabled.
        // - inout: r0, in: r1, r2, lr, clobbered: r3, ip, flags
        #[cfg(not(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        )))]
        const KUSER_CMPXCHG: usize = 0xFFFF0FC0;
        // __kuser_memory_barrier
        // https://github.com/torvalds/linux/blob/v2.6.15/arch/arm/kernel/entry-armv.S#L614-L651
        // https://github.com/torvalds/linux/blob/v6.19/arch/arm/kernel/entry-armv.S#L763-L767
        // https://github.com/torvalds/linux/blob/v6.19/arch/arm64/kernel/kuser32.S#L39-L41
        // Note:
        // - __kuser_helper_version >= 3 (kernel version 2.6.15+)
        // - has SeqCst semantics (smp_dmb arm)
        // - in: lr
        //   In pre-2.6.24 kernel, this might clobber the Z flag: https://github.com/torvalds/linux/commit/b49c0f24cf6744a3f4fd09289fe7cade349dead5
        //   However, we don't care about this because as of Rust 1.47 which added platform support
        //   page, the documented kernel version requirement for all Arm targets is at least 3.2:
        //   https://doc.rust-lang.org/1.47.0/rustc/platform-support.html
        //   (And with Rust 1.64, the kernel version requirement for other architectures also be at least 3.2:
        //   https://blog.rust-lang.org/2022/08/01/Increasing-glibc-kernel-requirements/).
        const KUSER_MEMORY_BARRIER: usize = 0xFFFF0FA0;
        // __kuser_cmpxchg64
        // https://github.com/torvalds/linux/blob/v3.1/arch/arm/kernel/entry-armv.S#L730-L814
        // https://github.com/torvalds/linux/blob/v3.1/Documentation/arm/kernel_user_helpers.txt#L205-L257
        // https://github.com/torvalds/linux/blob/v6.19/arch/arm/kernel/entry-armv.S#L693-L761
        // https://github.com/torvalds/linux/blob/v6.19/arch/arm64/kernel/kuser32.S#L23-L36
        // Note:
        // - __kuser_helper_version >= 5 (kernel version 3.1+)
        // - has SeqCst semantics (smp_dmb arm)
        // - push to the stack in all cases
        // - inout: r0, r1, lr, in: r2, clobbered: r3, flags
        #[cfg(not(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        )))]
        const KUSER_CMPXCHG64: usize = 0xFFFF0F60;

        #[cfg(not(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        )))]
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
        #[cfg(not(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        )))]
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

        #[cfg(not(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        )))]
        cfg_sel!({
            #[cfg(not(any(
                target_feature = "thumb-mode",
                atomic_maybe_uninit_target_feature = "thumb-mode",
            )))]
            {
                // Adds S suffix if needed. We prefer instruction without S suffix,
                // but pre-v7 Arm doesn't support thumb2 instructions.
                macro_rules! s {
                    ($op:tt, $operand:tt) => {
                        concat!($op, " ", $operand)
                    };
                }
                macro_rules! asm_use_s {
                    ($($asm:tt)*) => {
                        asm!(
                            $($asm)*
                            options(preserves_flags),
                        )
                    };
                }
                macro_rules! if_arm {
                    ($($tt:tt)*) => {
                        $($tt)*
                    };
                }
                macro_rules! if_thumb {
                    ($($tt:tt)*) => {
                        ""
                    };
                }
            }
            #[cfg(else)]
            {
                use core::arch::asm as asm_use_s;

                macro_rules! s {
                    ($op:tt, $operand:tt) => {
                        concat!($op, "s ", $operand)
                    };
                }
                macro_rules! if_arm {
                    ($($tt:tt)*) => {
                        ""
                    };
                }
                macro_rules! if_thumb {
                    ($($tt:tt)*) => {
                        $($tt)*
                    };
                }
            }
        });

        #[cfg(not(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        )))]
        #[inline(always)]
        fn lsl(mut val: MaybeUninit<u32>, shift: u32) -> MaybeUninit<u32> {
            // SAFETY: calling LSL{,S} is safe
            unsafe {
                asm_use_s!(
                    s!("lsl", "{val}, {shift}"), // val <<= shift
                    val = inout(reg) val,
                    shift = in(reg) shift,
                    // `preserves_flags` is set by asm_use_s! when s! doesn't modify the condition flags.
                    options(pure, nomem, nostack),
                );
            }
            val
        }
        #[cfg(not(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        )))]
        #[inline(always)]
        fn lsr(mut val: MaybeUninit<u32>, shift: u32) -> MaybeUninit<u32> {
            // SAFETY: calling LSR{,S} is safe
            unsafe {
                asm_use_s!(
                    s!("lsr", "{val}, {shift}"), // val >>= shift
                    val = inout(reg) val,
                    shift = in(reg) shift,
                    // `preserves_flags` is set by asm_use_s! when s! doesn't modify the condition flags.
                    options(pure, nomem, nostack),
                );
            }
            val
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

// -----------------------------------------------------------------------------
// Register-width or smaller atomics

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
                                concat!("ldr", $suffix, " {out}, [{src}]"), // atomic { out = zero_extend(*src) }
                                $acquire,                                   // fence
                                src = in(reg) src,
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(asm, ""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!(asm_use_dmb, dmb!()),
                        _ => crate::utils::unreachable_unchecked(),
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
                        Ordering::Relaxed => atomic_store!(asm, "", ""),
                        Ordering::Release => atomic_store!(asm_use_dmb, "", dmb!()),
                        Ordering::SeqCst => atomic_store!(asm_use_dmb, dmb!(), dmb!()),
                        _ => crate::utils::unreachable_unchecked(),
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
                    macro_rules! swap {
                        ($asm:ident, $acquire:expr, $release:expr) => {
                            $asm!(
                                $release,                                              // fence
                                "2:", // 'retry:
                                    concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = zero_extend(*dst); EXCLUSIVE = dst }
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
                    atomic_rmw!(swap, order);
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
                            s!("mov", "r0, {out}"),  // r0 = out
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
                        // Do not use `preserves_flags` because __kuser_cmpxchg and s! modify the condition flags.
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
                    let mut r: i32 = 1;
                    macro_rules! cmpxchg {
                        ($asm:ident, $acquire:expr, $fail_label:tt, $skip_success_fence:tt) => {
                            $asm!(
                                "2:", // 'retry:
                                    concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = zero_extend(*dst); EXCLUSIVE = dst }
                                    "cmp {out}, {old}",                                // if out == old { Z = 1 } else { Z = 0 }
                                    concat!("bne ", $fail_label),                      // if Z == 0 { jump 'fail }
                                    concat!("strex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                     // if r == 0 { Z = 1 } else { Z = 0 }
                                    "bne 2b",                                          // if Z == 0 { jump 'retry }
                                    $skip_success_fence,                               // jump 'skip-fence
                                "3:", // 'emit-fence:
                                    $acquire,                                          // fence
                                "4:", // 'skip-fence:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = inout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    macro_rules! cmpxchg_cond_release {
                        ($acquire:expr, $fail_label:tt, $success_label:tt, $skip_fail_fence:tt) => {
                            asm_use_dmb!(
                                concat!("ldrex", $suffix, " {out}, [{dst}]"),          // atomic { out = zero_extend(*dst); EXCLUSIVE = dst }
                                "cmp {out}, {old}",                                    // if out == old { Z = 1 } else { Z = 0 }
                                concat!("bne ", $fail_label),                          // if Z == 0 { jump 'fail }
                                dmb!(),                                                // fence
                                "2:", // 'retry:
                                    concat!("strex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                    "cmp {r}, #0",                                     // if r == 0 { Z = 1 } else { Z = 0 }
                                    concat!("beq ", $success_label),                   // if Z == 1 { jump 'success }
                                    concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = zero_extend(*dst); EXCLUSIVE = dst }
                                    "cmp {out}, {old}",                                // if out == old { Z = 1 } else { Z = 0 }
                                    "beq 2b",                                          // if Z == 1 { jump 'retry }
                                    $skip_fail_fence,                                  // jump 'skip-fence
                                "3:", // 'emit-fence:
                                    $acquire,                                          // fence
                                "4:", // 'skip-fence:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = inout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_cmpxchg!(cmpxchg, cmpxchg_cond_release, success, failure);
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
                            s!("mov", "r0, {out}"),  // r0 = out
                            "cmp {out}, {old}",      // if out == old { Z = 1 } else { Z = 0 }
                            "bne 3f",                // if Z == 0 { jump 'cmp-fail }
                            s!("mov", "r1, {new}"),  // r1 = new
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                            "b 4f",                  // jump 'success
                        "3:", // 'cmp-fail:
                            // write back to synchronize
                            s!("mov", "r1, r0"),     // r1 = r0
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                            s!("mov", "r0, #1"),     // r0 = 1
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
                        // Do not use `preserves_flags` because CMP, __kuser_cmpxchg, and s! modify the condition flags.
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
                let mut r: i32 = 1;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! cmpxchg_weak {
                        ($asm:ident, $acquire:expr, $release:expr, $cmp_fail_label:tt, $branch_after_sc:tt) => {
                            $asm!(
                                concat!("ldrex", $suffix, " {out}, [{dst}]"),      // atomic { out = zero_extend(*dst); EXCLUSIVE = dst }
                                "cmp {out}, {old}",                                // if out == old { Z = 1 } else { Z = 0 }
                                concat!("bne ", $cmp_fail_label),                  // if Z == 0 { jump 'cmp-fail }
                                $release,                                          // fence
                                concat!("strex", $suffix, " {r}, {new}, [{dst}]"), // atomic { if EXCLUSIVE == dst { *dst = new; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                                if_any!($branch_after_sc, "cmp {r}, #0"),          // if r == 0 { Z = 1 } else { Z = 0 }
                                $branch_after_sc,                                  // if ? { jump '? }
                                "3:", // 'emit-fence:
                                    $acquire,                                      // fence
                                "4:", // 'skip-fence:
                                dst = in(reg) dst,
                                old = in(reg) crate::utils::extend32::$ty::zero(old),
                                new = in(reg) new,
                                out = out(reg) out,
                                r = inout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition flags.
                                options(nostack),
                            )
                        };
                    }
                    atomic_cmpxchg_weak!(cmpxchg_weak, success, failure);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                }
                // 0 if the store was successful, 1 if no store was performed
                (out, r == 0)
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
                        let mut out: MaybeUninit<u32>;

                        // SAFETY: the caller must uphold the safety contract.
                        // __kuser_cmpxchg has SeqCst semantics.
                        unsafe {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                "2:", // 'retry:
                                    "ldr {out}, [r2]",                    // atomic { out = *r2 }
                                    s!("mov", "r0, {out}"),               // r0 = out
                                    if_arm!("and r1, {out}, {inv_mask}"), // r1 = out & inv_mask
                                    if_thumb!("movs r1, {out}"),          // r1 = out
                                    if_thumb!("ands r1, {inv_mask}"),     // r1 &= inv_mask
                                    s!("orr", "r1, {val}"),               // r1 |= val
                                    blx!("{kuser_cmpxchg}"),              // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                                    "bcc 2b",                             // if C == 0 { jump 'retry }
                                val = in(reg) lsl(crate::utils::extend32::$ty::zero(val), shift),
                                out = out(reg) out,
                                inv_mask = in(reg) !mask,
                                kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                                out("r0") _, // old_val
                                out("r1") _, // new_val
                                in("r2") dst, // ptr
                                // __kuser_cmpxchg clobbers r3, ip, and flags.
                                out("r3") _,
                                out("ip") _,
                                out("lr") _,
                                // Do not use `preserves_flags` because __kuser_cmpxchg and s! modify the condition flags.
                                // Do not use `nostack` because __kuser_cmpxchg may push to stack.
                            );
                        }
                        crate::utils::extend32::$ty::extract(lsr(out, shift))
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
                        let mut out: MaybeUninit<u32>;
                        let mut r: i32;

                        // SAFETY: the caller must uphold the safety contract.
                        // __kuser_cmpxchg has SeqCst semantics.
                        unsafe {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            #[cfg(not(any(
                                target_feature = "thumb-mode",
                                atomic_maybe_uninit_target_feature = "thumb-mode",
                            )))]
                            asm!(
                                "2:", // 'retry:
                                    "ldr r0, [r2]",          // atomic { r0 = *r2 }
                                    "and {out}, r0, {mask}", // out = r0 & mask
                                    "cmp {out}, {old}",      // if out == old { Z = 1 } else { Z = 0 }
                                    "bne 3f",                // if Z == 0 { jump 'cmp-fail }
                                    "mvn r1, {mask}",        // r1 = !mask
                                    "and r1, r0",            // r1 &= r0
                                    "orr r1, {new}",         // r1 |= new
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
                                old = in(reg) lsl(crate::utils::extend32::$ty::zero(old), shift),
                                new = in(reg) lsl(crate::utils::extend32::$ty::zero(new), shift),
                                out = out(reg) out,
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
                            #[cfg(any(
                                target_feature = "thumb-mode",
                                atomic_maybe_uninit_target_feature = "thumb-mode",
                            ))]
                            asm!(
                                "sub sp, #8",
                                "str r3, [sp]",
                                "2:", // 'retry:
                                    "ldr r3, [sp]",
                                    "ldr r0, [r2]",       // atomic { r0 = *r2 }
                                    "movs {out}, r0",     // out = r0
                                    "ands {out}, {mask}", // out &= mask
                                    "cmp {out}, {old}",   // if out == old { Z = 1 } else { Z = 0 }
                                    "bne 3f",             // if Z == 0 { jump 'cmp-fail }
                                    "mvns r1, {mask}",    // r1 = !mask
                                    "ands r1, r0",        // r1 &= r0
                                    "orrs r1, {new}",     // r1 |= new
                                    blx!("r3"),           // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                                    "bcc 2b",             // if C == 0 { jump 'retry }
                                    "b 4f",               // jump 'success
                                "3:", // 'cmp-fail:
                                    // write back to synchronize
                                    "movs r1, r0",        // r1 = r0
                                    blx!("r3"),           // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                                    "bcc 2b",             // if C == 0 { jump 'retry }
                                    "movs r0, #1",        // r0 = 1
                                "4:", // 'success:
                                "add sp, #8",
                                old = in(reg) lsl(crate::utils::extend32::$ty::zero(old), shift),
                                new = in(reg) lsl(crate::utils::extend32::$ty::zero(new), shift),
                                out = out(reg) out,
                                mask = in(reg) mask,
                                // We cannot create inv_mask here because there are no available registers
                                // inv_mask = in(reg) !mask,
                                // kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                                out("r0") r, // old_val
                                out("r1") _, // new_val
                                in("r2") dst, // ptr
                                // __kuser_cmpxchg clobbers r3, ip, and flags.
                                inout("r3") KUSER_CMPXCHG => _,
                                out("ip") _,
                                out("lr") _,
                                // Do not use `preserves_flags` because CMP, __kuser_cmpxchg, and *S modify the condition flags.
                                // Do not use `nostack` because __kuser_cmpxchg may push to stack.
                            );
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                        }
                        // 0 if the store was successful, 1 if no store was performed
                        (crate::utils::extend32::$ty::extract(lsr(out, shift)), r == 0)
                    }
                }
            }
        });
    };
}

atomic_sub_word!(u8, "b");
atomic_sub_word!(u16, "h");
atomic!(u32, "");

// -----------------------------------------------------------------------------
// 64-bit atomics
//
// Refs:
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/LDREXD
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/STREXD

#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
delegate_signed!(delegate_all, u64);
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
impl AtomicLoad for u64 {
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
    unsafe fn atomic_load(src: *const MaybeUninit<Self>, order: Ordering) -> MaybeUninit<Self> {
        debug_assert_atomic_unsafe_precondition!(src, u64);

        #[cfg(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        ))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            let (out_lo, out_hi);
            macro_rules! atomic_load {
                ($asm:ident, $acquire:expr) => {
                    $asm!(
                        "ldrexd r0, r1, [{src}]", // atomic { r0:r1 = *src; EXCLUSIVE = src }
                        $acquire,                 // fence
                        src = in(reg) src,
                        // out pair - must be even-numbered and not R14
                        lateout("r0") out_lo,
                        lateout("r1") out_hi,
                        options(nostack, preserves_flags),
                    )
                };
            }
            match order {
                Ordering::Relaxed => atomic_load!(asm, ""),
                // Acquire and SeqCst loads are equivalent.
                Ordering::Acquire | Ordering::SeqCst => atomic_load!(asm_use_dmb, dmb!()),
                _ => crate::utils::unreachable_unchecked(),
            }
            MaybeUninit64 { pair: Pair { lo: out_lo, hi: out_hi } }.whole
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
                    s!("mov", "r0, {out}"),    // r0 = out
                    s!("mov", "r1, {out}"),    // r1 = out
                    blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 }; r1 = ? }
                    "bcc 2b",                  // if C == 0 { jump 'retry }
                out = in(reg) out.as_mut_ptr(),
                kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                out("r0") _, // old_val
                out("r1") _, // new_val
                in("r2") src, // ptr
                // __kuser_cmpxchg64 clobbers r3, lr, and flags.
                out("r3") _,
                out("lr") _,
                // Do not use `preserves_flags` because __kuser_cmpxchg64 and s! modify the condition flags.
                // Do not use `nostack` because __kuser_cmpxchg64 push to stack.
            );
            out
        }
    }
}
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
impl AtomicStore for u64 {
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
    unsafe fn atomic_store(dst: *mut MaybeUninit<Self>, val: MaybeUninit<Self>, order: Ordering) {
        debug_assert_atomic_unsafe_precondition!(dst, u64);

        #[cfg(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        ))]
        // SAFETY: the caller must uphold the safety contract.
        // Do not use atomic_swap because it needs extra registers to implement store.
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
                Ordering::Relaxed => atomic_store!(asm, "", ""),
                Ordering::Release => atomic_store!(asm_use_dmb, "", dmb!()),
                Ordering::SeqCst => atomic_store!(asm_use_dmb, dmb!(), dmb!()),
                _ => crate::utils::unreachable_unchecked(),
            }
        }
        #[cfg(not(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        )))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            // __kuser_cmpxchg64 has SeqCst semantics.
            let _ = order;
            <u64 as AtomicSwap>::atomic_swap(dst, val, Ordering::SeqCst);
        }
    }
}
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
impl AtomicSwap for u64 {
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
        debug_assert_atomic_unsafe_precondition!(dst, u64);

        #[cfg(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        ))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            let val = MaybeUninit64 { whole: val };
            let (mut prev_lo, mut prev_hi);
            macro_rules! swap {
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
            atomic_rmw!(swap, order);
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
                    s!("mov", "r0, {out}"),    // r0 = out
                    s!("mov", "r1, {val}"),    // r1 = val
                    blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 }; r1 = ? }
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
                // Do not use `preserves_flags` because __kuser_cmpxchg64 and s! modify the condition flags.
                // Do not use `nostack` because __kuser_cmpxchg64 push to stack.
            );
            out
        }
    }
}
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
impl AtomicCompareExchange for u64 {
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
        debug_assert_atomic_unsafe_precondition!(dst, u64);
        let old = MaybeUninit64 { whole: old };

        #[cfg(all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            not(atomic_maybe_uninit_test_prefer_kuser_cmpxchg),
        ))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            let new = MaybeUninit64 { whole: new };
            let (mut prev_lo, mut prev_hi);
            let mut r: i32;
            macro_rules! cmpxchg {
                ($asm:ident, $acquire:expr, $fail_label:tt, $skip_success_fence:tt) => {
                    $asm!(
                        "2:", // 'retry:
                            "ldrexd r2, r3, [{dst}]",      // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                            "eor {tmp}, r3, {old_hi}",     // tmp = r3 ^ old_hi
                            "eor {r}, r2, {old_lo}",       // r = r2 ^ old_lo
                            "orrs {r}, {tmp}",             // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                            "mov {r}, #1",                 // r = 1
                            concat!("bne ", $fail_label),  // if Z == 0 { jump 'fail }
                            "strexd {r}, r4, r5, [{dst}]", // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                            "cmp {r}, #0",                 // if r == 0 { Z = 1 } else { Z = 0 }
                            "bne 2b",                      // if Z == 0 { jump 'retry }
                            $skip_success_fence,           // jump 'skip-fence
                        "3:", // 'emit-fence:
                            $acquire,                      // fence
                        "4:", // 'skip-fence:
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
            macro_rules! cmpxchg_cond_release {
                ($acquire:expr, $fail_label:tt, $success_label:tt, $skip_fail_fence:tt) => {
                    asm_use_dmb!(
                        "ldrexd r2, r3, [{dst}]",            // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                        "eor {tmp}, r3, {old_hi}",           // tmp = r3 ^ old_hi
                        "eor {r}, r2, {old_lo}",             // r = r2 ^ old_lo
                        "orrs {r}, {tmp}",                   // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                        "mov {r}, #1",                       // r = 1
                        concat!("bne ", $fail_label),        // if Z == 0 { jump 'fail }
                        dmb!(),                              // fence
                        "2:", // 'retry:
                            "strexd {r}, r4, r5, [{dst}]",   // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                            "cmp {r}, #0",                   // if r == 0 { Z = 1 } else { Z = 0 }
                            concat!("beq ", $success_label), // if Z == 1 { jump 'success }
                            "ldrexd r2, r3, [{dst}]",        // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                            "eor {tmp}, r3, {old_hi}",       // tmp = r3 ^ old_hi
                            "eor {r}, r2, {old_lo}",         // r = r2 ^ old_lo
                            "orrs {r}, {tmp}",               // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                            "mov {r}, #1",                   // r = 1
                            "beq 2b",                        // if Z == 1 { jump 'retry }
                            $skip_fail_fence,                // jump 'skip-fence
                        "3:", // 'emit-fence:
                            $acquire,                        // fence
                        "4:", // 'skip-fence:
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
            atomic_cmpxchg!(cmpxchg, cmpxchg_cond_release, success, failure);
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
            #[cfg(not(any(
                target_feature = "thumb-mode",
                atomic_maybe_uninit_target_feature = "thumb-mode",
            )))]
            asm!(
                "2:", // 'retry:
                    "ldr r0, [r2]",            // atomic { r0 = *r2 }
                    "ldr r1, [r2, #4]",        // atomic { r1 = *r2.byte_add(4) }
                    "str r0, [{out}]",         // *out = r0
                    "str r1, [{out}, #4]",     // *out.byte_add(4) = r1
                    "eor r0, {old_lo}",        // r0 ^= old_lo
                    "eor r1, {old_hi}",        // r1 ^= old_hi
                    "orrs r0, r1",             // r0 |= r1; if r0 == 0 { Z = 1 } else { Z = 0 }
                    "mov r0, {out}",           // r0 = out
                    "bne 3f",                  // if Z == 0 { jump 'cmp-fail }
                    "mov r1, {new}",           // r1 = new
                    blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 }; r1 = ? }
                    "bcc 2b",                  // if C == 0 { jump 'retry }
                    "b 4f",                    // jump 'success
                "3:", // 'cmp-fail:
                    // write back to ensure atomicity
                    "mov r1, {out}",           // r1 = out
                    blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 }; r1 = ? }
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
                // Do not use `preserves_flags` because ORRS and __kuser_cmpxchg64 modify the condition flags.
                // Do not use `nostack` because __kuser_cmpxchg64 push to stack.
            );
            #[cfg(any(
                target_feature = "thumb-mode",
                atomic_maybe_uninit_target_feature = "thumb-mode",
            ))]
            asm!(
                "sub sp, #8",
                "str r3, [sp]",
                "2:", // 'retry:
                    "ldr r3, [sp]",
                    "ldr r0, [r2]",        // atomic { r0 = *r2 }
                    "ldr r1, [r2, #4]",    // atomic { r1 = *r2.byte_add(4) }
                    "str r0, [{out}]",     // *out = r0
                    "str r1, [{out}, #4]", // *out.byte_add(4) = r1
                    "eors r0, {old_lo}",   // r0 ^= old_lo
                    "eors r1, {old_hi}",   // r1 ^= old_hi
                    "orrs r0, r1",         // r0 |= r1; if r0 == 0 { Z = 1 } else { Z = 0 }
                    "bne 3f",              // if Z == 0 { jump 'cmp-fail }
                    "movs r0, {out}",      // r0 = out
                    "movs r1, {new}",      // r1 = new
                    blx!("r3"),            // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 }; r1 = ? }
                    "bcc 2b",              // if C == 0 { jump 'retry }
                    "b 4f",                // jump 'success
                "3:", // 'cmp-fail:
                    // write back to ensure atomicity
                    "movs r0, {out}",      // r0 = out
                    "movs r1, {out}",      // r1 = out
                    blx!("r3"),            // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 }; r1 = ? }
                    "bcc 2b",              // if C == 0 { jump 'retry }
                    "movs r0, #1",         // r0 = 1
                "4:", // 'success:
                "add sp, #8",
                new = in(reg) new,
                out = in(reg) out_ptr,
                old_lo = in(reg) old.pair.lo,
                old_hi = in(reg) old.pair.hi,
                // kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                out("r0") r, // old_val
                out("r1") _, // new_val
                in("r2") dst, // ptr
                // __kuser_cmpxchg64 clobbers r3, lr, and flags.
                inout("r3") KUSER_CMPXCHG64 => _,
                out("lr") _,
                // Do not use `preserves_flags` because ORRS, __kuser_cmpxchg64, and *S modify the condition flags.
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
        debug_assert_atomic_unsafe_precondition!(dst, u64);
        let old = MaybeUninit64 { whole: old };
        let new = MaybeUninit64 { whole: new };
        let (mut prev_lo, mut prev_hi);

        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            let mut r: i32;
            macro_rules! cmpxchg_weak {
                ($asm:ident, $acquire:expr, $release:expr, $cmp_fail_label:tt,
                    $branch_after_sc:tt
                ) => {
                    $asm!(
                        "ldrexd r2, r3, [{dst}]",                 // atomic { r2:r3 = *dst; EXCLUSIVE = dst }
                        "eor {tmp}, r3, {old_hi}",                // tmp = r3 ^ old_hi
                        "eor {r}, r2, {old_lo}",                  // r = r2 ^ old_lo
                        "orrs {r}, {tmp}",                        // r |= tmp; if r == 0 { Z = 1 } else { Z = 0 }
                        "mov {r}, #1",                            // r = 1
                        concat!("bne ", $cmp_fail_label),         // if Z == 0 { jump 'cmp-fail }
                        $release,                                 // fence
                        "strexd {r}, r4, r5, [{dst}]",            // atomic { if EXCLUSIVE == dst { *dst = r4:r5; r = 0 } else { r = 1 }; EXCLUSIVE = None }
                        if_any!($branch_after_sc, "cmp {r}, #0"), // if r == 0 { Z = 1 } else { Z = 0 }
                        $branch_after_sc,                         // if ? { jump '? }
                        "3:", // 'emit-fence:
                            $acquire,                             // fence
                        "4:", // 'skip-fence:
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
            atomic_cmpxchg_weak!(cmpxchg_weak, success, failure);
            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
            // 0 if the store was successful, 1 if no store was performed
            (MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole, r == 0)
        }
    }
}

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
