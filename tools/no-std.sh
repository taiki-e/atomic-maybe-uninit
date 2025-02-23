#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0 OR MIT
set -CeEuo pipefail
IFS=$'\n\t'
trap -- 's=$?; printf >&2 "%s\n" "${0##*/}:${LINENO}: \`${BASH_COMMAND}\` exit with ${s}"; exit ${s}' ERR
trap -- 'printf >&2 "%s\n" "${0##*/}: trapped SIGINT"; exit 1' SIGINT
cd -- "$(dirname -- "$0")"/..

# USAGE:
#    ./tools/no-std.sh [+toolchain] [target]...

# rustc -Z unstable-options --print all-target-specs-json | jq -r '. | to_entries[] | if .value.os then empty else .key end'
default_targets=(
  # arm
  # v6-M
  thumbv6m-none-eabi
  # v7-M
  thumbv7m-none-eabi
  thumbv7em-none-eabi
  thumbv7em-none-eabihf
  # v8-M
  thumbv8m.base-none-eabi
  thumbv8m.main-none-eabi
  thumbv8m.main-none-eabihf

  # riscv32
  riscv32i-unknown-none-elf
  riscv32im-unknown-none-elf
  riscv32imc-unknown-none-elf
  riscv32ima-unknown-none-elf
  riscv32imac-unknown-none-elf
  riscv32imafc-unknown-none-elf
  riscv32gc-unknown-none-elf # custom target
  riscv32e-unknown-none-elf
  riscv32em-unknown-none-elf
  riscv32emc-unknown-none-elf
  # riscv64
  riscv64i-unknown-none-elf # custom target
  riscv64imac-unknown-none-elf
  riscv64gc-unknown-none-elf

  # sparc
  sparc-unknown-none-elf

  # avr
  avr-unknown-gnu-atmega2560 # custom target

  # msp430
  msp430-none-elf

  # m68k
  m68k-unknown-linux-gnu
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
  x cargo ${pre_args[@]+"${pre_args[@]}"} "${subcmd}" "$@"
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

pre_args=()
is_custom_toolchain=''
if [[ "${1:-}" == "+"* ]]; then
  if [[ "$1" == "+esp" ]]; then
    # shellcheck disable=SC1091
    . "${HOME}/export-esp.sh"
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
llvm_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | { grep -E '^LLVM version:' || true; } | cut -d' ' -f3)
llvm_version="${llvm_version%%.*}"
commit_date=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | grep -E '^commit-date:' | cut -d' ' -f2)
workspace_dir=$(pwd)
target_dir="${workspace_dir}/target"
nightly=''
if [[ "${rustc_version}" =~ nightly|dev ]]; then
  nightly=1
  if [[ -z "${is_custom_toolchain}" ]]; then
    retry rustup ${pre_args[@]+"${pre_args[@]}"} component add rust-src &>/dev/null
  fi
fi
export QEMU_AUDIO_DRV=none
export ATOMIC_MAYBE_UNINIT_DENY_WARNINGS=1

