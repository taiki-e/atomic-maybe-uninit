# Changelog

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](https://semver.org).

<!--
Note: In this file, do not use the hard wrap in the middle of a sentence for compatibility with GitHub comment style markdown rendering.
-->

## [Unreleased]

## [0.3.2] - 2024-07-10

- Support Arm64EC (experimental). ([4d94b3c](https://github.com/taiki-e/atomic-maybe-uninit/commit/4d94b3c0fe4c51f061abb33196821c0e32fa3f21))

- Support swap/CAS on AVR (experimental). ([71b9a5f](https://github.com/taiki-e/atomic-maybe-uninit/commit/71b9a5fa905f59c0c285c78157ed2165bf974fa5))

- Make `into_inner` `const fn` on Rust 1.61+. (align to the [std atomic change in Rust 1.79](https://github.com/rust-lang/rust/pull/123522)) ([9c253dc](https://github.com/taiki-e/atomic-maybe-uninit/commit/9c253dcc6590f27f7d896400d07ac862fae5e712))

- Improve loongarch64 support. ([358360c](https://github.com/taiki-e/atomic-maybe-uninit/commit/358360c2d6b89cdd3315eae6ec6a3b0c6d3abff4))

- Make rustc version detection robust for custom toolchains. ([c034611](https://github.com/taiki-e/atomic-maybe-uninit/commit/c0346119bf7e9e07cf9887c1acf10413c529f266))

- Respect `RUSTC_WRAPPER` in rustc version detection.

- Our build script is now less likely to be [re-run unnecessarily](https://github.com/taiki-e/portable-atomic/issues/151) in versions where the cargo bug fix is available (cargo 1.79+). ([91ec716](https://github.com/taiki-e/atomic-maybe-uninit/commit/91ec716ee76d68c08c217f06be3865a99588afb6))

- Various optimizations
  - Optimize x86_32 64-bit load/store when SSE is not available. ([75ca334](https://github.com/taiki-e/atomic-maybe-uninit/commit/75ca334dac1d0974a2e61dbb4c3d89cb0cf6cf22))
  - Optimize PowerPC32 Acquire/SeqCst load. ([f5ce83b](https://github.com/taiki-e/atomic-maybe-uninit/commit/f5ce83be02e1f123a8e549200786d0efb299d29d))
  - Optimize x86 inline assembly. ([adaf3a9](https://github.com/taiki-e/atomic-maybe-uninit/commit/adaf3a99a74f63faea7bc7bf407925a0ec8b9c49), [3ba37e9](https://github.com/taiki-e/atomic-maybe-uninit/commit/3ba37e95b084f6a4dd9e08c7b4f08d23e1cf47f6), [fcc0bf8](https://github.com/taiki-e/atomic-maybe-uninit/commit/fcc0bf8c0ff677b608900c139a50d9b34da8d476))
  - Optimize s390x inline assembly. ([9ee7f57](https://github.com/taiki-e/atomic-maybe-uninit/commit/9ee7f57101e68aaadb5f2ef9be095517692e8e2a))

## [0.3.1] - 2023-10-14

- Add `as_ptr` and `from_ptr`.

- Optimize weak CAS on PowerPC.

- Optimize {8,16}-bit CAS on AArch64.

## [0.3.0] - 2023-10-01

- Optimize inline assemblies using `MaybeUninit` input/output of inline assembly implemented by [rust-lang/rust#114790](https://github.com/rust-lang/rust/pull/114790), where it is available. This greatly improves performance and is almost equivalent to std atomic types. ([#19](https://github.com/taiki-e/atomic-maybe-uninit/pull/19))

## [0.2.22] - 2023-08-15

- Add `cfg_{has,no}_atomic_{8,16,32,64,128,ptr}` macros to enable code when the corresponding atomic implementation is available/unavailable. ([#9](https://github.com/taiki-e/atomic-maybe-uninit/pull/9))

- Add `cfg_{has,no}_atomic_cas` macros to enable code when atomic swap/CAS implementation is available/unavailable. ([#9](https://github.com/taiki-e/atomic-maybe-uninit/pull/9))

- Documentation improvements. ([#17](https://github.com/taiki-e/atomic-maybe-uninit/pull/17), [#18](https://github.com/taiki-e/atomic-maybe-uninit/pull/18), thanks @RalfJung)

## [0.2.21] - 2023-08-10

- Fix AVR 16-bit atomic load/store.

- Optimize AArch64 128-bit atomic store/swap when the `lse128` target feature is enabled at compile-time.

- Optimize AArch64 128-bit atomic load/store when the `rcpc3` target feature is enabled at compile-time.

## [0.2.20] - 2023-08-02

- Support pre-v6 Arm Linux/Android (e.g., armv5te-unknown-linux-gnueabi, arm-linux-androideabi, etc.).

- Support Hexagon (experimental).

- Support AVR atomic load/store (experimental).

- Improve {8,16}-bit atomic implementations on RISC-V, PowerPC, MIPS, s390x, LoongArch64.

## [0.2.19] - 2023-07-27

- Support LoongArch64.

- Fix build error on MIPS32r6 and MIPS64r6 (both tier 3) since [nightly-2023-07-19's target_arch change](https://github.com/rust-lang/rust/pull/112374).

- Fix build error on big endian Armv8 AArch32 (tier 3).

- Acknowledge all x86_64 Apple targets support 128-bit atomics.

  Our code already recognizes this via `cfg(target_feature)`, so this only affects users using pre-1.69 stable rustc.

  See also [rust-lang/rust#112150](https://github.com/rust-lang/rust/pull/112150).

- Optimize inline assemblies.

## [0.2.18] - 2023-05-31

- Fix build error on AArch64 ILP32 ABI targets (tier 3).

- Optimize inline assemblies on PowerPC and s390x.

## [0.2.17] - 2023-05-09

- Fix bug in s390x atomic RMWs on old nightly.

- Optimize inline assemblies on RISC-V, PowerPC, s390x, and MSP430.

## [0.2.16] - 2023-04-30

**Note:** This release has been yanked due to a bug fixed in 0.2.17.

- Support 64-bit atomics on Armv7-R and Armv8-R.

- Fix bug in AArch64 16-bit compare_exchange_weak.

- Fix bug in AArch64 128-bit SeqCst load when FEAT_LSE2 is enabled at compile-time.

- Optimize AArch64 atomic load when the `rcpc` target feature is enabled at compile-time.

- Optimize PowerPC atomic RMWs.

## [0.2.15] - 2022-12-25

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Improve support for Armv8 AArch32.

- Optimize inline assemblies on x86.

- Documentation improvements.

## [0.2.14] - 2022-09-04

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Support pre-power8 powerpc64le. powerpc64le's default cpu version is power8, but you can technically compile it for the old cpu using the unsafe `-C target-cpu` rustc flag.

## [0.2.13] - 2022-08-17

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Support MSP430 atomic load/store.

- Use track_caller when debug assertions are enabled.

## [0.2.12] - 2022-08-03

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Optimize AArch64 128-bit atomic load when the `lse` target feature is enabled at compile-time.

## [0.2.11] - 2022-07-31

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Optimize inline assemblies on x86, Arm, AArch64, and RISC-V.

## [0.2.10] - 2022-07-16

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Support Armv6.

## [0.2.9] - 2022-06-30

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Add `compare_exchange`, `compare_exchange_weak`, and `fetch_update`. ([#7](https://github.com/taiki-e/atomic-maybe-uninit/pull/7))

- Support x86_64 128-bit atomics when the `cmpxchg16b` target feature is enabled at compile-time.

- Support x86 64-bit atomics.

## [0.2.8] - 2022-06-21

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Fix bug in powerpc64 128-bit atomics.

- Documentation improvements.

## [0.2.7] - 2022-06-19

**Note:** This release has been yanked due to a bug fixed in 0.2.8.

- Fix bug in powerpc64 SeqCst atomic load.

## [0.2.6] - 2022-06-16

**Note:** This release has been yanked due to a bug fixed in 0.2.7.

- Support PowerPC.

- Support s390x.

- Implement RISC-V 8-bit and 16-bit swap.

- Implement MIPS32r2 8-bit and 16-bit swap.

- Implement MIPS64r2 8-bit and 16-bit swap.

## [0.2.5] - 2022-05-30

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Support Armv6-M.

- Optimize AArch64 128-bit atomic load/store when the `lse2` target feature is enabled at compile-time.

## [0.2.4] - 2022-03-20

- Implement MIPS32r2 32-bit swap.

- Implement MIPS64r2 32-bit and 64-bit swap.

## [0.2.3] - 2022-03-19

- Support MIPS32r2 and MIPS64r2.

- Add `#[must_use]` to constructors.

## [0.2.2] - 2022-03-16

- Support Armv7-A, Armv7-R, Armv7-M, and Armv8-M.

## [0.2.1] - 2022-03-14

- Optimize AArch64 atomic swap when the `lse` target feature is enabled at compile-time.

- Document safety requirements of functions in `raw` module.

## [0.2.0] - 2022-03-13

- Support AArch64.

- Support X32 ABI.

- Remove `raw` feature and always expose `raw` module.

## [0.1.0] - 2022-03-12

Initial release

[Unreleased]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.2...HEAD
[0.3.2]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.22...v0.3.0
[0.2.22]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.21...v0.2.22
[0.2.21]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.20...v0.2.21
[0.2.20]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.19...v0.2.20
[0.2.19]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.18...v0.2.19
[0.2.18]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.17...v0.2.18
[0.2.17]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.16...v0.2.17
[0.2.16]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.15...v0.2.16
[0.2.15]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.14...v0.2.15
[0.2.14]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.13...v0.2.14
[0.2.13]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.12...v0.2.13
[0.2.12]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.11...v0.2.12
[0.2.11]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.10...v0.2.11
[0.2.10]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.9...v0.2.10
[0.2.9]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.8...v0.2.9
[0.2.8]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.7...v0.2.8
[0.2.7]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.6...v0.2.7
[0.2.6]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.5...v0.2.6
[0.2.5]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.4...v0.2.5
[0.2.4]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.3...v0.2.4
[0.2.3]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/taiki-e/atomic-maybe-uninit/releases/tag/v0.1.0
