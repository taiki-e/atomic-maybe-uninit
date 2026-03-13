#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0 OR MIT
set -CeEuo pipefail
IFS=$'\n\t'
trap -- 's=$?; printf >&2 "%s\n" "${0##*/}:${LINENO}: \`${BASH_COMMAND}\` exit with ${s}"; exit ${s}' ERR
cd -- "$(dirname -- "$0")"/..

# Generates test matrix for CI.
#
# USAGE:
#    ./tools/matrix.sh
#
# This script is intended to be called by gen.sh, but can be called separately.

# FYI: To get the current matrix on normal workflow:
#   pipx run yq '.jobs.test.strategy.matrix' .github/workflows/ci.yml

bail() {
  printf >&2 'error: %s\n' "$*"
  exit 1
}

targets=(
  # x86_64
  x86_64-unknown-linux-gnu
  x86_64-apple-darwin
  x86_64-pc-windows-msvc

  # x86
  i586-unknown-linux-gnu
  i686-unknown-linux-gnu

  # aarch64
  aarch64-unknown-linux-gnu    # Linux little
  aarch64-apple-darwin         # macOS
  aarch64-pc-windows-msvc      # Windows
  aarch64_be-unknown-linux-gnu # Linux big

  # arm64ec
  arm64ec-pc-windows-msvc

  # arm
  armv4t-unknown-linux-gnueabi        # Armv4T A32
  armv5te-unknown-linux-gnueabi       # Armv5TE A32
  arm-unknown-linux-gnueabi           # Armv6K A32
  armv7-unknown-linux-gnueabi         # Armv7 A32 sf
  armv7-unknown-linux-gnueabihf       # Armv7 A32 hf
  thumbv7neon-unknown-linux-gnueabihf # Armv7 T32 hf
  armeb-unknown-linux-gnueabi         # Armv8 big (BE-8) A32 sf

  # csky
  csky-unknown-linux-gnuabiv2
  csky-unknown-linux-gnuabiv2hf

  # hexagon
  hexagon-unknown-linux-musl

  # loongarch
  # loongarch32-unknown-linux-gnu # TODO(loongarch32): https://inbox.sourceware.org/libc-alpha/20251225024222.1375100-6-mengqinggang@loongson.cn/t/
  loongarch64-unknown-linux-gnu

  # m68k
  # m68k-unknown-linux-gnu # TODO(m68k): relocation truncated to fit: R_68K_PC16 against

  # mips
  mips-unknown-linux-gnu
  mipsel-unknown-linux-gnu
  mips64-unknown-linux-gnuabi64
  mips64el-unknown-linux-gnuabi64
  mipsisa32r6-unknown-linux-gnu
  mipsisa32r6el-unknown-linux-gnu
  mipsisa64r6-unknown-linux-gnuabi64
  mipsisa64r6el-unknown-linux-gnuabi64

  # powerpc
  powerpc-unknown-linux-gnu
  powerpc64-unknown-linux-gnu
  powerpc64le-unknown-linux-gnu

  # riscv
  riscv32gc-unknown-linux-gnu
  riscv64gc-unknown-linux-gnu

  # s390x
  s390x-unknown-linux-gnu

  # sparc
  sparc-unknown-linux-gnu
  sparc64-unknown-linux-gnu

  # xtensa
  # xtensa-unknown-linux-gnu # TODO(xtensa): https://wiki.linux-xtensa.org
)

