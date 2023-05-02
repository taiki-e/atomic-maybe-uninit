// s390x
//
// Refs:
// - z/Architecture Reference Summary https://www.ibm.com/support/pages/zarchitecture-reference-summary
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - s390x https://godbolt.org/z/8eEYWr6f8

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic_load_store {
    ($int_type:ident, $asm_suffix:tt, $st_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {
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
                        }
                        Ordering::SeqCst => {
                            asm!(
                                // load from val to r0
                                concat!("l", $asm_suffix, " %r0, 0({val})"),
                                // (atomic) store r0 to dst
                                concat!("st", $st_suffix, " %r0, 0({dst})"),
                                "bcr 15, %r0",
                                dst = in(reg) dst,
                                val = in(reg) val,
                                out("r0") _,
                                options(nostack),
                            );
                        },
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // load from val to val_tmp
                        concat!("l", $asm_suffix, " {val_tmp}, 0({val})"),
                        // (atomic) swap (CAS loop)
                        concat!("l", $asm_suffix, " %r0, 0({dst})"),
                        "2:",
                            concat!("cs", $asm_suffix, " %r0, {val_tmp}, 0({dst})"),
                            "jl 2b",
                        // store r0 to out
                        concat!("st", $st_suffix, " %r0, 0({out})"),
                        dst = inout(reg) dst => _,
                        val = in(reg) val,
                        val_tmp = out(reg) _,
                        out = inout(reg) out => _,
                        out("r0") _,
                        options(nostack),
                    );
                }
            }
        }
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: usize;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // load from old/new to r0/tmp
                        concat!("l", $asm_suffix, " %r0, 0({old})"),
                        concat!("l", $asm_suffix, " {tmp}, 0({new})"),
                        // (atomic) compare and exchange
                        concat!("cs", $asm_suffix, " %r0, {tmp}, 0({dst})"),
                        // store result to r as true(1) or false(0)
                        "ipm {tmp}",
                        "afi {tmp}, -268435456",
                        "risbg {r}, {tmp}, 63, 191, 33",
                        // store r0 to out
                        concat!("st", $st_suffix, " %r0, 0({out})"),
                        dst = in(reg) dst,
                        old = in(reg) old,
                        new = in(reg) new,
                        tmp = out(reg) _,
                        out = inout(reg) out => _,
                        r = lateout(reg) r,
                        out("r0") _,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

macro_rules! atomic8 {
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // Implement sub-word atomic operations using word-sized CAS loop.
                        // Based on assemblies generated by rustc/LLVM.
                        // Refs:
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/SystemZ/atomicrmw-xchg-01.ll
                        "lb %r0, 0(%r3)",
                        "risbg %r1, %r2, 0, 189, 0",
                        "l %r3, 0(%r1)",
                        "sll %r2, 3",
                        "lcr %r5, %r2",
                        "2:",
                            "rll %r14, %r3, 0(%r2)",
                            "risbg %r14, %r0, 32, 39, 24",
                            "rll %r14, %r14, 0(%r5)",
                            "cs %r3, %r14, 0(%r1)",
                            "jl 2b",
                        "rll %r0, %r3, 8(%r2)",
                        "stc %r0, 0(%r4)",
                        out("r0") _,
                        out("r1") _, // dst ptr (aligned)
                        inout("r2") dst => _,
                        inout("r3") val => _,
                        in("r4") out,
                        out("r5") _,
                        out("r14") _,
                        options(nostack),
                    );
                }
            }
        }
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: usize;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // Implement sub-word atomic operations using word-sized CAS loop.
                        // Based on assemblies generated by rustc/LLVM.
                        // Refs:
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                        "llc %r0, 0(%r3)",
                        "lb %r1, 0(%r4)",
                        "risbg %r3, %r2, 0, 189, 0",
                        "l %r4, 0(%r3)",
                        "sll %r2, 3",
                        "lcr %r14, %r2",
                        "2:",
                            "rll %r13, %r4, 8(%r2)",
                            "risbg %r1, %r13, 32, 55, 0",
                            "llcr %r13, %r13",
                            "cr %r13, %r0",
                            "jlh 3f",
                            "rll %r12, %r1, -8(%r14)",
                            "cs %r4, %r12, 0(%r3)",
                            "jl 2b",
                        "3:",
                        // store result to r2 as true(1) or false(0)
                        "ipm %r0",
                        "afi %r0, -268435456",
                        "risbg %r2, %r0, 63, 191, 33",
                        "stc %r13, 0(%r5)",
                        out("r0") _,
                        out("r1") _,
                        inout("r2") dst => r,
                        inout("r3") old => _,
                        inout("r4") new => _,
                        in("r5") out,
                        out("r12") _,
                        out("r13") _,
                        out("r14") _,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

