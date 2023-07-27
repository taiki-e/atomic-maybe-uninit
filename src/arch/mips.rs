// MIPS32 and MIPS64
//
// Generated asm:
// - mips https://godbolt.org/z/oraj5srMn
// - mipsel https://godbolt.org/z/41hexMPsf
// - mips64 https://godbolt.org/z/3exjdnMWG
// - mips64el https://godbolt.org/z/z5rhsKzsj

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

#[cfg(target_endian = "little")]
macro_rules! if_be {
    ($($tt:tt)*) => {
        ""
    };
}
#[cfg(target_endian = "big")]
macro_rules! if_be {
    ($($tt:tt)*) => {
        $($tt)*
    };
}

#[cfg(any(target_arch = "mips", target_arch = "mips32r6"))]
macro_rules! daddiu {
    () => {
        "addiu"
    };
}
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
macro_rules! daddiu {
    () => {
        "daddiu"
    };
}

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("sync", ""),
            Ordering::Release => $op!("", "sync"),
            // AcqRel and SeqCst RMWs are equivalent.
            Ordering::AcqRel | Ordering::SeqCst => $op!("sync", "sync"),
            _ => unreachable!("{:?}", $order),
        }
    };
}

#[cfg(any(target_arch = "mips", target_arch = "mips32r6"))]
type XSize = u32;
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
type XSize = u64;