# See also LLVM version table in https://github.com/taiki-e/portable-atomic/blob/HEAD/tools/matrix.sh.
toolchains=(
  1.81 # LLVM 18
  1.86 # LLVM 19
  1.90 # LLVM 20
  1.94 # LLVM 21
  stable
  beta
  nightly
)
min_stable_toolchain() {
  if [[ -n "${require_nightly}" ]]; then
    toolchain=''
    return
  fi
  case "${target}" in
    arm64ec* | s390x*) toolchain=1.84 ;; # LLVM 19
    # TODO: uncomment once 1.95 is stable
    # powerpc*) toolchain=1.95 ;; # LLVM 22
    *) toolchain=1.74 ;; # LLVM 17 (oldest version that MaybeUninit register is supported)
  esac
}
min_nightly_toolchain() {
  case "${target}" in
    arm64ec*) toolchain=nightly-2024-04-19 ;; # Rust 1.79, LLVM 18 (https://github.com/rust-lang/rust/pull/123144)
    s390x*) toolchain=nightly-2024-01-05 ;;   # Rust 1.77, LLVM 17 (oldest version we can use asm_experimental_arch on this target)
    csky*) toolchain=nightly-2025-02-14 ;;    # Rust 1.86, LLVM 19 (oldest version we can use asm_experimental_arch on this target)
    hexagon*) toolchain=nightly-2024-11-29 ;; # Rust 1.85, LLVM 19 (oldest version we can use asm_experimental_arch on this target)
    sparc64*) toolchain=nightly-2024-11-08 ;; # Rust 1.84, LLVM 19 (oldest version we can use asm_experimental_arch on this target)
    sparc*) toolchain=nightly-2025-02-18 ;;   # Rust 1.87, LLVM 20 (Workaround by -v8plus only works on LLVM 20+)
    mipsisa*) toolchain=nightly-2023-09-20 ;; # Rust 1.74, LLVM 17 (cannot built with nightly-2023-08-24 due to compiler failure from libc when building std)
    *) toolchain=nightly-2023-08-24 ;;        # Rust 1.74, LLVM 17 (oldest version that MaybeUninit register is supported)
  esac
}
convert_toolchain_for_unstable_asm() {
  case "${toolchain}" in
    1.74) bail "should be handled by calling min_nightly_toolchain" ;;
    1.7[5-7])
      # LLVM 17
      case "${target}" in
        arm64ec* | csky* | hexagon* | sparc*) toolchain='' ;; # see min nightly toolchain
        *) toolchain=nightly-2024-02-13 ;;                    # Rust 1.78
      esac
      ;;
    1.7[8-9] | 1.8[0-1])
      # LLVM 18
      case "${target}" in
        csky* | hexagon* | sparc*) toolchain='' ;; # see min nightly toolchain
        *) toolchain=nightly-2024-07-31 ;;         # Rust 1.82
      esac
      ;;
    1.8[2-6])
      # LLVM 19
      case "${target}" in
        sparc-*) toolchain='' ;;                     # see min nightly toolchain
        aarch64_be*) toolchain=nightly-2024-11-07 ;; # Rust 1.84 (broken on nightly-2025-02-17 due to https://github.com/rust-lang/stdarch/issues/1484)
        *) toolchain=nightly-2025-02-17 ;;           # Rust 1.87
      esac
      ;;
    1.8[7-9] | 1.90)
      # LLVM 20
      case "${target}" in
        hexagon*) toolchain=nightly-2025-03-07 ;; # Rust 1.87 (broken on nightly-2025-08-06 due to "symbol 'fma' is already defined" error fixed in https://github.com/rust-lang/compiler-builtins/pull/1066)
        *) toolchain=nightly-2025-08-06 ;;        # Rust 1.91
      esac
      ;;
    1.9[1-4])
      # LLVM 21
      case "${target}" in
        *) toolchain=nightly-2026-01-28 ;; # Rust 1.95
      esac
      ;;
    1.*) bail "unhandled ${toolchain}" ;;
    stable | beta) toolchain='' ;; # ignore
  esac
}