macro_rules! atomic16 {
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // Implement sub-word atomic operations using word-sized CAS loop.
                        // Based on assemblies generated by rustc/LLVM.
                        // Refs:
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/SystemZ/atomicrmw-xchg-02.ll
                        "lh %r0, 0(%r3)",
                        "risbg %r1, %r2, 0, 189, 0",
                        "l %r3, 0(%r1)",
                        "sll %r2, 3",
                        "lcr %r5, %r2",
                        "2:",
                            "rll %r14, %r3, 0(%r2)",
                            "risbg %r14, %r0, 32, 47, 16",
                            "rll %r14, %r14, 0(%r5)",
                            "cs %r3, %r14, 0(%r1)",
                            "jl 2b",
                        "rll %r0, %r3, 16(%r2)",
                        "sth %r0, 0(%r4)",
                        out("r0") _,
                        out("r1") _, // dst ptr (aligned)
                        inout("r2") dst => _,
                        inout("r3") val => _,
                        in("r4") out,
                        out("r5") _,
                        out("r14") _,
                        options(nostack),
                    );
                }
            }
        }
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: usize;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // Implement sub-word atomic operations using word-sized CAS loop.
                        // Based on assemblies generated by rustc/LLVM.
                        // Refs:
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                        "llh %r0, 0(%r3)",
                        "lh %r1, 0(%r4)",
                        "risbg %r3, %r2, 0, 189, 0",
                        "l %r4, 0(%r3)",
                        "sll %r2, 3",
                        "lcr %r14, %r2",
                        "2:",
                            "rll %r13, %r4, 16(%r2)",
                            "risbg %r1, %r13, 32, 47, 0",
                            "llhr %r13, %r13",
                            "cr %r13, %r0",
                            "jlh 3f",
                            "rll %r12, %r1, -16(%r14)",
                            "cs %r4, %r12, 0(%r3)",
                            "jl 2b",
                        "3:",
                        // store result to r2 as true(1) or false(0)
                        "ipm %r0",
                        "afi %r0, -268435456",
                        "risbg %r2, %r0, 63, 191, 33",
                        "sth %r13, 0(%r5)",
                        out("r0") _,
                        out("r1") _,
                        inout("r2") dst => r,
                        inout("r3") old => _,
                        inout("r4") new => _,
                        in("r5") out,
                        out("r12") _,
                        out("r13") _,
                        out("r14") _,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

atomic8!(i8, "b", "c");
atomic8!(u8, "b", "c");
atomic16!(i16, "h", "h");
atomic16!(u16, "h", "h");
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
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
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
                        // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {
                            asm!(
                                // load from val to r0-r1 pair
                                "lg %r1, 8({val})",
                                "lg %r0, 0({val})",
                                // (atomic) store r0-r1 pair to dst
                                "stpq %r0, 0({dst})",
                                dst = in(reg) dst,
                                val = in(reg) val,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                out("r0") _,
                                out("r1") _,
                                options(nostack),
                            );
                        }
                        Ordering::SeqCst => {
                            asm!(
                                // load from val to r0-r1 pair
                                "lg %r1, 8({val})",
                                "lg %r0, 0({val})",
                                // (atomic) store r0-r1 pair to dst
                                "stpq %r0, 0({dst})",
                                "bcr 15, %r0",
                                dst = in(reg) dst,
                                val = in(reg) val,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                out("r0") _,
                                out("r1") _,
                                options(nostack),
                            );
                        }
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // load from val to r0-r1 pair
                        "lg %r1, 8({val})",
                        "lg %r0, 0({val})",
                        // (atomic) swap (CAS loop)
                        "lpq %r2, 0({dst})",
                        "2:",
                            "cdsg %r2, %r0, 0({dst})",
                            "jl 2b",
                        // store r2-r3 pair to out
                        "stg %r3, 8({out})",
                        "stg %r2, 0({out})",
                        dst = inout(reg) dst => _,
                        val = in(reg) val,
                        out = inout(reg) out => _,
                        // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                        out("r0") _, // val (hi)
                        out("r1") _, // val (lo)
                        lateout("r2") _, // out (hi)
                        lateout("r3") _, // out (lo)
                        options(nostack),
                    );
                }
            }
        }
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: usize;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // load from old/new to r0-r1/r12-r13 pairs
                        "lg %r1, 8({old})",
                        "lg %r0, 0({old})",
                        "lg %r13, 8({new})",
                        "lg %r12, 0({new})",
                        // (atomic) compare and exchange
                        "cdsg %r0, %r12, 0({dst})",
                        // store result to r as true(1) or false(0)
                        "ipm {r}",
                        "afi {r}, -268435456",
                        "risbg {r}, {r}, 63, 191, 33",
                        // store r0-r1 pair to out
                        "stg %r1, 8({out})",
                        "stg %r0, 0({out})",
                        dst = in(reg) dst,
                        old = in(reg) old,
                        new = in(reg) new,
                        out = inout(reg) out => _,
                        r = lateout(reg) r,
                        // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                        out("r0") _, // old (hi) -> out (hi)
                        out("r1") _, // old (lo) -> out (lo)
                        out("r12") _, // new (hi)
                        out("r13") _, // new (hi)
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
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
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);
    test_atomic!(i32);
    test_atomic!(u32);
    test_atomic!(i64);
    test_atomic!(u64);
    test_atomic!(i128);
    test_atomic!(u128);

    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
    stress_test!(u16);
    stress_test!(u32);
    stress_test!(u64);
    stress_test!(u128);
}
