#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0 OR MIT
set -CeEuo pipefail
IFS=$'\n\t'
trap -- 's=$?; printf >&2 "%s\n" "${0##*/}:${LINENO}: \`${BASH_COMMAND}\` exit with ${s}"; exit ${s}' ERR
trap -- 'printf >&2 "%s\n" "${0##*/}: trapped SIGINT"; exit 1' SIGINT
cd -- "$(dirname -- "$0")"/..

# USAGE:
#    ./tools/test.sh [+toolchain] [cargo_options]...
#    ./tools/test.sh [+toolchain] build|valgrind [cargo_options]...

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
  if [[ -n "${RUSTDOCFLAGS:-}" ]]; then
    printf '%s\n' "+ RUSTDOCFLAGS='${RUSTDOCFLAGS}' \\"
  fi
  if [[ -n "${CARGO_PROFILE_RELEASE_CODEGEN_UNITS:-}" ]]; then
    printf '%s\n' "+ CARGO_PROFILE_RELEASE_CODEGEN_UNITS='${CARGO_PROFILE_RELEASE_CODEGEN_UNITS}' \\"
  fi
  if [[ -n "${CARGO_PROFILE_RELEASE_LTO:-}" ]]; then
    printf '%s\n' "+ CARGO_PROFILE_RELEASE_LTO='${CARGO_PROFILE_RELEASE_LTO}' \\"
  fi
  if [[ -n "${TS:-}" ]]; then
    x "${cargo}" ${pre_args[@]+"${pre_args[@]}"} "$@" 2>&1 | "${TS}" -i '%.s  '
  else
    x "${cargo}" ${pre_args[@]+"${pre_args[@]}"} "$@"
  fi
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
if [[ "${1:-}" == "+"* ]]; then
  pre_args+=("$1")
  shift
fi
cmd='test'
case "${1:-}" in
  build | valgrind)
    cmd="$1"
    shift
    ;;
esac
target=''
build_std=()
release=()
tests=()
cargo_options=()
rest_cargo_options=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --)
      rest_cargo_options=("$@")
      break
      ;;
    --target)
      if [[ -n "${target}" ]]; then
        bail "multiple --target option"
      fi
      shift
      target="$1"
      ;;
    --target=*)
      if [[ -n "${target}" ]]; then
        bail "multiple --target option"
      fi
      target="${1#--target=}"
      ;;
    --tests) tests=("$1") ;;
    -Z*)
      arg="$1"
      case "${arg}" in
        -Z)
          shift
          arg="$1"
          ;;
        -Z*) arg="${arg#-Z}" ;;
      esac
      case "${arg}" in
        build-std | build-std=*)
          if [[ ${#build_std[@]} -gt 0 ]]; then
            bail "multiple -Z build-std option"
          fi
          build_std=(-Z "${arg}")
          ;;
        *) cargo_options+=(-Z "${arg}") ;;
      esac
      ;;
    -r | --release) release=(--release) ;;
    *) cargo_options+=("$1") ;;
  esac
  shift
done

cargo="${cargo:-cargo}"
if type -P rustup >/dev/null; then
  rustup_target_list=$(rustup ${pre_args[@]+"${pre_args[@]}"} target list | cut -d' ' -f1)
fi
rustc_target_list=$(rustc ${pre_args[@]+"${pre_args[@]}"} --print target-list)
rustc_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | grep -E '^release:' | cut -d' ' -f2)
rustc_minor_version="${rustc_version#*.}"
rustc_minor_version="${rustc_minor_version%%.*}"
host=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | grep -E '^host:' | cut -d' ' -f2)
target_dir=$(pwd)/target
nightly=''
if [[ "${rustc_version}" =~ nightly|dev ]]; then
  nightly=1
  if type -P rustup >/dev/null; then
    retry rustup ${pre_args[@]+"${pre_args[@]}"} component add rust-src &>/dev/null
  fi
