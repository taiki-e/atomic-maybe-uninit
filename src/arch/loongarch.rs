// LoongArch
//
// Generated asm:
// - loongarch64 https://godbolt.org/z/vTxfajT14

#[path = "partword.rs"]
mod partword;

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
                        // (atomic) CAS (LL/SC loop)
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
macro_rules! atomic_sub_word {
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
                    macro_rules! atomic_swap {
                        ($fence:tt) => {
                            asm!(
                                "sll.w {mask}, {mask}, {shift}",
                                "addi.w {mask}, {mask}, 0",
                                concat!("ld.", $asm_suffix, "u {val}, {val}, 0"),
                                "sll.w {val}, {val}, {shift}",
                                "addi.w {val}, {val}, 0",
                                // (atomic) swap (LL/SC loop)
                                "2:",
                                    $fence,
                                    "ll.w {tmp1}, {dst}, 0",
                                    "addi.w {tmp2}, {val}, 0",
                                    "xor {tmp2}, {tmp1}, {tmp2}",
                                    "and {tmp2}, {tmp2}, {mask}",
                                    "xor {tmp2}, {tmp1}, {tmp2}",
                                    "sc.w {tmp2}, {dst}, 0",
                                    "beqz {tmp2}, 2b",
                                "srl.w {tmp1}, {tmp1}, {shift}",
                                concat!("st.", $asm_suffix, " {tmp1}, {out}, 0"),
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
                    match order {
                        Ordering::Relaxed => atomic_swap!(""),
                        _ => atomic_swap!("dbar 0"),
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
                _success: Ordering,
                _failure: Ordering,
            ) -> bool {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(old as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(new as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);
                let (aligned_ptr, shift, mask) = partword::create_mask_values(dst);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: XSize;
                    // Implement sub-word atomic operations using word-sized LL/SC loop.
                    // Based on assemblies generated by rustc/LLVM.
                    // See also partword.rs.
                    asm!(
                        concat!("ld.", $asm_suffix, "u {new}, {new}, 0"),
                        concat!("ld.", $asm_suffix, "u {old}, {old}, 0"),
                        "sll.w {new}, {new}, {shift}",
                        "addi.w {new}, {new}, 0",
                        "sll.w {old}, {old}, {shift}",
                        "addi.w $a7, {old}, 0",
                        "sll.w {mask}, {mask}, {shift}",
                        "addi.w $a6, {mask}, 0",
                        // (atomic) CAS (LL/SC loop)
                        "2:",
                            "ll.w $t0, {dst}, 0",
                            "and $t1, $t0, $a6",
                            "bne $t1, $a7, 3f",
                            "dbar 0",
                            "andn $t1, $t0, $a6",
                            "or $t1, $t1, {new}",
                            "sc.w $t1, {dst}, 0",
                            "beqz $t1, 2b",
                            "b 4f",
                        "3:",
                            "dbar 1792",
                        "4:",
                        "srl.w $a6, $t0, {shift}",
                        concat!("st.", $asm_suffix, " $a6, {out}, 0"),
                        "and {r}, $t0, {mask}",
                        "addi.w {r}, {r}, 0",
                        "xor {r}, {old}, {r}",
                        "sltui {r}, {r}, 1",
                        dst = in(reg) ptr_reg!(aligned_ptr),
                        old = inout(reg) ptr_reg!(old) => _,
                        new = inout(reg) ptr_reg!(new) => _,
                        out = inout(reg) ptr_reg!(out) => _,
                        shift = in(reg) shift,
                        mask = inout(reg) mask => _,
                        r = lateout(reg) r,
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

atomic_sub_word!(i8, "b");
atomic_sub_word!(u8, "b");
atomic_sub_word!(i16, "h");
atomic_sub_word!(u16, "h");
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

#[macro_export]
macro_rules! cfg_has_atomic_8 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_8 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_16 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_16 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
