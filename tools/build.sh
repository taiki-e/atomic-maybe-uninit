#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0 OR MIT
set -eEuo pipefail
IFS=$'\n\t'
cd "$(dirname "$0")"/..

# shellcheck disable=SC2154
trap 's=$?; echo >&2 "$0: error on line "${LINENO}": ${BASH_COMMAND}"; exit ${s}' ERR
trap -- 'echo >&2 "$0: trapped SIGINT"; exit 1' SIGINT

# USAGE:
#    ./tools/build.sh [+toolchain] [target]...

default_targets=(
    # x86_64
    # rustc --print target-list | grep -E '^x86_64'
    x86_64-unknown-linux-gnu
    # x86_64 X32 ABI
    x86_64-unknown-linux-gnux32
    # x86_64 with CMPXCHG16B
    x86_64-apple-darwin
    # x86_64 without SSE
    x86_64-unknown-none

    # x86
    # rustc --print target-list | grep -E '^i.86'
    i586-unknown-linux-gnu
    i686-unknown-linux-gnu

    # aarch64
    # rustc --print target-list | grep -E '^(aarch64|arm64)'
    aarch64-unknown-linux-gnu
    # aarch64 big endian
    aarch64_be-unknown-linux-gnu
    # aarch64 ILP32 ABI
    aarch64-unknown-linux-gnu_ilp32
    # aarch64 ILP32 ABI big endian
    aarch64_be-unknown-linux-gnu_ilp32
    # aarch64 with FEAT_LSE & FEAT_LSE2 & FEAT_LRCPC
    aarch64-apple-darwin

    # arm
    # rustc --print target-list | grep -E '^(arm|thumb)'
    # armv4t
    armv4t-unknown-linux-gnueabi
    # armv5te
    armv5te-unknown-linux-gnueabi
    # armv6
    arm-unknown-linux-gnueabi
    arm-unknown-linux-gnueabihf
    # armv7-a
    armv7-unknown-linux-gnueabi
    armv7-unknown-linux-gnueabihf
    thumbv7neon-unknown-linux-gnueabihf
    # armv7-a big endian
    armebv7-unknown-linux-gnueabi # custom target
    # armv8-a
    armv8a-none-eabi # custom target
    # armv8-a big endian
    armeb-unknown-linux-gnueabi
    # armv7-r
    armv7r-none-eabi
    # armv7-r big endian
    armebv7r-none-eabi
    # armv8-r
    armv8r-none-eabihf
    # armv8-r big endian
    armebv8r-none-eabihf # custom target
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
    # riscv32 with A-extension
    riscv32imac-unknown-none-elf
    # riscv32 without A-extension
    riscv32i-unknown-none-elf
    # riscv64 with A-extension
    riscv64gc-unknown-linux-gnu
    # riscv64 without A-extension
    riscv64i-unknown-none-elf # custom target

    # loongarch
    loongarch64-unknown-linux-gnu

    # mips
    # rustc --print target-list | grep -E '^mips'
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

    # arm64ec
    # rustc --print target-list | grep -E '^arm64ec'
    arm64ec-pc-windows-msvc

    # avr
    # rustc --print target-list | grep -E '^avr'
    avr-unknown-gnu-atmega2560 # custom target

    # hexagon
    # rustc --print target-list | grep -E '^hexagon'
    hexagon-unknown-linux-musl
)

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

rustup_target_list=$(rustup ${pre_args[@]+"${pre_args[@]}"} target list | cut -d' ' -f1)
rustc_target_list=$(rustc ${pre_args[@]+"${pre_args[@]}"} --print target-list)
rustc_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | grep '^release:' | cut -d' ' -f2)
rustc_minor_version="${rustc_version#*.}"
rustc_minor_version="${rustc_minor_version%%.*}"
llvm_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -vV | (grep '^LLVM version:' || true) | cut -d' ' -f3)
llvm_version="${llvm_version%%.*}"
base_args=(${pre_args[@]+"${pre_args[@]}"} hack build)
target_dir=$(pwd)/target
nightly=''
if [[ "${rustc_version}" == *"nightly"* ]] || [[ "${rustc_version}" == *"dev"* ]]; then
    nightly=1
    rustup ${pre_args[@]+"${pre_args[@]}"} component add rust-src &>/dev/null
    # We only run clippy on the recent nightly to avoid old clippy bugs.
    if [[ "${rustc_minor_version}" -ge 80 ]]; then
        rustup ${pre_args[@]+"${pre_args[@]}"} component add clippy &>/dev/null
        base_args=(${pre_args[@]+"${pre_args[@]}"} hack clippy)
    fi
