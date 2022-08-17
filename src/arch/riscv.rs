// Refs:
// - "Mappings from C/C++ primitives to RISC-V primitives." table in RISC-V Instruction Set Manual:
//   https://five-embeddev.com/riscv-isa-manual/latest/memory.html#sec:memory:porting
// - RISC-V Instruction Set Specifications https://msyksphinz-self.github.io/riscv-isadoc/html/index.html
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - riscv64gc https://godbolt.org/z/P35T9Thsq
// - riscv32imac https://godbolt.org/z/ofaPr8Gbc

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
macro_rules! if_64 {
    ($($tt:tt)*) => {
        ""
    };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv64")]
macro_rules! if_64 {
    ($($tt:tt)*) => {
        $($tt)*
    };
}

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv32")]
macro_rules! addiw {
    () => {
        "addi"
    };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv64")]
macro_rules! addiw {
    () => {
        "addiw"
    };
}

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv32")]
macro_rules! slliw {
    () => {
        "slli"
    };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv64")]
macro_rules! slliw {
    () => {
        "slliw"
    };
}

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv32")]
macro_rules! sllw {
    () => {
        "sll"
    };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv64")]
macro_rules! sllw {
    () => {
        "sllw"
    };
}

#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv32")]
macro_rules! srlw {
    () => {
        "srl"
    };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[cfg(target_arch = "riscv64")]
macro_rules! srlw {
    () => {
        "srlw"
    };
}

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

                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // (atomic) load from src to tmp
                                $release,
                                concat!("l", $asm_suffix, " {tmp}, 0({src})"),
                                $acquire,
                                // store tmp to out
                                concat!("s", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("fence r, rw", ""),
                        Ordering::SeqCst => atomic_load!("fence r, rw", "fence rw, rw"),
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
                    macro_rules! atomic_store {
                        ($release:expr) => {
                            asm!(
                                // load from val to tmp
                                concat!("l", $asm_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                $release,
                                concat!("s", $asm_suffix, " {tmp}, 0({dst})"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        // Release and SeqCst stores are equivalent.
                        Ordering::Release | Ordering::SeqCst => atomic_store!("fence rw, w"),
                        _ => unreachable_unchecked!("{:?}", order),
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

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($order:tt) => {
                            asm!(
                                // load val to val_tmp
                                concat!("l", $asm_suffix, " {val_tmp}, 0({val})"),
                                // (atomic) swap (AMO)
                                // - load value from dst and store it to out_tmp
                                // - store value of val_tmp to dst
                                concat!("amoswap.", $asm_suffix, $order, " {out_tmp}, {val_tmp}, 0({dst})"),
                                // store out_tmp to out
                                concat!("s", $asm_suffix, " {out_tmp}, 0({out})"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                val_tmp = lateout(reg) _,
                                out = inout(reg) out => _,
                                out_tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!(""),
                        Ordering::Acquire => atomic_swap!(".aq"),
                        Ordering::Release => atomic_swap!(".rl"),
                        // AcqRel and SeqCst swaps are equivalent.
                        Ordering::AcqRel | Ordering::SeqCst => atomic_swap!(".aqrl"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
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

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                unsafe {
                    let mut r: usize;
                    macro_rules! atomic_cmpxchg {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // load old/new to old_tmp/new_tmp
                                concat!("l", $asm_suffix, " {old_tmp}, 0({old})"),
                                concat!("l", $asm_suffix, " {new_tmp}, 0({new})"),
                                // (atomic) compare and exchange
                                "2:",
                                    concat!("lr.", $asm_suffix, $acquire, " {out_tmp}, 0({dst})"),
                                    "bne {out_tmp}, {old_tmp}, 3f", // compare and jump if compare failed
                                    concat!("sc.", $asm_suffix, $release, " {r}, {new_tmp}, 0({dst})"),
                                    "bnez {r}, 2b", // continue loop if store failed
                                "3:",
                                "xor {r}, {out_tmp}, {old_tmp}",
                                "seqz {r}, {r}",
                                // store out_tmp to out
                                concat!("s", $asm_suffix, " {out_tmp}, 0({out})"),
                                dst = inout(reg) dst => _,
                                old = in(reg) old,
                                old_tmp = lateout(reg) _,
                                new = inout(reg) new => _,
                                new_tmp = lateout(reg) _,
                                out = inout(reg) out => _,
                                out_tmp = lateout(reg) _,
                                r = out(reg) r,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("", ""),
                        Ordering::Acquire => atomic_cmpxchg!(".aq", ""),
                        Ordering::Release => atomic_cmpxchg!("", ".rl"),
                        Ordering::AcqRel => atomic_cmpxchg!(".aq", ".rl"),
                        Ordering::SeqCst => atomic_cmpxchg!(".aqrl", ".aqrl"),
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

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // Implement sub-word atomic operations using word-sized LL/SC loop.
                                // Based on assemblies generated by rustc/LLVM.
                                // Refs:
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/test/CodeGen/RISCV/atomic-rmw.ll
                                "lbu a1, 0({val})",
                                // create aligned address and masks
                                // https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                "andi a6, a0, -4",
                                concat!(slliw!(), " a0, a0, 3"),
                                "li a4, 255",
                                concat!(sllw!(), " a4, a4, a0"),
                                concat!(sllw!(), " a1, a1, a0"),
                                // (atomic) swap (LR/SC)
                                "2:",
                                    concat!("lr.w", $acquire, " a5, 0(a6)"),
                                    "mv a3, a1",
                                    "xor a3, a3, a5",
                                    "and a3, a3, a4",
                                    "xor a3, a3, a5",
                                    concat!("sc.w", $release, " a3, a3, 0(a6)"),
                                    "bnez a3, 2b",
                                concat!(srlw!(), " a0, a5, a0"),
                                "sb a0, 0({out})",
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                inout("a0") dst => _,
                                lateout("a1") _,
                                out("a3") _,
                                out("a4") _,
                                out("a5") _,
                                out("a6") _, // dst ptr (aligned)
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!(".aq", ""),
                        Ordering::Release => atomic_swap!("", ".rl"),
                        Ordering::AcqRel => atomic_swap!(".aq", ".rl"),
                        Ordering::SeqCst => atomic_swap!(".aqrl", ".aqrl"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
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
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/test/CodeGen/RISCV/atomic-rmw.ll
                                "lbu a1, 0(a1)",
                                "lbu a2, 0(a2)",
                                // create aligned address and masks
                                // https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                "andi a6, a0, -4",
                                concat!(slliw!(), " a0, a0, 3"),
                                "li a5, 255",
                                concat!(sllw!(), " a5, a5, a0"),
                                concat!(sllw!(), " a7, a1, a0"),
                                concat!(sllw!(), " a2, a2, a0"),
                                // (atomic) compare and exchange (LR/SC loop)
                                "2:",
                                    concat!("lr.w", $acquire, " a4, 0(a6)"),
                                    "and a1, a4, a5",
                                    "bne a1, a7, 3f",
                                    "xor a1, a4, a2",
                                    "and a1, a1, a5",
                                    "xor a1, a1, a4",
                                    concat!("sc.w", $release, " a1, a1, 0(a6)"),
                                    "bnez a1, 2b",
                                "3:",
                                concat!(srlw!(), " a1, a4, a0"),
                                "and a0, a4, a5",
                                if_64!("sext.w a0, a0"),
                                "xor a0, a7, a0",
                                "seqz a0, a0",
                                "sb a1, 0({out})",
                                out = inout(reg) out => _,
                                inout("a0") dst => r,
                                inout("a1") old => _,
                                inout("a2") new => _,
                                out("a4") _,
                                out("a5") _,
                                out("a6") _,
                                out("a7") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("", ""),
                        Ordering::Acquire => atomic_cmpxchg!(".aq", ""),
                        Ordering::Release => atomic_cmpxchg!("", ".rl"),
                        Ordering::AcqRel => atomic_cmpxchg!(".aq", ".rl"),
                        Ordering::SeqCst => atomic_cmpxchg!(".aqrl", ".aqrl"),
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

                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                // Implement sub-word atomic operations using word-sized LL/SC loop.
                                // Based on assemblies generated by rustc/LLVM.
                                // Refs:
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/test/CodeGen/RISCV/atomic-rmw.ll
                                "lhu a1, 0({val})",
                                // create aligned address and masks
                                // https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                "andi a6, a0, -4",
                                concat!(slliw!(), " a0, a0, 3"),
                                "lui a4, 16",
                                concat!(addiw!(), " a4, a4, -1"),
                                concat!(sllw!(), " a4, a4, a0"),
                                concat!(sllw!(), " a1, a1, a0"),
                                // (atomic) swap (LR/SC)
                                "2:",
                                    concat!("lr.w", $acquire, " a5, 0(a6)"),
                                    "mv a3, a1",
                                    "xor a3, a3, a5",
                                    "and a3, a3, a4",
                                    "xor a3, a3, a5",
                                    concat!("sc.w", $release, " a3, a3, 0(a6)"),
                                    "bnez a3, 2b",
                                concat!(srlw!(), " a0, a5, a0"),
                                "sh a0, 0({out})",
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                inout("a0") dst => _,
                                lateout("a1") _,
                                out("a3") _,
                                out("a4") _,
                                out("a5") _,
                                out("a6") _, // dst ptr (aligned)
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!(".aq", ""),
                        Ordering::Release => atomic_swap!("", ".rl"),
                        Ordering::AcqRel => atomic_swap!(".aq", ".rl"),
                        Ordering::SeqCst => atomic_swap!(".aqrl", ".aqrl"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
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
                                // - https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/test/CodeGen/RISCV/atomic-rmw.ll
                                "lhu a1, 0(a1)",
                                "lhu a2, 0(a2)",
                                // create aligned address and masks
                                // https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0-rc1/llvm/lib/CodeGen/AtomicExpandPass.cpp#L682
                                "andi a6, a0, -4",
                                concat!(slliw!(), " a0, a0, 3"),
                                "lui a5, 16",
                                concat!(addiw!(), " a5, a5, -1"),
                                concat!(sllw!(), " a5, a5, a0"),
                                concat!(sllw!(), " a7, a1, a0"),
                                concat!(sllw!(), " a2, a2, a0"),
                                // (atomic) compare and exchange (LR/SC loop)
                                "2:",
                                    concat!("lr.w", $acquire, " a4, 0(a6)"),
                                    "and a1, a4, a5",
                                    "bne a1, a7, 3f",
                                    "xor a1, a4, a2",
                                    "and a1, a1, a5",
                                    "xor a1, a1, a4",
                                    concat!("sc.w", $release, " a1, a1, 0(a6)"),
                                    "bnez a1, 2b",
                                "3:",
                                concat!(srlw!(), " a1, a4, a0"),
                                "and a0, a4, a5",
                                if_64!("sext.w a0, a0"),
                                "xor a0, a7, a0",
                                "seqz a0, a0",
                                "sh a1, 0({out})",
                                out = inout(reg) out => _,
                                inout("a0") dst => r,
                                inout("a1") old => _,
                                inout("a2") new => _,
                                out("a4") _,
                                out("a5") _,
                                out("a6") _,
                                out("a7") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_cmpxchg!("", ""),
                        Ordering::Acquire => atomic_cmpxchg!(".aq", ""),
                        Ordering::Release => atomic_cmpxchg!("", ".rl"),
                        Ordering::AcqRel => atomic_cmpxchg!(".aq", ".rl"),
                        Ordering::SeqCst => atomic_cmpxchg!(".aqrl", ".aqrl"),
                        _ => unreachable_unchecked!("{:?}, {:?}", success, failure),
                    }
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

    stress_test_load_store!();
    stress_test_load_swap!();
}
