// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Run-time CPU feature detection on x86_64 by using CPUID.

Adapted from https://github.com/rust-lang/rust/blob/1.92.0/library/std_detect/src/detect/os/x86.rs.
*/

// SGX doesn't support CPUID: https://github.com/rust-lang/rust/blob/1.92.0/library/std_detect/src/detect/os/x86.rs#L30-L33
#[cfg(target_env = "sgx")]
compile_error!("internal error: this module is not supported on this environment");

include!("common.rs");

use core::arch::x86_64::{__cpuid, _xgetbv, CpuidResult};

#[cold]
fn _detect(info: &mut CpuInfo) {
    #[allow(unused_unsafe)] // safe in newer rustc
    // SAFETY: Calling `__cpuid` is safe on all x86_64 CPUs except for SGX,
    // which doesn't support `cpuid`.
    // https://github.com/rust-lang/stdarch/blob/a0c30f3e3c75adcd6ee7efc94014ebcead61c507/crates/core_arch/src/x86/cpuid.rs#L102-L109
    let CpuidResult { ecx: proc_info_ecx, .. } = unsafe { __cpuid(1) };

    // https://github.com/rust-lang/rust/blob/1.92.0/library/std_detect/src/detect/os/x86.rs#L166-L236
    let cpu_xsave = test(proc_info_ecx, 26);
    if cpu_xsave {
        let cpu_osxsave = test(proc_info_ecx, 27);
        if cpu_osxsave {
            // SAFETY: Calling `_xgetbv` is safe because the CPU has `xsave` support
            // and OS has set `osxsave`.
            let xcr0 = unsafe { _xgetbv(0) };
            let os_avx_support = xcr0 & 6 == 6;
            if os_avx_support && test(proc_info_ecx, 28) {
                info.set(CpuInfoFlag::avx);
            }
        }
    }
}

#[allow(
    clippy::alloc_instead_of_core,
    clippy::std_instead_of_alloc,
    clippy::std_instead_of_core,
    clippy::undocumented_unsafe_blocks,
    clippy::wildcard_imports
)]
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    #[cfg_attr(atomic_maybe_uninit_test_detect_false, ignore = "detection disabled")]
    fn test_cpuid() {
        // The recent Rosetta 2 unofficially implements AVX support.
        // (The OS reports it as unsupported, likely due to poor performance.)
        #[cfg(target_vendor = "apple")]
        assert_eq!(
            std::is_x86_feature_detected!("avx"),
            detect().avx() || cfg!(target_feature = "avx")
        );
        #[cfg(not(target_vendor = "apple"))]
        assert_eq!(std::is_x86_feature_detected!("avx"), detect().avx());
    }
}
