// SPDX-License-Identifier: Apache-2.0 OR MIT

// This module contains the atomic implementation for older rustc that does not support MaybeUninit registers.
//
// The implementation is based on the code just before we started using MaybeUninit registers.

#[cfg(not(any(
    target_arch = "x86",
    target_arch = "x86_64",
    all(
        target_arch = "arm",
        any(
            target_feature = "v6",
            atomic_maybe_uninit_target_feature = "v6",
            target_os = "linux",
            target_os = "android",
        ),
    ),
    target_arch = "aarch64",
    target_arch = "riscv32",
    target_arch = "riscv64",
    all(target_arch = "loongarch64", not(atomic_maybe_uninit_no_loongarch64_asm)),
    all(
        any(
            target_arch = "avr",
            target_arch = "hexagon",
            target_arch = "mips",
            target_arch = "mips32r6",
            target_arch = "mips64",
            target_arch = "mips64r6",
            target_arch = "msp430",
            target_arch = "powerpc",
            target_arch = "powerpc64",
            target_arch = "s390x",
        ),
        atomic_maybe_uninit_unstable_asm_experimental_arch,
    ),
)))]
#[path = "../arch/cfgs/unsupported.rs"]
mod unsupported;

#[cfg(target_arch = "aarch64")]
mod aarch64;
#[cfg(target_arch = "arm")]
#[cfg(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(any(
        target_feature = "v8",
        atomic_maybe_uninit_target_feature = "v8",
        target_feature = "v8m",
        atomic_maybe_uninit_target_feature = "v8m",
    )),
))]
mod arm;
#[cfg(target_arch = "arm")]
#[cfg(all(
    any(target_os = "linux", target_os = "android"),
    not(any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6")),
))]
mod arm_linux;
#[cfg(target_arch = "arm")]
#[cfg(any(
    target_feature = "v8",
    atomic_maybe_uninit_target_feature = "v8",
    target_feature = "v8m",
    atomic_maybe_uninit_target_feature = "v8m",
))]
mod armv8;
#[cfg(target_arch = "avr")]
#[cfg(atomic_maybe_uninit_unstable_asm_experimental_arch)]
#[path = "../arch/avr.rs"]
mod avr;
#[cfg(target_arch = "hexagon")]
#[cfg(atomic_maybe_uninit_unstable_asm_experimental_arch)]
mod hexagon;
#[cfg(target_arch = "loongarch64")]
#[cfg(not(atomic_maybe_uninit_no_loongarch64_asm))]
mod loongarch;
#[cfg(any(
    target_arch = "mips",
    target_arch = "mips32r6",
    target_arch = "mips64",
    target_arch = "mips64r6",
))]
#[cfg(atomic_maybe_uninit_unstable_asm_experimental_arch)]
mod mips;
#[cfg(target_arch = "msp430")]
#[cfg(atomic_maybe_uninit_unstable_asm_experimental_arch)]
mod msp430;
#[cfg(any(target_arch = "powerpc", target_arch = "powerpc64"))]
#[cfg(atomic_maybe_uninit_unstable_asm_experimental_arch)]
mod powerpc;
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
mod riscv;
#[cfg(target_arch = "s390x")]
#[cfg(atomic_maybe_uninit_unstable_asm_experimental_arch)]
mod s390x;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod x86;
