// RISC-V
//
// Refs:
// - "Mappings from C/C++ primitives to RISC-V primitives." table in RISC-V Instruction Set Manual:
//   https://five-embeddev.com/riscv-isa-manual/latest/memory.html#sec:memory:porting
// - RISC-V Instruction Set Specifications https://msyksphinz-self.github.io/riscv-isadoc/html/index.html
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - riscv64gc https://godbolt.org/z/nW3Po8n4K
// - riscv32imac https://godbolt.org/z/51nPPMYze

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[path = "partword.rs"]
mod partword;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
use crate::raw::{AtomicCompareExchange, AtomicSwap};
use crate::raw::{AtomicLoad, AtomicStore};

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv32")]
macro_rules! w {
    () => {
        ""
    };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv64")]
macro_rules! w {
    () => {
        "w"
    };
}

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
macro_rules! atomic_rmw_amo {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!(""),
            Ordering::Acquire => $op!(".aq"),
            Ordering::Release => $op!(".rl"),
            // AcqRel and SeqCst RMWs are equivalent.
            Ordering::AcqRel | Ordering::SeqCst => $op!(".aqrl"),
            _ => unreachable!("{:?}", $order),
        }
    };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
macro_rules! atomic_rmw_lr_sc {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!(".aq", ""),
            Ordering::Release => $op!("", ".rl"),
            Ordering::AcqRel => $op!(".aq", ".rl"),
            Ordering::SeqCst => $op!(".aqrl", ".rl"),
            _ => unreachable!("{:?}", $order),
        }
    };
}

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv32")]
type XSize = u32;
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv64")]
type XSize = u64;