matrix='{"include": []}'
add_matrix() {
  case "${target}" in
    arm64ec* | s390x*)
      case "${toolchain}" in
        1.7[4-9] | 1.8[0-3]) convert_toolchain_for_unstable_asm ;;
      esac
      ;;
    # TODO: uncomment once 1.95 is stable
    # powerpc*)
    #   case "${toolchain}" in
    #     1.[7-8][0-9] | 1.9[0-4]) convert_toolchain_for_unstable_asm ;;
    #   esac
    #   ;;
    *) [[ -z "${require_nightly}" ]] || convert_toolchain_for_unstable_asm ;;
  esac
  if [[ -z "${toolchain}" ]]; then
    return
  fi
  case "${target}" in
    *-windows-gnullvm) ;;
    x86_64-pc-windows-msvc) ;;
    x86_64*-windows* | i?86*-windows*) toolchain="${toolchain}-${target}" ;;
  esac
  local target_out="\"rust\": \"${toolchain}\""
  target_out+=",\"target\": \"${target}\""
  [[ -z "${os}" ]] || target_out+=",\"os\": \"${os}\""
  [[ -z "${flags}" ]] || target_out+=",\"flags\": \"${flags# }\""
  matrix=$(jq -c ".include |= .+ [{${target_out}}]" <<<"${matrix}")
}
for target in "${targets[@]}"; do
  # Check target with unstable asm or tier 3 target.
  require_nightly=''
  case "${target}" in
    # TODO: remove powerpc once 1.95 is stable
    aarch64_be* | armeb* | riscv32* | csky* | hexagon* | m68k* | mips* | powerpc* | sparc*)
      require_nightly=1
      ;;
  esac

  # Determine the default runs-on.
  base_os=''
  case "${target}" in
    aarch64-unknown-linux-gnu | armv7*-linux-gnueabihf | thumbv7*-linux-gnueabihf) base_os=ubuntu-24.04-arm ;;
    armeb-unknown-linux-gnueabi) base_os=ubuntu-22.04 ;;
    x86_64*-apple-* | i?86*-apple-*) base_os=macos-15-intel ;;
    aarch64*-apple-* | arm*-apple-*) base_os=macos-latest ;;
    x86_64*-windows* | i?86*-windows*) base_os=windows-latest ;;
    aarch64*-windows* | arm*-windows*) base_os=windows-11-arm ;;
  esac
  os="${base_os}"

  test_only_on_nightly=''
  case "${target}" in
    # x86_64-apple-darwin:
    #   We test only one version because we do not have macOS-specific code and
    #   x86_64-specific code is also tested on Linux using multiple versions.
    # aarch64-pc-windows-msvc:
    #   We test only one version because we do not have Windows-specific code and
    #   AArch64-specific code is also tested on Linux using multiple versions.
    x86_64-apple-darwin | aarch64-pc-windows-msvc) test_only_on_nightly=1 ;;
    # Tested with Arm runner in test-container job.
    armv4t-unknown-linux-gnueabi | armv5te-unknown-linux-gnueabi | arm-unknown-linux-gnueabi | armv7-unknown-linux-gnueabi) test_only_on_nightly=1 ;;
  esac

  if [[ -z "${test_only_on_nightly}" ]]; then
    # Test with min stable toolchain.
    flags=''
    min_stable_toolchain
    add_matrix
    # Test with min nightly toolchain.
    flags=''
    min_nightly_toolchain
    add_matrix
  fi
  # Test other toolchains.
  for toolchain in "${toolchains[@]}"; do
    # To test other Rust/LLVM versions, comment out the following and test_only_on_nightly above
    # (you also need to disable "nightly" in toolchains due to job limits of GitHub Actions):
    case "${toolchain}" in
      beta)
        case "${target}" in
          # 64-bit tier 1 only
          # https://doc.rust-lang.org/nightly/rustc/platform-support.html#tier-1-with-host-tools
          x86_64-unknown-linux-gnu | aarch64-unknown-linux-gnu | aarch64-apple-darwin | x86_64-pc-windows-msvc) ;;
          # x86_64-unknown-linux-gnu | aarch64-unknown-linux-gnu | aarch64-apple-darwin | x86_64-pc-windows-msvc | aarch64-pc-windows-msvc) ;;
          *) continue ;;
        esac
        ;;
      1.*) continue ;;
      nightly) ;;
      *) [[ -z "${test_only_on_nightly}" ]] || continue ;;
    esac
    flags=''
    case "${target}" in
      arm64ec* | s390x*)
        case "${toolchain}" in
          1.8[4-6]) toolchain='' ;; # Handled in min stable toolchain
        esac
        ;;
      powerpc*)
        case "${toolchain}" in
          1.95) toolchain='' ;; # Handled in min stable toolchain
        esac
        ;;
      arm-unknown-linux-gnueabi | armv7-unknown-linux-gnueabi | armeb-unknown-linux-gnueabi)
        case "${toolchain}" in
          1.8[7-9] | 1.9[0-5]) toolchain='' ;; # SIGILL on QEMU with LLVM 20-22
          # TODO(arm): SIGILL on QEMU with LLVM 20-22
          stable | beta) toolchain='' ;;
          nightly) toolchain=nightly-2025-02-17 ;;
        esac
        ;;
      hexagon-unknown-linux-musl)
        case "${toolchain}" in
          1.9[1-4]) toolchain='' ;; # "symbol 'fma' is already defined" error fixed in Rust 1.95 https://github.com/rust-lang/compiler-builtins/pull/1066
          # TODO(hexagon): "symbol 'fma' is already defined" error fixed in Rust 1.95 https://github.com/rust-lang/compiler-builtins/pull/1066
          stable) toolchain='' ;;
        esac
        ;;
      sparc64-unknown-linux-gnu)
        case "${toolchain}" in
          1.8[7-9] | 1.9[0-5]) toolchain='' ;; # "rustc-LLVM ERROR: Not supported instr: <MCInst 11 <MCOperand Reg:162>>" with LLVM 20-22
          # TODO(sprac): "rustc-LLVM ERROR: Not supported instr: <MCInst 11 <MCOperand Reg:162>>" with LLVM 20-22
          stable | beta) toolchain='' ;;
          nightly) toolchain=nightly-2025-02-17 ;;
        esac
        ;;
      mipsisa32r6*)
        case "${toolchain}" in
          1.95) toolchain='' ;; # compiler SIGILL with LLVM 22
          # TODO(mips): compiler SIGILL with LLVM 22
          beta) toolchain='' ;;
          nightly) toolchain=nightly-2026-01-28 ;;
        esac
        ;;
    esac
    add_matrix
  done
  # Test with QEMU.
  case "${target}" in
    aarch64-unknown-linux-gnu | armv7*-linux-gnueabihf | thumbv7*-linux-gnueabihf)
      toolchain=nightly
      case "${target}" in
        armv7*-linux-gnueabihf | thumbv7*-linux-gnueabihf)
          toolchain=nightly-2025-02-17 # TODO(arm): SIGILL on QEMU with LLVM 20-22
          ;;
      esac
      os=''
      flags=''
      add_matrix
      os="${base_os}"
      ;;
  esac
  # Test with Rosetta on AArch64.
  case "${target}" in
    x86_64-apple-darwin)
      toolchain=nightly
      os='macos-latest'
      flags=''
      add_matrix
      os="${base_os}"
      ;;
  esac
  # Test with -C panic=abort.
  case "${target}" in
    x86_64-unknown-linux-gnu)
      toolchain=nightly
      flags="-C panic=abort -Z panic_abort_tests"
      add_matrix
      ;;
  esac
  # Test with cranelift backend.
  case "${target}" in
    # https://github.com/rust-lang/rust/blob/1.93.0/src/bootstrap/src/utils/helpers.rs#L228
    # TODO(cranelift): s390x-unknown-linux-gnu: cranelift doesn't support asm for s390x yet
    # TODO(cranelift): riscv64gc-unknown-linux-gnu: cranelift doesn't support cfg(target_feature) yet: https://github.com/rust-lang/rustc_codegen_cranelift/issues/1400
    x86_64-unknown-linux-gnu | aarch64-unknown-linux-gnu | x86_64-apple-darwin | aarch64-apple-darwin | x86_64-pc-windows-msvc)
      toolchain=nightly
      flags="-Z codegen-backend=cranelift"
      add_matrix
      ;;
  esac
  # Test with gcc backend.
  case "${target}" in
    # TODO(gcc): m68k-unknown-linux-gnu
    x86_64-unknown-linux-gnu)
      toolchain=nightly
      flags="-Z codegen-backend=gcc"
      add_matrix
      ;;
  esac
done

jq <<<"${matrix}" >|.github/workflows/test-matrix.json
