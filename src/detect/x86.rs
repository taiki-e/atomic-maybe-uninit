// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Run-time CPU feature detection on x86 and x86_64 by using CPUID.

Adapted from https://github.com/rust-lang/rust/blob/b3869b94cd1ed4bfa2eb28f301535d5e9599c713/library/std_detect/src/detect/os/x86.rs.
*/

// SGX doesn't support CPUID: https://github.com/rust-lang/rust/blob/1.92.0/library/std_detect/src/detect/os/x86.rs#L30-L33
#[cfg(target_env = "sgx")]
compile_error!("internal error: this module is not supported on this environment");

include!("common.rs");

#[cfg(target_arch = "x86")]
use core::arch::x86::{__cpuid, _xgetbv, CpuidResult};
#[cfg(target_arch = "x86_64")]
use core::arch::x86_64::{__cpuid, _xgetbv, CpuidResult};

#[cold]
fn _detect(info: &mut CpuInfo) {
    // Based on has_cpuid removed in Rust 1.90: https://github.com/rust-lang/rust/commit/8b77e779cbabd67733f3cda9c18aea1661608a32
    // See also comment about atomic_maybe_uninit_no_cmpxchg8b in Cargo.toml.
    #[cfg(all(target_arch = "x86", not(target_feature = "sse")))]
    #[allow(clippy::inline_asm_x86_att_syntax)]
    unsafe {
        // On `x86` the `cpuid` instruction is not always available.
        // This follows the approach indicated in:
        // https://wiki.osdev.org/CPUID#Checking_CPUID_availability
        // https://web.archive.org/web/20161107105657/https://software.intel.com/en-us/articles/using-cpuid-to-detect-the-presence-of-sse-41-and-sse-42-instruction-sets/
        // which detects whether `cpuid` is available by checking whether
        // the 21st bit of the EFLAGS register is modifiable or not.
        // If it is, then `cpuid` is available.
        let result: u32;
        asm!(
            // Read eflags and save a copy of it
            "pushfd",
            "pop {result}",
            "mov {result}, {saved_flags}",
            // Flip 21st bit of the flags
            "xor $0x200000, {result}",
            // Load the modified flags and read them back.
            // Bit 21 can only be modified if cpuid is available.
            "push {result}",
            "popfd",
            "pushfd",
            "pop {result}",
            // Use xor to find out whether bit 21 has changed
            "xor {saved_flags}, {result}",
            result = out(reg) result,
            saved_flags = out(reg) _,
            options(nomem, att_syntax),
        );
        // There is a race between popfd (A) and pushfd (B)
        // where other bits beyond 21st may have been modified due to
        // interrupts, a debugger stepping through the asm, etc.
        //
        // Therefore, explicitly check whether the 21st bit
        // was modified or not.
        //
        // If the result is zero, the cpuid bit was not modified.
        // If the result is `0x200000` (non-zero), then the cpuid
        // was correctly modified and the CPU supports the cpuid
        // instruction:
        let has_cpuid = (result & 0x200000) != 0;
        if !has_cpuid {
            return;
        }
    }

    #[allow(unused_unsafe)] // https://github.com/rust-lang/stdarch/pull/1935
    // SAFETY: we've checked that CPUID is available.
    let CpuidResult { eax: max_basic_leaf, .. } = unsafe { __cpuid(0) };

    if max_basic_leaf < 1 {
        // Earlier Intel 486, CPUID not implemented
        return;
    }

    #[allow(unused_unsafe)] // https://github.com/rust-lang/stdarch/pull/1935
    // SAFETY: we've checked that CPUID is available.
    let CpuidResult { ecx: proc_info_ecx, .. } = unsafe { __cpuid(0x0000_0001) };

    let (extended_features_ebx, extended_features_ecx, extended_features_edx) =
        if max_basic_leaf >= 7 {
            #[allow(unused_unsafe)] // https://github.com/rust-lang/stdarch/pull/1935
            // SAFETY: we've checked that CPUID is available.
            let CpuidResult { ebx, ecx, edx, .. } = unsafe { __cpuid(0x0000_0007) };
            (ebx, ecx, edx)
        } else {
            (0, 0, 0)
        };

    let mut enable = |r, rb, f| {
        if test(r, rb) {
            info.set(f);
        }
    };

    enable(extended_features_ebx, 9, CpuInfoFlag::ermsb);
    enable(extended_features_edx, 4, CpuInfoFlag::fsrm);

    // https://github.com/rust-lang/rust/blob/1.92.0/library/std_detect/src/detect/os/x86.rs#L166-L236
    let cpu_xsave = test(proc_info_ecx, 26);
    if cpu_xsave {
        let cpu_osxsave = test(proc_info_ecx, 27);
        if cpu_osxsave {
            // SAFETY: Calling `_xgetbv` is safe because the CPU has `xsave` support
            // and OS has set `osxsave`.
            let xcr0 = unsafe { _xgetbv(0) };
            let os_avx_support = xcr0 & 6 == 6;
            let os_avx512_support = xcr0 & 0xE0 == 0xE0;
            if os_avx_support {
                enable(proc_info_ecx, 28, CpuInfoFlag::avx);
                enable(extended_features_ebx, 5, CpuInfoFlag::avx2);

                if os_avx512_support {
                    let avx512f = test(extended_features_ebx, 16);
                    if avx512f {
                        info.set(CpuInfoFlag::avx512f);

                        // Ice Lake (or Zen 4) or later CPUs.
                        //
                        // This check is based on target features available only since Intel Ice Lake.
                        // https://en.wikipedia.org/wiki/AVX-512#CPUs_with_AVX-512
                        if
                        // avx512vbmi2
                        test(extended_features_ecx, 6)
                            // avx512bitalg
                            && test(extended_features_ecx, 12)
                            // gfni
                            && test(extended_features_ecx, 8)
                            // vaes
                            && test(extended_features_ecx, 9)
                            // vpclmulqdq
                            && test(extended_features_ecx, 10)
                        {
                            info.set(CpuInfoFlag::icelake_or_later);
                        }
                    }
                }
            }
        }
    }
}
