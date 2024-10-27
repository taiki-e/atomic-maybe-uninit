// SPDX-License-Identifier: Apache-2.0 OR MIT

// Refs:
// - inline assembly reference: https://doc.rust-lang.org/nightly/reference/inline-assembly.html
// - inline assembly rust by example: https://doc.rust-lang.org/nightly/rust-by-example/unsafe/asm.html
// - feature(asm_experimental_arch): https://doc.rust-lang.org/nightly/unstable-book/language-features/asm-experimental-arch.html
// - asm module in rustc_target: https://github.com/rust-lang/rust/tree/HEAD/compiler/rustc_target/src/asm
// - asm module in rustc_codegen_llvm: https://github.com/rust-lang/rust/blob/HEAD/compiler/rustc_codegen_llvm/src/asm.rs
// - LLVM LangRef: https://llvm.org/docs/LangRef.html#inline-assembler-expressions
// - inline assembly related issues in rust-lang/rust: https://github.com/rust-lang/rust/labels/A-inline-assembly

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
    target_arch = "loongarch64",
    all(
        any(
            target_arch = "arm64ec",
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
            target_arch = "xtensa",
        ),
        atomic_maybe_uninit_unstable_asm_experimental_arch,
    ),
)))]
#[path = "cfgs/unsupported.rs"]
mod unsupported;

#[cfg(any(
    target_arch = "aarch64",
    all(target_arch = "arm64ec", atomic_maybe_uninit_unstable_asm_experimental_arch),
))]
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
mod avr;
#[cfg(target_arch = "hexagon")]
#[cfg(atomic_maybe_uninit_unstable_asm_experimental_arch)]
mod hexagon;
#[cfg(target_arch = "loongarch64")]
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
#[cfg_attr(atomic_maybe_uninit_s390x_no_reg_addr, path = "s390x_no_reg_addr.rs")]
mod s390x;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod x86;
#[cfg(target_arch = "xtensa")]
#[cfg(atomic_maybe_uninit_unstable_asm_experimental_arch)]
mod xtensa;
