// Generated asm:
// - s390x https://godbolt.org/z/E3cxcjn7G

use core::{
    arch::asm,
    mem::MaybeUninit,
    sync::atomic::{self, Ordering},
};

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic_load_store {
    ($int_type:ident, $asm_suffix:tt, $st_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // (atomic) load from src to r0
                        concat!("l", $asm_suffix, " %r0, 0({src})"),
                        // store r0 to out
                        concat!("st", $st_suffix, " %r0, 0({out})"),
                        src = in(reg) src,
                        out = in(reg) out,
                        out("r0") _,
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    asm!(
                        // load from val to r0
                        concat!("l", $asm_suffix, " %r0, 0({val})"),
                        // (atomic) store r0 to dst
                        concat!("st", $st_suffix, " %r0, 0({dst})"),
                        dst = in(reg) dst,
                        val = in(reg) val,
                        out("r0") _,
                        options(nostack),
                    );
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {}
                        Ordering::SeqCst => atomic::fence(Ordering::SeqCst),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt, $st_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, $st_suffix);
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // load from val to val_tmp
                        concat!("l", $asm_suffix, " {val_tmp}, 0({val})"),
                        // (atomic) swap (cas loop)
                        concat!("l", $asm_suffix, " %r0, 0({dst})"),
                        "2:",
                            concat!("cs", $asm_suffix, " %r0, {val_tmp}, 0({dst})"),
                            "jl 2b",
                        // store r0 to out
                        concat!("st", $st_suffix, " %r0, 0({out})"),
                        dst = inout(reg) dst => _,
                        val = in(reg) val,
                        val_tmp = lateout(reg) _,
                        out = inout(reg) out => _,
                        out("r0") _,
                        options(nostack),
                    );
                }
            }
        }
    };
}

atomic_load_store!(i8, "b", "c");
atomic_load_store!(u8, "b", "c");
atomic_load_store!(i16, "h", "h");
atomic_load_store!(u16, "h", "h");
atomic!(i32, "", "");
atomic!(u32, "", "");
atomic!(i64, "g", "g");
atomic!(u64, "g", "g");
atomic!(isize, "g", "g");
atomic!(usize, "g", "g");

// https://github.com/llvm/llvm-project/commit/a11f63a952664f700f076fd754476a2b9eb158cc
macro_rules! atomic128 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // (atomic) load from src to r0-r1 pair
                        "lpq %r0, 0({src})",
                        // store r0-r1 pair to out
                        "stg %r1, 8({out})",
                        "stg %r0, 0({out})",
                        src = in(reg) src,
                        out = in(reg) out,
                        // lpq loads value into the pair of specified register and subsequent register.
                        out("r0") _,
                        out("r1") _,
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    asm!(
                        // load from val to r0-r1 pair
                        "lg %r1, 8({val})",
                        "lg %r0, 0({val})",
                        // (atomic) store r0-r1 pair to dst
                        "stpq %r0, 0({dst})",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        // stpq stores value from the pair of specified register and subsequent register.
                        out("r0") _,
                        out("r1") _,
                        options(nostack),
                    );
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {}
                        Ordering::SeqCst => atomic::fence(Ordering::SeqCst),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

atomic128!(i128);
atomic128!(u128);

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic_load_store!(i8);
    test_atomic_load_store!(u8);
    test_atomic_load_store!(i16);
    test_atomic_load_store!(u16);
    test_atomic!(i32);
    test_atomic!(u32);
    test_atomic!(i64);
    test_atomic!(u64);
    test_atomic_load_store!(i128);
    test_atomic_load_store!(u128);

    stress_test_load_store!();
    stress_test_load_swap!();
}
