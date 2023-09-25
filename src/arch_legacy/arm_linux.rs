// SPDX-License-Identifier: Apache-2.0 OR MIT

// Pre-v6 ARM Linux/Android
//
// Refs:
// - https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt
// - https://github.com/rust-lang/compiler-builtins/blob/0.1.88/src/arm_linux.rs
// - ARMv4 and ARMv5 Differences
//   https://developer.arm.com/documentation/ddi0406/cb/Appendixes/ARMv4-and-ARMv5-Differences?lang=en
//
// Generated asm:
// - armv5te https://godbolt.org/z/r61s7cnG8
// - armv4t https://godbolt.org/z/xrxfKx1rc

#[path = "../arch/cfgs/arm_linux.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

// https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt
const KUSER_HELPER_VERSION: usize = 0xFFFF0FFC;
// __kuser_helper_version >= 2 (kernel version 2.6.12+)
const KUSER_CMPXCHG: usize = 0xFFFF0FC0;
// __kuser_helper_version >= 3 (kernel version 2.6.15+)
const KUSER_MEMORY_BARRIER: usize = 0xFFFF0FA0;
// __kuser_helper_version >= 5 (kernel version 3.1+)
const KUSER_CMPXCHG64: usize = 0xFFFF0F60;

#[inline]
fn kuser_helper_version() -> i32 {
    // SAFETY: core assumes that at least __kuser_memory_barrier (__kuser_helper_version >= 3) is
    // available on this platform. __kuser_helper_version is always available on such a platform.
    unsafe { (KUSER_HELPER_VERSION as *const i32).read() }
}

#[cfg(any(target_feature = "v5te", atomic_maybe_uninit_target_feature = "v5te"))]
macro_rules! blx {
    ($addr:tt) => {
        concat!("blx ", $addr)
    };
}
#[cfg(not(any(target_feature = "v5te", atomic_maybe_uninit_target_feature = "v5te")))]
macro_rules! blx {
    ($addr:tt) => {
        concat!("mov lr, pc", "\n", "bx ", $addr)
    };
}

