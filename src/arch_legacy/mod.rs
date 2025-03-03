// SPDX-License-Identifier: Apache-2.0 OR MIT

// This module contains the atomic implementation for older rustc that does not support MaybeUninit registers.
//
// The implementation is based on the code just before we started using MaybeUninit registers.

#![allow(missing_docs)] // For cfg_* macros.

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
    all(target_arch = "loongarch64", not(atomic_maybe_uninit_no_asm)),
)))]
#[path = "../arch/unsupported.rs"]
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
#[cfg(target_arch = "loongarch64")]
#[cfg(not(atomic_maybe_uninit_no_asm))]
mod loongarch;
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
mod riscv;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod x86;
