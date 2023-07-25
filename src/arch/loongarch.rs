// LoongArch
//
// Generated asm:
// - loongarch64 https://godbolt.org/z/c9n6fhxTa

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

#[cfg(target_arch = "loongarch64")]
type XSize = u64;

#[rustfmt::skip]
macro_rules! atomic_load {
    ($int_type:ident, $asm_suffix:tt) => {
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
                                // (atomic) load from src to tmp
                                concat!("ld.", $asm_suffix, " {tmp}, {src}, 0"),
                                $acquire,
                                // store tmp to out
                                concat!("st.", $asm_suffix, " {tmp}, {out}, 0"),
                                src = in(reg) ptr_reg!(src),
                                out = inout(reg) ptr_reg!(out) => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!(""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("dbar 0"),
                        _ => unreachable!("{:?}", order),
                    }
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load!($int_type, $asm_suffix);
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
                        Ordering::Relaxed => {
                            asm!(
                                // load from val to tmp
                                concat!("ld.", $asm_suffix, " {tmp}, {val}, 0"),
                                // (atomic) store tmp to dst
                                concat!("st.", $asm_suffix, " {tmp}, {dst}, 0"),
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::Release | Ordering::SeqCst => {
                            asm!(
                                // load from val to tmp
                                concat!("ld.", $asm_suffix, " {tmp}, {val}, 0"),
                                // (atomic) store tmp to dst
                                concat!("amswap_db.", $asm_suffix, " $zero, {tmp}, {dst}"),
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        }
                        _ => unreachable!("{:?}", order),
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
                    asm!(
                        // load from val (ptr) to val (val)
                        concat!("ld.", $asm_suffix, " {val}, {val}, 0"),
                        // (atomic) swap (AMO)
                        // - load value from dst and store it to tmp
                        // - store value of val to dst
                        concat!("amswap_db.", $asm_suffix, " {tmp}, {val}, {dst}"),
                        // store tmp to out
                        concat!("st.", $asm_suffix, " {tmp}, {out}, 0"),
                        dst = in(reg) ptr_reg!(dst),
                        val = inout(reg) ptr_reg!(val) => _,
                        out = inout(reg) ptr_reg!(out) => _,
                        tmp = out(reg) _,
                        options(nostack, preserves_flags),
                    )
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
                    let mut r: XSize;
                    asm!(
                        // load from old/new (ptr) to old/new (val)
                        concat!("ld.", $asm_suffix, " {old}, {old}, 0"),
                        concat!("ld.", $asm_suffix, " {new}, {new}, 0"),
                        // (atomic) compare and exchange
                        "2:",
                            concat!("ll.", $asm_suffix, " {tmp}, {dst}, 0"),
                            "bne {tmp}, {old}, 3f", // compare and jump if compare failed
                            "dbar 0",
                            "move {r}, {new}",
                            concat!("sc.", $asm_suffix, " {r}, {dst}, 0"),
                            "beqz {r}, 2b", // continue loop if store failed
                            "b 4f",
                        "3:",
                            "dbar 1792",
                        "4:",
                        // store tmp to out
                        concat!("st.", $asm_suffix, " {tmp}, {out}, 0"),
                        "xor {r}, {tmp}, {old}",
                        "sltui {r}, {r}, 1",
                        dst = in(reg) ptr_reg!(dst),
                        old = inout(reg) ptr_reg!(old) => _,
                        new = inout(reg) ptr_reg!(new) => _,
                        out = in(reg) ptr_reg!(out),
                        tmp = out(reg) _,
                        r = out(reg) r,
                        options(nostack, preserves_flags),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic8 {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load!($int_type, $asm_suffix);
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
                    macro_rules! atomic_store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("ld.", $asm_suffix, " {tmp}, {val}, 0"),
                                // (atomic) store tmp to dst
                                $release,
                                concat!("st.", $asm_suffix, " {tmp}, {dst}, 0"),
                                $acquire,
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "dbar 0"),
                        Ordering::SeqCst => atomic_store!("dbar 0", "dbar 0"),
                        _ => unreachable!("{:?}", order),
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
                    asm!(
                        // Implement sub-word atomic operations using word-sized LL/SC loop.
                        // Based on assemblies generated by rustc/LLVM.
                        // Refs:
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                        "addi.w $a3, $zero, -4",
                        "and $a3, $a0, $a3",
                        "slli.d $a0, $a0, 3",
                        "ori $a4, $zero, 255",
                        "sll.w $a4, $a4, $a0",
                        "addi.w $a4, $a4, 0",
                        "ld.bu $a1, $a1, 0",
                        "sll.w $a1, $a1, $a0",
                        "addi.w $a1, $a1, 0",
                        "2:",
                            "dbar 0",
                            "ll.w $a5, $a3, 0",
                            "addi.w $a6, $a1, 0",
                            "xor $a6, $a5, $a6",
                            "and $a6, $a6, $a4",
                            "xor $a6, $a5, $a6",
                            "sc.w $a6, $a3, 0",
                            "beqz $a6, 2b",
                        "srl.w $a0, $a5, $a0",
                        "st.b $a0, {out}, 0",
                        out = in(reg) ptr_reg!(out),
                        inout("$a0") ptr_reg!(dst) => _,
                        inout("$a1") ptr_reg!(val) => _,
                        out("$a3") _, // dst ptr (aligned)
                        out("$a4") _,
                        out("$a5") _,
                        out("$a6") _,
                        options(nostack, preserves_flags),
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
                    let mut r: XSize;
                    asm!(
                        // Implement sub-word atomic operations using word-sized LL/SC loop.
                        // Based on assemblies generated by rustc/LLVM.
                        // Refs:
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                        "addi.w $a4, $zero, -4",
                        "and $a4, $a0, $a4",
                        "slli.d $a0, $a0, 3",
                        "ld.bu $a2, $a2, 0",
                        "sll.w $a2, $a2, $a0",
                        "addi.w $a2, $a2, 0",
                        "ld.bu $a1, $a1, 0",
                        "sll.w $a1, $a1, $a0",
                        "ori $a5, $zero, 255",
                        "sll.w $a5, $a5, $a0",
                        "addi.w $a6, $a5, 0",
                        "addi.w $a7, $a1, 0",
                        "2:",
                            "ll.w $t0, $a4, 0",
                            "and $t1, $t0, $a6",
                            "bne $t1, $a7, 3f",
                            "dbar 0",
                            "andn $t1, $t0, $a6",
                            "or $t1, $t1, $a2",
                            "sc.w $t1, $a4, 0",
                            "beqz $t1, 2b",
                            "b 4f",
                        "3:",
                            "dbar 1792",
                        "4:",
                        "srl.w $a0, $t0, $a0",
                        "st.b $a0, {out}, 0",
                        "and $a0, $t0, $a5",
                        "bstrpick.d $a0, $a0, 31, 0",
                        "bstrpick.d $a1, $a1, 31, 0",
                        "xor $a0, $a1, $a0",
                        "sltui $a0, $a0, 1",
                        out = in(reg) ptr_reg!(out),
                        inout("$a0") ptr_reg!(dst) => r,
                        inout("$a1") ptr_reg!(old) => _,
                        inout("$a2") ptr_reg!(new) => _,
                        out("$a4") _, // dst ptr (aligned)
                        out("$a5") _,
                        out("$a6") _,
                        out("$a7") _,
                        out("$t0") _,
                        out("$t1") _,
                        options(nostack, preserves_flags),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic16 {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load!($int_type, $asm_suffix);
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
                    macro_rules! atomic_store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("ld.", $asm_suffix, " {tmp}, {val}, 0"),
                                // (atomic) store tmp to dst
                                $release,
                                concat!("st.", $asm_suffix, " {tmp}, {dst}, 0"),
                                $acquire,
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "dbar 0"),
                        Ordering::SeqCst => atomic_store!("dbar 0", "dbar 0"),
                        _ => unreachable!("{:?}", order),
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
                    asm!(
                        // Implement sub-word atomic operations using word-sized LL/SC loop.
                        // Based on assemblies generated by rustc/LLVM.
                        // Refs:
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                        "addi.w $a3, $zero, -4",
                        "and $a3, $a0, $a3",
                        "slli.d $a0, $a0, 3",
                        "lu12i.w $a4, 15",
                        "ori $a4, $a4, 4095",
                        "sll.w $a4, $a4, $a0",
                        "addi.w $a4, $a4, 0",
                        "ld.hu $a1, $a1, 0",
                        "sll.w $a1, $a1, $a0",
                        "addi.w $a1, $a1, 0",
                        "2:",
                            "dbar 0",
                            "ll.w $a5, $a3, 0",
                            "addi.w $a6, $a1, 0",
                            "xor $a6, $a5, $a6",
                            "and $a6, $a6, $a4",
                            "xor $a6, $a5, $a6",
                            "sc.w $a6, $a3, 0",
                            "beqz $a6, 2b",
                        "srl.w $a0, $a5, $a0",
                        "st.h $a0, {out}, 0",
                        out = in(reg) ptr_reg!(out),
                        inout("$a0") ptr_reg!(dst) => _,
                        inout("$a1") ptr_reg!(val) => _,
                        out("$a3") _, // dst ptr (aligned)
                        out("$a4") _,
                        out("$a5") _,
                        out("$a6") _,
                        options(nostack, preserves_flags),
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
                    let mut r: XSize;
                    asm!(
                        // Implement sub-word atomic operations using word-sized LL/SC loop.
                        // Based on assemblies generated by rustc/LLVM.
                        // Refs:
                        // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                        "addi.w $a4, $zero, -4",
                        "and $a4, $a0, $a4",
                        "slli.d $a0, $a0, 3",
                        "ld.hu $a2, $a2, 0",
                        "sll.w $a2, $a2, $a0",
                        "ld.hu $a1, $a1, 0",
                        "addi.w $a2, $a2, 0",
                        "sll.w $a1, $a1, $a0",
                        "lu12i.w $a5, 15",
                        "ori $a5, $a5, 4095",
                        "sll.w $a5, $a5, $a0",
                        "addi.w $a6, $a5, 0",
                        "addi.w $a7, $a1, 0",
                        "2:",
                            "ll.w $t0, $a4, 0",
                            "and $t1, $t0, $a6",
                            "bne $t1, $a7, 3f",
                            "dbar 0",
                            "andn $t1, $t0, $a6",
                            "or $t1, $t1, $a2",
                            "sc.w $t1, $a4, 0",
                            "beqz $t1, 2b",
                            "b 4f",
                        "3:",
                            "dbar 1792",
                        "4:",
                        "srl.w $a0, $t0, $a0",
                        "st.h $a0, {out}, 0",
                        "and $a0, $t0, $a5",
                        "bstrpick.d $a0, $a0, 31, 0",
                        "bstrpick.d $a1, $a1, 31, 0",
                        "xor $a0, $a1, $a0",
                        "sltui $a0, $a0, 1",
                        out = in(reg) ptr_reg!(out),
                        inout("$a0") ptr_reg!(dst) => r,
                        inout("$a1") ptr_reg!(old) => _,
                        inout("$a2") ptr_reg!(new) => _,
                        out("$a4") _, // dst ptr (aligned)
                        out("$a5") _,
                        out("$a6") _,
                        out("$a7") _,
                        out("$t0") _,
                        out("$t1") _,
                        options(nostack, preserves_flags),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

atomic8!(i8, "b");
atomic8!(u8, "b");
atomic16!(i16, "h");
atomic16!(u16, "h");
atomic!(i32, "w");
atomic!(u32, "w");
#[cfg(target_arch = "loongarch64")]
atomic!(i64, "d");
#[cfg(target_arch = "loongarch64")]
atomic!(u64, "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "w");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "w");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d");

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
    #[cfg(target_arch = "loongarch64")]
    test_atomic!(i64);
    #[cfg(target_arch = "loongarch64")]
    test_atomic!(u64);

    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
    stress_test!(u16);
    stress_test!(u32);
    #[cfg(target_arch = "loongarch64")]
    stress_test!(u64);
}
