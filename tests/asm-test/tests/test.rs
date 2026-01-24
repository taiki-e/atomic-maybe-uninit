// SPDX-License-Identifier: Apache-2.0 OR MIT

use asmtest::{Revision, Tester};

#[rustfmt::skip]
#[test]
fn test() {
    let revisions = &[
        // AArch64
        Revision::new("aarch64", "aarch64-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=-outline-atomics"]),
        Revision::new("aarch64_be", "aarch64_be-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=-outline-atomics"]),
        Revision::new("aarch64_ilp32", "aarch64-unknown-linux-gnu_ilp32")
            .rustc_args(["-C", "target-feature=-outline-atomics"]),
        Revision::new("aarch64_msvc", "aarch64-pc-windows-msvc")
            .rustc_args(["-C", "target-feature=-outline-atomics"]),
        Revision::new("aarch64_lse", "aarch64-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+lse"]),
        Revision::new("aarch64_lse_msvc", "aarch64-pc-windows-msvc")
            .rustc_args(["-C", "target-feature=+lse"]),
        Revision::new("aarch64_lse_lse2", "aarch64-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+lse,+lse2"]),
        Revision::new("aarch64_lse_lse2_rcpc3", "aarch64-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+lse,+lse2,+rcpc3"]),
        Revision::new("aarch64_rcpc", "aarch64-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+rcpc"]),
        Revision::new("aarch64_lse2_lse128", "aarch64-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+lse2,+lse128"]),
        Revision::new("aarch64_lse2_lse128_rcpc3", "aarch64-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+lse2,+lse128,+rcpc3"]),
        // Arm64EC
        Revision::new("arm64ec", "arm64ec-pc-windows-msvc")
            .rustc_args(["-C", "target-feature=-outline-atomics"]),
        // Arm
        Revision::new("armv4t", "armv4t-unknown-linux-gnueabi"),
        Revision::new("armv5te", "armv5te-unknown-linux-gnueabi"),
        Revision::new("armv6_kuser_memory_barrier", "arm-unknown-linux-gnueabi"),
        Revision::new("armv6_cp15_barrier", "arm-unknown-linux-gnueabi")
            .rustc_args(["--cfg", "atomic_maybe_uninit_use_cp15_barrier"]),
        Revision::new("armv6m", "thumbv6m-none-eabi"),
        Revision::new("armv7a", "armv7-unknown-linux-gnueabi"),
        Revision::new("armv7m", "thumbv7m-none-eabi"),
        Revision::new("armv8a", "armv7-unknown-linux-gnueabi")
            .rustc_args(["-C", "target-feature=+v8"]),
        Revision::new("armv8m_base", "thumbv8m.base-none-eabi"),
        Revision::new("armv8m_main", "thumbv8m.main-none-eabi"),
        // AVR
        Revision::new("avr", "avr-none")
            .rustc_args(["-C", "target-cpu=atmega2560"]),
        Revision::new("avr_rmw", "avr-none")
            .rustc_args(["-C", "target-cpu=atxmega384c3"]),
        // C-SKY
        Revision::new("csky", "csky-unknown-linux-gnuabiv2")
            .rustc_args(["-C", "target-cpu=ck860"]),
        // Hexagon
        Revision::new("hexagon", "hexagon-unknown-linux-musl"),
        // LoongArch32 and LoongArch64
        Revision::new("loongarch32", "loongarch32-unknown-none"),
        Revision::new("loongarch64", "loongarch64-unknown-linux-gnu"),
        // M68k
        Revision::new("m68k", "m68k-unknown-linux-gnu"),
        // MIPS32 and MIPS64
        Revision::new("mips", "mips-unknown-linux-gnu"),
        Revision::new("mipsel", "mipsel-unknown-linux-gnu"),
        Revision::new("mips64", "mips64-unknown-linux-gnuabi64"),
        Revision::new("mips64el", "mips64el-unknown-linux-gnuabi64"),
        // MSP430
        Revision::new("msp430", "msp430-none-elf"),
        // PowerPC and PowerPC64
        Revision::new("powerpc", "powerpc-unknown-linux-gnu"),
        Revision::new("powerpc_pwr8", "powerpc-unknown-linux-gnu")
            .rustc_args(["-C", "target-cpu=pwr8"]),
        Revision::new("powerpcspe", "powerpc-unknown-linux-gnuspe"),
        Revision::new("powerpc64", "powerpc64-unknown-linux-gnu"),
        Revision::new("powerpc64_pwr8", "powerpc64-unknown-linux-gnu")
            .rustc_args(["-C", "target-cpu=pwr8"]),
        Revision::new("powerpc64le", "powerpc64le-unknown-linux-gnu"),
        Revision::new("powerpc64le_pwr7", "powerpc64le-unknown-linux-gnu")
            .rustc_args(["-C", "target-cpu=pwr7"]),
        // RISC-V
        Revision::new("riscv64gc", "riscv64gc-unknown-linux-gnu"),
        Revision::new("riscv64gc_zacas", "riscv64gc-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+zacas"]),
        Revision::new("riscv64gc_zabha_zacas", "riscv64gc-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+zabha,+zacas"]),
        Revision::new("riscv32imac", "riscv32imac-unknown-none-elf"),
        Revision::new("riscv32imac_zacas", "riscv32imac-unknown-none-elf")
            .rustc_args(["-C", "target-feature=+zacas"]),
        Revision::new("riscv32imac_zabha_zacas", "riscv32imac-unknown-none-elf")
            .rustc_args(["-C", "target-feature=+zabha,+zacas"]),
        Revision::new("riscv32i_zalrsc", "riscv32i-unknown-none-elf")
            .rustc_args(["-C", "target-feature=+zalrsc"]),
        Revision::new("riscv32i_zacas", "riscv32i-unknown-none-elf")
            .rustc_args(["-C", "target-feature=+zacas"]),
        // s390x (SystemZ)
        Revision::new("s390x", "s390x-unknown-linux-gnu"),
        Revision::new("s390x_z196", "s390x-unknown-linux-gnu")
            .rustc_args(["-C", "target-cpu=z196"]),
        // SPARC and SPARC64
        Revision::new("sparcv8_leoncasa", "sparc-unknown-none-elf")
            .rustc_args(["-C", "target-cpu=leon3", "-C", "target-feature=+leoncasa"]),
        Revision::new("sparcv8plus", "sparc-unknown-linux-gnu"),
        Revision::new("sparc64", "sparc64-unknown-linux-gnu"),
        // x86 and x86_64
        Revision::new("x86_64", "x86_64-unknown-linux-gnu"),
        Revision::new("x86_64_cmpxchg16b", "x86_64-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+cmpxchg16b"]),
        Revision::new("x86_64_cmpxchg16b_msvc", "x86_64-pc-windows-msvc")
            .rustc_args(["-C", "target-feature=+cmpxchg16b"]),
        Revision::new("x86_64_cmpxchg16b_avx", "x86_64-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=+cmpxchg16b,+avx"]),
        Revision::new("x86_64_cmpxchg16b_avx_x32", "x86_64-unknown-linux-gnux32")
            .rustc_args(["-C", "target-feature=+cmpxchg16b,+avx"]),
        Revision::new("x86_64_cmpxchg16b_avx_msvc", "x86_64-pc-windows-msvc")
            .rustc_args(["-C", "target-feature=+cmpxchg16b,+avx"]),
        Revision::new("x86_sse2", "i686-unknown-linux-gnu"),
        Revision::new("x86_sse", "i686-unknown-linux-gnu")
            .rustc_args(["-C", "target-feature=-sse2"]),
        Revision::new("x86_x87", "i586-unknown-linux-gnu"),
        Revision::new("x86_no_x87", "i586-unknown-linux-gnu")
            .rustc_args(["--cfg", "atomic_maybe_uninit_test_prefer_cmpxchg8b_over_x87"]),
    ];
    let esp_revisions = &[
        // Xtensa
        Revision::new("xtensa", "xtensa-esp32-none-elf"),
    ];
    let revisions = if build_context::RUSTC.contains(".rustup/toolchains/esp/bin/") {
        &esp_revisions[..]
    } else {
        &revisions[..]
    };
    Tester::new()
        .cargo_args(["-Z", "build-std=core", "--features", "atomic-maybe-uninit"])
        .dump(env!("CARGO_MANIFEST_DIR"), "asm/atomic-maybe-uninit", revisions);
    Tester::new()
        .cargo_args(["-Z", "build-std=core", "--features", "core"])
        .dump(env!("CARGO_MANIFEST_DIR"), "asm/core", revisions);
}
