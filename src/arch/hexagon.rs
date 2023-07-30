// Hexagon
//
// Refs:
// - Hexagon V5x Programmer's Reference Manual
//   https://developer.qualcomm.com/download/hexagon/hexagon-v5x-programmers-reference-manual.pdf?referrer=node/6116

#[path = "partword.rs"]
mod partword;

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

type XSize = usize;

macro_rules! atomic_load_store {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        // (atomic) load from src to tmp
                        concat!("{tmp} = mem", $asm_u_suffix, $asm_suffix, "({src})"),
                        // store tmp to out
                        concat!("mem", $asm_suffix, "({out}) = {tmp}"),
                        src = in(reg) src,
                        out = inout(reg) out => _,
                        tmp = lateout(reg) _,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        // load from val to tmp
                        concat!("{tmp} = mem", $asm_u_suffix, $asm_suffix, "({val})"),
                        // (atomic) store tmp to dst
                        concat!("mem", $asm_suffix, "({dst}) = {tmp}"),
                        dst = inout(reg) dst => _,
                        val = in(reg) val,
                        tmp = lateout(reg) _,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident) => {
        atomic_load_store!($int_type, "w", "");
        impl AtomicSwap for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "{val} = memw({val})",
                        "2:",
                            "{tmp} = memw_locked({dst})",
                            "memw_locked({dst},p0) = {val}",
                            "if (!p0) jump 2b",
                        "memw({out}) = {tmp}",
                        dst = in(reg) dst,
                        val = inout(reg) val => _,
                        out = in(reg) out,
                        tmp = out(reg) _,
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> bool {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32 = 1;
                    asm!(
                        "{old} = memw({old})",
                        "{new} = memw({new})",
                        "2:",
                            "{tmp} = memw_locked({dst})",
                            "{{ p0 = cmp.eq({tmp},{old})",
                                "if (!p0.new) jump:nt 3f }}",
                            "memw_locked({dst},p0) = {new}",
                            "if (!p0) jump 2b",
                            "jump 4f",
                        "3:",
                            "{r} = #0",
                        "4:",
                        "memw({out}) = {tmp}",
                        dst = in(reg) dst,
                        old = inout(reg) old => _,
                        new = inout(reg) new => _,
                        out = in(reg) out,
                        tmp = out(reg) _,
                        r = inout(reg) r,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

macro_rules! atomic_sub_word {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, $asm_u_suffix);
        impl AtomicSwap for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                let (aligned_ptr, shift, mask) = partword::create_mask_values(dst);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("{val} = mem", $asm_u_suffix, $asm_suffix, "({val})"),
                        "{mask} = asl({mask},{shift})",
                        "{val} = asl({val},{shift})",
                        "{val} = and({val},{mask})",
                        "{inv_mask} = not({mask})",
                        "2:",
                            "{out_tmp} = memw_locked({dst})",
                            "{tmp} = and({out_tmp},{inv_mask})",
                            "{tmp} = or({tmp},{val})",
                            "memw_locked({dst},p0) = {tmp}",
                            "if (!p0) jump 2b",
                        "{out_tmp} = asr({out_tmp},{shift})",
                        concat!("mem", $asm_suffix, "({out}) = {out_tmp}"),
                        dst = in(reg) aligned_ptr,
                        val = inout(reg) val => _,
                        out = in(reg) out,
                        shift = in(reg) shift,
                        mask = inout(reg) mask => _,
                        inv_mask = out(reg) _,
                        out_tmp = out(reg) _,
                        tmp = out(reg) _,
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> bool {
                let (aligned_ptr, shift, mask) = partword::create_mask_values(dst);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32 = 1;
                    asm!(
                        concat!("{old} = mem", $asm_u_suffix, $asm_suffix, "({old})"),
                        concat!("{new} = mem", $asm_u_suffix, $asm_suffix, "({new})"),
                        "{mask} = asl({mask},{shift})",
                        "{old} = asl({old},{shift})",
                        "{new} = asl({new},{shift})",
                        "{old} = and({old},{mask})",
                        "{new} = and({new},{mask})",
                        "{inv_mask} = not({mask})",
                        "2:",
                            "{tmp} = memw_locked({dst})",
                            "{out_tmp} = and({tmp},{mask})",
                            "{{ p0 = cmp.eq({out_tmp},{old})",
                                "if (!p0.new) jump:nt 3f }}",
                            "{tmp} = and({tmp},{inv_mask})",
                            "{tmp} = or({tmp},{new})",
                            "memw_locked({dst},p0) = {tmp}",
                            "if (!p0) jump 2b",
                            "jump 4f",
                        "3:",
                            "{r} = #0",
                        "4:",
                        "{out_tmp} = asr({out_tmp},{shift})",
                        concat!("mem", $asm_suffix, "({out}) = {out_tmp}"),
                        dst = in(reg) aligned_ptr,
                        old = inout(reg) old => _,
                        new = inout(reg) new => _,
                        out = in(reg) out,
                        shift = in(reg) shift,
                        mask = inout(reg) mask => _,
                        inv_mask = out(reg) _,
                        out_tmp = out(reg) _,
                        tmp = out(reg) _,
                        r = inout(reg) r,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

atomic_sub_word!(i8, "b", "u");
atomic_sub_word!(u8, "b", "u");
atomic_sub_word!(i16, "h", "u");
atomic_sub_word!(u16, "h", "u");
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
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        // (atomic) load from src to tmp pair
                        "{{ r3:2 = memd({src}) }}",
                        // store tmp pair to out
                        "memd({out}) = r3:2",
                        src = in(reg) src,
                        out = in(reg) out,
                        out("r2") _, // tmp
                        out("r3") _, // tmp
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        // load from val to tmp pair
                        "{{ r3:2 = memd({val}) }}",
                        // (atomic) store tmp pair to dst
                        "memd({dst}) = r3:2",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        out("r2") _, // tmp
                        out("r3") _, // tmp
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
        impl AtomicSwap for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        "{{ r3:2 = memd({val}) }}",
                        "2:",
                            "{{ r5:4 = memd_locked({dst}) }}",
                            "memd_locked({dst},p0) = r3:2",
                            "if (!p0) jump 2b",
                        "memd({out}) = r5:4",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        out = in(reg) out,
                        out("r2") _, // val
                        out("r3") _, // val
                        out("r4") _, // tmp
                        out("r5") _, // tmp
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline(never)] // TODO: there is no way to mark p0 as clobbered
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> bool {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: i32 = 1;
                    asm!(
                        "{{ r3:2 = memd({old}) }}",
                        "{{ r5:4 = memd({new}) }}",
                        "2:",
                            "{{ r7:6 = memd_locked({dst}) }}",
                            // TODO: merge two cmp?
                            "{{ p0 = cmp.eq(r6,r2)",
                                "if (!p0.new) jump:nt 3f }}",
                            "{{ p0 = cmp.eq(r7,r3)",
                                "if (!p0.new) jump:nt 3f }}",
                            "memd_locked({dst},p0) = r5:4",
                            "if (!p0) jump 2b",
                            "jump 4f",
                        "3:",
                            "{r} = #0",
                        "4:",
                        "memd({out}) = r7:6",
                        dst = in(reg) dst,
                        old = in(reg) old,
                        new = in(reg) new,
                        out = in(reg) out,
                        out("r2") _, // old
                        out("r3") _, // old
                        out("r4") _, // new
                        out("r5") _, // new
                        out("r6") _, // tmp
                        out("r7") _, // tmp
                        r = inout(reg) r,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

atomic64!(i64);
atomic64!(u64);

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);
    test_atomic!(i32);
    test_atomic!(u32);
    test_atomic!(i64);
    test_atomic!(u64);

    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
    stress_test!(u16);
    stress_test!(u32);
    stress_test!(u64);
}
