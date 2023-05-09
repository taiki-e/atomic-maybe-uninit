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
        any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    ),
    target_arch = "aarch64",
    target_arch = "riscv32",
    target_arch = "riscv64",
    target_arch = "mips",
    target_arch = "mips64",
    target_arch = "powerpc",
    target_arch = "powerpc64",
    target_arch = "s390x",
    target_arch = "msp430",
)))]
compile_error!("this target is not supported yet");

#[cfg(target_arch = "aarch64")]
mod aarch64;
#[cfg(target_arch = "arm")]
#[cfg(all(
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(all(
        any(
            target_feature = "v8",
            atomic_maybe_uninit_target_feature = "v8",
            target_feature = "v8m",
            atomic_maybe_uninit_target_feature = "v8m",
        ),
        target_endian = "little",
    )),
))]
mod arm;
#[cfg(target_arch = "arm")]
#[cfg(all(
    any(
        target_feature = "v8",
        atomic_maybe_uninit_target_feature = "v8",
        target_feature = "v8m",
        atomic_maybe_uninit_target_feature = "v8m",
    ),
    target_endian = "little",
))]
mod armv8;
#[cfg(any(target_arch = "mips", target_arch = "mips64"))]
mod mips;
#[cfg(target_arch = "msp430")]
mod msp430;
#[cfg(any(target_arch = "powerpc", target_arch = "powerpc64"))]
mod powerpc;
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
mod riscv;
#[cfg(target_arch = "s390x")]
mod s390x;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod x86;
