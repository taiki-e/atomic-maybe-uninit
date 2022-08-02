// Generated asm:
// - mips https://godbolt.org/z/dYEKfYfz5
// - mipsel https://godbolt.org/z/GbsoaKz8x
// - mips64 https://godbolt.org/z/T51cG4Wsq
// - mips64el https://godbolt.org/z/338d978rn

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

#[cfg(target_arch = "mips")]
macro_rules! daddiu {
    () => {
        "addiu"
    };
}
#[cfg(target_arch = "mips64")]
macro_rules! daddiu {
    () => {
        "daddiu"
    };
}

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

                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                ".set noat",
                                // (atomic) load from src to tmp
                                concat!("l", $asm_suffix, " {tmp}, 0({src})"),
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                ".set at",
                                src = in(reg) src,
                                out = in(reg) out,
                                tmp = out(reg) _,
                                options(nostack),
                            );
                        }
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => {
                            asm!(
                                ".set noat",
                                // (atomic) load from src to tmp
                                concat!("l", $asm_suffix, " {tmp}, 0({src})"),
                                "sync",
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                ".set at",
                                src = in(reg) src,
                                out = in(reg) out,
                                tmp = out(reg) _,
                                options(nostack),
                            );
                        }
                        _ => unreachable_unchecked!("{:?}", order),
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

                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                ".set noat",
                                // load from val to tmp
                                concat!("l", $asm_suffix, $asm_u_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                ".set at",
                                dst = in(reg) dst,
                                val = in(reg) val,
                                tmp = out(reg) _,
                                options(nostack),
                            );
                        }
                        Ordering::Release => {
                            asm!(
                                ".set noat",
                                // load from val to tmp
                                concat!("l", $asm_suffix, $asm_u_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                "sync",
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                ".set at",
                                dst = in(reg) dst,
                                val = in(reg) val,
                                tmp = out(reg) _,
                                options(nostack),
                            );
                        }
                        Ordering::SeqCst => {
                            asm!(
                                ".set noat",
                                // load from val to tmp
                                concat!("l", $asm_suffix, $asm_u_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                "sync",
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                "sync",
                                ".set at",
                                dst = in(reg) dst,
                                val = in(reg) val,
                                tmp = out(reg) _,
                                options(nostack),
                            );
                        }
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt, $asm_ll_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, $asm_u_suffix);
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

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                ".set noat",
                                // load from val to val_tmp
                                concat!("l", $asm_suffix, " {val_tmp}, 0({val})"),
                                // (atomic) swap
                                $release, // release fence
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ll", $asm_ll_suffix, " {out_tmp}, 0({dst})"),
                                    "move {r}, {val_tmp}",
                                    // store val to dst
                                    concat!("sc", $asm_ll_suffix, " {r}, 0({dst})"),
                                    // 1 if the store was successful, 0 if no store was performed
                                    "beqz {r}, 2b",
                                $acquire, // acquire fence
                                // store out_tmp to out
                                concat!("s", $asm_suffix, " {out_tmp}, 0({out})"),
                                ".set at",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                r = lateout(reg) _,
                                out_tmp = lateout(reg) _,
                                val_tmp = out(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("sync", ""),
                        Ordering::Release => atomic_swap!("", "sync"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!("sync", "sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
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

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                unsafe {
                    let mut r: usize;
                    macro_rules! atomic_cmpxchg {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                ".set noat",
                                // load from old/new to old_tmp/new_tmp
                                concat!("l", $asm_suffix, " {old_tmp}, 0({old})"),
                                concat!("l", $asm_suffix, " {new_tmp}, 0({new})"),
                                $release, // release fence
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("ll", $asm_ll_suffix, " {out_tmp}, 0({dst})"),
                                    "bne {out_tmp}, {old_tmp}, 3f",
                                    "move {r}, {new_tmp}",
                                    // store new to dst
                                    concat!("sc", $asm_ll_suffix, " {r}, 0({dst})"),
                                    // 1 if the store was successful, 0 if no store was performed
                                    "beqz {r}, 2b",
                                "3:",
                                $acquire, // acquire fence
                                "xor {new_tmp}, {out_tmp}, {old_tmp}",
                                // store out_tmp to out
                                concat!("s", $asm_suffix, " {out_tmp}, 0({out})"),
                                "sltiu {r}, {new_tmp}, 1",
                                ".set at",
                                dst = inout(reg) dst => _,
                                old = in(reg) old,
                                new = inout(reg) new => _,
                                out = inout(reg) out => _,
                                r = lateout(reg) r,
                                out_tmp = lateout(reg) _,
                                old_tmp = out(reg) _,
                                new_tmp = lateout(reg) _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("", ""),
                        Ordering::Acquire => atomic_cmpxchg!("sync", ""),
                        Ordering::Release => atomic_cmpxchg!("", "sync"),
                        // AcqRel and SeqCst compare_exchange are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_cmpxchg!("sync", "sync"),
                        _ => unreachable_unchecked!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic8 {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, $asm_u_suffix);
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

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // Implement sub-word atomic operations using word-sized LL/SC loop.
                                // Based on assemblies generated by rustc/LLVM.
                                // Refs:
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/test/CodeGen/Mips/atomic.ll
                                ".set noat",
                                // create aligned address and masks
                                // https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                concat!(daddiu!(), " $2, $zero, -4"),
                                "andi $3, $4, 3",
                                "lbu {tmp}, 0($5)",
                                $release,
                                if_be!("xori $3, $3, 3"),
                                "and $2, $4, $2",
                                "sll $3, $3, 3",
                                "ori $4, $zero, 255",
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
                                    "seb {tmp}, {tmp}",
                                $acquire,
                                "sb {tmp}, 0($6)",
                                ".set at",
                                tmp = out(reg) _,
                                out("$2") _, // dst ptr (aligned)
                                out("$3") _,
                                inout("$4") dst => _,
                                inout("$5") val => _,
                                in("$6") out,
                                out("$7") _,
                                out("$8") _,
                                out("$9") _,
                                out("$10") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("sync", ""),
                        Ordering::Release => atomic_swap!("", "sync"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!("sync", "sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
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

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                unsafe {
                    let mut r: usize;
                    macro_rules! atomic_cmpxchg {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // Implement sub-word atomic operations using word-sized LL/SC loop.
                                // Based on assemblies generated by rustc/LLVM.
                                // Refs:
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/test/CodeGen/Mips/atomic.ll
                                ".set noat",
                                concat!(daddiu!(), " $3, $zero, -4"),
                                "lbu $2, 0($6)", // new
                                "lb {tmp}, 0($5)",  // old
                                "ori $5, $zero, 255",
                                $release,
                                "and $3, $4, $3",
                                "andi $4, $4, 3",
                                if_be!("xori $4, $4, 3"),
                                "sll $4, $4, 3",
                                "andi $8, {tmp}, 255",
                                "andi $2, $2, 255",
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
                                "seb $2, $2",
                                $acquire,
                                "xor {tmp}, $2, {tmp}",
                                "sb $2, 0($7)",
                                "sltiu $2, {tmp}, 1",
                                ".set at",
                                tmp = out(reg) _,
                                out("$2") r,
                                out("$3") _, // dst (aligned)
                                inout("$4") dst => _,
                                inout("$5") old => _,
                                inout("$6") new => _,
                                in("$7") out,
                                out("$8") _,
                                out("$9") _,
                                out("$10") _,
                                out("$11") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("", ""),
                        Ordering::Acquire => atomic_cmpxchg!("sync", ""),
                        Ordering::Release => atomic_cmpxchg!("", "sync"),
                        // AcqRel and SeqCst compare_exchange are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_cmpxchg!("sync", "sync"),
                        _ => unreachable_unchecked!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic16 {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix, $asm_u_suffix);
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

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // Implement sub-word atomic operations using word-sized LL/SC loop.
                                // Based on assemblies generated by rustc/LLVM.
                                // Refs:
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/test/CodeGen/Mips/atomic.ll
                                ".set noat",
                                // create aligned address and masks
                                // https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                concat!(daddiu!(), " $2, $zero, -4"),
                                "andi $3, $4, 3",
                                "lhu {tmp}, 0($5)",
                                $release,
                                if_be!("xori $3, $3, 2"),
                                "and $2, $4, $2",
                                "sll $3, $3, 3",
                                "ori $4, $zero, 65535",
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
                                    "seh {tmp}, {tmp}",
                                $acquire,
                                "sh {tmp}, 0($6)",
                                ".set at",
                                tmp = out(reg) _,
                                out("$2") _, // dst ptr (aligned)
                                out("$3") _,
                                inout("$4") dst => _,
                                inout("$5") val => _,
                                in("$6") out,
                                out("$7") _,
                                out("$8") _,
                                out("$9") _,
                                out("$10") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("sync", ""),
                        Ordering::Release => atomic_swap!("", "sync"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!("sync", "sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
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

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                unsafe {
                    let mut r: usize;
                    macro_rules! atomic_cmpxchg {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // Implement sub-word atomic operations using word-sized LL/SC loop.
                                // Based on assemblies generated by rustc/LLVM.
                                // Refs:
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/test/CodeGen/Mips/atomic.ll
                                ".set noat",
                                concat!(daddiu!(), " $3, $zero, -4"),
                                "lhu $2, 0($6)", // new
                                "lh {tmp}, 0($5)", // old
                                "ori $5, $zero, 65535",
                                $release,
                                "and $3, $4, $3",
                                "andi $4, $4, 3",
                                if_be!("xori $4, $4, 2"),
                                "sll $4, $4, 3",
                                "andi $8, {tmp}, 65535",
                                "andi $2, $2, 65535",
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
                                "seh $2, $2",
                                $acquire,
                                "xor {tmp}, $2, {tmp}",
                                "sh $2, 0($7)",
                                "sltiu $2, {tmp}, 1",
                                ".set at",
                                tmp = out(reg) _,
                                out("$2") r,
                                out("$3") _, // dst (aligned)
                                inout("$4") dst => _,
                                inout("$5") old => _,
                                inout("$6") new => _,
                                in("$7") out,
                                out("$8") _,
                                out("$9") _,
                                out("$10") _,
                                out("$11") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("", ""),
                        Ordering::Acquire => atomic_cmpxchg!("sync", ""),
                        Ordering::Release => atomic_cmpxchg!("", "sync"),
                        // AcqRel and SeqCst compare_exchange are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_cmpxchg!("sync", "sync"),
                        _ => unreachable_unchecked!("{:?}, {:?}", success, failure),
                    }
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

atomic8!(i8, "b", "u");
atomic8!(u8, "b", "u");
atomic16!(i16, "h", "u");
atomic16!(u16, "h", "u");
atomic!(i32, "w", "", "");
atomic!(u32, "w", "", "");
#[cfg(target_arch = "mips64")]
atomic!(i64, "d", "", "d");
#[cfg(target_arch = "mips64")]
atomic!(u64, "d", "", "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "w", "", "");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "w", "", "");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d", "", "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d", "", "d");

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
    #[cfg(target_arch = "mips64")]
    test_atomic!(i64);
    #[cfg(target_arch = "mips64")]
    test_atomic!(u64);

    stress_test_load_store!();
    stress_test_load_swap!();
}
