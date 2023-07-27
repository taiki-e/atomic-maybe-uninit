// PowerPC and PowerPC64
//
// Refs:
// - Power ISA https://openpowerfoundation.org/specifications/isa
// - AIX Assembler language reference https://www.ibm.com/docs/en/aix/7.3?topic=aix-assembler-language-reference
// - http://www.rdrop.com/users/paulmck/scalability/paper/N2745r.2010.02.19a.html
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - powerpc https://godbolt.org/z/TYvn6sEq8
// - powerpc64 https://godbolt.org/z/v754dbW1T
// - powerpc64 (pwr8) https://godbolt.org/z/9EbnYG5vq
// - powerpc64le https://godbolt.org/z/MncqT45K4
// - powerpc64le (pwr7) https://godbolt.org/z/51jWrKh7e

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
#[cfg(target_endian = "big")]
macro_rules! p128h {
    () => {
        "0"
    };
}
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
#[cfg(target_endian = "big")]
macro_rules! p128l {
    () => {
        "8"
    };
}
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
#[cfg(target_endian = "little")]
macro_rules! p128h {
    () => {
        "8"
    };
}
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
#[cfg(target_endian = "little")]
macro_rules! p128l {
    () => {
        "0"
    };
}

#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
#[cfg(target_endian = "little")]
macro_rules! if_be {
    ($($tt:tt)*) => {
        ""
    };
}
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
#[cfg(target_endian = "big")]
macro_rules! if_be {
    ($($tt:tt)*) => {
        $($tt)*
    };
}

#[cfg(target_arch = "powerpc")]
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
macro_rules! select_32_or_64 {
    ($expr32:expr, $expr64:expr) => {
        $expr32
    };
}
#[cfg(target_arch = "powerpc64")]
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
macro_rules! select_32_or_64 {
    ($expr32:expr, $expr64:expr) => {
        $expr64
    };
}

macro_rules! atomic_rmw {
    ($op:ident, $order:ident) => {
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("lwsync", ""),
            Ordering::Release => $op!("", "lwsync"),
            Ordering::AcqRel => $op!("lwsync", "lwsync"),
            Ordering::SeqCst => $op!("lwsync", "sync"),
            _ => unreachable!("{:?}", $order),
        }
    };
}

#[cfg(target_arch = "powerpc")]
type Cr = u32;
#[cfg(target_arch = "powerpc64")]
type Cr = u64;
// Extracts and checks the EQ bit of cr0.
#[inline]
fn extract_cr0(r: Cr) -> bool {
    r & 0x20000000 != 0
}

