#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
cd "$(dirname "$0")"/..

# shellcheck disable=SC2154
trap 's=$?; echo >&2 "$0: Error on line "${LINENO}": ${BASH_COMMAND}"; exit ${s}' ERR
trap -- 'exit 0' SIGINT

# USAGE:
#    ./tools/build.sh [+toolchain] [target]...

default_targets=(
    # x86_64
    # rustc --print target-list | grep -E '^x86_64'
    x86_64-unknown-linux-gnu
    # x86_64 X32 ABI
    x86_64-unknown-linux-gnux32
    # x86_64 always support cmpxchg16b
    x86_64-apple-darwin
    # x86_64 without SSE
    x86_64-unknown-none

    # x86
    # rustc --print target-list | grep -E '^i.86'
    i586-unknown-linux-gnu
    i686-unknown-linux-gnu

    # aarch64
    # rustc --print target-list | grep -E '^aarch64'
    aarch64-unknown-linux-gnu
    # aarch64 big endian
    aarch64_be-unknown-linux-gnu
    # aarch64 ILP32 ABI
    aarch64-unknown-linux-gnu_ilp32
    # aarch64 ILP32 ABI big endian
    aarch64_be-unknown-linux-gnu_ilp32
    # aarch64 always support lse
    aarch64-apple-darwin

    # arm
    # rustc --print target-list | grep -E '^(arm|thumb)(eb)?(v(6|7|8|9)|-)'
    # armv6
    arm-unknown-linux-gnueabi
    arm-unknown-linux-gnueabihf
    # armv7-a
    armv7-unknown-linux-gnueabi
    armv7-unknown-linux-gnueabihf
    thumbv7neon-unknown-linux-gnueabihf
    # armv8-a
    armv8a-none-eabi # custom target
    # armv8-a big endian
    armeb-unknown-linux-gnueabi
    # armv7-r
    armv7r-none-eabi
    # armv7-r big endian
    armebv7r-none-eabi
    # armv8-r
    armv8r-none-eabi # custom target
    # armv8-r big endian
    armebv8r-none-eabi # custom target
    # armv6-m
    thumbv6m-none-eabi
    # armv7-m
    thumbv7em-none-eabi
    thumbv7em-none-eabihf
    thumbv7m-none-eabi
    # armv8-m
    thumbv8m.base-none-eabi
    thumbv8m.main-none-eabi
    thumbv8m.main-none-eabihf

    # riscv
    # rustc --print target-list | grep -E '^riscv'
    riscv64gc-unknown-linux-gnu
    # riscv64 no atomic load/store
    riscv64i-unknown-none-elf # custom target
    # riscv32 no atomic load/store
    riscv32i-unknown-none-elf
    riscv32im-unknown-none-elf
    riscv32imc-unknown-none-elf
    # riscv32 with atomic
    riscv32imac-unknown-none-elf

    # mips
    # rustc --print target-list | grep -E '^mips'
    mips-unknown-linux-gnu
    mipsel-unknown-linux-gnu
    # mips64
    mips64-unknown-linux-gnuabi64
    mips64el-unknown-linux-gnuabi64

    # powerpc
    # rustc --print target-list | grep -E '^powerpc'
    powerpc-unknown-linux-gnu
    powerpc64-unknown-linux-gnu
    powerpc64le-unknown-linux-gnu

    # s390x
    # rustc --print target-list | grep -E '^s390'
    s390x-unknown-linux-gnu

    # msp430
    # rustc --print target-list | grep -E '^msp430'
    msp430-none-elf
)
known_cfgs=()