macro_rules! atomic_load_store {
    ($int_type:ident, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{src}]"),
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                src = in(reg) src,
                                out = inout(reg) out_ptr => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => {
                            debug_assert!(kuser_helper_version() >= 3);
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{src}]"),
                                blx!("{kuser_memory_barrier}"), // acquire fence
                                // store tmp to out
                                concat!("str", $asm_suffix, " {tmp}, [{out}]"),
                                src = in(reg) src,
                                out = inout(reg) out_ptr => _,
                                tmp = lateout(reg) _,
                                kuser_memory_barrier = inout(reg) KUSER_MEMORY_BARRIER => _,
                                out("lr") _,
                                options(nostack, preserves_flags),
                            );
                        }
                        _ => unreachable!("{:?}", order),
                    }
                }
                out
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store_release {
                        ($acquire:expr) => {{
                            debug_assert!(kuser_helper_version() >= 3);
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{val}]"),
                                // (atomic) store tmp to dst
                                blx!("{kuser_memory_barrier}"), // release fence
                                concat!("str", $asm_suffix, " {tmp}, [{dst}]"),
                                $acquire, // acquire fence
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                kuser_memory_barrier = inout(reg) KUSER_MEMORY_BARRIER => _,
                                out("lr") _,
                                options(nostack, preserves_flags),
                            )
                        }};
                    }
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // load from val to tmp
                                concat!("ldr", $asm_suffix, " {tmp}, [{val}]"),
                                // (atomic) store tmp to dst
                                concat!("str", $asm_suffix, " {tmp}, [{dst}]"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Release => atomic_store_release!(""),
                        Ordering::SeqCst => atomic_store_release!(blx!("{kuser_memory_barrier}")),
                        _ => unreachable!("{:?}", order),
                    }
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident) => {
        atomic_load_store!($int_type, "");
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(kuser_helper_version() >= 2);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "ldr r1, [r1]", // new_val
                        "2:",
                            "ldr r0, [r2]", // old_val
                            "mov {out_tmp}, r0",
                            blx!("{kuser_cmpxchg}"),
                            "cmp r0, #0",
                            "bne 2b",
                        "str {out_tmp}, [{out}]",
                        out = in(reg) out_ptr,
                        out_tmp = out(reg) _,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") _,
                        inout("r1") val => _,
                        in("r2") dst, // ptr
                        out("r3") _,
                        out("ip") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP and __kuser_cmpxchg modify the condition flags.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(kuser_helper_version() >= 2);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    asm!(
                        "ldr {old}, [{old}]",
                        "ldr {new}, [{new}]",
                        "2:",
                            "ldr r0, [r2]", // old_val
                            "mov {out_tmp}, r0",
                            "cmp r0, {old}",
                            "bne 3f",
                            "mov r1, {new}", // new_val
                            blx!("{kuser_cmpxchg}"),
                            "cmp r0, #0",
                            "bne 2b",
                            "b 4f",
                        "3:",
                            // write back to synchronize
                            "mov r1, r0", // new_val
                            blx!("{kuser_cmpxchg}"),
                            "cmp r0, #0",
                            "bne 2b",
                            "mov r0, #1",
                        "4:",
                        "str {out_tmp}, [{out}]",
                        old = inout(reg) old => _,
                        new = inout(reg) new => _,
                        out = in(reg) out_ptr,
                        out_tmp = out(reg) _,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") r,
                        out("r1") _,
                        in("r2") dst, // ptr
                        out("r3") _,
                        out("ip") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP and __kuser_cmpxchg modify the condition flags.
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix);
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(kuser_helper_version() >= 2);
                let (aligned_ptr, shift, mask) = crate::utils::create_partword_mask_values(dst);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("ldr", $asm_suffix, " {val}, [{val}]"),
                        "lsl {mask}, {mask}, {shift}",
                        "lsl {val}, {val}, {shift}",
                        "and {val}, {val}, {mask}",
                        "mvn {inv_mask}, {mask}",
                        "2:",
                            "ldr r0, [r2]", // old_val
                            "mov {out_tmp}, r0",
                            "and r1, r0, {inv_mask}",
                            "orr r1, r1, {val}", // new_val
                            blx!("{kuser_cmpxchg}"),
                            "cmp r0, #0",
                            "bne 2b",
                        "lsr {out_tmp}, {out_tmp}, {shift}",
                        concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                        val = inout(reg) val => _,
                        out = in(reg) out_ptr,
                        shift = in(reg) shift,
                        mask = inout(reg) mask => _,
                        inv_mask = out(reg) _,
                        out_tmp = out(reg) _,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") _,
                        out("r1") _,
                        in("r2") aligned_ptr, // ptr
                        out("r3") _,
                        out("ip") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP and __kuser_cmpxchg modify the condition flags.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(kuser_helper_version() >= 2);
                let (aligned_ptr, shift, mask) = crate::utils::create_partword_mask_values(dst);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    asm!(
                        concat!("ldr", $asm_suffix, " {old}, [{old}]"),
                        concat!("ldr", $asm_suffix, " {new}, [{new}]"),
                        "lsl {mask}, {mask}, {shift}",
                        "lsl {old}, {old}, {shift}",
                        "lsl {new}, {new}, {shift}",
                        "and {old}, {old}, {mask}",
                        "and {new}, {new}, {mask}",
                        // We cannot create inv_mask here because there are no available registers
                        // "mvn {inv_mask}, {mask}",
                        "2:",
                            "ldr r0, [r2]", // old_val
                            "and {out_tmp}, r0, {mask}",
                            "cmp {out_tmp}, {old}",
                            "bne 3f",
                            "mvn r1, {mask}",
                            "and r1, r0, r1",
                            "orr r1, r1, {new}", // new_val
                            blx!("{kuser_cmpxchg}"),
                            "cmp r0, #0",
                            "bne 2b",
                            "b 4f",
                        "3:",
                            // write back to synchronize
                            "mov r1, r0", // new_val
                            blx!("{kuser_cmpxchg}"),
                            "cmp r0, #0",
                            "bne 2b",
                            "mov r0, #1",
                        "4:",
                        "lsr {out_tmp}, {out_tmp}, {shift}",
                        concat!("str", $asm_suffix, " {out_tmp}, [{out}]"),
                        old = inout(reg) old => _,
                        new = inout(reg) new => _,
                        out = in(reg) out_ptr,
                        shift = in(reg) shift,
                        mask = inout(reg) mask => _,
                        out_tmp = out(reg) _,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") r,
                        out("r1") _,
                        in("r2") aligned_ptr, // ptr
                        out("r3") _,
                        out("ip") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP and __kuser_cmpxchg modify the condition flags.
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
        }
    };
}

