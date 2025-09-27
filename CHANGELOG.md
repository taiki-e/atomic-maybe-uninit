# Changelog

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](https://semver.org).

Releases may yanked if there is a security bug, a soundness bug, or a regression.

<!--
Note: In this file, do not use the hard wrap in the middle of a sentence for compatibility with GitHub comment style markdown rendering.
-->

## [Unreleased]

- Support 64-bit atomics on M68k.

- Optimize CAS on Hexagon and MIPS.

- Optimize {8,16}-bit CAS on RISC-V and Xtensa.

## [0.3.11] - 2025-09-25

- Fix bug in CAS on M68k. ([3b022e7](https://github.com/taiki-e/atomic-maybe-uninit/commit/3b022e7dd3d82feff1bfd18002539f7f774d0673))

- Optimize 64-bit load/store on x86_32. ([3b45646](https://github.com/taiki-e/atomic-maybe-uninit/commit/3b4564625830e8685a94818cba6e4698cd0f2113))

- Optimize 8-bit swap/CAS on AVR. ([cbab034](https://github.com/taiki-e/atomic-maybe-uninit/commit/cbab034f49fcd8cd508832ee45f4abb2661bfdd5))

## [0.3.10] - 2025-09-12

- Increase the minimum supported Rust version (MSRV) from Rust 1.59 to Rust 1.74. ([#48](https://github.com/taiki-e/atomic-maybe-uninit/pull/48))
  This removes legacy [inefficient](https://github.com/crossbeam-rs/crossbeam/pull/1015#issuecomment-1676549870) implementation for pre-1.74 Rust which doesn't support `MaybeUninit` registers in `asm!`. ([#48](https://github.com/taiki-e/atomic-maybe-uninit/pull/48))

- Deprecate `AtomicMaybeUninit::const_new` because `AtomicMaybeUninit::new` is now always `const fn` because of the MSRV bump. ([#48](https://github.com/taiki-e/atomic-maybe-uninit/pull/48), [d428f97](https://github.com/taiki-e/atomic-maybe-uninit/commit/d428f975f88f4bfeffd2e31656bc18200722deff))

- Fix bug in 64-bit atomics on pre-v6 Arm Linux/Android. ([075494c](https://github.com/taiki-e/atomic-maybe-uninit/commit/075494c1d7c6ab6db6c12c2adc149a1e16b9c5ae))

- Optimize AArch64 128-bit CAS when FEAT_LSE is not enabled. ([0015d1a](https://github.com/taiki-e/atomic-maybe-uninit/commit/0015d1ae76c8d79285d482c999f250386c5fb142))

## [0.3.9] - 2025-09-05

- Update to stabilized [LoongArch32](https://github.com/rust-lang/rust/pull/144402) inline assembly. ([803b062](https://github.com/taiki-e/atomic-maybe-uninit/commit/803b06263c8a3e38596eb48aec88d2dce77d60e6))

## [0.3.8] - 2025-07-06

- Support LoongArch32 (experimental). ([a4a93e7](https://github.com/taiki-e/atomic-maybe-uninit/commit/a4a93e7fd76b6f3827f41f0a1cbee9c2bcf673d8))

## [0.3.7] - 2025-03-04

- Improve RISC-V support
  - Support 64-bit atomics on riscv32 when Zacas extension is available. ([f32463f](https://github.com/taiki-e/atomic-maybe-uninit/commit/f32463f92c35c9ee902e07c08e3952698db5b2a8))
  - Support 128-bit atomics on riscv64 when Zacas extension is available. ([f32463f](https://github.com/taiki-e/atomic-maybe-uninit/commit/f32463f92c35c9ee902e07c08e3952698db5b2a8))
  - Provide all operations when Zalrsc or Zacas extension is available even if A extension is not available. ([2668665](https://github.com/taiki-e/atomic-maybe-uninit/commit/26686651192aea4d7380b162c4b60c1772f70903), [7069c98](https://github.com/taiki-e/atomic-maybe-uninit/commit/7069c98f15a393b5dfdbcae2cffe6f2a20157197))
  - Optimize atomic CAS when Zacas extension is available. ([0d7dc48](https://github.com/taiki-e/atomic-maybe-uninit/commit/0d7dc48172b3cab61b9a4a9b3a957b9a40bf20c3), [ed74261](https://github.com/taiki-e/atomic-maybe-uninit/commit/ed7426182f2f4bc04166a918c44cc20b599d34e6))

- Support PowerPC CPUs without `lwsync` instruction such as e500. ([91812c2](https://github.com/taiki-e/atomic-maybe-uninit/commit/91812c2ebabd24de38294627fff3eeec0f04d46d), [79f7479](https://github.com/taiki-e/atomic-maybe-uninit/commit/79f7479e60adca8da1f2c10d2c4598553475a8e1))

- Improve support for very legacy CPUs on x86 and MIPS. ([02627e2](https://github.com/taiki-e/atomic-maybe-uninit/commit/02627e29c6997bbfecd52876dec5aec32b74d6b0), [2877324](https://github.com/taiki-e/atomic-maybe-uninit/commit/2877324dd82c67b14dee34b83fc5b81c630dee65), [292f6b3](https://github.com/taiki-e/atomic-maybe-uninit/commit/292f6b314eb335c4ba4a9b25de61c091ca6663aa))

- Optimize Arm/AArch64 atomic store/RMWs. ([fdea51f](https://github.com/taiki-e/atomic-maybe-uninit/commit/fdea51fd020eb5769b58e8a0e189bd92559e3f7e))

- Optimize MSP430 atomic RMWs. ([e76c112](https://github.com/taiki-e/atomic-maybe-uninit/commit/e76c11237f9a708e9952e03f40653c2cf142c30e))

## [0.3.6] - 2025-01-05

- Optimize Hexagon atomic RMWs. ([cd12f7b](https://github.com/taiki-e/atomic-maybe-uninit/commit/cd12f7b60fb41796528fe351e6d5b8ad1bb3dedf))

- Improve compile-time detection of x86_32 x87. ([7c40f86](https://github.com/taiki-e/atomic-maybe-uninit/commit/7c40f86e2eba61bdf4268129c39d1721f2efe1f1))

- Improve compile-time detection of m68k isa-68020. ([0aec2a6](https://github.com/taiki-e/atomic-maybe-uninit/commit/0aec2a6703d4bc92bbd5e9619d370754d0299754))

- Improve diagnostics when method is unavailable. ([b9f7f2d](https://github.com/taiki-e/atomic-maybe-uninit/commit/b9f7f2da3af19cee947ac2685833de6d9a924959))

## [0.3.5] - 2024-11-23

- Documentation improvements.

## [0.3.4] - 2024-11-19

This release includes improvements to platform support, various optimizations, [significant improvements to code comments](https://github.com/taiki-e/atomic-maybe-uninit/pull/30), etc.

- Improvements to platform support:
  - Support SPARC/SPARC64 (experimental). ([#31](https://github.com/taiki-e/atomic-maybe-uninit/pull/31))
  - Support M68k (experimental). ([#27](https://github.com/taiki-e/atomic-maybe-uninit/pull/27), [#28](https://github.com/taiki-e/atomic-maybe-uninit/pull/28))
  - Support Xtensa (experimental). ([#26](https://github.com/taiki-e/atomic-maybe-uninit/pull/26), [#29](https://github.com/taiki-e/atomic-maybe-uninit/pull/29))
  - Support swap/CAS on MSP430 (experimental). ([4fb09a7](https://github.com/taiki-e/atomic-maybe-uninit/commit/4fb09a724485073ebdcb27ecd2d89a2e30997f7f))

- Update to stabilized [s390x](https://github.com/rust-lang/rust/pull/131258) and [Arm64EC](https://github.com/rust-lang/rust/pull/131781) inline assembly. ([c9d7286](https://github.com/taiki-e/atomic-maybe-uninit/commit/c9d72863c9701ed6b91088631fd6c83c3635d8dd), [3a85789](https://github.com/taiki-e/atomic-maybe-uninit/commit/3a85789eda2cf3c1432335b91d2e73d2d763721f))

- Make `from_ptr` `const fn` on Rust 1.83+. (align to the [std atomic change in Rust 1.84](https://github.com/rust-lang/rust/pull/131717)) ([c8ef5c4](https://github.com/taiki-e/atomic-maybe-uninit/commit/c8ef5c4eefb45d372c8b95ab196d5b1ed195f810))

- Various optimizations:
  - AArch64: Optimize 128-bit SeqCst load when FEAT_LRCPC3 enabled and 128-bit SeqCst store when FEAT_LRCPC3 enabled and FEAT_LSE128 is disabled. ([#30](https://github.com/taiki-e/atomic-maybe-uninit/pull/30))
  - pre-v6 Arm Linux/Android: Optimize {8,16,32}-bit swap/CAS and all 64-bit atomics. ([#30](https://github.com/taiki-e/atomic-maybe-uninit/pull/30))
  - PowerPC: Optimize {8,16}-bit swap/CAS ([#30](https://github.com/taiki-e/atomic-maybe-uninit/pull/30)), all Acquire/AcqRel/SeqCst swap/CAS, all CAS with Relaxed failure ordering, and {8,16}-bit weak CAS ([18aadd2](https://github.com/taiki-e/atomic-maybe-uninit/commit/18aadd249062b0874f3017623e0be73f8df529de)).
  - s390x: Optimize {8,16,128}-bit swap. ([#30](https://github.com/taiki-e/atomic-maybe-uninit/pull/30))
  - RISC-V, MIPS, LoongArch64, Hexagon: Optimize {8,16}-bit swap/CAS. ([#30](https://github.com/taiki-e/atomic-maybe-uninit/pull/30))
  - AVR: Optimize 8-bit load/store. ([18aadd2](https://github.com/taiki-e/atomic-maybe-uninit/commit/18aadd249062b0874f3017623e0be73f8df529de))

- Respect [`RUSTC_BOOTSTRAP=-1` recently added in nightly](https://github.com/rust-lang/rust/pull/132993) in rustc version detection. ([07f64d5](https://github.com/taiki-e/atomic-maybe-uninit/commit/07f64d56bfa0e1cee64531f111e5d5cb827fbd21))

## [0.3.3] - 2024-10-14

- Make `get_mut` `const fn` on Rust 1.83+. ([484a32f](https://github.com/taiki-e/atomic-maybe-uninit/commit/484a32f8cc2a45315b6868e6984036814f9850b5))

- Work around [LLVM pre-20 bug](https://github.com/rust-lang/rust/issues/129585). ([#25](https://github.com/taiki-e/atomic-maybe-uninit/issues/25))

- Support atomic swap on RISC-V without A-extension when Zaamo extension enabled. ([34d37b9](https://github.com/taiki-e/atomic-maybe-uninit/commit/34d37b936f242457da3c2bb3c6c6f8861082f6eb))

- Optimize RISC-V {8,16}-bit atomic swap when Zabha is enabled. ([34d37b9](https://github.com/taiki-e/atomic-maybe-uninit/commit/34d37b936f242457da3c2bb3c6c6f8861082f6eb))

- Strengthen RISC-V SeqCst store to improve compatibility with code that uses atomic instruction mapping that differs from LLVM and GCC. ([836d3fe](https://github.com/taiki-e/atomic-maybe-uninit/commit/836d3fe2a364da6e2137f991a2fb6153225ecd36))

- Optimize x86_32 64-bit load/store when SSE is not available. ([c6f914b](https://github.com/taiki-e/atomic-maybe-uninit/commit/c6f914b105bfb9d5b35c5c90e0c26c4a704a1f15))

- Improve compile-time detection of AArch64 FEAT_LSE2/FEAT_LRCPC3/FEAT_LSE128. ([959477b](https://github.com/taiki-e/atomic-maybe-uninit/commit/959477b043bc44917e8c2197c4c60bb3adbac4dd))

- Improve compile-time detection of powerpc64 partword-atomics/quadword-atomics. ([e1a1596](https://github.com/taiki-e/atomic-maybe-uninit/commit/e1a1596ff1359e2888a04db32e6af8f8b4d5ef8e))

## [0.3.2] - 2024-07-10

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

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

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Add `as_ptr`. ([d9f0cf5](https://github.com/taiki-e/atomic-maybe-uninit/commit/d9f0cf581f3d39ddb2b2928809771dba7f6c582a))

- Add `from_ptr`. ([6338985](https://github.com/taiki-e/atomic-maybe-uninit/commit/63389851db9a2616f8a093ace2d0f32e4606142e))

- Optimize weak CAS on PowerPC. ([6f14f20](https://github.com/taiki-e/atomic-maybe-uninit/commit/6f14f20ebffd1c9f3f842997e67ff696d53a79fb))

- Optimize {8,16}-bit CAS on AArch64. ([29aae39](https://github.com/taiki-e/atomic-maybe-uninit/commit/29aae3976ae858bc39c03b229f747ac44fe26521))

## [0.3.0] - 2023-10-01

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Optimize inline assemblies using `MaybeUninit` input/output of inline assembly implemented by [rust-lang/rust#114790](https://github.com/rust-lang/rust/pull/114790), where it is available. This greatly improves performance and is almost equivalent to std atomic types. ([#19](https://github.com/taiki-e/atomic-maybe-uninit/pull/19))

## [0.2.22] - 2023-08-15

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Add `cfg_{has,no}_atomic_{8,16,32,64,128,ptr}` macros to enable code when the corresponding atomic implementation is available/unavailable. ([#9](https://github.com/taiki-e/atomic-maybe-uninit/pull/9))

- Add `cfg_{has,no}_atomic_cas` macros to enable code when atomic swap/CAS implementation is available/unavailable. ([#9](https://github.com/taiki-e/atomic-maybe-uninit/pull/9))

- Documentation improvements. ([#17](https://github.com/taiki-e/atomic-maybe-uninit/pull/17), [#18](https://github.com/taiki-e/atomic-maybe-uninit/pull/18), thanks @RalfJung)

## [0.2.21] - 2023-08-10

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Fix AVR 16-bit atomic load/store. ([b2fcc0d](https://github.com/taiki-e/atomic-maybe-uninit/commit/b2fcc0d8b523166a9d92b6e41f58d435785d0f90))

- Optimize AArch64 128-bit atomic store/swap when the `lse128` target feature is enabled at compile-time. ([9a114a7](https://github.com/taiki-e/atomic-maybe-uninit/commit/9a114a746a7f265e33b07d566f498586893c7266))

- Optimize AArch64 128-bit atomic load/store when the `rcpc3` target feature is enabled at compile-time. ([85d9ef3](https://github.com/taiki-e/atomic-maybe-uninit/commit/85d9ef3622345f9b85700ffa7181dde1731b1a5c))

## [0.2.20] - 2023-08-02

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Support pre-v6 Arm Linux/Android (e.g., armv5te-unknown-linux-gnueabi, arm-linux-androideabi, etc.). ([#10](https://github.com/taiki-e/atomic-maybe-uninit/pull/10))

- Support Hexagon (experimental). ([#15](https://github.com/taiki-e/atomic-maybe-uninit/pull/15))

- Support AVR atomic load/store (experimental). ([6491450](https://github.com/taiki-e/atomic-maybe-uninit/commit/649145078abd23d9e3495e81fb828e02aeff947d))

- Improve {8,16}-bit atomic implementations on RISC-V, PowerPC, MIPS, s390x, LoongArch64. ([d82c47f](https://github.com/taiki-e/atomic-maybe-uninit/commit/d82c47f2079cccfa5fb36514e13b34132b7afdfa))

## [0.2.19] - 2023-07-27

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Support LoongArch64. ([#14](https://github.com/taiki-e/atomic-maybe-uninit/pull/14))

- Fix build error on MIPS32r6 and MIPS64r6 (both tier 3) since [nightly-2023-07-19's target_arch change](https://github.com/rust-lang/rust/pull/112374).

- Fix build error on big endian Armv8 AArch32 (tier 3).

- Acknowledge all x86_64 Apple targets support 128-bit atomics.

  Our code already recognizes this via `cfg(target_feature)`, so this only affects users using pre-1.69 stable rustc.

  See also [rust-lang/rust#112150](https://github.com/rust-lang/rust/pull/112150).

- Optimize inline assemblies.

## [0.2.18] - 2023-05-31

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Fix build error on AArch64 ILP32 ABI targets (tier 3).

- Optimize inline assemblies on PowerPC and s390x.

## [0.2.17] - 2023-05-09

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

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

- Support PowerPC. ([#5](https://github.com/taiki-e/atomic-maybe-uninit/pull/5))

- Support s390x. ([#6](https://github.com/taiki-e/atomic-maybe-uninit/pull/6))

- Implement RISC-V 8-bit and 16-bit swap.

- Implement MIPS32r2 8-bit and 16-bit swap.

- Implement MIPS64r2 8-bit and 16-bit swap.

## [0.2.5] - 2022-05-30

**Note:** This release has been yanked due to a bug fixed in 0.2.16.

- Support Armv6-M. ([#4](https://github.com/taiki-e/atomic-maybe-uninit/pull/4))

- Optimize AArch64 128-bit atomic load/store when the `lse2` target feature is enabled at compile-time.

## [0.2.4] - 2022-03-20

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Implement MIPS32r2 32-bit swap.

- Implement MIPS64r2 32-bit and 64-bit swap.

## [0.2.3] - 2022-03-19

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Support MIPS32r2 and MIPS64r2.

- Add `#[must_use]` to constructors.

## [0.2.2] - 2022-03-16

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Support Armv7-A, Armv7-R, Armv7-M, and Armv8-M.

## [0.2.1] - 2022-03-14

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Optimize AArch64 atomic swap when the `lse` target feature is enabled at compile-time.

- Document safety requirements of functions in `raw` module.

## [0.2.0] - 2022-03-13

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

- Support AArch64.

- Support X32 ABI.

- Remove `raw` feature and always expose `raw` module.

## [0.1.0] - 2022-03-12

**Note:** This release has been yanked due to pre-20 LLVM's bug (we implemented a workaround in 0.3.3).

Initial release

[Unreleased]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.11...HEAD
[0.3.11]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.10...v0.3.11
[0.3.10]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.9...v0.3.10
[0.3.9]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.8...v0.3.9
[0.3.8]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.7...v0.3.8
[0.3.7]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.6...v0.3.7
[0.3.6]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.5...v0.3.6
[0.3.5]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.4...v0.3.5
[0.3.4]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.3...v0.3.4
[0.3.3]: https://github.com/taiki-e/atomic-maybe-uninit/compare/v0.3.2...v0.3.3
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
