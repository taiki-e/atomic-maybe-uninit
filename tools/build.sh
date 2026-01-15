#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0 OR MIT
set -CeEuo pipefail
IFS=$'\n\t'
trap -- 's=$?; printf >&2 "%s\n" "${0##*/}:${LINENO}: \`${BASH_COMMAND}\` exit with ${s}"; exit ${s}' ERR
trap -- 'printf >&2 "%s\n" "${0##*/}: trapped SIGINT"; exit 1' SIGINT
cd -- "$(dirname -- "$0")"/..

# USAGE:
#    ./tools/build.sh [+toolchain] [target]...

default_targets=(
  # aarch64
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "aarch64" then .key else empty end'
  aarch64-unknown-linux-gnu
  # big endian
  aarch64_be-unknown-linux-gnu
  # ILP32 ABI
  aarch64-unknown-linux-gnu_ilp32
  # ILP32 ABI big endian
  aarch64_be-unknown-linux-gnu_ilp32
  # FEAT_LSE & FEAT_LSE2 & FEAT_LRCPC
  aarch64-apple-darwin

  # arm64ec
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "arm64ec" then .key else empty end'
  arm64ec-pc-windows-msvc

  # arm
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "arm" then .key else empty end'
  # v4T
  armv4t-unknown-linux-gnueabi
  # v5TE
  armv5te-unknown-linux-gnueabi
  armv5te-none-eabi # no atomic
  # v6
  arm-unknown-linux-gnueabi
  arm-unknown-linux-gnueabihf
  # v7-A
  armv7-unknown-linux-gnueabi
  armv7-unknown-linux-gnueabihf
  thumbv7neon-unknown-linux-gnueabihf
  # v7-A big endian
  armebv7-unknown-linux-gnueabi # custom target
  # v8-A
  armv8a-none-eabi # custom target
  # v8-A big endian
  armeb-unknown-linux-gnueabi
  # v7-R
  armv7r-none-eabi
  # v7-R big endian
  armebv7r-none-eabi
  # v8-R
  armv8r-none-eabihf
  # v8-R big endian
  armebv8r-none-eabihf # custom target
  # v6-M
  thumbv6m-none-eabi
  # v7-M
  thumbv7em-none-eabi
  thumbv7em-none-eabihf
  thumbv7m-none-eabi
  # v8-M
  thumbv8m.base-none-eabi
  thumbv8m.main-none-eabi
  thumbv8m.main-none-eabihf

  # avr
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "avr" then .key else empty end'
  avr-none

  # csky
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "csky" then .key else empty end'
  csky-unknown-linux-gnuabiv2
  csky-unknown-linux-gnuabiv2hf

  # hexagon
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "hexagon" then .key else empty end'
  # TODO(hexagon): error: symbol 'fma' is already defined
  # hexagon-unknown-linux-musl

  # loongarch
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "loongarch32" or .value.arch == "loongarch64" then .key else empty end'
  loongarch32-unknown-none
  loongarch64-unknown-linux-gnu

  # m68k
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "m68k" then .key else empty end'
  m68k-unknown-linux-gnu

  # mips
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "mips" or .value.arch == "mips32r6" or .value.arch == "mips64" or .value.arch == "mips64r6" then .key else empty end'
  # mips1 (no atomic)
  mipsel-sony-psx
  # mips32r2
  mips-unknown-linux-gnu
  mipsel-unknown-linux-gnu
  # mips32r6
  mipsisa32r6-unknown-linux-gnu
  mipsisa32r6el-unknown-linux-gnu
  # mips64r2
  mips64-unknown-linux-gnuabi64
  mips64el-unknown-linux-gnuabi64
  # mips64r6
  mipsisa64r6-unknown-linux-gnuabi64
  mipsisa64r6el-unknown-linux-gnuabi64

  # msp430
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "msp430" then .key else empty end'
  msp430-none-elf

  # powerpc
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "powerpc" or .value.arch == "powerpc64" then .key else empty end'
  powerpc-unknown-linux-gnu
  powerpc64-unknown-linux-gnu
  powerpc64le-unknown-linux-gnu

  # riscv
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "riscv32" or .value.arch == "riscv64" then .key else empty end'
  # riscv32 with A-extension
  riscv32imac-unknown-none-elf
  # riscv32 without A-extension
  riscv32i-unknown-none-elf
  # riscv64 with A-extension
  riscv64gc-unknown-linux-gnu
  # riscv64 without A-extension
  riscv64im-unknown-none-elf

  # s390x
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "s390x" then .key else empty end'
  s390x-unknown-linux-gnu

  # sparc
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "sparc" or .value.arch == "sparc64" then .key else empty end'
  sparc-unknown-none-elf
  sparc-unknown-linux-gnu
  sparc64-unknown-linux-gnu

  # x86
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "x86" then .key else empty end'
  # no SSE
  i586-unknown-linux-gnu
  # with SSE2
  i686-unknown-linux-gnu

  # x86_64
  # rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.arch == "x86_64" then .key else empty end'
  x86_64-unknown-linux-gnu
  # with CMPXCHG16B
  x86_64-apple-darwin
  # X32 ABI
  x86_64-unknown-linux-gnux32
  # no SSE
  x86_64-unknown-none
)

