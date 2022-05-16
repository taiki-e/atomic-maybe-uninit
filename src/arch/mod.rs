// Refs:
// - inline assembly reference: https://doc.rust-lang.org/nightly/reference/inline-assembly.html
// - inline assembly rust by example: https://doc.rust-lang.org/nightly/rust-by-example/unsafe/asm.html
// - feature(asm_experimental_arch): https://doc.rust-lang.org/nightly/unstable-book/language-features/asm-experimental-arch.html
//
// template for "generated asm" link: https://godbolt.org/z/PG9jrT58x

#[cfg(not(any(
    target_arch = "x86",
    target_arch = "x86_64",
    all(
        target_arch = "arm",
        any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7")
    ),
    target_arch = "aarch64",
    target_arch = "riscv32",
    target_arch = "riscv64",
    target_arch = "mips",
    target_arch = "mips64",
)))]
compile_error!("this target is not supported yet");

#[cfg(target_arch = "aarch64")]
mod aarch64;
#[cfg(all(
    target_arch = "arm",
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7")
))]
#[cfg(not(any(target_feature = "v8", atomic_maybe_uninit_target_feature = "v8")))]
mod armv7;
#[cfg(all(
    target_arch = "arm",
    any(target_feature = "v8", atomic_maybe_uninit_target_feature = "v8")
))]
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
mod armv8m;
#[cfg(any(target_arch = "mips", target_arch = "mips64"))]
mod mips;
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
mod riscv;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod x86;
