#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0 OR MIT
set -CeEuo pipefail
IFS=$'\n\t'
trap -- 's=$?; printf >&2 "%s\n" "${0##*/}:${LINENO}: \`${BASH_COMMAND}\` exit with ${s}"; exit ${s}' ERR
trap -- 'printf >&2 "%s\n" "${0##*/}: trapped SIGINT"; exit 1' SIGINT
cd -- "$(dirname -- "$0")"/..

# USAGE:
#    ./tools/no-std.sh [+toolchain] [target]...

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

    # avr
    avr-unknown-gnu-atmega2560 # custom target

    # msp430
    msp430-none-elf
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
    x cargo "$@"
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
if [[ $# -gt 0 ]]; then
    targets=("$@")
else
    targets=("${default_targets[@]}")
fi

rustup_target_list=$(rustup ${pre_args[@]+"${pre_args[@]}"} target list | cut -d' ' -f1)
rustc_target_list=$(rustc ${pre_args[@]+"${pre_args[@]}"} --print target-list)
rustc_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | grep -E '^release:' | cut -d' ' -f2)
commit_date=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | grep -E '^commit-date:' | cut -d' ' -f2)
target_dir=$(pwd)/target
nightly=''
if [[ "${rustc_version}" =~ nightly|dev ]]; then
    nightly=1
    retry rustup ${pre_args[@]+"${pre_args[@]}"} component add rust-src &>/dev/null
fi
export QEMU_AUDIO_DRV=none
export ATOMIC_MAYBE_UNINIT_DENY_WARNINGS=1

run() {
    local target="$1"
    shift
    target_lower="${target//-/_}"
    target_lower="${target_lower//./_}"
    target_upper=$(tr '[:lower:]' '[:upper:]' <<<"${target_lower}")
    local args=(${pre_args[@]+"${pre_args[@]}"})
    local target_rustflags="${RUSTFLAGS:-}"
    if ! grep -Eq "^${target}$" <<<"${rustc_target_list}" || [[ -f "target-specs/${target}.json" ]]; then
        if [[ ! -f "target-specs/${target}.json" ]]; then
            printf '%s\n' "target '${target}' not available on ${rustc_version} (skipped)"
            return 0
        fi
        local target_flags=(--target "$(pwd)/target-specs/${target}.json")
    else
        local target_flags=(--target "${target}")
    fi
    local subcmd=run
    if [[ -z "${CI:-}" ]]; then
        case "${target}" in
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
    args+=("${subcmd}" "${target_flags[@]}")
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
        avr*)
            test_dir=tests/avr
            ;;
        msp430*)
            case "${commit_date}" in
                2023-08-22)
                    # multiple definition of `__muldi3'
                    printf '%s\n' "target '${target}' in broken on this version (skipped)"
                    return 0
                    ;;
            esac
            test_dir=tests/msp430
            runner="$(pwd)/tools/mspdebug-test-runner.sh"
            export "CARGO_TARGET_${target_upper}_RUNNER"="${runner}"
            # Refs: https://github.com/rust-embedded/msp430-quickstart/blob/535cd3c810ec6096a1dd0546ea290ed94aa6fd01/.cargo/config
            linker=link.x
            target_rustflags+=" -C link-arg=-T${linker}"
            target_rustflags+=" -C link-arg=-nostartfiles"
            target_rustflags+=" -C link-arg=-mcpu=msp430"
            target_rustflags+=" -C link-arg=-lmul_f5"
            target_rustflags+=" -C link-arg=-lgcc"
            ;;
        *) bail "unrecognized target '${target}'" ;;
    esac
    args+=(--all-features)

    (
        cd -- "${test_dir}"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
            RUSTFLAGS="${target_rustflags}" \
            x_cargo "${args[@]}" "$@"
        CARGO_TARGET_DIR="${target_dir}/no-std-test" \
            RUSTFLAGS="${target_rustflags}" \
            x_cargo "${args[@]}" --release "$@"
    )
}

for target in "${targets[@]}"; do
    run "${target}"
done