x() {
  (
    set -x
    "$@"
  )
}
x_cargo() {
  if [[ -n "${RUSTFLAGS:-}" ]]; then
    printf '%s\n' "+ RUSTFLAGS='${RUSTFLAGS}' \\"
  fi
  x cargo ${pre_args[@]+"${pre_args[@]}"} "$@"
  printf '\n'
}
retry() {
  for i in {1..10}; do
    if "$@"; then
      return 0
    else
      sleep "${i}"
    fi
  done
  "$@"
}
bail() {
  printf >&2 'error: %s\n' "$*"
  exit 1
}
info() {
  printf >&2 'info: %s\n' "$*"
}
is_no_std() {
  case "$1" in
    *-linux-none*) ;;
    # https://github.com/rust-lang/rust/blob/1.90.0/library/std/build.rs#L61
    # ESP-IDF supports std, but it is often broken.
    *-none* | *-psp* | *-psx* | *-cuda* | avr* | *-espidf | m68k*) return 0 ;;
  esac
  return 1
}

pre_args=()
is_custom_toolchain=''
if [[ "${1:-}" == "+"* ]]; then
  if [[ "$1" == "+esp" ]]; then
    is_custom_toolchain=1
  fi
  pre_args+=("$1")
  shift
fi
if [[ $# -gt 0 ]]; then
  targets=("$@")
else
  targets=("${default_targets[@]}")
fi

rustup_target_list=''
if [[ -z "${is_custom_toolchain}" ]]; then
  rustup_target_list=$(rustup ${pre_args[@]+"${pre_args[@]}"} target list | cut -d' ' -f1)
fi
rustc_target_list=$(rustc ${pre_args[@]+"${pre_args[@]}"} --print target-list)
rustc_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | grep -E '^release:' | cut -d' ' -f2)
rustc_minor_version="${rustc_version#*.}"
rustc_minor_version="${rustc_minor_version%%.*}"
llvm_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | { grep -E '^LLVM version:' || true; } | cut -d' ' -f3)
llvm_version="${llvm_version%%.*}"
host=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | grep -E '^host:' | cut -d' ' -f2)
workspace_dir=$(pwd)
target_dir="${workspace_dir}/target"
# Do not use check here because it misses some errors such as invalid inline asm operands and LLVM codegen errors.
subcmd=build
if [[ -n "${TESTS:-}" ]]; then
  # TESTS=1 builds binaries, so cargo build requires toolchain and libraries.
  subcmd=check
fi
base_args=(hack "${subcmd}")
nightly=''
base_rustflags="${RUSTFLAGS:-}"
strict_provenance_lints=''
if [[ "${rustc_version}" =~ nightly|dev ]]; then
  nightly=1
  if [[ -z "${is_custom_toolchain}" ]]; then
    retry rustup ${pre_args[@]+"${pre_args[@]}"} component add rust-src &>/dev/null
  fi
  # We only run clippy on the recent nightly to avoid old clippy bugs.
  if [[ "${rustc_minor_version}" -ge 86 ]] && [[ -z "${RUSTC:-}" ]] && [[ -n "${TESTS:-}" ]]; then
    subcmd=clippy
    retry rustup ${pre_args[@]+"${pre_args[@]}"} component add clippy &>/dev/null
    base_args=(hack "${subcmd}")
    base_rustflags+=' -Z crate-attr=feature(unqualified_local_imports) -W unqualified_local_imports'
    strict_provenance_lints=' -Z crate-attr=feature(strict_provenance_lints) -W fuzzy_provenance_casts -W lossy_provenance_casts'
  fi
