# atomic-maybe-uninit

[![crates.io](https://img.shields.io/crates/v/atomic-maybe-uninit?style=flat-square&logo=rust)](https://crates.io/crates/atomic-maybe-uninit)
[![docs.rs](https://img.shields.io/badge/docs.rs-atomic--maybe--uninit-blue?style=flat-square)](https://docs.rs/atomic-maybe-uninit)
[![license](https://img.shields.io/badge/license-Apache--2.0_OR_MIT-blue?style=flat-square)](#license)
[![rustc](https://img.shields.io/badge/rustc-1.59+-blue?style=flat-square&logo=rust)](https://www.rust-lang.org)
[![build status](https://img.shields.io/github/workflow/status/taiki-e/atomic-maybe-uninit/CI/main?style=flat-square&logo=github)](https://github.com/taiki-e/atomic-maybe-uninit/actions)

Atomic operations on potentially uninitialized integers.

## Motivation

Copying types containing uninitialized bytes (e.g., padding), via the standard library's atomic types is [undefined behavior because the copy goes through integers][undefined-behavior].

This crate provides a way to soundly perform such operations.

## Platform Support

Currently, x86, x86_64, AArch64, and RISC-V are supported.

| target_arch | primitives                                          | load | store | swap |
| ----------- | --------------------------------------------------- |:----:|:-----:|:----:|
| x86         | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓    | ✓     | ✓    |
| x86_64      | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓    | ✓     | ✓    |
| aarch64     | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓    | ✓     | ✓    |
| riscv32     | isize,usize,i32,u32                                 | ✓    | ✓     | ✓*   |
| riscv32     | i8,u8,i16,u16                                       | ✓    | ✓     |      |
| riscv64     | isize,usize,i32,u32,i64,u64                         | ✓    | ✓     | ✓*   |
| riscv64     | i8,u8,i16,u16                                       | ✓    | ✓     |      |

\* RISC-V's atomic swap requires the A extension.

Feel free to submit an issue if your target is not supported yet.

## Related Projects

- [portable-atomic]: Portable atomic types including extensions such as 128-bit atomics, atomic float, etc.
- [atomic-memcpy]: Byte-wise atomic memcpy.

[atomic-memcpy]: https://github.com/taiki-e/atomic-memcpy
[portable-atomic]: https://github.com/taiki-e/portable-atomic
[undefined-behavior]: https://doc.rust-lang.org/reference/behavior-considered-undefined.html

## License

Licensed under either of [Apache License, Version 2.0](LICENSE-APACHE) or
[MIT license](LICENSE-MIT) at your option.

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall
be dual licensed as above, without any additional terms or conditions.