fi
export RUST_TEST_THREADS=1
export ATOMIC_MAYBE_UNINIT_DENY_WARNINGS=1
if [[ -n "${CI:-}" ]]; then
  if type -P ts >/dev/null; then
    TS=ts
  elif [[ -e C:/msys64/usr/bin/ts ]]; then
    TS=C:/msys64/usr/bin/ts
  fi
fi

args=()
if [[ -z "${target}" ]] && [[ ${#build_std[@]} -gt 0 ]]; then
  target="${target:-"${host}"}"
fi
if [[ -n "${target}" ]]; then
  if ! grep -Eq "^${target}$" <<<"${rustc_target_list}" || [[ -f "target-specs/${target}.json" ]]; then
    if [[ ! -f "target-specs/${target}.json" ]]; then
      bail "target '${target}' not available on ${rustc_version}"
    fi
    target_flags=(--target "$(pwd)/target-specs/${target}.json")
  else
    target_flags=(--target "${target}")
  fi
  args+=("${target_flags[@]}")
  if type -P rustup >/dev/null; then
    if grep -Eq "^${target}$" <<<"${rustup_target_list}"; then
      retry rustup ${pre_args[@]+"${pre_args[@]}"} target add "${target}" &>/dev/null
    elif [[ -n "${nightly}" ]]; then
      if [[ ${#build_std[@]} -eq 0 ]]; then
        build_std=(-Z build-std)
      fi
    else
      bail "target '${target}' requires nightly compiler"
    fi
  fi
fi
args+=(--all-features)
case "${cmd}" in
  build) ;;
  *) args+=(--workspace) ;;
esac
target="${target:-"${host}"}"
target_lower="${target//-/_}"
target_lower="${target_lower//./_}"
target_upper=$(tr '[:lower:]' '[:upper:]' <<<"${target_lower}")
randomize_layout=' -Z randomize-layout'
case "${target}" in
  hexagon-unknown-linux-musl)
    release=(--release)
    build_std+=(-Z build-std-features="panic-unwind,llvm-libunwind")
    flags=' -C link-args=-lclang_rt.builtins-hexagon -C opt-level=z'
    export RUSTFLAGS="${RUSTFLAGS:-}${flags}"
    export RUSTDOCFLAGS="${RUSTDOCFLAGS:-}${flags}"
    ;;
esac
cranelift=''
if [[ "${RUSTFLAGS:-}" =~ -Z\ *codegen-backend=cranelift ]]; then
  cranelift=1
  retry rustup ${pre_args[@]+"${pre_args[@]}"} component add rustc-codegen-cranelift-preview
else
  case "$(basename -- "${cargo%.exe}")" in
    cargo-clif) cranelift=1 ;;
  esac
fi
if [[ -n "${cranelift}" ]]; then
  # panic=unwind is not supported yet.
  # https://github.com/rust-lang/rustc_codegen_cranelift#not-yet-supported
  flags=' -C panic=abort -Z panic_abort_tests'
  export RUSTFLAGS="${RUSTFLAGS:-}${flags}"
  export RUSTDOCFLAGS="${RUSTDOCFLAGS:-}${flags}"
fi

case "${cmd}" in
  build)
    TS=''
    args+=(--no-run ${release[@]+"${release[@]}"})
    x_cargo test ${build_std[@]+"${build_std[@]}"} ${cargo_options[@]+"${cargo_options[@]}"} "${args[@]}" >&2
    manifest_path=$(cargo ${pre_args[@]+"${pre_args[@]}"} locate-project --message-format=plain)
    binary_path=$(
      "${cargo}" ${pre_args[@]+"${pre_args[@]}"} test ${build_std[@]+"${build_std[@]}"} ${cargo_options[@]+"${cargo_options[@]}"} "${args[@]}" -q --message-format=json \
        | jq -r --arg manifest_path "${manifest_path}" 'select(.manifest_path == $manifest_path) | if .executable then .executable else empty end'
    )
    printf '%s\n' "${binary_path}"
    exit 0
    ;;
  valgrind)
    # TODO: use --errors-for-leak-kinds=definite,indirect due to upstream bug (https://github.com/rust-lang/rust/issues/135608)
    export "CARGO_TARGET_${target_upper}_RUNNER"="valgrind -v --error-exitcode=1 --error-limit=no --leak-check=full --show-leak-kinds=all --errors-for-leak-kinds=definite,indirect --track-origins=yes --fair-sched=yes"
    # TODO: always pass randomize-layout
    export RUSTFLAGS="${RUSTFLAGS:-} --cfg valgrind"
    export RUSTDOCFLAGS="${RUSTDOCFLAGS:-} --cfg valgrind"
    # doctest on Valgrind is very slow
    if [[ ${#tests[@]} -eq 0 ]]; then
      tests=(--tests)
    fi
    ;;
  test) ;;
  *) bail "unrecognized command '${cmd}'" ;;
esac

run() {
  if [[ ${#release[@]} -eq 0 ]]; then
    x_cargo test ${build_std[@]+"${build_std[@]}"} ${tests[@]+"${tests[@]}"} "$@"
  fi

  # release mode + doctests is slow on some platforms (probably related to the fact that they compile binaries for each example)
  x_cargo test ${build_std[@]+"${build_std[@]}"} --release --tests "$@"

  if [[ -n "${cranelift}" ]]; then
    return # LTO is not supported
  fi

  case "${target}" in
    # TODO: segmentation fault (also happen without this crate)
    hexagon-unknown-linux-musl) ;;
    *)
      # LTO + doctests is very slow on some platforms (probably related to the fact that they compile binaries for each example)
      CARGO_TARGET_DIR="${target_dir}/fat-lto" \
        CARGO_PROFILE_RELEASE_CODEGEN_UNITS=1 \
        CARGO_PROFILE_RELEASE_LTO=fat \
        x_cargo test ${build_std[@]+"${build_std[@]}"} --release --tests "$@"
      ;;
  esac

  # cargo-careful only supports nightly. rustc-build-sysroot doesn't work on old nightly (at least on nightly-2022-08-12 - 1.65.0-nightly).
  if [[ "${rustc_minor_version}" -ge 66 ]] && [[ -n "${nightly}" ]] && type -P cargo-careful >/dev/null && [[ "${cargo}" == "cargo" ]]; then
    # Since nightly-2022-12-23, -Z build-std + -Z randomize-layout + release mode on Windows
    # sometimes causes segfault in build script or proc-macro.
    if [[ "${target}" == *"-windows"* ]]; then
      randomize_layout=''
    fi
    flags="${randomize_layout}"
    case "${target}" in
      *-linux-musl*) flags+=" -C target-feature=-crt-static" ;;
    esac
    case "${target}" in
      # cannot find rsbegin.o/rsend.o when building std
      *-windows-gnu*) ;;
      # TODO: haw to pass build-std-features to cargo-careful?
      hexagon-unknown-linux-musl) ;;
      *)
        if [[ ${#build_std[@]} -gt 0 ]]; then
          CARGO_TARGET_DIR="${target_dir}/careful" \
            RUSTFLAGS="${RUSTFLAGS:-}${flags}" \
            RUSTDOCFLAGS="${RUSTDOCFLAGS:-}${flags}" \
            x_cargo careful test -Z doctest-xcompile ${release[@]+"${release[@]}"} ${tests[@]+"${tests[@]}"} "$@"
        else
          # -Z doctest-xcompile is already passed
          CARGO_TARGET_DIR="${target_dir}/careful" \
            RUSTFLAGS="${RUSTFLAGS:-}${flags}" \
            RUSTDOCFLAGS="${RUSTDOCFLAGS:-}${flags}" \
            x_cargo careful test ${release[@]+"${release[@]}"} ${tests[@]+"${tests[@]}"} "$@"
        fi
        ;;
    esac
  fi
}

run ${cargo_options[@]+"${cargo_options[@]}"} "${args[@]}" ${rest_cargo_options[@]+"${rest_cargo_options[@]}"}