x() {
    local cmd="$1"
    shift
    (
        set -x
        "${cmd}" "$@"
    )
}
x_cargo() {
    if [[ -n "${RUSTFLAGS:-}" ]]; then
        echo "+ RUSTFLAGS='${RUSTFLAGS}' \\"
    fi
    RUSTFLAGS="${RUSTFLAGS:-} ${check_cfg:-}" \
        x cargo "$@"
    echo
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

rustup_target_list=$(rustup ${pre_args[@]+"${pre_args[@]}"} target list)
rustc_target_list=$(rustc ${pre_args[@]+"${pre_args[@]}"} --print target-list)
rustc_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -Vv | grep 'release: ' | sed 's/release: //')
rustc_minor_version="${rustc_version#*.}"
rustc_minor_version="${rustc_minor_version%%.*}"
base_args=(${pre_args[@]+"${pre_args[@]}"} hack build)
nightly=''
if [[ "${rustc_version}" == *"nightly"* ]] || [[ "${rustc_version}" == *"dev"* ]]; then
    nightly=1
    rustup ${pre_args[@]+"${pre_args[@]}"} component add rust-src &>/dev/null
    # -Z check-cfg requires 1.63.0-nightly
    if [[ "${rustc_minor_version}" -gt 62 ]]; then
        # TODO: handle key-value cfg from build script as --check-cfg=values(name, "value1", "value2", ... "valueN")
        # shellcheck disable=SC2207
        known_cfgs+=($(grep -E 'cargo:rustc-cfg=' build.rs | sed -E 's/^.*cargo:rustc-cfg=//; s/(=\\)?".*$//' | LC_ALL=C sort -u))
        check_cfg="-Z unstable-options --check-cfg=names($(IFS=',' && echo "${known_cfgs[*]}")) --check-cfg=values(target_pointer_width,\"128\") --check-cfg=values(feature,\"cargo-clippy\")"
        rustup ${pre_args[@]+"${pre_args[@]}"} component add clippy &>/dev/null
        base_args=(${pre_args[@]+"${pre_args[@]}"} hack clippy -Z check-cfg="names,values,output,features")
    fi
fi

build() {
    local target="$1"
    shift
    local args=("${base_args[@]}")
    local target_rustflags="${RUSTFLAGS:-} ${check_cfg:-}"
    if ! grep <<<"${rustc_target_list}" -Eq "^${target}$" || [[ -f "target-specs/${target}.json" ]]; then
        if [[ ! -f "target-specs/${target}.json" ]]; then
            echo "target '${target}' not available on ${rustc_version} (skipped all checks)"
            return 0
        fi
        local target_flags=(--target "$(pwd)/target-specs/${target}.json")
    else
        local target_flags=(--target "${target}")
    fi
    args+=("${target_flags[@]}")
    if grep <<<"${rustup_target_list}" -Eq "^${target}( |$)"; then
        x rustup ${pre_args[@]+"${pre_args[@]}"} target add "${target}" &>/dev/null
    elif [[ -n "${nightly}" ]]; then
        case "${target}" in
            *-none* | *-cuda* | avr-* | *-esp-espidf) args+=(-Z build-std="core") ;;
            *) args+=(-Z build-std) ;;
        esac
    else
        echo "target '${target}' requires nightly compiler (skipped all checks)"
        return 0
    fi
    if [[ -z "${nightly}" ]]; then
        case "${target}" in
            mips* | powerpc* | s390* | msp430*)
                echo "target '${target}' requires nightly compiler (skipped all checks)"
                return 0
                ;;
        esac
    fi

    args+=(
        --workspace --ignore-private
        --feature-powerset --optional-deps
    )
    RUSTFLAGS="${target_rustflags}" \
        x_cargo "${args[@]}" "$@"
    case "${target}" in
        x86_64*)
            # macOS is skipped because it is +cmpxchg16b by default
            case "${target}" in
                *-darwin) ;;
                *)
                    RUSTFLAGS="${target_rustflags} -C target-feature=+cmpxchg16b" \
                        x_cargo "${args[@]}" --target-dir target/cmpxchg16b "$@"
                    ;;
            esac
            ;;
        aarch64* | arm64*)
            # macOS is skipped because it is +lse,+lse2 by default
            case "${target}" in
                *-darwin) ;;
                *)
                    RUSTFLAGS="${target_rustflags} -C target-feature=+lse" \
                        x_cargo "${args[@]}" --target-dir target/lse "$@"
                    RUSTFLAGS="${target_rustflags} -C target-feature=+lse,+lse2" \
                        x_cargo "${args[@]}" --target-dir target/lse2 "$@"
                    ;;
            esac
            ;;
        powerpc64-*)
            # powerpc64le- (little-endian) is skipped because it is pwr8 by default
            RUSTFLAGS="${target_rustflags} -C target-cpu=pwr8" \
                x_cargo "${args[@]}" --target-dir target/pwr8 "$@"
            ;;
        powerpc64le-*)
            # powerpc64- (big-endian) is skipped because it is pre-pwr8 by default
            RUSTFLAGS="${target_rustflags} -C target-cpu=pwr7" \
                x_cargo "${args[@]}" --target-dir target/pwr7 "$@"
            ;;
    esac
}

for target in "${targets[@]}"; do
    build "${target}"
done
