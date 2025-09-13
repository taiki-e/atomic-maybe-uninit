// SPDX-License-Identifier: Apache-2.0 OR MIT

// Note: This file is enabled when the current target is not supported.

// Refs:
// - inline assembly reference: https://doc.rust-lang.org/nightly/reference/inline-assembly.html
// - inline assembly rust by example: https://doc.rust-lang.org/nightly/rust-by-example/unsafe/asm.html
// - feature(asm_experimental_arch): https://doc.rust-lang.org/nightly/unstable-book/language-features/asm-experimental-arch.html
// - asm module in rustc_target: https://github.com/rust-lang/rust/tree/HEAD/compiler/rustc_target/src/asm
// - asm module in rustc_codegen_llvm: https://github.com/rust-lang/rust/blob/HEAD/compiler/rustc_codegen_llvm/src/asm.rs
// - LLVM LangRef: https://llvm.org/docs/LangRef.html#inline-assembler-expressions
// - inline assembly related issues in rust-lang/rust: https://github.com/rust-lang/rust/labels/A-inline-assembly

#[cfg(test)]
compile_error!("testing unsupported target is not supported");

#[macro_export]
macro_rules! cfg_has_atomic_8 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_8 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_16 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_16 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
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
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