macro_rules! atomic_load_store {
    ($int_type:ident, $ld_suffix:tt, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                #[cfg(target_arch = "powerpc64")]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load_acquire {
                        ($release:tt) => {
                            asm!(
                                $release,
                                // (atomic) load from src to tmp
                                concat!("l", $ld_suffix, " {tmp}, 0({src})"),
                                // Lightweight acquire sync
                                // Refs: https://github.com/boostorg/atomic/blob/boost-1.79.0/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp#L47-L62
                                "cmpd %cr7, {tmp}, {tmp}",
                                "bne- %cr7, 2f",
                                "2:",
                                "isync",
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp = lateout(reg_nonzero) _,
                                out("cr7") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("l", $ld_suffix, " {tmp}, 0({src})"),
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp = lateout(reg_nonzero) _,
                                options(nostack, preserves_flags),
                            )
                        }
                        Ordering::Acquire => atomic_load_acquire!(""),
                        Ordering::SeqCst =>  atomic_load_acquire!("sync"),
                        _ => unreachable!("{:?}", order),
                    }
                }
                #[cfg(target_arch = "powerpc")]
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // (atomic) load from src to tmp
                                $release,
                                concat!("l", $ld_suffix, " {tmp}, 0({src})"),
                                $acquire,
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp = lateout(reg_nonzero) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("lwsync", ""),
                        Ordering::SeqCst => atomic_load!("lwsync", "sync"),
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
                                concat!("l", $ld_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                $release,
                                concat!("st", $asm_suffix, " {tmp}, 0({dst})"),
                                dst = inout(reg_nonzero) ptr_reg!(dst) => _,
                                val = in(reg_nonzero) ptr_reg!(val),
                                tmp = lateout(reg_nonzero) _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        Ordering::Release => atomic_store!("lwsync"),
                        Ordering::SeqCst => atomic_store!("sync"),
                        _ => unreachable!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($int_type:ident, $ld_suffix:tt, $asm_suffix:tt, $cmp_suffix:tt) => {
        atomic_load_store!($int_type, $ld_suffix, $asm_suffix);
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
                                // load from val (ptr) to val (val)
                                concat!("l", $ld_suffix, " {val}, 0({val})"),
                                // (atomic) swap
                                $release,
                                "2:",
                                    // load from dst to tmp
                                    concat!("l", $asm_suffix, "arx {tmp}, 0, {dst}"),
                                    // try to store val to dst
                                    concat!("st", $asm_suffix, "cx. {val}, 0, {dst}"),
                                    "bne %cr0, 2b",
                                $acquire,
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                val = inout(reg_nonzero) ptr_reg!(val) => _,
                                out = in(reg_nonzero) ptr_reg!(out),
                                tmp = out(reg_nonzero) _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
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
                    let mut r: Cr;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from old/new (ptr) to old/new (val)
                                concat!("l", $ld_suffix, " {old}, 0({old})"),
                                concat!("l", $ld_suffix, " {new}, 0({new})"),
                                // (atomic) compare and exchange
                                $release,
                                "2:",
                                    concat!("l", $asm_suffix, "arx {tmp}, 0, {dst}"),
                                    concat!("cmp", $cmp_suffix, " {old}, {tmp}"),
                                    "bne %cr0, 3f", // jump if compare failed
                                    concat!("st", $asm_suffix, "cx. {new}, 0, {dst}"),
                                    "bne %cr0, 2b", // continue loop if store failed
                                "3:",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr {r}",
                                $acquire,
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                dst = in(reg_nonzero) ptr_reg!(dst),
                                old = inout(reg_nonzero) ptr_reg!(old) => _,
                                new = inout(reg_nonzero) ptr_reg!(new) => _,
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp = out(reg_nonzero) _,
                                r = lateout(reg_nonzero) r,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    extract_cr0(r)
                }
            }
        }
    };
}

#[cfg(not(all(
    target_arch = "powerpc64",
    any(target_feature = "partword-atomics", atomic_maybe_uninit_target_feature = "partword-atomics"),
)))]
#[rustfmt::skip]
macro_rules! atomic8 {
    ($int_type:ident, $ld_suffix:tt, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $ld_suffix, $asm_suffix);
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
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // Refs:
                    // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                    // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/PowerPC/atomics.ll
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "lbz %r7, 0(%r4)",
                                "li %r6, 255",
                                "rlwinm %r4, %r3, 3, 27, 28",
                                if_be!("xori %r4, %r4, 24"),
                                $release,
                                select_32_or_64!("rlwinm %r3, %r3, 0, 0, 29", "rldicr %r3, %r3, 0, 61"),
                                "slw %r6, %r6, %r4",
                                "slw %r7, %r7, %r4",
                                "and %r7, %r7, %r6",
                                // (atomic) swap
                                "2:",
                                    "lwarx %r8, 0, %r3",
                                    "andc %r9, %r8, %r6",
                                    "or %r9, %r7, %r9",
                                    "stwcx. %r9, 0, %r3",
                                    "bne %cr0, 2b",
                                "srw %r3, %r8, %r4",
                                "clrlwi %r3, %r3, 24",
                                $acquire,
                                "stb %r3, 0({out})",
                                out = in(reg_nonzero) ptr_reg!(out),
                                inout("r3") ptr_reg!(dst) => _,
                                inout("r4") ptr_reg!(val) => _,
                                out("r6") _,
                                out("r7") _,
                                out("r8") _,
                                out("r9") _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
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
                    let mut r: Cr;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // Refs:
                    // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                    // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/PowerPC/atomics.ll
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "lbz %r8, 0(%r5)",
                                "lbz %r4, 0(%r4)",
                                "li %r7, 255",
                                "rlwinm %r5, %r3, 3, 27, 28",
                                if_be!("xori %r5, %r5, 24"),
                                $release,
                                select_32_or_64!("rlwinm %r3, %r3, 0, 0, 29", "rldicr %r3, %r3, 0, 61"),
                                "slw %r7, %r7, %r5",
                                "slw %r8, %r8, %r5",
                                "slw %r9, %r4, %r5",
                                "and %r8, %r8, %r7",
                                "and %r10, %r9, %r7",
                                "2:",
                                    "lwarx %r11, 0, %r3",
                                    "and %r9, %r11, %r7",
                                    "cmpw %r9, %r10",
                                    "bne %cr0, 3f",
                                    "andc %r11, %r11, %r7",
                                    "or %r11, %r11, %r8",
                                    "stwcx. %r11, 0, %r3",
                                    "bne %cr0, 2b",
                                "3:",
                                "srw %r5, %r9, %r5",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr %r3",
                                $acquire,
                                "stb %r5, 0({out})",
                                out = in(reg_nonzero) ptr_reg!(out),
                                inout("r3") ptr_reg!(dst) => r,
                                inout("r4") ptr_reg!(old) => _,
                                inout("r5") ptr_reg!(new) => _,
                                out("r7") _,
                                out("r8") _,
                                out("r9") _,
                                out("r10") _,
                                out("r11") _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    extract_cr0(r)
                }
            }
        }
    };
}

