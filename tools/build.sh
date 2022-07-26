#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
cd "$(dirname "$0")"/..

trap -- 'exit 0' SIGINT

default_targets=(
    # x86_64
    # rustc --print target-list | grep -E '^x86_64' | grep -E '(-unknown-linux|-none)'
    x86_64-unknown-linux-gnu
    # x86_64 X32 ABI
    x86_64-unknown-linux-gnux32
    # x86_64 always support cmpxchg16b
    x86_64-apple-darwin
    # x86_64 without SSE
    x86_64-unknown-none

    # x86
    # rustc --print target-list | grep -E '^i.86' | grep -E '(-unknown-linux|-none)'
    i586-unknown-linux-gnu
    i686-unknown-linux-gnu

    # aarch64
    # rustc --print target-list | grep -E '^aarch64' | grep -E '(-unknown-linux|-none)'
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
    # rustc --print target-list | grep -E '^(arm(eb)?|thumb)(v6m|v7|v8|v9)' | grep -E '(-unknown-linux|-none)'
    # armv6
    arm-unknown-linux-gnueabi
    arm-unknown-linux-gnueabihf
    # armv7-a
    armv7-unknown-linux-gnueabi
    armv7-unknown-linux-gnueabihf
    thumbv7neon-unknown-linux-gnueabihf
    # armv7-r
    armv7r-none-eabi
    # armv7-r big endian
    armebv7r-none-eabi
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
    # rustc --print target-list | grep -E '^riscv' | grep -E '(-unknown-linux|-none)'
    riscv64gc-unknown-linux-gnu
    # no atomic load/store
    riscv32i-unknown-none-elf
    riscv32im-unknown-none-elf
    riscv32imc-unknown-none-elf
    # riscv32 with atomic
    riscv32imac-unknown-none-elf

    # mips
    # rustc --print target-list | grep -E '^mips' | grep -E '(-unknown-linux|-none)'
    mips-unknown-linux-gnu
    mipsel-unknown-linux-gnu
    # mips64
    mips64-unknown-linux-gnuabi64
    mips64el-unknown-linux-gnuabi64

    # powerpc
    # rustc --print target-list | grep -E '^powerpc' | grep -E '(-unknown-linux|-none)'
    powerpc-unknown-linux-gnu
    powerpc64-unknown-linux-gnu
    powerpc64le-unknown-linux-gnu

    # s390x
    # rustc --print target-list | grep -E '^s390' | grep -E '(-unknown-linux|-none)'
    s390x-unknown-linux-gnu
)

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
base_args=(${pre_args[@]+"${pre_args[@]}"} hack build)
nightly=''
if [[ "${rustc_version}" == *"nightly"* ]] || [[ "${rustc_version}" == *"dev"* ]]; then
    nightly=1
    rustup ${pre_args[@]+"${pre_args[@]}"} component add rust-src &>/dev/null
    case "${rustc_version}" in
        # -Z check-cfg requires 1.63.0-nightly
        1.[0-5]* | 1.6[0-2].*) ;;
        *)
            # TODO: handle key-value cfg from build script as --check-cfg=values(name, "value1", "value2", ... "valueN")
            # shellcheck disable=SC2207
            build_script_cfg=($(grep -E 'cargo:rustc-cfg=' build.rs | sed -E 's/^.*cargo:rustc-cfg=//' | sed -E 's/(=\\)?".*$//' | LC_ALL=C sort | uniq))
            check_cfg="-Z unstable-options --check-cfg=names($(IFS=',' && echo "${build_script_cfg[*]}")) --check-cfg=values(target_pointer_width,\"128\")"
            rustup ${pre_args[@]+"${pre_args[@]}"} component add clippy &>/dev/null
            base_args=(${pre_args[@]+"${pre_args[@]}"} hack clippy -Z check-cfg="names,values,output,features")
            ;;
    esac
fi
echo "base rustflags='${RUSTFLAGS:-} ${check_cfg:-}'"

x() {
    local cmd="$1"
    shift
    (
        set -x
        "${cmd}" "$@"
    )
}
build() {
    local target="$1"
    shift
    local args=("${base_args[@]}" --target "${target}")
    local target_rustflags="${RUSTFLAGS:-} ${check_cfg:-}"
    if ! grep <<<"${rustc_target_list}" -Eq "^${target}$"; then
        echo "target '${target}' not available on ${rustc_version}"
        return 0
    fi
    if [[ -z "${nightly}" ]]; then
        case "${target}" in
            mips* | powerpc* | s390*)
                echo "target '${target}' requires nightly compiler"
                return 0
                ;;
        esac
    fi
    if grep <<<"${rustup_target_list}" -Eq "^${target}( |$)"; then
        x rustup ${pre_args[@]+"${pre_args[@]}"} target add "${target}" &>/dev/null
    elif [[ -n "${nightly}" ]]; then
        case "${target}" in
            *-none* | avr-* | *-esp-espidf) args+=(-Z build-std="core") ;;
            *) args+=(-Z build-std) ;;
        esac
    else
        echo "target '${target}' requires nightly compiler"
        return 0
    fi

    args+=(
        --workspace --ignore-private
        --feature-powerset --optional-deps
    )
    RUSTFLAGS="${target_rustflags}" \
        x cargo "${args[@]}" "$@"
    case "${target}" in
        x86_64*)
            RUSTFLAGS="${target_rustflags} -C target-feature=+cmpxchg16b" \
                x cargo "${args[@]}" --target-dir target/cmpxchg16b "$@"
            ;;
        aarch64* | arm64*)
            RUSTFLAGS="${target_rustflags} -C target-feature=+lse" \
                x cargo "${args[@]}" --target-dir target/lse "$@"
            RUSTFLAGS="${target_rustflags} -C target-feature=+lse,+lse2" \
                x cargo "${args[@]}" --target-dir target/lse2 "$@"
            ;;
        powerpc64-*)
            RUSTFLAGS="${target_rustflags} -C target-cpu=pwr8" \
                x cargo "${args[@]}" --target-dir target/pwr8 "$@"
            ;;
    esac
}

for target in "${targets[@]}"; do
    build "${target}"
done
