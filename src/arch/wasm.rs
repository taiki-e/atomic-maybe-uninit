// Generated asm:
// - wasm32 https://godbolt.org/z/1Gs1KrMds
// - wasm32 (+atomics) https://godbolt.org/z/M3TE1a35G

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

#[cfg(target_feature = "atomics")]
macro_rules! asm_atomic {
    ($($tt:tt)*) => {
        ".atomic"
    };
}
#[cfg(not(target_feature = "atomics"))]
macro_rules! asm_atomic {
    ($($tt:tt)*) => {
        ""
    };
}

macro_rules! atomic_sub_word {
    ($int_type:ident, $bits:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        "local.get {1}",
                        "local.get {0}",
                        concat!("i32", asm_atomic!(), ".load", $bits, "_u {0}"),
                        concat!("i32.store", $bits, " {0}"),
                        inout(local) src => _,
                        in(local) out,
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
                _order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        "local.get {0}",
                        "local.get {1}",
                        concat!("i32.load", $bits, "_u {0}"),
                        concat!("i32", asm_atomic!(), ".store", $bits, " {0}"),
                        inout(local) dst => _,
                        inout(local) val => _,
                        options(nostack),
                    );
                }
            }
        }
        #[cfg(target_feature = "atomics")]
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        "local.get {2}",
                        "local.get {0}",
                        "local.get {1}",
                        concat!("i32.load", $bits, "_u {0}"),
                        concat!("i32.atomic.rmw", $bits, ".xchg_u {0}"),
                        concat!("i32.store", $bits, " {0}"),
                        inout(local) dst => _,
                        inout(local) val => _,
                        in(local) out,
                        options(nostack),
                    );
                }
            }
        }
        #[cfg(target_feature = "atomics")]
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg
                unsafe {
                    let r: usize;
                    // compare_exchange is always SeqCst.
                    asm!(
                        "local.get {3}",
                        "local.get {0}",
                        "local.get {1}",
                        concat!("i32.load", $bits, "_u {0}"),
                        "local.tee {1}",
                        "local.get {2}",
                        concat!("i32.load", $bits, "_u {0}"),
                        concat!("i32.atomic.rmw", $bits, ".cmpxchg_u {0}"),
                        "local.tee {0}",
                        concat!("i32.store", $bits, " {0}"),
                        "local.get {0}",
                        "local.get {1}",
                        "i32.eq",
                        inout(local) dst => r,
                        inout(local) old => _,
                        inout(local) new => _,
                        in(local) out,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $bits:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        "local.get {1}",
                        "local.get {0}",
                        concat!("i", $bits, asm_atomic!(), ".load {0}"),
                        concat!("i", $bits, ".store {0}"),
                        inout(local) src => _,
                        in(local) out,
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
                _order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        "local.get {0}",
                        "local.get {1}",
                        concat!("i", $bits, ".load {0}"),
                        concat!("i", $bits, asm_atomic!(), ".store {0}"),
                        in(local) dst,
                        inout(local) val => _,
                        options(nostack),
                    );
                }
            }
        }
        #[cfg(target_feature = "atomics")]
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        "local.get {2}",
                        "local.get {0}",
                        "local.get {1}",
                        concat!("i", $bits, ".load {0}"),
                        concat!("i", $bits, ".atomic.rmw.xchg {0}"),
                        concat!("i", $bits, ".store {0}"),
                        in(local) dst,
                        inout(local) val => _,
                        in(local) out,
                        options(nostack),
                    );
                }
            }
        }
        #[cfg(target_feature = "atomics")]
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg
                unsafe {
                    let r: usize;
                    // compare_exchange is always SeqCst.
                    asm!(
                        "local.get {3}",
                        "local.get {0}",
                        "local.get {1}",
                        concat!("i", $bits, ".load {0}"),
                        "local.tee {1}",
                        "local.get {2}",
                        concat!("i", $bits, ".load {0}"),
                        concat!("i", $bits, ".atomic.rmw.cmpxchg {0}"),
                        "local.tee {0}",
                        concat!("i", $bits, ".store {0}"),
                        "local.get {0}",
                        "local.get {1}",
                        concat!("i", $bits, ".eq"),
                        inout(local) dst => r,
                        inout(local) old => _,
                        inout(local) new => _,
                        in(local) out,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

atomic_sub_word!(i8, "8");
atomic_sub_word!(u8, "8");
atomic_sub_word!(i16, "16");
atomic_sub_word!(u16, "16");
atomic!(i32, "32");
atomic!(u32, "32");
atomic!(i64, "64");
atomic!(u64, "64");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "32");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "32");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "64");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "64");

#[cfg(test)]
mod tests {
    test_atomic_load_store!(isize);
    test_atomic_load_store!(usize);
    test_atomic_load_store!(i8);
    test_atomic_load_store!(u8);
    test_atomic_load_store!(i16);
    test_atomic_load_store!(u16);
    test_atomic_load_store!(i32);
    test_atomic_load_store!(u32);
    test_atomic_load_store!(i64);
    test_atomic_load_store!(u64);

    // stress_test_load_store!();
    // stress_test_load_swap!();
}