#[cfg(not(all(
    target_arch = "powerpc64",
    any(target_feature = "partword-atomics", atomic_maybe_uninit_target_feature = "partword-atomics"),
)))]
#[rustfmt::skip]
macro_rules! atomic16 {
    ($int_type:ident, $ld_suffix:tt, $asm_suffix:tt) => {
        atomic_load_store!($int_type, $ld_suffix, $asm_suffix);
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
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // Refs:
                    // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                    // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/PowerPC/atomics.ll
                    macro_rules! swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "lhz %r7, 0(%r4)",
                                "li %r6, 0",
                                "rlwinm %r4, %r3, 3, 27, 27",
                                if_be!("xori %r4, %r4, 16"),
                                $release,
                                "ori %r6, %r6, 65535",
                                select_32_or_64!("rlwinm %r3, %r3, 0, 0, 29", "rldicr %r3, %r3, 0, 61"),
                                "slw %r6, %r6, %r4",
                                "slw %r7, %r7, %r4",
                                "and %r7, %r7, %r6",
                                // (atomic) swap
                                "2:",
                                    "lwarx %r8, 0, %r3",
                                    "andc %r9, %r8, %r6",
                                    "or %r9, %r7, %r9",
                                    "stwcx. %r9, 0, %r3",
                                    "bne %cr0, 2b",
                                "srw %r3, %r8, %r4",
                                "clrlwi %r3, %r3, 16",
                                $acquire,
                                "sth %r3, 0({out})",
                                out = in(reg_nonzero) ptr_reg!(out),
                                inout("r3") ptr_reg!(dst) => _,
                                inout("r4") ptr_reg!(val) => _,
                                out("r6") _,
                                out("r7") _,
                                out("r8") _,
                                out("r9") _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
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
                    let mut r: Cr;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // Refs:
                    // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
                    // - https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/PowerPC/atomics.ll
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "lhz %r8, 0(%r5)",
                                "lhz %r4, 0(%r4)",
                                "li %r7, 0",
                                "rlwinm %r5, %r3, 3, 27, 27",
                                if_be!("xori %r5, %r5, 16"),
                                $release,
                                "ori %r7, %r7, 65535",
                                select_32_or_64!("rlwinm %r3, %r3, 0, 0, 29", "rldicr %r3, %r3, 0, 61"),
                                "slw %r7, %r7, %r5",
                                "slw %r8, %r8, %r5",
                                "slw %r9, %r4, %r5",
                                "and %r8, %r8, %r7",
                                "and %r10, %r9, %r7",
                                "2:",
                                    "lwarx %r11, 0, %r3",
                                    "and %r9, %r11, %r7",
                                    "cmpw %r9, %r10",
                                    "bne %cr0, 3f",
                                    "andc %r11, %r11, %r7",
                                    "or %r11, %r11, %r8",
                                    "stwcx. %r11, 0, %r3",
                                    "bne %cr0, 2b",
                                "3:",
                                "srw %r5, %r9, %r5",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr %r3",
                                $acquire,
                                "sth %r5, 0({out})",
                                out = in(reg_nonzero) ptr_reg!(out),
                                inout("r3") ptr_reg!(dst) => r,
                                inout("r4") ptr_reg!(old) => _,
                                inout("r5") ptr_reg!(new) => _,
                                out("r7") _,
                                out("r8") _,
                                out("r9") _,
                                out("r10") _,
                                out("r11") _,
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    extract_cr0(r)
                }
            }
        }
    };
}

