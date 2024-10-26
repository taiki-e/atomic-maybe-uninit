// SPDX-License-Identifier: Apache-2.0 OR MIT
// This file is @generated by target_spec.sh.
// It is not intended for manual editing.

#![allow(dead_code, unused_macros)]

// On AArch64, the base register of memory-related instructions must be 64-bit.
// Passing a 32-bit value to `in(reg)` on AArch64 results in the upper bits
// having an undefined value, but to work correctly with ILP32 ABI, the upper
// bits must be zero, which is handled here by casting to u64. Another way to
// handle this is to pass it as a pointer and clear the upper bits inside asm,
// but it is easier to overlook than cast, which can catch overlooks by
// asm_sub_register lint.
// See also https://github.com/ARM-software/abi-aa/blob/2024Q3/aapcs64/aapcs64.rst#pointers
//
// Except for x86_64, which can use 32-bit registers in the destination operand
// (on x86_64, we use the ptr_modifier macro to handle this), we need to do the
// same for ILP32 ABI on other 64-bit architectures. (At least, as far as I can
// see from the assembly generated by LLVM, this is also required for MIPS64 N32
// ABI. I don't know about the RISC-V s64ilp32 ABI for which a patch was
// recently submitted to the kernel, but in any case, this should be a safe
// default for such ABIs).
//
// Known architectures that have such ABI are x86_64 (X32), AArch64 (ILP32),
// mips64 (N32), and riscv64 (s64ilp32, not merged yet though). (As of
// 2023-06-05, only the former two are supported by rustc.) However, we list all
// known 64-bit architectures because similar ABIs may exist or future added for
// other architectures.
#[cfg(all(
    target_pointer_width = "32",
    any(
        target_arch = "aarch64",
        target_arch = "arm64ec",
        target_arch = "bpf",
        target_arch = "loongarch64",
        target_arch = "mips64",
        target_arch = "mips64r6",
        target_arch = "nvptx64",
        target_arch = "powerpc64",
        target_arch = "riscv64",
        target_arch = "s390x",
        target_arch = "sparc64",
        target_arch = "wasm64",
        target_arch = "x86_64",
    ),
))]
#[macro_use]
mod imp {
    macro_rules! ptr_reg {
        ($ptr:ident) => {{
            let _: *const _ = $ptr; // ensure $ptr is a pointer (*mut _ or *const _)
            #[cfg(not(atomic_maybe_uninit_no_asm_maybe_uninit))]
            #[allow(clippy::ptr_as_ptr)]
            {
                // If we cast to u64 here, the provenance will be lost,
                // so we convert to MaybeUninit<u64> via zero extend helper.
                crate::utils::zero_extend64_ptr($ptr as *mut ())
            }
            #[cfg(atomic_maybe_uninit_no_asm_maybe_uninit)]
            {
                // Use cast on old rustc because it does not support MaybeUninit
                // registers. This is still permissive-provenance compatible and
                // is sound.
                $ptr as u64
            }
        }};
    }
    pub(crate) type RegSize = u64;
}
#[cfg(not(all(
    target_pointer_width = "32",
    any(
        target_arch = "aarch64",
        target_arch = "arm64ec",
        target_arch = "bpf",
        target_arch = "loongarch64",
        target_arch = "mips64",
        target_arch = "mips64r6",
        target_arch = "nvptx64",
        target_arch = "powerpc64",
        target_arch = "riscv64",
        target_arch = "s390x",
        target_arch = "sparc64",
        target_arch = "wasm64",
        target_arch = "x86_64",
    ),
)))]
#[macro_use]
mod imp {
    macro_rules! ptr_reg {
        ($ptr:ident) => {{
            let _: *const _ = $ptr; // ensure $ptr is a pointer (*mut _ or *const _)
            $ptr // cast is unnecessary here.
        }};
    }
    pub(crate) type RegSize = usize;
}
pub(crate) use self::imp::RegSize;
