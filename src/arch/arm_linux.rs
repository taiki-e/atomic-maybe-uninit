// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Pre-v6 Arm Linux/Android

Refs:
- https://github.com/torvalds/linux/blob/v6.13/Documentation/arch/arm/kernel_user_helpers.rst
- https://github.com/rust-lang/compiler-builtins/blob/compiler_builtins-v0.1.124/src/arm_linux.rs
- ARMv4 and ARMv5 Differences
  https://developer.arm.com/documentation/ddi0406/cb/Appendixes/ARMv4-and-ARMv5-Differences

Note: __kuser_cmpxchg and __kuser_cmpxchg64 are always SeqCst.
https://github.com/torvalds/linux/blob/v6.13/arch/arm/kernel/entry-armv.S#L814-L822
https://github.com/torvalds/linux/blob/v6.13/arch/arm/kernel/entry-armv.S#L700-L707

Generated asm:
- armv5te https://godbolt.org/z/jqMMv6c3K
- armv4t https://godbolt.org/z/qMYe5qsTb
*/

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::{
    raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap},
    utils::MaybeUninit64,
};

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
    ($ty:ident, $suffix:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("ldr", $suffix, " {out}, [{src}]"), // atomic { out = *src }
                                src = in(reg) src,
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            );
                        }
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => {
                            debug_assert!(kuser_helper_version() >= 3);
                            asm!(
                                concat!("ldr", $suffix, " {out}, [{src}]"), // atomic { out = *src }
                                blx!("{kuser_memory_barrier}"),             // fence
                                src = in(reg) src,
                                out = lateout(reg) out,
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_store_release {
                        ($acquire:expr) => {{
                            debug_assert!(kuser_helper_version() >= 3);
                            asm!(
                                blx!("{kuser_memory_barrier}"),             // fence
                                concat!("str", $suffix, " {val}, [{dst}]"), // atomic { *dst = val }
                                $acquire,                                   // fence
                                dst = in(reg) dst,
                                val = in(reg) val,
                                kuser_memory_barrier = in(reg) KUSER_MEMORY_BARRIER,
                                out("lr") _,
                                options(nostack, preserves_flags),
                            )
                        }};
                    }
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                concat!("str", $suffix, " {val}, [{dst}]"), // atomic { *dst = val }
                                dst = in(reg) dst,
                                val = in(reg) val,
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
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "2:", // 'retry:
                            "ldr {out}, [r2]",       // atomic { out = *r2 }
                            "mov r0, {out}",         // r0 = out
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                        out = out(reg) out,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") _, // old_val
                        in("r1") val, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg clobbers r3, ip, and flags.
                        out("r3") _,
                        out("ip") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because __kuser_cmpxchg modifies the condition flags.
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
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    asm!(
                        "2:", // 'retry:
                            "ldr {out}, [r2]",       // atomic { out = *r2 }
                            "mov r0, {out}",         // r0 = out
                            "cmp {out}, {old}",      // if out == old { Z = 1 } else { Z = 0 }
                            "bne 3f",                // if Z == 0 { jump 'cmp-fail }
                            "mov r1, {new}",         // r1 = new
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                            "b 4f",                  // jump 'success
                        "3:", // 'cmp-fail:
                            // write back to synchronize
                            "mov r1, r0",            // r1 = r0
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                            "mov r0, #1",            // r0 = 1
                        "4:", // 'success:
                        old = in(reg) old,
                        new = in(reg) new,
                        out = out(reg) out,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") r, // old_val
                        out("r1") _, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg clobbers r3, ip, and flags.
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
    ($ty:ident, $suffix:tt) => {
        atomic_load_store!($ty, $suffix);
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
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized CAS loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "lsl {val}, {val}, {shift}",  // val <<= shift
                        "2:", // 'retry:
                            "ldr {out}, [r2]",        // atomic { out = *r2 }
                            "mov r0, {out}",          // r0 = out
                            "and r1, r0, {inv_mask}", // r1 = r0 & inv_mask
                            "orr r1, r1, {val}",      // r1 |= val
                            blx!("{kuser_cmpxchg}"),  // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                 // if C == 0 { jump 'retry }
                        "lsr {out}, {out}, {shift}",  // out >>= shift
                        val = inout(reg) crate::utils::ZeroExtend::zero_extend(val) => _,
                        out = out(reg) out,
                        shift = in(reg) shift,
                        inv_mask = in(reg) !mask,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") _, // old_val
                        out("r1") _, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg clobbers r3, ip, and flags.
                        out("r3") _,
                        out("ip") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because __kuser_cmpxchg modifies the condition flags.
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
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    // Implement sub-word atomic operations using word-sized CAS loop.
                    // See also create_sub_word_mask_values.
                    asm!(
                        "lsl {old}, {old}, {shift}",  // old <<= shift
                        "lsl {new}, {new}, {shift}",  // new <<= shift
                        "2:", // 'retry:
                            "ldr r0, [r2]",          // atomic { r0 = *r2 }
                            "and {out}, r0, {mask}", // out = r0 & mask
                            "cmp {out}, {old}",      // if out == old { Z = 1 } else { Z = 0 }
                            "bne 3f",                // if Z == 0 { jump 'cmp-fail }
                            "mvn r1, {mask}",        // r1 = !mask
                            "and r1, r0, r1",        // r1 &= r0
                            "orr r1, r1, {new}",     // r1 |= new
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                            "b 4f",                  // jump 'success
                        "3:", // 'cmp-fail:
                            // write back to synchronize
                            "mov r1, r0",            // r1 = r0
                            blx!("{kuser_cmpxchg}"), // atomic { if *r2 == r0 { *r2 = r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                // if C == 0 { jump 'retry }
                            "mov r0, #1",            // r0 = 1
                        "4:", // 'success:
                        "lsr {out}, {out}, {shift}",  // out >>= shift
                        old = inout(reg) crate::utils::ZeroExtend::zero_extend(old) => _,
                        new = inout(reg) crate::utils::ZeroExtend::zero_extend(new) => _,
                        out = out(reg) out,
                        shift = in(reg) shift,
                        mask = in(reg) mask,
                        // We cannot create inv_mask here because there are no available registers
                        // inv_mask = in(reg) !mask,
                        kuser_cmpxchg = in(reg) KUSER_CMPXCHG,
                        out("r0") r, // old_val
                        out("r1") _, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg clobbers r3, ip, and flags.
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
                        "2:", // 'retry:
                            "ldr r0, [r2]",            // atomic { r0 = *r2 }
                            "ldr r3, [r2, #4]",        // atomic { r3 = *r2.byte_add(4) }
                            "str r0, [r1]",            // *r1 = r0
                            "str r3, [r1, #4]",        // *r1.byte_add(4) = r3
                            "mov r0, r1",              // r0 = r1
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") _, // old_val
                        in("r1") out_ptr, // new_val
                        in("r2") src, // ptr
                        // __kuser_cmpxchg64 clobbers r3, lr, and flags.
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because __kuser_cmpxchg64 modifies the condition flags.
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
                        "2:", // 'retry:
                            "ldr r0, [r2]",            // atomic { r0 = *r2 }
                            "ldr r3, [r2, #4]",        // atomic { r3 = *r2.byte_add(4) }
                            "str r0, [{out}]",         // *out = r0
                            "str r3, [{out}, #4]",     // *out.byte_add(4) = r3
                            "mov r0, {out}",           // r0 = out
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                        out = in(reg) out_tmp.as_mut_ptr(),
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") _, // old_val
                        in("r1") val, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg64 clobbers r3, lr, and flags.
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because __kuser_cmpxchg64 modifies the condition flags.
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
                        "2:", // 'retry:
                            "ldr r0, [r2]",            // atomic { r0 = *r2 }
                            "ldr r3, [r2, #4]",        // atomic { r3 = *r2.byte_add(4) }
                            "str r0, [{out}]",         // *out = r0
                            "str r3, [{out}, #4]",     // *out.byte_add(4) = r3
                            "mov r0, {out}",           // r0 = out
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                        out = in(reg) out_ptr,
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") _, // old_val
                        in("r1") val, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg64 clobbers r3, lr, and flags.
                        out("r3") _,
                        out("lr") _,
                        // Do not use `preserves_flags` because __kuser_cmpxchg64 modifies the condition flags.
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
                let old = MaybeUninit64 { $ty: old };
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32;
                    asm!(
                        "2:", // 'retry:
                            "ldr r0, [r2]",            // atomic { r0 = *r2 }
                            "ldr r3, [r2, #4]",        // atomic { r3 = *r2.byte_add(4) }
                            "str r0, [{out}]",         // *out = r0
                            "str r3, [{out}, #4]",     // *out.byte_add(4) = r3
                            "eor r0, r0, {old_lo}",    // r0 ^= old_lo
                            "eor r3, r3, {old_hi}",    // r3 ^= old_hi
                            "orrs r0, r0, r3",         // r0 |= r3; if r0 == 0 { Z = 1 } else { Z = 0 }
                            "bne 3f",                  // if Z == 0 { jump 'cmp-fail }
                            "mov r0, {out}",           // r0 = out
                            "mov r1, {new}",           // r1 = new
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                            "b 4f",                    // jump 'success
                        "3:", // 'cmp-fail:
                            // write back to ensure atomicity
                            "mov r0, {out}",           // r0 = out
                            "mov r1, {out}",           // r1 = out
                            blx!("{kuser_cmpxchg64}"), // atomic { if *r2 == *r0 { *r2 = *r1; r0 = 0; C = 1 } else { r0 = nonzero; C = 0 } }
                            "bcc 2b",                  // if C == 0 { jump 'retry }
                            "mov r0, #1",              // r0 = 1
                        "4:", // 'success:
                        new = in(reg) new,
                        out = in(reg) out_ptr,
                        old_lo = in(reg) old.pair.lo,
                        old_hi = in(reg) old.pair.hi,
                        kuser_cmpxchg64 = in(reg) KUSER_CMPXCHG64,
                        out("r0") r, // old_val
                        out("r1") _, // new_val
                        in("r2") dst, // ptr
                        // __kuser_cmpxchg64 clobbers r3, lr, and flags.
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