fi
export ATOMIC_MAYBE_UNINIT_DENY_WARNINGS=1

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
    local cfgs
    if grep <<<"${rustup_target_list}" -Eq "^${target}$"; then
        cfgs=$(RUSTC_BOOTSTRAP=1 rustc ${pre_args[@]+"${pre_args[@]}"} --print cfg "${target_flags[@]}")
        rustup ${pre_args[@]+"${pre_args[@]}"} target add "${target}" &>/dev/null
    elif [[ -n "${nightly}" ]]; then
        cfgs=$(RUSTC_BOOTSTRAP=1 rustc ${pre_args[@]+"${pre_args[@]}"} --print cfg "${target_flags[@]}")
        # Only build core because our library code doesn't depend on std.
        args+=(-Z build-std="core")
    else
        echo "target '${target}' requires nightly compiler (skipped all checks)"
        return 0
    fi
    if [[ "${target}" == "avr"* ]]; then
        if [[ "${llvm_version}" -eq 16 ]]; then
            # https://github.com/rust-lang/compiler-builtins/issues/523
            target_rustflags+=" -C linker-plugin-lto -C codegen-units=1"
        elif [[ "${llvm_version}" -ge 17 ]]; then
            # https://github.com/rust-lang/rust/issues/88252
            target_rustflags+=" -C opt-level=s"
        fi
    fi

    args+=(
        --workspace --no-private
        --feature-powerset --optional-deps
    )
    RUSTFLAGS="${target_rustflags}" \
        x_cargo "${args[@]}" "$@"
    case "${target}" in
        x86_64*)
            # Apple and Windows (except Windows 7, since Rust 1.78) targets are +cmpxchg16b by default
            if ! grep <<<"${cfgs}" -q 'target_feature="cmpxchg16b"'; then
                CARGO_TARGET_DIR="${target_dir}/cmpxchg16b" \
                    RUSTFLAGS="${target_rustflags} -C target-feature=+cmpxchg16b" \
                    x_cargo "${args[@]}" "$@"
            fi
            ;;
        i686*)
            CARGO_TARGET_DIR="${target_dir}/sse" \
                RUSTFLAGS="${target_rustflags} -C target-feature=-sse2" \
                x_cargo "${args[@]}" "$@"
            ;;
        i586*)
            # i586 is -C target-feature=+x87 by default, but cfg(target_feature = "x87") doesn't work.
            CARGO_TARGET_DIR="${target_dir}/x87" \
                RUSTFLAGS="${target_rustflags} --cfg target_feature=\"x87\"" \
                x_cargo "${args[@]}" "$@"
            ;;
        aarch64* | arm64*)
            # macOS is +lse,+lse2,+rcpc by default
            if ! grep <<<"${cfgs}" -q 'target_feature="lse"'; then
                CARGO_TARGET_DIR="${target_dir}/lse" \
                    RUSTFLAGS="${target_rustflags} -C target-feature=+lse" \
                    x_cargo "${args[@]}" "$@"
            fi
            if ! grep <<<"${cfgs}" -q 'target_feature="rcpc"'; then
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
            # Support for FEAT_LRCPC3 and FEAT_LSE128 requires LLVM 16+.
            if [[ "${llvm_version}" -ge 16 ]]; then
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
            fi
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
        s390x*)
            CARGO_TARGET_DIR="${target_dir}/z196" \
                RUSTFLAGS="${target_rustflags} -C target-cpu=z196" \
                x_cargo "${args[@]}" "$@"
            ;;
    esac
}

for target in "${targets[@]}"; do
    build "${target}"
done