#[rustfmt::skip]
macro_rules! atomic_load_store {
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
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) load from src to tmp
                                $release,
                                concat!("l", $asm_suffix, " {tmp}, 0({src})"),
                                $acquire,
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg) ptr_reg!(src),
                                out = inout(reg) ptr_reg!(out) => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("fence r, rw", ""),
                        Ordering::SeqCst => atomic_load!("fence r, rw", "fence rw, rw"),
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
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("l", $asm_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                $release,
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                dst = inout(reg) ptr_reg!(dst) => _,
                                val = in(reg) ptr_reg!(val),
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        // Release and SeqCst stores are equivalent.
                        Ordering::Release | Ordering::SeqCst => atomic_store!("fence rw, w"),
                        _ => unreachable!("{:?}", order),
                    }
                }
            }
        }
    };
}

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix);
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
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
                        ($order:tt) => {
                            asm!(
                                // load from val (ptr) to val (val)
                                concat!("l", $asm_suffix, " {val}, 0({val})"),
                                // (atomic) swap (AMO)
                                // - load value from dst and store it to tmp
                                // - store value of val to dst
                                concat!("amoswap.", $asm_suffix, $order, " {tmp}, {val}, 0({dst})"),
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                dst = in(reg) ptr_reg!(dst),
                                val = inout(reg) ptr_reg!(val) => _,
                                out = inout(reg) ptr_reg!(out) => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_amo!(swap, order);
                }
            }
        }
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
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
                                // load from old/new (ptr) to old/new (val)
                                concat!("l", $asm_suffix, " {old}, 0({old})"),
                                concat!("l", $asm_suffix, " {new}, 0({new})"),
                                // (atomic) CAS (LR/SC loop)
                                "2:",
                                    concat!("lr.", $asm_suffix, $acquire, " {tmp}, 0({dst})"),
                                    "bne {tmp}, {old}, 3f", // compare and jump if compare failed
                                    concat!("sc.", $asm_suffix, $release, " {r}, {new}, 0({dst})"),
                                    "bnez {r}, 2b", // continue loop if store failed
                                "3:",
                                "xor {r}, {tmp}, {old}",
                                "seqz {r}, {r}",
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                dst = in(reg) ptr_reg!(dst),
                                old = inout(reg) ptr_reg!(old) => _,
                                new = inout(reg) ptr_reg!(new) => _,
                                out = in(reg) ptr_reg!(out),
                                tmp = out(reg) _,
                                r = out(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_lr_sc!(cmpxchg, order);
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($int_type:ident, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $asm_suffix);
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
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
                let (aligned_ptr, shift, mask) = partword::create_mask_values(dst);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also partword.rs.
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("l", $asm_suffix, "u {val}, 0({val})"),
                                concat!("sll", w!(), " {mask}, {mask}, {shift}"),
                                concat!("sll", w!(), " {val}, {val}, {shift}"),
                                // (atomic) swap (LR/SC loop)
                                "2:",
                                    concat!("lr.w", $acquire, " {tmp1}, 0({dst})"),
                                    "mv {tmp2}, {val}",
                                    "xor {tmp2}, {tmp2}, {tmp1}",
                                    "and {tmp2}, {tmp2}, {mask}",
                                    "xor {tmp2}, {tmp2}, {tmp1}",
                                    concat!("sc.w", $release, " {tmp2}, {tmp2}, 0({dst})"),
                                    "bnez {tmp2}, 2b",
                                concat!("srl", w!(), " {tmp1}, {tmp1}, {shift}"),
                                concat!("s", $asm_suffix, " {tmp1}, 0({out})"),
                                dst = in(reg) ptr_reg!(aligned_ptr),
                                val = inout(reg) ptr_reg!(val) => _,
                                out = in(reg) ptr_reg!(out),
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                tmp1 = out(reg) _,
                                tmp2 = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_lr_sc!(swap, order);
                }
            }
        }
        #[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
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
                let (aligned_ptr, shift, mask) = partword::create_mask_values(dst);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: XSize;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also partword.rs.
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                concat!("l", $asm_suffix, "u {old}, 0({old})"),
                                concat!("l", $asm_suffix, "u {new}, 0({new})"),
                                concat!("sll", w!(), " {mask}, {mask}, {shift}"),
                                concat!("sll", w!(), " {old}, {old}, {shift}"),
                                concat!("sll", w!(), " {new}, {new}, {shift}"),
                                // (atomic) CAS (LR/SC loop)
                                "2:",
                                    concat!("lr.w", $acquire, " {tmp1}, 0({dst})"),
                                    "and {tmp2}, {tmp1}, {mask}",
                                    "bne {tmp2}, {old}, 3f",
                                    "xor {tmp2}, {tmp1}, {new}",
                                    "and {tmp2}, {tmp2}, {mask}",
                                    "xor {tmp2}, {tmp2}, {tmp1}",
                                    concat!("sc.w", $release, " {tmp2}, {tmp2}, 0({dst})"),
                                    "bnez {tmp2}, 2b",
                                "3:",
                                concat!("srl", w!(), " {tmp2}, {tmp1}, {shift}"),
                                "and {tmp1}, {tmp1}, {mask}",
                                "xor {r}, {old}, {tmp1}",
                                "seqz {r}, {r}",
                                concat!("s", $asm_suffix, " {tmp2}, 0({out})"),
                                dst = in(reg) ptr_reg!(aligned_ptr),
                                old = inout(reg) ptr_reg!(old) => _,
                                new = inout(reg) ptr_reg!(new) => _,
                                out = inout(reg) ptr_reg!(out) => _,
                                shift = in(reg) shift,
                                mask = inout(reg) mask => _,
                                r = lateout(reg) r,
                                tmp1 = out(reg) _,
                                tmp2 = out(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_lr_sc!(cmpxchg, order);
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

atomic_sub_word!(i8, "b");
atomic_sub_word!(u8, "b");
atomic_sub_word!(i16, "h");
atomic_sub_word!(u16, "h");
atomic!(i32, "w");
atomic!(u32, "w");
#[cfg(target_arch = "riscv64")]
atomic!(i64, "d");
#[cfg(target_arch = "riscv64")]
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
    #[cfg(target_arch = "riscv64")]
    test_atomic!(i64);
    #[cfg(target_arch = "riscv64")]
    test_atomic!(u64);

    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
    stress_test!(u16);
    stress_test!(u32);
    #[cfg(target_arch = "riscv64")]
    stress_test!(u64);
}