run() {
  local target="$1"
  shift
  target_lower="${target//-/_}"
  target_lower="${target_lower//./_}"
  target_upper=$(tr '[:lower:]' '[:upper:]' <<<"${target_lower}")
  local target_rustflags="${RUSTFLAGS:-}"
  if ! grep -Eq "^${target}$" <<<"${rustc_target_list}" || [[ -f "target-specs/${target}.json" ]]; then
    if [[ ! -f "target-specs/${target}.json" ]]; then
      printf '%s\n' "target '${target}' not available on ${rustc_version} (skipped)"
      return 0
    fi
    local target_flags=(--target "${workspace_dir}/target-specs/${target}.json")
  else
    local target_flags=(--target "${target}")
  fi
  subcmd=run
  if [[ -z "${CI:-}" ]]; then
    case "${target}" in
      sparc*)
        if ! type -P tsim-leon3 >/dev/null; then
          printf '%s\n' "no-std test for ${target} requires tsim-leon3 (switched to build-only)"
          subcmd=build
        fi
        ;;
      avr*)
        if ! type -P simavr >/dev/null; then
          printf '%s\n' "no-std test for ${target} requires simavr (switched to build-only)"
          subcmd=build
        fi
        ;;
      msp430*)
        if ! type -P mspdebug >/dev/null; then
          printf '%s\n' "no-std test for ${target} requires mspdebug (switched to build-only)"
          subcmd=build
        fi
        ;;
    esac
  fi
  case "${target}" in
    xtensa*)
      # TODO: run test with simulator on CI
      if ! type -P wokwi-server >/dev/null; then
        printf '%s\n' "no-std test for ${target} requires wokwi-server (switched to build-only)"
        subcmd=build
      fi
      ;;
  esac
  local args=("${target_flags[@]}")
  if grep -Eq "^${target}$" <<<"${rustup_target_list}"; then
    retry rustup ${pre_args[@]+"${pre_args[@]}"} target add "${target}" &>/dev/null
  elif [[ -n "${nightly}" ]]; then
    args+=(-Z build-std="core")
  else
    printf '%s\n' "target '${target}' requires nightly compiler (skipped)"
    return 0
  fi

  local test_dir
  case "${target}" in
    thumb* | riscv*)
      test_dir=tests/no-std-qemu
      linker=link.x
      target_rustflags+=" -C link-arg=-T${linker}"
      ;;
    sparc*)
      case "${commit_date}" in
        2023-08-23)
          # no asm support
          printf '%s\n' "target '${target}' is not supported on this version (skipped)"
          return 0
          ;;
      esac
      test_dir=tests/sparc
      export "CARGO_TARGET_${target_upper}_RUNNER"="${workspace_dir}/tools/runner.sh tsim-leon3 ${target}"
      # Refs: https://github.com/ferrous-systems/sparc-experiments/blob/ff502602ffe57a0ac03a461563f8d84870b475a0/sparc-demo-rust/.cargo/config.toml
      target_rustflags+=" -C target-cpu=gr712rc -C link-arg=-mcpu=leon3 -C link-arg=-qbsp=leon3"
      ;;
    avr*)
      test_dir=tests/avr
      export "CARGO_TARGET_${target_upper}_RUNNER"="${workspace_dir}/tools/runner.sh simavr ${target}"
      ;;
    msp430*)
      case "${commit_date}" in
        2023-08-23)
          # multiple definition of `__muldi3'
          printf '%s\n' "target '${target}' in broken on this version (skipped)"
          return 0
          ;;
      esac
      test_dir=tests/msp430
      export "CARGO_TARGET_${target_upper}_RUNNER"="${workspace_dir}/tools/runner.sh mspdebug ${target}"
      # Refs: https://github.com/rust-embedded/msp430-quickstart/blob/535cd3c810ec6096a1dd0546ea290ed94aa6fd01/.cargo/config
      linker=link.x
      target_rustflags+=" -C link-arg=-T${linker}"
      target_rustflags+=" -C link-arg=-nostartfiles"
      target_rustflags+=" -C link-arg=-mcpu=msp430"
      target_rustflags+=" -C link-arg=-lmul_f5"
      target_rustflags+=" -C link-arg=-lgcc"
      ;;
    xtensa*)
      test_dir=tests/xtensa
      export "CARGO_TARGET_${target_upper}_RUNNER"="${workspace_dir}/tools/runner.sh wokwi-server ${target}"
      linker=linkall.x
      target_rustflags+=" -C link-arg=-Wl,-T${linker} -C link-arg=-nostartfiles"
      ;;
    m68k*)
      if [[ "${llvm_version}" -lt 20 ]]; then
        # pre-20 LLVM bug https://github.com/llvm/llvm-project/issues/107939
        printf '%s\n' "target '${target}' is not supported on this version (skipped)"
        return 0
      fi
      test_dir=tests/m68k
      ;;
    *) bail "unrecognized target '${target}'" ;;
  esac
  case "${target}" in
    m68k*) ;;
    *) args+=(--all-features) ;;
  esac

  (
    cd -- "${test_dir}"
    case "${target}" in
      m68k*) ;;
      *)
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" "$@"
        ;;
    esac
    CARGO_TARGET_DIR="${target_dir}/no-std-test" \
      RUSTFLAGS="${target_rustflags}" \
      x_cargo "${args[@]}" --release "$@"
    case "${target}" in
      riscv*)
        case "${target}" in
          riscv??[ie]-* | riscv??[ie]m-* | riscv??[ie]mc-*)
            # With Zalrsc without Zaamo
            CARGO_TARGET_DIR="${target_dir}/no-std-test-zalrsc" \
              RUSTFLAGS="${target_rustflags} -C target-feature=+zalrsc" \
              x_cargo "${args[@]}" "$@"
            CARGO_TARGET_DIR="${target_dir}/no-std-test-zalrsc" \
              RUSTFLAGS="${target_rustflags} -C target-feature=+zalrsc" \
              x_cargo "${args[@]}" --release "$@"
            ;;
        esac
        local arch
        case "${target}" in
          riscv32*) arch=riscv32 ;;
          riscv64*) arch=riscv64 ;;
          *) bail "${target}" ;;
        esac
        # Support for Zabha extension requires LLVM 19+ and QEMU 9.1+.
        # https://github.com/qemu/qemu/commit/be4a8db7f304347395b081ae5848bad2f507d0c4
        qemu_version=$(qemu-system-"${arch}" --version | sed -En '1 s/QEMU emulator version [^ ]+ \(v([^ )]+)\)/\1/p')
        if [[ -z "${qemu_version}" ]]; then
          qemu_version=$(qemu-system-"${arch}" --version | sed -En '1 s/QEMU emulator version ([^ )]+)/\1/p')
        fi
        if [[ "${llvm_version}" -ge 19 ]] && [[ "${qemu_version}" =~ ^(9\.[^0]|[1-9][0-9]+\.) ]]; then
          export "CARGO_TARGET_${target_upper}_RUNNER"="qemu-system-${arch} -M virt -cpu max -display none -semihosting -kernel"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-zabha" \
            RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo,+zabha" \
            x_cargo "${args[@]}" "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-zabha" \
            RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo,+zabha" \
            x_cargo "${args[@]}" --release "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-zacas" \
            RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo,+zacas" \
            x_cargo "${args[@]}" "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-zacas" \
            RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo,+zacas" \
            x_cargo "${args[@]}" --release "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-zabha-zacas" \
            RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo,+zabha,+zacas" \
            x_cargo "${args[@]}" "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-zabha-zacas" \
            RUSTFLAGS="${target_rustflags} -C target-feature=+zaamo,+zabha,+zacas" \
            x_cargo "${args[@]}" --release "$@"
        fi
        ;;
      avr*)
        # Run with qemu-system-avr.
        subcmd=run
        export "CARGO_TARGET_${target_upper}_RUNNER"="${workspace_dir}/tools/runner.sh qemu-system ${target}"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" --release "$@"
        ;;
      sparc*)
        # Run with qemu-system-sparc.
        subcmd=run
        export "CARGO_TARGET_${target_upper}_RUNNER"="${workspace_dir}/tools/runner.sh qemu-system ${target}"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" --release "$@"
        ;;
      m68k*)
        # Note: We cannot test everything at once due to size.
        # isize, usize, i8, u8 are covered by the run with the default feature.
        # NB: Sync feature list with tests/m68k/Cargo.toml
        feature=i16,u16,i32,u32,i64,u64
        # CARGO_TARGET_DIR="${target_dir}/no-std-test" \
        #     RUSTFLAGS="${target_rustflags}" \
        #     x_cargo "${args[@]}" --features "${feature}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" --no-default-features --features "${feature}" --release "$@"
        ;;
    esac
  )
}

for target in "${targets[@]}"; do
  run "${target}"
done
