# atomic-maybe-uninit

[![crates.io](https://img.shields.io/crates/v/atomic-maybe-uninit?style=flat-square&logo=rust)](https://crates.io/crates/atomic-maybe-uninit)
[![docs.rs](https://img.shields.io/badge/docs.rs-atomic--maybe--uninit-blue?style=flat-square&logo=docs.rs)](https://docs.rs/atomic-maybe-uninit)
[![license](https://img.shields.io/badge/license-Apache--2.0_OR_MIT-blue?style=flat-square)](#license)
[![rustc](https://img.shields.io/badge/rustc-1.59+-blue?style=flat-square&logo=rust)](https://www.rust-lang.org)
[![build status](https://img.shields.io/github/actions/workflow/status/taiki-e/atomic-maybe-uninit/ci.yml?branch=main&style=flat-square&logo=github)](https://github.com/taiki-e/atomic-maybe-uninit/actions)
[![build status](https://img.shields.io/cirrus/github/taiki-e/atomic-maybe-uninit/main?style=flat-square&logo=cirrusci)](https://cirrus-ci.com/github/taiki-e/atomic-maybe-uninit)

<!-- tidy:crate-doc:start -->
Atomic operations on potentially uninitialized integers.

## Motivation

Copying types containing uninitialized bytes (e.g., padding), via the standard library's atomic types is [undefined behavior because the copy goes through integers][undefined-behavior].

This crate provides a way to soundly perform such operations.

## Platform Support

Currently, x86, x86_64, ARM (v6+), AArch64, RISC-V, MIPS32r2, MIPS64r2, PowerPC, s390x, and MSP430 are supported.

| target_arch                          | primitives                                          | load/store | swap  | CAS   |
| ------------------------------------ | --------------------------------------------------- |:----------:|:-----:|:-----:|
| x86                                  | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓     | ✓     |
| x86_64                               | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓     | ✓     |
| x86_64 (+cmpxchg16b)                 | i128,u128                                           | ✓          | ✓     | ✓     |
| arm (v6+)                            | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1] | ✓\[1] |
| arm (v6 except v6-m, v7-{a,r}+) \[2] | i64,u64                                             | ✓          | ✓     | ✓     |
| aarch64                              | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓     | ✓     |
| riscv32                              | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1] | ✓\[1] |
| riscv64                              | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓\[1] | ✓\[1] |
| mips \[3]                            | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓     | ✓     |
| mips64 \[3]                          | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓     | ✓     |
| powerpc \[3]                         | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓     | ✓     |
| powerpc64 \[3]                       | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓     | ✓     |
| powerpc64 (pwr8+) \[3] \[4]          | i128,u128                                           | ✓          | ✓     | ✓     |
| s390x \[3]                           | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓     | ✓     |
| msp430 \[3]                          | isize,usize,i8,u8,i16,u16                           | ✓          |       |       |

\[1] ARM's atomic RMW operations are not available on v6-m (thumbv6m). RISC-V's atomic RMW operations are not available on targets without the A (or G which means IMAFD) extension such as riscv32i, riscv32imc, etc.<br>
\[2] ARMv6 except ARMv6-M, ARMv7+ with A-profile or R-profile<br>
\[3] Requires nightly due to `#![feature(asm_experimental_arch)]`.<br>
\[4] target-cpu `pwr8`, `pwr9`, or `pwr10`. powerpc64le is `pwr8` by default.<br>

Feel free to submit an issue if your target is not supported yet.

## Related Projects

- [portable-atomic]: Portable atomic types including support for 128-bit atomics, atomic float, etc.
- [atomic-memcpy]: Byte-wise atomic memcpy.

[atomic-memcpy]: https://github.com/taiki-e/atomic-memcpy
[portable-atomic]: https://github.com/taiki-e/portable-atomic
[undefined-behavior]: https://doc.rust-lang.org/reference/behavior-considered-undefined.html

<!-- tidy:crate-doc:end -->

## License

Licensed under either of [Apache License, Version 2.0](LICENSE-APACHE) or
[MIT license](LICENSE-MIT) at your option.

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall
be dual licensed as above, without any additional terms or conditions.