fi
export CARGO_TARGET_DIR="${target_dir}"
export ATOMIC_MAYBE_UNINIT_DENY_WARNINGS=1

build() {
  local target="$1"
  shift
  local args=("${base_args[@]}")
  local target_rustflags="${base_rustflags}"
  if ! grep -Eq "^${target}$" <<<"${rustc_target_list}" || [[ -f "target-specs/${target}.json" ]]; then
    if [[ "${target}" == "avr-none" ]]; then
      target=avr-unknown-gnu-atmega2560 # custom target
    fi
    if [[ "${target}" == "riscv64im-unknown-none-elf" ]]; then
      target=riscv64i-unknown-none-elf # custom target
    fi
    if [[ ! -f "target-specs/${target}.json" ]]; then
      if [[ -n "${ALL_TARGETS_MUST_BE_AVAILABLE:-}" ]]; then
        bail "target '${target}' not available on ${rustc_version}"
      fi
      info "target '${target}' not available on ${rustc_version} (skipped all checks)"
      return 0
    fi
    if [[ "${rustc_minor_version}" -lt 91 ]] && [[ "${target}" != "avr"* ]]; then
      # Skip pre-1.91 because target-pointer-width change
      info "target '${target}' requires 1.91-nightly or later (skipped)"
      return 0
    fi
    local target_flags=(--target "${workspace_dir}/target-specs/${target}.json")
  elif [[ "${target}" != "${host}" ]]; then
    local target_flags=(--target "${target}")
  fi
  args+=(${target_flags[@]+"${target_flags[@]}"})
  local cfgs
  if grep -Eq "^${target}$" <<<"${rustup_target_list}"; then
    cfgs=$(RUSTC_BOOTSTRAP=1 rustc ${pre_args[@]+"${pre_args[@]}"} --print cfg ${target_flags[@]+"${target_flags[@]}"})
    retry rustup ${pre_args[@]+"${pre_args[@]}"} target add "${target}" &>/dev/null
    # core/alloc/std sets feature(strict_provenance_lints), so we cannot use
    # -Z crate-attr=feature(strict_provenance_lints) when -Z build-std is needed.
    target_rustflags+="${strict_provenance_lints}"
  elif [[ -n "${nightly}" ]]; then
    cfgs=$(RUSTC_BOOTSTRAP=1 rustc ${pre_args[@]+"${pre_args[@]}"} --print cfg ${target_flags[@]+"${target_flags[@]}"})
    if [[ -n "${TESTS:-}" ]]; then
      if is_no_std "${target}"; then
        args+=(-Z build-std="core,alloc")
      elif grep -Eq '^panic="abort"' <<<"${cfgs}"; then
        args+=(-Z build-std="panic_abort,std")
      else
        args+=(-Z build-std)
      fi
    else
      # Only build core because our library code doesn't depend on std.
      args+=(-Z build-std="core")
    fi
  else
    info "target '${target}' requires nightly compiler (skipped all checks)"
    return 0
  fi
  case "${target}" in
    avr*)
      # https://github.com/rust-lang/rust/issues/88252
      target_rustflags+=" -C opt-level=s"
      if [[ "${target}" == "avr-none" ]]; then
        # "error: target requires explicitly specifying a cpu with `-C target-cpu`"
        target_rustflags+=" -C target-cpu=atmega2560"
      fi
      ;;
    m68k*)
      if [[ "${llvm_version}" -lt 20 ]]; then
        info "target '${target}' requires LLVM 20+ (skipped all checks)"
        return 0
      fi
      # Workaround for compiler SIGSEGV.
      target_rustflags+=" -C opt-level=s"
      ;;
  esac

  if [[ -n "${TESTS:-}" ]]; then
    # We use std in main tests, so we cannot build them on no-std targets.
    # Some no-std targets have target-specific test crates, so build public
    # crates' library part and (if they exist) target-specific test crates.
    if is_no_std "${target}"; then
      case "${target}" in
        sparc-*) target_rustflags+=' -C target-cpu=leon4' ;;
      esac
      RUSTFLAGS="${target_rustflags}" \
        x_cargo "${args[@]}" --manifest-path Cargo.toml "$@"
      # Most target-specific test crates are nightly-only.
      if [[ -n "${nightly}" ]]; then
        local test_dir=''
        # NB: sync with tools/no-std.sh
        case "${target}" in
          armv[45]* | thumbv[45]*) ;; # no atomic
          arm* | thumb* | riscv* | loongarch32*)
            test_dir=tests/no-std-qemu
            args+=(--features semihosting-no-std-test-rt/disable-link-check)
            ;;
          avr*) test_dir=tests/avr ;;
          msp430*) test_dir=tests/msp430 ;;
          sparc-*) test_dir=tests/sparc ;;
          xtensa*)
            test_dir=tests/xtensa
            local cpu
            cpu=$(cut -d- -f2 <<<"${target}")
            args+=(--features "esp-println/${cpu},esp-hal/${cpu}")
            ;;
        esac
        if [[ -n "${test_dir}" ]]; then
          RUSTFLAGS="${target_rustflags}" \
            x_cargo "${args[@]}" --all-features --manifest-path "${test_dir}"/Cargo.toml "$@"
        fi
      fi
      return 0
    fi
    args+=(
      --tests
      --all-features
      --workspace
    )
  else
    args+=(
      --feature-powerset --optional-deps
      --workspace --no-private
    )
  fi
  RUSTFLAGS="${target_rustflags}" \
    x_cargo "${args[@]}" "$@"
  case "${target}" in
    x86_64*)
      # Apple and Windows (except Windows 7, since Rust 1.78) targets are +cmpxchg16b by default
      if ! grep -Eq '^target_feature="cmpxchg16b"' <<<"${cfgs}"; then
        CARGO_TARGET_DIR="${target_dir}/cmpxchg16b" \
          RUSTFLAGS="${target_rustflags} -C target-feature=+cmpxchg16b" \
          x_cargo "${args[@]}" "$@"
      fi
      CARGO_TARGET_DIR="${target_dir}/cmpxchg16b-avx" \
        RUSTFLAGS="${target_rustflags} -C target-feature=+cmpxchg16b,+avx" \
        x_cargo "${args[@]}" "$@"
      ;;
    i686*)
      CARGO_TARGET_DIR="${target_dir}/sse" \
        RUSTFLAGS="${target_rustflags} -C target-feature=-sse2" \
        x_cargo "${args[@]}" "$@"
      ;;
    i586*)
      CARGO_TARGET_DIR="${target_dir}/no-x87" \
        RUSTFLAGS="${target_rustflags} -C target-feature=-x87" \
        x_cargo "${args[@]}" "$@"
      CARGO_TARGET_DIR="${target_dir}/no-cmpxchg8b" \
        RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_no_cmpxchg8b" \
        x_cargo "${args[@]}" "$@"
      CARGO_TARGET_DIR="${target_dir}/no-cmpxchg" \
        RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_no_cmpxchg --cfg atomic_maybe_uninit_no_cmpxchg8b" \
        x_cargo "${args[@]}" "$@"
      ;;
    aarch64* | arm64*)
      # macOS is +lse,+lse2,+rcpc by default
      if ! grep -Eq '^target_feature="lse"' <<<"${cfgs}"; then
        CARGO_TARGET_DIR="${target_dir}/lse" \
          RUSTFLAGS="${target_rustflags} -C target-feature=+lse" \
          x_cargo "${args[@]}" "$@"
      fi
      if ! grep -Eq '^target_feature="rcpc"' <<<"${cfgs}"; then
        CARGO_TARGET_DIR="${target_dir}/rcpc" \
          RUSTFLAGS="${target_rustflags} -C target-feature=+rcpc" \
          x_cargo "${args[@]}" "$@"
      fi
      case "${target}" in
        *-darwin) ;;
        *)
          # FEAT_LSE2 doesn't imply FEAT_LSE.
          CARGO_TARGET_DIR="${target_dir}/lse2" \
            RUSTFLAGS="${target_rustflags} -C target-feature=+lse,+lse2" \
            x_cargo "${args[@]}" "$@"
          ;;
      esac
      CARGO_TARGET_DIR="${target_dir}/rcpc3" \
        RUSTFLAGS="${target_rustflags} -C target-feature=+lse,+lse2,+rcpc3" \
        x_cargo "${args[@]}" "$@"
      # FEAT_LSE128 implies FEAT_LSE but not FEAT_LSE2.
      CARGO_TARGET_DIR="${target_dir}/lse128" \
        RUSTFLAGS="${target_rustflags} -C target-feature=+lse2,+lse128" \
        x_cargo "${args[@]}" "$@"
      CARGO_TARGET_DIR="${target_dir}/lse128-rcpc3" \
        RUSTFLAGS="${target_rustflags} -C target-feature=+lse2,+lse128,+rcpc3" \
        x_cargo "${args[@]}" "$@"
      ;;
    arm-unknown-linux-gnueabi*)
      CARGO_TARGET_DIR="${target_dir}/cp15-barrier" \
        RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_use_cp15_barrier" \
        x_cargo "${args[@]}" "$@"
      ;;
    powerpc-*)
      CARGO_TARGET_DIR="${target_dir}/msync" \
        RUSTFLAGS="${target_rustflags} -C target-feature=+msync" \
        x_cargo "${args[@]}" "$@"
      ;;
    powerpc64-*)
      # powerpc64le- (little-endian) is skipped because it is pwr8 by default
      CARGO_TARGET_DIR="${target_dir}/pwr8" \
        RUSTFLAGS="${target_rustflags} -C target-cpu=pwr8" \
        x_cargo "${args[@]}" "$@"
      ;;
    powerpc64le-*)
      # powerpc64- (big-endian) is skipped because it is pre-pwr8 by default
      CARGO_TARGET_DIR="${target_dir}/pwr7" \
        RUSTFLAGS="${target_rustflags} -C target-cpu=pwr7" \
        x_cargo "${args[@]}" "$@"
      ;;
    riscv*)
      # Support for Zaamo/Zabha/Zalrsc extensions requires LLVM 19+.
      if [[ "${llvm_version}" -ge 19 ]]; then
        CARGO_TARGET_DIR="${target_dir}/zaamo" \
          RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/zabha" \
          RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo,+zabha" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/zalrsc" \
          RUSTFLAGS="${target_rustflags} -C target-feature=+zalrsc" \
          x_cargo "${args[@]}" "$@"
      fi
      # Support for Zacas extension requires LLVM 20+.
      if [[ "${llvm_version}" -ge 20 ]]; then
        CARGO_TARGET_DIR="${target_dir}/zacas" \
          RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo,+zacas" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/zabha-zacas" \
          RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo,+zabha,+zacas" \
          x_cargo "${args[@]}" "$@"
      fi
      ;;
    s390x*)
      CARGO_TARGET_DIR="${target_dir}/z196" \
        RUSTFLAGS="${target_rustflags} -C target-cpu=z196" \
        x_cargo "${args[@]}" "$@"
      ;;
    sparc-unknown-none-elf)
      CARGO_TARGET_DIR="${target_dir}/leon4" \
        RUSTFLAGS="${target_rustflags} -C target-cpu=leon4" \
        x_cargo "${args[@]}" "$@"
      ;;
    avr*)
      CARGO_TARGET_DIR="${target_dir}/rmw" \
        RUSTFLAGS="${target_rustflags} -C target-feature=+rmw" \
        x_cargo "${args[@]}" "$@"
      ;;
    csky-unknown-linux-gnuabiv2)
      CARGO_TARGET_DIR="${target_dir}/ck860" \
        RUSTFLAGS="${target_rustflags} -C target-cpu=ck860" \
        x_cargo "${args[@]}" "$@"
      ;;
  esac
}

for target in "${targets[@]}"; do
  build "${target}"
done
