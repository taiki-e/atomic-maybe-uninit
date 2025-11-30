# atomic-maybe-uninit

[![crates.io](https://img.shields.io/crates/v/atomic-maybe-uninit?style=flat-square&logo=rust)](https://crates.io/crates/atomic-maybe-uninit)
[![docs.rs](https://img.shields.io/badge/docs.rs-atomic--maybe--uninit-blue?style=flat-square&logo=docs.rs)](https://docs.rs/atomic-maybe-uninit)
[![license](https://img.shields.io/badge/license-Apache--2.0_OR_MIT-blue?style=flat-square)](#license)
[![msrv](https://img.shields.io/badge/msrv-1.74-blue?style=flat-square&logo=rust)](https://www.rust-lang.org)
[![github actions](https://img.shields.io/github/actions/workflow/status/taiki-e/atomic-maybe-uninit/ci.yml?branch=main&style=flat-square&logo=github)](https://github.com/taiki-e/atomic-maybe-uninit/actions)

<!-- tidy:sync-markdown-to-rustdoc:start:src/lib.rs -->

Atomic operations on potentially uninitialized integers.

## Motivation

Copying types containing uninitialized bytes (e.g., padding), via the standard library's atomic types
is [undefined behavior because the copy goes through integers][undefined-behavior].

This crate provides a way to soundly perform such operations.

## Platform Support

Currently, x86, x86_64, Arm, AArch64, RISC-V, LoongArch, Arm64EC, s390x, MIPS, PowerPC, MSP430, AVR, SPARC, Hexagon, M68k, C-SKY, and Xtensa are supported.
(You can use `cfg_{has,no}_*` macros to write code based on whether or not which size of primitives is available.)

| target_arch                                 | primitives                                          | load/store | swap/CAS |
| ------------------------------------------- | --------------------------------------------------- |:----------:|:--------:|
| x86                                         | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| x86_64                                      | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| x86_64 (+cmpxchg16b) \[2]                   | i128,u128                                           | ✓          | ✓        |
| arm (v6+ or Linux/Android)                  | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |
| arm (except for M-profile) \[3]             | i64,u64                                             | ✓          | ✓        |
| aarch64                                     | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓        |
| riscv32                                     | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |
| riscv32 (+zacas) \[4]                       | i64,u64                                             | ✓          | ✓        |
| riscv64                                     | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓\[1]    |
| riscv64 (+zacas) \[4]                       | i128,u128                                           | ✓          | ✓        |
| loongarch64                                 | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| loongarch32 \[8] (experimental)             | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓        |
| arm64ec \[7]                                | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓        |
| s390x \[7]                                  | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓        |
| mips / mips32r6 \[9]                        | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓        |
| mips64 / mips64r6 \[9]                      | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| powerpc \[9]                                | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓        |
| powerpc64 \[9]                              | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| powerpc64 (+quadword-atomics) \[5] \[9]     | i128,u128                                           | ✓          | ✓        |
| msp430 \[9] (experimental)                  | isize,usize,i8,u8,i16,u16                           | ✓          | ✓        |
| avr \[9] (experimental)                     | isize,usize,i8,u8,i16,u16                           | ✓          | ✓        |
| sparc \[6] \[9] (experimental)              | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓        |
| sparc64 \[9] (experimental)                 | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| hexagon \[9] (experimental)                 | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| m68k \[9] (experimental)                    | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |
| m68k (+isa-68020) \[9] \[10] (experimental) | i64,u64                                             | ✓          | ✓        |
| csky \[9] (experimental)                    | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |
| xtensa \[9] (experimental)                  | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |

\[1] Arm's atomic RMW operations are not available on Armv6-M (thumbv6m). RISC-V's atomic RMW operations are not available on targets without the A (or G which means IMAFD) or Zalrsc or Zacas extension, such as riscv32i, riscv32imc, etc. M68k's atomic RMW operations requires target-cpu M68020+ (enabled by default on Linux). C-SKY's atomic RMW operations requires target-cpu ck860\* or c860\* (enabled by default on the hard-float target). Xtensa's atomic RMW operations are not available on esp32s2.<br>
\[2] Requires `cmpxchg16b` target feature (enabled by default on Apple, Windows (except Windows 7), and Fuchsia targets).<br>
\[3] Armv6+ or Linux/Android, except for M-profile architecture such as thumbv6m, thumbv7m, etc.<br>
\[4] Requires `zacas` target feature.<br>
\[5] Requires `quadword-atomics` target feature (enabled by default on powerpc64le).<br>
\[6] Requires `v9` or `leoncasa` target feature (enabled by default on Linux).<br>
\[7] Requires Rust 1.84+.<br>
\[8] Requires Rust 1.91+.<br>
\[9] Requires nightly due to `#![feature(asm_experimental_arch)]`.<br>
\[10] Requires target-cpu M68020+ (enabled by default on Linux).<br>

See also [Atomic operation overview by architecture](https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md)
for more information about atomic operations in these architectures.

Feel free to submit an issue if your target is not supported yet.

## Related Projects

- [portable-atomic]: Portable atomic types including support for 128-bit atomics, atomic float, etc.
- [atomic-memcpy]: Byte-wise atomic memcpy.

[atomic-memcpy]: https://github.com/taiki-e/atomic-memcpy
[portable-atomic]: https://github.com/taiki-e/portable-atomic
[undefined-behavior]: https://doc.rust-lang.org/reference/behavior-considered-undefined.html

<!-- tidy:sync-markdown-to-rustdoc:end -->

## License

Licensed under either of [Apache License, Version 2.0](LICENSE-APACHE) or
[MIT license](LICENSE-MIT) at your option.

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall
be dual licensed as above, without any additional terms or conditions.