macro_rules! atomic_load_store {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // (atomic) load from src to tmp
                                concat!("l", $asm_suffix, " {tmp}, 0({src})"),
                                $acquire,
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                ".set pop",
                                src = in(reg) ptr_reg!(src),
                                out = in(reg) ptr_reg!(out),
                                tmp = out(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("sync"),
                        _ => unreachable!("{:?}", order),
                    }
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
                    macro_rules! store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // load from val to tmp
                                concat!("l", $asm_suffix, $asm_u_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                $release, // release fence
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                $acquire, // acquire fence
                                ".set pop",
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) ptr_reg!(val),
                                tmp = out(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(store, order);
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt, $asm_ll_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, "");
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // load from val to val_tmp
                                concat!("l", $asm_suffix, " {val_tmp}, 0({val})"),
                                // (atomic) swap
                                $release, // release fence
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ll", $asm_ll_suffix, " {out_tmp}, 0({dst})"),
                                    "move {r}, {val_tmp}",
                                    // try to store val to dst
                                    concat!("sc", $asm_ll_suffix, " {r}, 0({dst})"),
                                    // 1 if the store was successful, 0 if no store was performed
                                    "beqz {r}, 2b",
                                $acquire, // acquire fence
                                // store out_tmp to out
                                concat!("s", $asm_suffix, " {out_tmp}, 0({out})"),
                                ".set pop",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                out = inout(reg) ptr_reg!(out) => _,
                                val_tmp = out(reg) _,
                                out_tmp = out(reg) _,
                                r = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
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
                success: Ordering,
                failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: XSize;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                ".set push",
                                ".set noat",
                                // load from old/new to old_tmp/new_tmp
                                concat!("l", $asm_suffix, " {old_tmp}, 0({old})"),
                                concat!("l", $asm_suffix, " {new_tmp}, 0({new})"),
                                $release, // release fence
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ll", $asm_ll_suffix, " {out_tmp}, 0({dst})"),
                                    "bne {out_tmp}, {old_tmp}, 3f", // compare and jump if compare failed
                                    "move {r}, {new_tmp}",
                                    // try to store new to dst
                                    concat!("sc", $asm_ll_suffix, " {r}, 0({dst})"),
                                    // 1 if the store was successful, 0 if no store was performed
                                    "beqz {r}, 2b", // continue loop if store failed
                                "3:",
                                $acquire, // acquire fence
                                "xor {new_tmp}, {out_tmp}, {old_tmp}",
                                // store out_tmp to out
                                concat!("s", $asm_suffix, " {out_tmp}, 0({out})"),
                                "sltiu {r}, {new_tmp}, 1",
                                ".set pop",
                                dst = inout(reg) ptr_reg!(dst) => _,
                                old = in(reg) ptr_reg!(old),
                                new = in(reg) ptr_reg!(new),
                                out = inout(reg) ptr_reg!(out) => _,
                                new_tmp = out(reg) _,
                                old_tmp = out(reg) _,
                                out_tmp = out(reg) _,
                                r = lateout(reg) r,
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($int_type:ident, $asm_suffix:tt, $xor_mask:tt, $max:tt) => {
        atomic_load_store!($int_type, $asm_suffix, "u");
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // Implement sub-word atomic operations using word-sized LL/SC loop.
                                // Based on assemblies generated by rustc/LLVM.
                                // Refs:
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/Mips/atomic.ll
                                ".set push",
                                ".set noat",
                                concat!(daddiu!(), " $2, $zero, -4"),
                                "andi $3, $4, 3",
                                concat!("l", $asm_suffix, "u {tmp}, 0($5)"),
                                $release,
                                if_be!(concat!("xori $3, $3, ", $xor_mask)),
                                "and $2, $4, $2",
                                "sll $3, $3, 3",
                                concat!("ori $4, $zero, ", $max),
                                "sllv $4, $4, $3",
                                "sllv $7, {tmp}, $3",
                                "nor $5, $zero, $4",
                                // (atomic) swap
                                "2:",
                                    "ll $8, 0($2)",
                                    "and $9, $7, $4",
                                    "and $10, $8, $5",
                                    "or $10, $10, $9",
                                    "sc $10, 0($2)",
                                    "beqz $10, 2b",
                                "and {tmp}, $8, $4",
                                "srlv {tmp}, {tmp}, $3",
                                concat!("se", $asm_suffix, " {tmp}, {tmp}"),
                                $acquire,
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                ".set pop",
                                out = in(reg) ptr_reg!(out),
                                tmp = out(reg) _,
                                out("$2") _, // dst ptr (aligned)
                                out("$3") _,
                                inout("$4") ptr_reg!(dst) => _,
                                inout("$5") ptr_reg!(val) => _,
                                out("$7") _,
                                out("$8") _,
                                out("$9") _,
                                out("$10") _,
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
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
                success: Ordering,
                failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);
                let order = crate::utils::upgrade_success_ordering(success, failure);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: XSize;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // Implement sub-word atomic operations using word-sized LL/SC loop.
                                // Based on assemblies generated by rustc/LLVM.
                                // Refs:
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/Mips/atomic.ll
                                ".set push",
                                ".set noat",
                                concat!(daddiu!(), " $3, $zero, -4"),
                                concat!("l", $asm_suffix, "u $2, 0($6)"), // new
                                concat!("l", $asm_suffix, " {tmp}, 0($5)"),  // old
                                concat!("ori $5, $zero, ", $max),
                                $release,
                                "and $3, $4, $3",
                                "andi $4, $4, 3",
                                if_be!(concat!("xori $4, $4, ", $xor_mask)),
                                "sll $4, $4, 3",
                                concat!("andi $8, {tmp}, ", $max),
                                concat!("andi $2, $2, ", $max),
                                "sllv $5, $5, $4",
                                "sllv $8, $8, $4",
                                "sllv $9, $2, $4",
                                "nor $6, $zero, $5",
                                "2:",
                                    "ll $10, 0($3)",
                                    "and $11, $10, $5",
                                    "bne $11, $8, 3f",
                                    "and $10, $10, $6",
                                    "or $10, $10, $9",
                                    "sc $10, 0($3)",
                                    "beqz $10, 2b",
                                "3:",
                                "srlv $2, $11, $4",
                                concat!("se", $asm_suffix, " $2, $2"),
                                $acquire,
                                "xor {tmp}, $2, {tmp}",
                                concat!("s", $asm_suffix, " $2, 0({out})"),
                                "sltiu $2, {tmp}, 1",
                                ".set pop",
                                out = in(reg) ptr_reg!(out),
                                tmp = out(reg) _,
                                out("$2") r,
                                out("$3") _, // dst (aligned)
                                inout("$4") ptr_reg!(dst) => _,
                                inout("$5") ptr_reg!(old) => _,
                                inout("$6") ptr_reg!(new) => _,
                                out("$8") _,
                                out("$9") _,
                                out("$10") _,
                                out("$11") _,
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

atomic_sub_word!(i8, "b", "3", "255");
atomic_sub_word!(u8, "b", "3", "255");
atomic_sub_word!(i16, "h", "2", "65535");
atomic_sub_word!(u16, "h", "2", "65535");
atomic!(i32, "w", "");
atomic!(u32, "w", "");
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
atomic!(i64, "d", "d");
#[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
atomic!(u64, "d", "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "w", "");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "w", "");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d", "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d", "d");

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
    #[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
    test_atomic!(i64);
    #[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
    test_atomic!(u64);

    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
    stress_test!(u16);
    stress_test!(u32);
    #[cfg(any(target_arch = "mips64", target_arch = "mips64r6"))]
    stress_test!(u64);
}
