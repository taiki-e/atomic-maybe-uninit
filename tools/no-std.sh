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
  # v6
  # armv6-none-eabi # TODO(arm): Hang on 64-bit atomics test in release mode
  thumbv6-none-eabi

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
  riscv64im-unknown-none-elf
  riscv64imac-unknown-none-elf
  riscv64gc-unknown-none-elf
  riscv64gc-unknown-linux-musl

  # loongarch32
  loongarch32-unknown-none

  # sparc
  sparc-unknown-none-elf

  # avr
  avr-none

  # msp430
  msp430-none-elf

  # m68k
  m68k-unknown-linux-gnu

  # bpf
  bpfel-unknown-none
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
info() {
  printf >&2 'info: %s\n' "$*"
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
rustc_minor_version="${rustc_version#*.}"
rustc_minor_version="${rustc_minor_version%%.*}"
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

setup_wokwi() {
  local target="$1"
  local test_dir="$2"
  local cpu="$3"
  export "CARGO_TARGET_${target_upper}_RUNNER"="${workspace_dir}/tools/runner.sh wokwi-cli ${target}"
  export WOKWI_TMPDIR="${workspace_dir}/tmp/wokwi"
  export WOKWI_WORKSPACE_DIR="${workspace_dir}"
  rm -rf -- "${WOKWI_TMPDIR}"
  mkdir -p -- "${WOKWI_TMPDIR}"
  cp -- "${workspace_dir}/${test_dir}/diagram-${cpu}.json" "${WOKWI_TMPDIR}/diagram.json"
}

run() {
  local target="$1"
  shift
  local target_rustflags="${RUSTFLAGS:-}"
  if [[ "${target}" == "avr-none" ]] && [[ "${rustc_minor_version}" -lt 88 ]]; then
    target=avr-unknown-gnu-atmega2560 # custom target
  fi
  local target_flags=()
  if ! grep -Eq "^${target}$" <<<"${rustc_target_list}" || [[ -f "target-specs/${target}.json" ]]; then
    if [[ "${target}" == "riscv64im-unknown-none-elf" ]]; then
      target=riscv64i-unknown-none-elf # custom target
    fi
    if [[ ! -f "target-specs/${target}.json" ]]; then
      if [[ -n "${ALL_TARGETS_MUST_BE_AVAILABLE:-}" ]]; then
        bail "target '${target}' not available on ${rustc_version}"
      fi
      info "target '${target}' not available on ${rustc_version} (skipped)"
      return 0
    fi
    if { cargo ${pre_args[@]+"${pre_args[@]}"} -Z help || true; } | grep -Fq json-target-spec; then
      target_flags+=(-Z json-target-spec)
    fi
    if [[ "${rustc_minor_version}" -lt 91 ]] || [[ "${commit_date}" == '2025-08-05' ]]; then
      # Handle target-pointer-width change.
      mkdir -p -- tmp/target-specs
      sed -E 's/"target-(c-int|pointer)-width": ([0-9]+)/"target-\1-width": "\2"/g' "target-specs/${target}.json" >|"tmp/target-specs/${target}.json"
      target_flags+=(--target "${workspace_dir}/tmp/target-specs/${target}.json")
    else
      target_flags+=(--target "${workspace_dir}/target-specs/${target}.json")
    fi
  else
    target_flags+=(--target "${target}")
  fi
  target_lower="${target//-/_}"
  target_lower="${target_lower//./_}"
  target_upper=$(tr '[:lower:]' '[:upper:]' <<<"${target_lower}")
  subcmd=run
  if [[ -z "${CI:-}" ]]; then
    case "${target}" in
      riscv*-linux-*)
        if ! type -P "${SPIKE:-spike}" >/dev/null; then
          info "no-std test for ${target} requires spike (switched to build-only)"
          subcmd=build
        fi
        ;;
      sparc*)
        if ! type -P "${TSIM_LEON3:-tsim-leon3}" >/dev/null; then
          info "no-std test for ${target} requires tsim-leon3 (switched to build-only)"
          subcmd=build
        fi
        ;;
      avr*)
        if ! type -P "${SIMAVR:-simavr}" >/dev/null; then
          info "no-std test for ${target} requires simavr (switched to build-only)"
          subcmd=build
        fi
        ;;
      msp430*)
        if ! type -P "${MSPDEBUG:-mspdebug}" >/dev/null; then
          info "no-std test for ${target} requires mspdebug (switched to build-only)"
          subcmd=build
        fi
        ;;
    esac
  fi
  case "${target}" in
    xtensa*)
      # TODO(xtensa): run test with simulator on CI
      if ! type -P "${WOKWI_CLI:-wokwi-cli}" >/dev/null; then
        info "no-std test for ${target} requires wokwi-cli (switched to build-only)"
        subcmd=build
      fi
      ;;
  esac
  local args=()
  case "${target}" in
    bpf*) ;;
    *) args+=("${target_flags[@]}") ;;
  esac
  if grep -Eq "^${target}$" <<<"${rustup_target_list}"; then
    retry rustup ${pre_args[@]+"${pre_args[@]}"} target add "${target}" &>/dev/null
  elif [[ -n "${nightly}" ]]; then
    case "${target}" in
      bpf*) ;;
      *) args+=(-Z build-std="core") ;;
    esac
  else
    info "target '${target}' requires nightly compiler (skipped)"
    return 0
  fi

  local test_dir
  case "${target}" in
    riscv*-linux-*)
      test_dir=tests/no-std-linux
      local xlen=''
      case "${target}" in
        riscv32*) xlen=32 ;;
        riscv64*) xlen=64 ;;
      esac
      local isa_sim_dir
      isa_sim_dir="$(dirname -- "$(dirname -- "$(type -P "${SPIKE:-spike}")")")"
      export "CARGO_TARGET_${target_upper}_RUNNER"="${SPIKE:-spike} --isa=rv${xlen}gcv_zabha_zacas ${isa_sim_dir}/riscv${xlen}-linux-gnu/bin/pk"
      target_rustflags+=" -C target-feature=+crt-static -C link-self-contained=no"
      ;;
    arm* | thumb* | riscv* | loongarch*)
      case "${target}" in
        loongarch*)
          # TODO: The patched QEMU needed (see semihosting crate's README.md for details).
          if [[ -z "${LOONGARCH_QEMU_BIN_DIR:-}" ]]; then
            if [[ -z "${CI:-}" ]]; then
              info "LoongArch semihosting support doesn't yet merged in upstream (skipped)"
              return 0
            else
              bail "LoongArch semihosting support doesn't yet merged in upstream"
            fi
          fi
          local cpu=''
          case "${target}" in
            loongarch32*) cpu=' -cpu la132' ;;
          esac
          export "CARGO_TARGET_${target_upper}_RUNNER"="${LOONGARCH_QEMU_BIN_DIR}/qemu-system-loongarch64 -M virt${cpu} -display none -semihosting -kernel"
          ;;
      esac
      test_dir=tests/no-std-qemu
      linker=link.x
      target_rustflags+=" -C link-arg=-T${linker}"
      ;;
    sparc*)
      case "${commit_date}" in
        2023-08-23)
          # no asm support
          info "target '${target}' is not supported on this version (skipped)"
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
      if [[ "${target}" == "avr-none" ]]; then
        # "error: target requires explicitly specifying a cpu with `-C target-cpu`"
        target_rustflags+=" -C target-cpu=atmega2560"
      fi
      ;;
    msp430*)
      case "${commit_date}" in
        2023-08-23)
          # multiple definition of `__muldi3'
          info "target '${target}' in broken on this version (skipped)"
          return 0
          ;;
        2025-08-05)
          # "invalid signature for `extern "msp430-interrupt"` function" due to https://github.com/rust-lang/rust/issues/143072
          info "target '${target}' in broken on this version (skipped)"
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
      linker=linkall.x
      target_rustflags+=" -C link-arg=-Wl,-T${linker} -C link-arg=-nostartfiles"
      local cpu
      cpu=$(cut -d- -f2 <<<"${target}")
      args+=(--features "esp-println/${cpu},esp-hal/${cpu}")
      if [[ "${subcmd}" != "build" ]]; then
        setup_wokwi "${target}" "${test_dir}" "${cpu}"
      fi
      ;;
    m68k*)
      if [[ "${llvm_version}" -lt 20 ]]; then
        # pre-20 LLVM bug https://github.com/llvm/llvm-project/issues/107939
        info "target '${target}' is not supported on this version (skipped)"
        return 0
      fi
      test_dir=tests/no-std-linux
      ;;
    bpf*)
      case "${commit_date}" in
        2023-08-23)
          # bpf-test uses 2024 edition
          printf '%s\n' "target '${target}' is not supported on this version (skipped)"
          return 0
          ;;
      esac
      test_dir=tests/bpf
      args+=(--config "target.\"cfg(all())\".runner=\"${workspace_dir}/tools/runner.sh sudo ${target}\"")
      ;;
    *) bail "unrecognized target '${target}'" ;;
  esac
  case "${target}" in
    m68k* | bpf*) ;;
    *) args+=(--all-features) ;;
  esac

  (
    cd -- "${test_dir}"
    case "${target}" in
      bpf*) ;;
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
        # Support for Zabha extension requires LLVM 19+.
        if [[ "${llvm_version}" -ge 19 ]]; then
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
        case "${target}" in
          riscv*-linux-*) ;;
          *)
            # Support for Zalasr extension requires LLVM 22+.
            if [[ "${llvm_version}" -ge 22 ]]; then
              CARGO_TARGET_DIR="${target_dir}/no-std-test-zalasr" \
                RUSTFLAGS="${target_rustflags} -C target-feature=+zalasr" \
                x_cargo "${args[@]}" "$@"
              CARGO_TARGET_DIR="${target_dir}/no-std-test-zalasr" \
                RUSTFLAGS="${target_rustflags} -C target-feature=+zalasr" \
                x_cargo "${args[@]}" --release "$@"
            fi
            ;;
        esac
        ;;
      avr*)
        CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\"" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\"" \
          x_cargo "${args[@]}" --release "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny-lowbytefirst" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\" --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny-lowbytefirst" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\" --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
          x_cargo "${args[@]}" --release "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-lowbytefirst" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-lowbytefirst" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
          x_cargo "${args[@]}" --release "$@"

        # Run with qemu-system-avr.
        subcmd=run
        export "CARGO_TARGET_${target_upper}_RUNNER"="${workspace_dir}/tools/runner.sh qemu-system ${target}"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" --release "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\"" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\"" \
          x_cargo "${args[@]}" --release "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny-lowbytefirst" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\" --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny-lowbytefirst" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\" --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
          x_cargo "${args[@]}" --release "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-lowbytefirst" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
          x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test-lowbytefirst" \
          RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
          x_cargo "${args[@]}" --release "$@"

        # Run with wokwi-cli.
        # TODO(avr): run test with wokwi on CI
        if type -P "${WOKWI_CLI:-wokwi-cli}" >/dev/null; then
          subcmd=run
          setup_wokwi "${target}" "${test_dir}" "mega"
          CARGO_TARGET_DIR="${target_dir}/no-std-test" \
            RUSTFLAGS="${target_rustflags}" \
            x_cargo "${args[@]}" "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test" \
            RUSTFLAGS="${target_rustflags}" \
            x_cargo "${args[@]}" --release "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny" \
            RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\"" \
            x_cargo "${args[@]}" "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny" \
            RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\"" \
            x_cargo "${args[@]}" --release "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny-lowbytefirst" \
            RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\" --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
            x_cargo "${args[@]}" "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-tiny-lowbytefirst" \
            RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"tinyencoding\" --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
            x_cargo "${args[@]}" --release "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-lowbytefirst" \
            RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
            x_cargo "${args[@]}" "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-lowbytefirst" \
            RUSTFLAGS="${target_rustflags} --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
            x_cargo "${args[@]}" --release "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-rmw" \
            RUSTFLAGS="${target_rustflags} -C target-feature=+rmw --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
            x_cargo "${args[@]}" "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test-rmw" \
            RUSTFLAGS="${target_rustflags} -C target-feature=+rmw --cfg atomic_maybe_uninit_target_feature=\"lowbytefirst\"" \
            x_cargo "${args[@]}" --release "$@"
        else
          info "no-std test for ${target} requires wokwi-cli (switched to build-only)"
        fi
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
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" --no-default-features --features "${feature}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          RUSTFLAGS="${target_rustflags}" \
          x_cargo "${args[@]}" --no-default-features --features "${feature}" --release "$@"
        ;;
      bpf*)
        # Note: We cannot test everything at once due to size.
        # isize, usize, i64, u64 are covered by the run with the default feature.
        # NB: Sync feature list with tests/bpf/Cargo.toml
        for feature in i32 u32; do
          # CARGO_TARGET_DIR="${target_dir}/no-std-test" \
          #   RUSTFLAGS="${target_rustflags}" \
          #   x_cargo "${args[@]}" --no-default-features --features "${feature}" "$@"
          CARGO_TARGET_DIR="${target_dir}/no-std-test" \
            RUSTFLAGS="${target_rustflags}" \
            x_cargo "${args[@]}" --no-default-features --features "${feature}" --release "$@"
        done
        ;;
    esac
  )
}

for target in "${targets[@]}"; do
  run "${target}"
done
