# Changelog

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](https://semver.org).

<!--
Note: In this file, do not use the hard wrap in the middle of a sentence for compatibility with GitHub comment style markdown rendering.
-->

## [Unreleased]

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

[Unreleased]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.2...HEAD
[0.2.2]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/taiki-e/atomic-maybe-uninit/releases/tag/v0.1.0