atomic_sub_word!(i8, "b");
atomic_sub_word!(u8, "b");
atomic_sub_word!(i16, "h");
atomic_sub_word!(u16, "h");
atomic!(i32);
atomic!(u32);
atomic!(isize);
atomic!(usize);

macro_rules! atomic64 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                assert_has_kuser_cmpxchg64();
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "2:",
                            "ldr r0, [r2]",
                            "ldr r3, [r2, #4]",
                            "str r0, [r1]",
                            "str r3, [r1, #4]",
                            "mov r0, r1", // old_val
                            blx!("{kuser_cmpxchg64}"),
                            "cmp r0, #0",
                            "bne 2b",
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") _,
                        in("r1") out_ptr, // new_val
                        in("r2") src, // ptr
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP and __kuser_cmpxchg64 modify the condition flags.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                assert_has_kuser_cmpxchg64();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut out_tmp = MaybeUninit::<Self>::uninit();
                    asm!(
                        "2:",
                            "ldr r0, [r2]",
                            "ldr r3, [r2, #4]",
                            "str r0, [{out_tmp}]",
                            "str r3, [{out_tmp}, #4]",
                            "mov r0, {out_tmp}", // old_val
                            blx!("{kuser_cmpxchg64}"),
                            "cmp r0, #0",
                            "bne 2b",
                        out_tmp = in(reg) out_tmp.as_mut_ptr(),
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") _,
                        in("r1") val, // new_val
                        in("r2") dst, // ptr
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP and __kuser_cmpxchg64 modify the condition flags.
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                assert_has_kuser_cmpxchg64();
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "2:",
                            "ldr r0, [r2]",
                            "ldr r3, [r2, #4]",
                            "str r0, [{out_tmp}]",
                            "str r3, [{out_tmp}, #4]",
                            "mov r0, {out_tmp}", // old_val
                            blx!("{kuser_cmpxchg64}"),
                            "cmp r0, #0",
                            "bne 2b",
                        out_tmp = in(reg) out_ptr,
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") _,
                        in("r1") val, // new_val
                        in("r2") dst, // ptr
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP and __kuser_cmpxchg64 modify the condition flags.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                assert_has_kuser_cmpxchg64();
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    asm!(
                        "ldr {old_lo}, [{old_hi}]",
                        "ldr {old_hi}, [{old_hi}, #4]",
                        "2:",
                            "ldr r0, [r2]",
                            "ldr r3, [r2, #4]",
                            "str r0, [{out_tmp}]",
                            "str r3, [{out_tmp}, #4]",
                            "eor r0, r0, {old_lo}",
                            "eor r3, r3, {old_hi}",
                            "orrs r0, r0, r3",
                            "bne 3f",
                            "mov r0, {out_tmp}", // old_val
                            "mov r1, {new}", // new_val
                            blx!("{kuser_cmpxchg64}"),
                            "cmp r0, #0",
                            "bne 2b",
                            "b 4f",
                        "3:",
                            // write back to ensure atomicity
                            "mov r0, {out_tmp}", // old_val
                            "mov r1, {out_tmp}", // new_val
                            blx!("{kuser_cmpxchg64}"),
                            "cmp r0, #0",
                            "bne 2b",
                            "mov r0, #1",
                        "4:",
                        new = in(reg) new,
                        out_tmp = in(reg) out_ptr,
                        old_lo = out(reg) _,
                        old_hi = inout(reg) old => _,
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") r,
                        out("r1") _,
                        in("r2") dst, // ptr
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because CMP, ORRS, and __kuser_cmpxchg64 modify the condition flags.
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);

// TODO: Since Rust 1.64, the Linux kernel requirement for Rust when using std is 3.2+, so it
// should be possible to convert this to debug_assert if the std feature is enabled on Rust 1.64+.
// https://blog.rust-lang.org/2022/08/01/Increasing-glibc-kernel-requirements.html
#[inline]
fn assert_has_kuser_cmpxchg64() {
    if kuser_helper_version() < 5 {
        #[cold]
        fn p() -> ! {
            panic!("64-bit atomics on pre-v6 ARM requires Linux kernel version 3.1+")
        }
        p()
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn kuser_helper_version() {
        let version = super::kuser_helper_version();
        assert!(version >= 5, "{:?}", version);
    }

    // TODO: set has_atomic_64 to true
    test_atomic!(i64);
    test_atomic!(u64);
    stress_test!(u64);
}
