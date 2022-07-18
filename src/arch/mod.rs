// Refs:
// - inline assembly reference: https://doc.rust-lang.org/nightly/reference/inline-assembly.html
// - inline assembly rust by example: https://doc.rust-lang.org/nightly/rust-by-example/unsafe/asm.html
// - feature(asm_experimental_arch): https://doc.rust-lang.org/nightly/unstable-book/language-features/asm-experimental-arch.html
// - asm module in rustc_target: https://github.com/rust-lang/rust/tree/1.62.0/compiler/rustc_target/src/asm
// - asm module in rustc_codegen_llvm: https://github.com/rust-lang/rust/blob/1.62.0/compiler/rustc_codegen_llvm/src/asm.rs
// - inline assembly related issues in rust-lang/rust: https://github.com/rust-lang/rust/labels/A-inline-assembly

#[cfg(not(any(
    target_arch = "x86",
    target_arch = "x86_64",
    all(
        target_arch = "arm",
        any(any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6")),
    ),
    target_arch = "aarch64",
    target_arch = "riscv32",
    target_arch = "riscv64",
    target_arch = "mips",
    target_arch = "mips64",
    target_arch = "powerpc",
    target_arch = "powerpc64",
    target_arch = "s390x",
)))]
compile_error!("this target is not supported yet");

#[cfg(target_arch = "aarch64")]
mod aarch64;
#[cfg(all(
    target_arch = "arm",
    any(
        any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
        all(
            any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
            any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"),
        )
    ),
    not(any(target_feature = "v8", atomic_maybe_uninit_target_feature = "v8"))
))]
mod arm;
#[cfg(all(
    target_arch = "arm",
    any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
    not(any(
        target_feature = "v7",
        atomic_maybe_uninit_target_feature = "v7",
        target_feature = "mclass",
        atomic_maybe_uninit_target_feature = "mclass"
    )),
))]
mod armv6;
#[cfg(all(
    target_arch = "arm",
    any(target_feature = "v8", atomic_maybe_uninit_target_feature = "v8"),
    any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")
))]
mod armv8m;
#[cfg(any(target_arch = "mips", target_arch = "mips64"))]
mod mips;
#[cfg(any(target_arch = "powerpc", target_arch = "powerpc64"))]
mod powerpc;
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
mod riscv;
#[cfg(target_arch = "s390x")]
mod s390x;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod x86;
