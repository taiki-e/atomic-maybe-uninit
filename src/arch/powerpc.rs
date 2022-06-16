// Refs:
// - https://www.ibm.com/docs/en/aix/7.3?topic=aix-assembler-language-reference
//
// Generated asm:
// - powerpc https://godbolt.org/z/Pnaja5hG4
// - powerpc64 https://godbolt.org/z/1vTb3vbab
// - powerpc64 (pwr8) https://godbolt.org/z/bdhqnr1hP
// - powerpc64le https://godbolt.org/z/Yx36Yj96E

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic_load_store {
    ($int_type:ident, $ld_suffix:tt, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                #[cfg(target_arch = "powerpc64")]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("l", $ld_suffix, " {tmp}, 0({src})"),
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                out("r0") _,
                                options(nostack),
                            )
                        }
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("l", $ld_suffix, " {tmp}, 0({src})"),
                                // Refs: https://github.com/boostorg/atomic/blob/a17267547071e0dd60c81945bcb6bf0162a5db07/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp
                                "cmpd %cr7, {tmp}, {tmp}",
                                "bne- %cr7, 2f",
                                "2:",
                                "isync",
                                // store tmp to out
                                concat!("st", $asm_suffix, " {tmp}, 0({out})"),
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                out("r0") _,
                                options(nostack),
                            )
                        }
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
                #[cfg(target_arch = "powerpc")]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
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
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                out("r0") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("lwsync", ""),
                        Ordering::SeqCst => atomic_load!("lwsync", "sync"),
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
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("l", $ld_suffix, " {tmp}, 0({val})"),
                                // (atomic) store tmp to dst
                                $release,
                                concat!("st", $asm_suffix, " {tmp}, 0({dst})"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                out("r0") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        Ordering::Release => atomic_store!("lwsync"),
                        Ordering::SeqCst => atomic_store!("sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
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
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to val_tmp
                                concat!("l", $ld_suffix, " {val_tmp}, 0({val})"),
                                // (atomic) swap
                                $release,
                                "2:",
                                    // load from dst to out_tmp
                                    concat!("l", $asm_suffix, "arx {out_tmp}, 0, {dst}"),
                                    // store val to dst
                                    concat!("st", $asm_suffix, "cx. {val_tmp}, 0, {dst}"),
                                    "bne %cr0, 2b",
                                $acquire,
                                // store out_tmp to out
                                concat!("st", $asm_suffix, " {out_tmp}, 0({out})"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                val_tmp = lateout(reg) _,
                                out = inout(reg) out => _,
                                out_tmp = out(reg) _,
                                out("r0") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("lwsync", ""),
                        Ordering::Release => atomic_swap!("", "lwsync"),
                        Ordering::AcqRel => atomic_swap!("lwsync", "lwsync"),
                        Ordering::SeqCst => atomic_swap!("lwsync", "sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[cfg(target_endian = "big")]
#[cfg(not(all(target_arch = "powerpc64", atomic_maybe_uninit_pwr8)))]
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
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // Refs:
                    // - https://github.com/llvm/llvm-project/blob/03c066ab134f02289df1b61db00294c1da579f9c/llvm/lib/CodeGen/AtomicExpandPass.cpp#L677
                    // - https://github.com/llvm/llvm-project/blob/03c066ab134f02289df1b61db00294c1da579f9c/llvm/test/CodeGen/PowerPC/atomics.ll
                    #[cfg(target_arch = "powerpc64")]
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "lbz %r7, 0(%r4)",
                                "rlwinm %r4, %r3, 3, 27, 28",
                                "li %r6, 255",
                                "xori %r4, %r4, 24",
                                "slw %r6, %r6, %r4",
                                "slw %r8, %r7, %r4",
                                "rldicr %r7, %r3, 0, 61",
                                "and %r8, %r8, %r6",
                                $release,
                                // (atomic) swap
                                "2:",
                                    "lwarx %r3, 0, %r7",
                                    "andc %r9, %r3, %r6",
                                    "or %r9, %r8, %r9",
                                    "stwcx. %r9, 0, %r7",
                                    "bne %cr0, 2b",
                                "srw %r3, %r3, %r4",
                                "clrlwi %r3, %r3, 24",
                                $acquire,
                                "stb %r3, 0(%r5)",
                                out("r0") _,
                                inout("r3") dst => _,
                                inout("r4") val => _,
                                in("r5") out,
                                out("r6") _,
                                out("r7") _,
                                out("r8") _,
                                out("r9") _,
                                options(nostack),
                            )
                        };
                    }
                    #[cfg(target_arch = "powerpc")]
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "lbz %r7, 0(%r4)",
                                "rlwinm %r8, %r3, 3, 27, 28",
                                "li %r6, 255",
                                "rlwinm %r4, %r3, 0, 0, 29",
                                "xori %r3, %r8, 24",
                                "slw %r8, %r7, %r3",
                                "slw %r7, %r6, %r3",
                                "and %r8, %r8, %r7",
                                $release,
                                // (atomic) swap
                                "2:",
                                    "lwarx %r6, 0, %r4",
                                    "andc %r9, %r6, %r7",
                                    "or %r9, %r8, %r9",
                                    "stwcx. %r9, 0, %r4",
                                    "bne %cr0, 2b",
                                "srw %r3, %r6, %r3",
                                "clrlwi %r3, %r3, 24",
                                $acquire,
                                "stb %r3, 0(%r5)",
                                out("r0") _,
                                inout("r3") dst => _,
                                inout("r4") val => _,
                                in("r5") out,
                                out("r6") _,
                                out("r7") _,
                                out("r8") _,
                                out("r9") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("lwsync", ""),
                        Ordering::Release => atomic_swap!("", "lwsync"),
                        Ordering::AcqRel => atomic_swap!("lwsync", "lwsync"),
                        Ordering::SeqCst => atomic_swap!("lwsync", "sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[cfg(target_endian = "big")]
#[cfg(not(all(target_arch = "powerpc64", atomic_maybe_uninit_pwr8)))]
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
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // Refs:
                    // - https://github.com/llvm/llvm-project/blob/03c066ab134f02289df1b61db00294c1da579f9c/llvm/lib/CodeGen/AtomicExpandPass.cpp#L677
                    // - https://github.com/llvm/llvm-project/blob/03c066ab134f02289df1b61db00294c1da579f9c/llvm/test/CodeGen/PowerPC/atomics.ll
                    #[cfg(target_arch = "powerpc64")]
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "lhz %r8, 0(%r4)",
                                "li %r6, 0",
                                "rlwinm %r7, %r3, 3, 27, 27",
                                "ori %r6, %r6, 65535",
                                "xori %r4, %r7, 16",
                                "slw %r6, %r6, %r4",
                                "slw %r8, %r8, %r4",
                                "rldicr %r7, %r3, 0, 61",
                                "and %r8, %r8, %r6",
                                $release,
                                // (atomic) swap
                                "2:",
                                    "lwarx %r3, 0, %r7",
                                    "andc %r9, %r3, %r6",
                                    "or %r9, %r8, %r9",
                                    "stwcx. %r9, 0, %r7",
                                    "bne %cr0, 2b",
                                "srw %r3, %r3, %r4",
                                "clrlwi %r3, %r3, 16",
                                $acquire,
                                "sth %r3, 0(%r5)",
                                out("r0") _,
                                inout("r3") dst => _,
                                inout("r4") val => _,
                                in("r5") out,
                                out("r6") _,
                                out("r7") _,
                                out("r8") _,
                                out("r9") _,
                                options(nostack),
                            )
                        };
                    }
                    #[cfg(target_arch = "powerpc")]
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                "lhz %r7, 0(%r4)",
                                "li %r6, 0",
                                "rlwinm %r8, %r3, 3, 27, 27",
                                "rlwinm %r4, %r3, 0, 0, 29",
                                "ori %r6, %r6, 65535",
                                "xori %r3, %r8, 16",
                                "slw %r8, %r7, %r3",
                                "slw %r7, %r6, %r3",
                                "and %r8, %r8, %r7",
                                $release,
                                // (atomic) swap
                                "2:",
                                    "lwarx %r6, 0, %r4",
                                    "andc %r9, %r6, %r7",
                                    "or %r9, %r8, %r9",
                                    "stwcx. %r9, 0, %r4",
                                    "bne %cr0, 2b",
                                "srw %r3, %r6, %r3",
                                "clrlwi %r3, %r3, 16",
                                $acquire,
                                "sth %r3, 0(%r5)",
                                out("r0") _,
                                inout("r3") dst => _,
                                inout("r4") val => _,
                                in("r5") out,
                                out("r6") _,
                                out("r7") _,
                                out("r8") _,
                                out("r9") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("lwsync", ""),
                        Ordering::Release => atomic_swap!("", "lwsync"),
                        Ordering::AcqRel => atomic_swap!("lwsync", "lwsync"),
                        Ordering::SeqCst => atomic_swap!("lwsync", "sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[cfg(target_arch = "powerpc64")]
#[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
atomic!(i8, "bz", "b");
#[cfg(target_arch = "powerpc64")]
#[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
atomic!(u8, "bz", "b");
#[cfg(target_arch = "powerpc64")]
#[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
atomic!(i16, "hz", "h");
#[cfg(target_arch = "powerpc64")]
#[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
atomic!(u16, "hz", "h");
#[cfg(target_endian = "big")]
#[cfg(not(all(target_arch = "powerpc64", atomic_maybe_uninit_pwr8)))]
atomic8!(i8, "bz", "b");
#[cfg(target_endian = "big")]
#[cfg(not(all(target_arch = "powerpc64", atomic_maybe_uninit_pwr8)))]
atomic8!(u8, "bz", "b");
#[cfg(target_endian = "big")]
#[cfg(not(all(target_arch = "powerpc64", atomic_maybe_uninit_pwr8)))]
atomic16!(i16, "hz", "h");
#[cfg(target_endian = "big")]
#[cfg(not(all(target_arch = "powerpc64", atomic_maybe_uninit_pwr8)))]
atomic16!(u16, "hz", "h");
atomic!(i32, "wz", "w");
atomic!(u32, "wz", "w");
#[cfg(target_arch = "powerpc64")]
atomic!(i64, "d", "d");
#[cfg(target_arch = "powerpc64")]
atomic!(u64, "d", "d");
#[cfg(target_pointer_width = "32")]
atomic!(isize, "wz", "w");
#[cfg(target_pointer_width = "32")]
atomic!(usize, "wz", "w");
#[cfg(target_pointer_width = "64")]
atomic!(isize, "d", "d");
#[cfg(target_pointer_width = "64")]
atomic!(usize, "d", "d");

// https://github.com/llvm/llvm-project/commit/549e118e93c666914a1045fde38a2cac33e1e445
// https://github.com/llvm/llvm-project/blob/2ba5d820e2b0e5016ec706e324060a329f9a83a3/llvm/test/CodeGen/PowerPC/atomics-i128-ldst.ll
// https://github.com/llvm/llvm-project/blob/2ba5d820e2b0e5016ec706e324060a329f9a83a3/llvm/test/CodeGen/PowerPC/atomics-i128.ll
#[cfg(target_arch = "powerpc64")]
// powerpc64le is pwr8+ https://github.com/llvm/llvm-project/blob/2ba5d820e2b0e5016ec706e324060a329f9a83a3/llvm/lib/Target/PowerPC/PPC.td#L652
// See also https://github.com/rust-lang/rust/issues/59932
#[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
macro_rules! atomic128 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    match order {
                        Ordering::Relaxed => {
                            asm!(
                                // (atomic) load from src to r4-r5 pair
                                "lq %r4, 0({src})",
                                // store r4-r5 pair to out
                                "stq %r4, 0({out})",
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                out("r0") _,
                                // lq loads value into the pair of specified register and subsequent register.
                                // We cannot use r1 and r2, so starting with r4.
                                out("r4") _,
                                out("r5") _,
                                options(nostack),
                            )
                        }
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => {
                            asm!(
                                // (atomic) load from src to r4-r5 pair
                                "lq %r4, 0({src})",
                                // Refs: https://github.com/boostorg/atomic/blob/a17267547071e0dd60c81945bcb6bf0162a5db07/include/boost/atomic/detail/core_arch_ops_gcc_ppc.hpp
                                "cmpd %cr7, %r4, %r4",
                                "bne- %cr7, 2f",
                                "2:",
                                "isync",
                                // store r4-r5 pair to out
                                "stq %r4, 0({out})",
                                src = in(reg) src,
                                out = inout(reg) out => _,
                                out("r0") _,
                                // lq loads value into the pair of specified register and subsequent register.
                                // We cannot use r1 and r2, so starting with r4.
                                out("r4") _,
                                out("r5") _,
                                options(nostack),
                            )
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
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store {
                        ($release:tt) => {
                            asm!(
                                // load from val to r4-r5 pair
                                "lq %r4, 0({val})",
                                // (atomic) store r4-r5 pair to dst
                                $release,
                                "stq %r4, 0({dst})",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out("r0") _,
                                // lq loads value into the pair of specified register and subsequent register.
                                // We cannot use r1 and r2, so starting with r4.
                                out("r4") _,
                                out("r5") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!(""),
                        Ordering::Release => atomic_store!("lwsync"),
                        Ordering::SeqCst => atomic_store!("sync"),
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
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    macro_rules! atomic_swap {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                // load from val to r4-r5 pair
                                "lq %r4, 0({val})",
                                // (atomic) swap
                                $release,
                                "2:",
                                    // load from dst to r6-r7 pair
                                    "lqarx %r6, 0, {dst}",
                                    // store r4-r5 pair to dst
                                    "stqcx. %r4, 0, {dst}",
                                    "bne %cr0, 2b",
                                $acquire,
                                // store r6-r7 pair to out
                                "stq %r6, 0({out})",
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                out = inout(reg) out => _,
                                out("r0") _,
                                // lq loads value into the pair of specified register and subsequent register.
                                // We cannot use r1 and r2, so starting with r4.
                                out("r4") _,
                                out("r5") _,
                                out("r6") _,
                                out("r7") _,
                                options(nostack),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_swap!("", ""),
                        Ordering::Acquire => atomic_swap!("lwsync", ""),
                        Ordering::Release => atomic_swap!("", "lwsync"),
                        Ordering::AcqRel => atomic_swap!("lwsync", "lwsync"),
                        Ordering::SeqCst => atomic_swap!("lwsync", "sync"),
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
            }
        }
    };
}

#[cfg(target_arch = "powerpc64")]
#[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
atomic128!(i128);
#[cfg(target_arch = "powerpc64")]
#[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
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

    #[cfg(not(qemu))]
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
    test_atomic!(i128);
    #[cfg(not(qemu))]
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
    test_atomic!(u128);
    // As of qemu 7.0.0 , using lqarx/stqcx. with qemu-user hangs.
    // To test this, use real powerpc64le hardware or use POWER Functional
    // Simulator. See DEVELOPMENT.md for more.
    #[cfg(qemu)]
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
    test_atomic_load_store!(i128);
    #[cfg(qemu)]
    #[cfg(target_arch = "powerpc64")]
    #[cfg(any(target_endian = "little", atomic_maybe_uninit_pwr8))]
    test_atomic_load_store!(u128);

    stress_test_load_store!();
    stress_test_load_swap!();
}
