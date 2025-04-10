// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Pre-v6 Arm Linux/Android

See arch/arm_linux.rs for references and notes.

Generated asm:
- armv5te https://godbolt.org/z/r61s7cnG8
- armv4t https://godbolt.org/z/xrxfKx1rc
*/

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

// https://github.com/torvalds/linux/blob/v6.13/Documentation/arch/arm/kernel_user_helpers.rst
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
    unsafe { crate::utils::ptr::with_exposed_provenance::<i32>(KUSER_HELPER_VERSION).read() }
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
    ($ty:ident, $asm_suffix:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
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
                        _ => unreachable!(),
                    }
                }
                out
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
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
                        _ => unreachable!(),
                    }
                }
            }
        }
    };
}

macro_rules! atomic {
    ($ty:ident) => {
        atomic_load_store!($ty, "");
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
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
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
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
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    // 0 if the store was successful, 1 if no store was performed
                    (out, r == 0)
                }
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($ty:ident, $asm_suffix:tt) => {
        atomic_load_store!($ty, $asm_suffix);
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                debug_assert!(kuser_helper_version() >= 2);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        concat!("ldr", $asm_suffix, " {val}, [{val}]"),
                        "lsl {val}, {val}, {shift}",
                        "and {val}, {val}, {mask}",
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
                        mask = in(reg) mask,
                        inv_mask = in(reg) !mask,
                        out_tmp = out(reg) _,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") _,
                        out("r1") _,
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
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                debug_assert!(kuser_helper_version() >= 2);
                let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        concat!("ldr", $asm_suffix, " {old}, [{old}]"),
                        concat!("ldr", $asm_suffix, " {new}, [{new}]"),
                        "lsl {old}, {old}, {shift}",
                        "lsl {new}, {new}, {shift}",
                        "and {old}, {old}, {mask}",
                        "and {new}, {new}, {mask}",
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
                        mask = in(reg) mask,
                        // We cannot create inv_mask here because there are no available registers
                        // inv_mask = in(reg) !mask,
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
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
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
    ($ty:ident) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
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
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
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
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
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
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
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
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
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
            panic!("64-bit atomics on pre-v6 Arm requires Linux kernel version 3.1+")
        }
        p()
    }
}

// -----------------------------------------------------------------------------
// cfg macros

#[macro_export]
macro_rules! cfg_has_atomic_8 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_8 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_16 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_16 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => {};
}
// TODO: set has_atomic_64 to true
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}

#[cfg(test)]
mod tests {
    #[test]
    fn kuser_helper_version() {
        let version = super::kuser_helper_version();
        assert!(version >= 5, "{version:?}");
    }

    // TODO: set has_atomic_64 to true
    test_atomic!(i64);
    test_atomic!(u64);
    stress_test!(u64);
}
