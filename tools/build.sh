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

    # avr
    # rustc --print target-list | grep -E '^avr'
    avr-unknown-gnu-atmega2560 # custom target

    # hexagon
    # rustc --print target-list | grep -E '^hexagon'
    hexagon-unknown-linux-musl
)
# List of known custom cfgs, excluding those that may be set from build script.
known_cfgs=(
    # arm: Use cp15_barrier instead of __kuser_memory_barrier on ARMv6 Linux/Android.
    # ARMv6 binaries compiled with this cfg may cause problems when run on ARMv7+ chips:
    # https://github.com/rust-lang/rust/issues/60605
    atomic_maybe_uninit_use_cp15_barrier
    # x86: Assume CPU does not have CMPXCHG8B instruction.
    # This is a cfg for compatibility with 80486/80386, but
    # note that LLVM does not support those CPUs well:
    # https://reviews.llvm.org/D18802
    # This cannot be supported by automatic detection in the build script,
    # since rustc does not have a target feature to indicate this, and targets
    # beginning with i386- may actually be i686 (e.g., i386-apple-ios)
    # https://github.com/rust-lang/rust/blob/1.70.0/compiler/rustc_target/src/spec/apple_base.rs#L68
    atomic_maybe_uninit_no_cmpxchg8b
    # x86: Assume CPU does not have CMPXCHG instruction.
    # This is a cfg for compatibility with 80386.
    # See atomic_maybe_uninit_no_cmpxchg8b for details.
    atomic_maybe_uninit_no_cmpxchg
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

rustup_target_list=$(rustup ${pre_args[@]+"${pre_args[@]}"} target list | sed 's/ .*//g')
rustc_target_list=$(rustc ${pre_args[@]+"${pre_args[@]}"} --print target-list)
rustc_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -Vv | grep 'release: ' | sed 's/release: //')
rustc_minor_version="${rustc_version#*.}"
rustc_minor_version="${rustc_minor_version%%.*}"
llvm_version=$(rustc ${pre_args[@]+"${pre_args[@]}"} -Vv | (grep 'LLVM version: ' || true) | (sed 's/LLVM version: //' || true))
llvm_version="${llvm_version%%.*}"
base_args=(${pre_args[@]+"${pre_args[@]}"} hack build)
target_dir=$(pwd)/target
nightly=''
if [[ "${rustc_version}" == *"nightly"* ]] || [[ "${rustc_version}" == *"dev"* ]]; then
    nightly=1
    rustup ${pre_args[@]+"${pre_args[@]}"} component add rust-src &>/dev/null
    # The latest syntax of -Z check-cfg requires 1.75.0-nightly.
    # We only check this on the recent nightly to avoid old clippy bugs.
    # shellcheck disable=SC2207
    if [[ "${rustc_minor_version}" -ge 79 ]]; then
        build_scripts=(build.rs)
        check_cfg='-Z unstable-options --check-cfg=cfg(target_pointer_width,values("128")) --check-cfg=cfg(target_arch,values("xtensa")) --check-cfg=cfg(target_feature,values("x87","lse2","lse128","rcpc3","v8m","partword-atomics","quadword-atomics","fast-serialization"))'
        known_cfgs+=($(grep -E 'cargo:rustc-cfg=' "${build_scripts[@]}" | sed -E 's/^.*cargo:rustc-cfg=//; s/(=\\)?".*$//' | LC_ALL=C sort -u))
        # TODO: handle multi-line target_feature_if
        known_target_feature_values+=($(grep -E 'target_feature_if\("' "${build_scripts[@]}" | sed -E 's/^.*target_feature_if\(//; s/",.*$/"/' | LC_ALL=C sort -u))
        check_cfg+=" --check-cfg=cfg(atomic_maybe_uninit_target_feature,values($(IFS=',' && echo "${known_target_feature_values[*]}")))"
        check_cfg+=" --check-cfg=cfg($(IFS=',' && echo "${known_cfgs[*]}"))"
        rustup ${pre_args[@]+"${pre_args[@]}"} component add clippy &>/dev/null
        base_args=(${pre_args[@]+"${pre_args[@]}"} hack clippy -Z check-cfg)
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
    if grep <<<"${rustup_target_list}" -Eq "^${target}$"; then
        rustup ${pre_args[@]+"${pre_args[@]}"} target add "${target}" &>/dev/null
    elif [[ -n "${nightly}" ]]; then
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
            # Apple targets are skipped because they are +cmpxchg16b by default
            case "${target}" in
                *-apple-*) ;;
                *)
                    CARGO_TARGET_DIR="${target_dir}/cmpxchg16b" \
                        RUSTFLAGS="${target_rustflags} -C target-feature=+cmpxchg16b" \
                        x_cargo "${args[@]}" "$@"
                    ;;
            esac
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
            # macOS is skipped because it is +lse,+lse2,+rcpc by default
            case "${target}" in
                *-darwin) ;;
                *)
                    CARGO_TARGET_DIR="${target_dir}/lse" \
                        RUSTFLAGS="${target_rustflags} -C target-feature=+lse" \
                        x_cargo "${args[@]}" "$@"
                    # FEAT_LSE2 doesn't imply FEAT_LSE.
                    CARGO_TARGET_DIR="${target_dir}/lse2" \
                        RUSTFLAGS="${target_rustflags} -C target-feature=+lse,+lse2" \
                        x_cargo "${args[@]}" "$@"
                    CARGO_TARGET_DIR="${target_dir}/rcpc" \
                        RUSTFLAGS="${target_rustflags} -C target-feature=+rcpc" \
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
