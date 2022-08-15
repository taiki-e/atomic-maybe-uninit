# Changelog

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](https://semver.org).

<!--
Note: In this file, do not use the hard wrap in the middle of a sentence for compatibility with GitHub comment style markdown rendering.
-->

## [Unreleased]

- Use track_caller when debug assertions are enabled.

## [0.2.12] - 2022-08-03

- Optimize AArch64 128-bit atomic load when the `lse` target feature is enabled at compile-time.

## [0.2.11] - 2022-07-31

- Optimize inline assemblies on x86, x86_64, ARM, AArch64, and RISC-V.

## [0.2.10] - 2022-07-16

- Support ARMv6.

## [0.2.9] - 2022-06-30

- Add `compare_exchange`, `compare_exchange_weak`, and `fetch_update`. ([#7](https://github.com/taiki-e/atomic-maybe-uninit/pull/7))

- Support x86_64 128-bit atomics when the `cmpxchg16b` target feature is enabled at compile-time.

- Support x86 64-bit atomics.

## [0.2.8] - 2022-06-21

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

- Support ARMv6-M.

- Optimize AArch64 128-bit atomic load/store when the `lse2` target feature is enabled at compile-time.

## [0.2.4] - 2022-03-20

- Implement MIPS32r2 32-bit swap.

- Implement MIPS64r2 32-bit and 64-bit swap.

## [0.2.3] - 2022-03-19

- Support MIPS32r2 and MIPS64r2.

- Add `#[must_use]` to constructors.

## [0.2.2] - 2022-03-16

- Support ARMv7-A, ARMv7-R, ARMv7-M, and ARMv8-M.

## [0.2.1] - 2022-03-14

- Optimize AArch64 atomic swap when the `lse` target feature is enabled at compile-time.

- Document safety requirements of functions in `raw` module.

## [0.2.0] - 2022-03-13

- Support AArch64.

- Support X32 ABI.

- Remove `raw` feature and always expose `raw` module.

## [0.1.0] - 2022-03-12

Initial release

[Unreleased]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.12...HEAD
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