#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "partword-atomics",
    atomic_maybe_uninit_target_feature = "partword-atomics",
))]
atomic!(i8, "bz", "b", "w");
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "partword-atomics",
    atomic_maybe_uninit_target_feature = "partword-atomics",
))]
atomic!(u8, "bz", "b", "w");
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "partword-atomics",
    atomic_maybe_uninit_target_feature = "partword-atomics",
))]
atomic!(i16, "hz", "h", "w");
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "partword-atomics",
    atomic_maybe_uninit_target_feature = "partword-atomics",
))]
atomic!(u16, "hz", "h", "w");
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
atomic8!(i8, "bz", "b");
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
atomic8!(u8, "bz", "b");
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
atomic16!(i16, "hz", "h");
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "partword-atomics",
        atomic_maybe_uninit_target_feature = "partword-atomics",
    ),
)))]
atomic16!(u16, "hz", "h");
atomic!(i32, "wz", "w", "w");
atomic!(u32, "wz", "w", "w");
#[cfg(target_arch = "powerpc64")]
atomic!(i64, "d", "d", "d");
#[cfg(target_arch = "powerpc64")]
atomic!(u64, "d", "d", "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "wz", "w", "w");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "wz", "w", "w");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d", "d", "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d", "d", "d");

// https://github.com/llvm/llvm-project/commit/549e118e93c666914a1045fde38a2cac33e1e445
// https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/PowerPC/atomics-i128-ldst.ll
// https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/test/CodeGen/PowerPC/atomics-i128.ll
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
macro_rules! atomic128 {
    ($int_type:ident) => {
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
                    macro_rules! atomic_load_acquire {
                        ($release:tt) => {
                            asm!(
                                $release,
                                // (atomic) load from src to out pair
                                "lq %r4, 0({src})",
                                // Refs: https://github.com/boostorg/atomic/blob/boost-1.79.0/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp#L47-L62
                                "cmpd %cr7, %r4, %r4",
                                "bne- %cr7, 2f",
                                "2:",
                                "isync",
                                // store out pair to out
                                concat!("std %r4, ", p128h!(), "({out})"),
                                concat!("std %r5, ", p128l!(), "({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // out (hi)
                                out("r5") _, // out (lo)
                                out("cr7") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // (atomic) load from src to out pair
                                "lq %r4, 0({src})",
                                // store out pair to out
                                concat!("std %r4, ", p128h!(), "({out})"),
                                concat!("std %r5, ", p128l!(), "({out})"),
                                src = in(reg_nonzero) ptr_reg!(src),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // out (hi)
                                out("r5") _, // out (lo)
                                options(nostack, preserves_flags),
                            )
                        }
                        Ordering::Acquire => atomic_load_acquire!(""),
                        Ordering::SeqCst =>  atomic_load_acquire!("sync"),
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
                                // load from val to val pair
                                concat!("ld %r4, ", p128h!(), "({val})"),
                                concat!("ld %r5, ", p128l!(), "({val})"),
                                // (atomic) store val pair to dst
                                $release,
                                "stq %r4, 0({dst})",
                                dst = inout(reg_nonzero) ptr_reg!(dst) => _,
                                val = in(reg_nonzero) ptr_reg!(val),
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // val (hi)
                                lateout("r5") _, // val (lo)
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        Ordering::Release => atomic_store!("lwsync"),
                        Ordering::SeqCst => atomic_store!("sync"),
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
                                // load from val to val pair
                                concat!("ld %r4, ", p128h!(), "({val})"),
                                concat!("ld %r5, ", p128l!(), "({val})"),
                                // (atomic) swap
                                $release,
                                "2:",
                                    // load from dst to out pair
                                    "lqarx %r6, 0, {dst}",
                                    // try to store val pair to dst
                                    "stqcx. %r4, 0, {dst}",
                                    "bne %cr0, 2b",
                                $acquire,
                                // store out pair to out
                                concat!("std %r6, ", p128h!(), "({out})"),
                                concat!("std %r7, ", p128l!(), "({out})"),
                                dst = inout(reg_nonzero) ptr_reg!(dst) => _,
                                val = in(reg_nonzero) ptr_reg!(val),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // val (hi)
                                lateout("r5") _, // val (lo)
                                out("r6") _, // out (hi)
                                out("r7") _, // out (lo)
                                out("cr0") _,
                                options(nostack, preserves_flags),
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
                    let mut r: Cr;
                    macro_rules! cmpxchg {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from old/new to old/new pairs
                                concat!("ld %r4, ", p128h!(), "({old})"),
                                concat!("ld %r5, ", p128l!(), "({old})"),
                                concat!("ld %r6, ", p128h!(), "({new})"),
                                concat!("ld %r7, ", p128l!(), "({new})"),
                                // (atomic) compare and exchange
                                $release,
                                "2:",
                                    "lqarx %r8, 0, {dst}",
                                    "xor {tmp_lo}, %r9, %r5",
                                    "xor {tmp_hi}, %r8, %r4",
                                    "or. {tmp_lo}, {tmp_lo}, {tmp_hi}",
                                    "bne %cr0, 3f", // jump if compare failed
                                    "stqcx. %r6, 0, {dst}",
                                    "bne %cr0, 2b", // continue loop if store failed
                                "3:",
                                // if compare failed EQ bit is cleared, if stqcx succeeds EQ bit is set.
                                "mfcr {tmp_lo}",
                                $acquire,
                                // store out pair to out
                                concat!("std %r8, ", p128h!(), "({out})"),
                                concat!("std %r9, ", p128l!(), "({out})"),
                                dst = inout(reg_nonzero) ptr_reg!(dst) => _,
                                old = in(reg_nonzero) ptr_reg!(old),
                                new = in(reg_nonzero) ptr_reg!(new),
                                out = inout(reg_nonzero) ptr_reg!(out) => _,
                                tmp_hi = out(reg_nonzero) _,
                                tmp_lo = out(reg_nonzero) r,
                                // Quadword atomic instructions work with even/odd pair of specified register and subsequent register.
                                // We cannot use r1 (sp) and r2 (system reserved), so start with r4 or grater.
                                out("r4") _, // old (hi)
                                out("r5") _, // old (lo)
                                out("r6") _, // new (hi)
                                lateout("r7") _, // new (lo)
                                lateout("r8") _, // out (hi)
                                lateout("r9") _, // out (lo)
                                out("cr0") _,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    extract_cr0(r)
                }
            }
        }
    };
}

#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
atomic128!(i128);
#[cfg(target_arch = "powerpc64")]
#[cfg(any(
    target_feature = "quadword-atomics",
    atomic_maybe_uninit_target_feature = "quadword-atomics",
))]
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
    #[cfg(target_arch = "powerpc64")]
    test_atomic!(i64);
    #[cfg(target_arch = "powerpc64")]
    test_atomic!(u64);
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ))]
    test_atomic!(i128);
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ))]
    test_atomic!(u128);

    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
    stress_test!(u16);
    stress_test!(u32);
    #[cfg(target_arch = "powerpc64")]
    stress_test!(u64);
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ))]
    stress_test!(u128);
}
