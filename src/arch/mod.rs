// Refs:
// - inline assembly reference: https://doc.rust-lang.org/nightly/reference/inline-assembly.html
// - inline assembly rust by example: https://doc.rust-lang.org/nightly/rust-by-example/unsafe/asm.html
// - feature(asm_experimental_arch): https://doc.rust-lang.org/stable/unstable-book/language-features/asm-experimental-arch.html
//
// template for "generated asm" link: https://godbolt.org/z/PG9jrT58x

#[cfg(not(any(
    target_arch = "x86",
    target_arch = "x86_64",
    target_arch = "aarch64",
    target_arch = "riscv32",
    target_arch = "riscv64"
)))]
compile_error!("this target is not supported yet");

#[cfg(target_arch = "aarch64")]
mod aarch64;
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
mod riscv;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod x86;
