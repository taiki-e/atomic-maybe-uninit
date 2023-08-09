// AVR

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore};

// TODO: https://github.com/llvm/llvm-project/commit/2a528760bf20004066effcf8f91fedaabd261903

macro_rules! atomic8 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        "in {sreg}, 0x3F",
                        "cli",
                        "ld {tmp}, X",
                        "out 0x3F, {sreg}",
                        "st Z, {tmp}",
                        sreg = out(reg) _,
                        tmp = out(reg) _,
                        in("X") src,
                        in("Z") out,
                        options(nostack, preserves_flags),
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
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        "ld {tmp}, Z",
                        "in {sreg}, 0x3F",
                        "cli",
                        "st X, {tmp}",
                        "out 0x3F, {sreg}",
                        sreg = out(reg) _,
                        tmp = out(reg) _,
                        in("X") dst,
                        in("Z") val,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
    };
}

macro_rules! atomic16 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        "in {sreg}, 0x3F",
                        "cli",
                        "ld {tmp}, X",
                        "ldd {tmp1}, X+1",
                        "out 0x3F, {sreg}",
                        "std Z+1, {tmp1}",
                        "st Z, {tmp}",
                        sreg = out(reg) _,
                        tmp = out(reg) _,
                        tmp1 = out(reg) _,
                        in("X") src,
                        in("Z") out,
                        options(nostack, preserves_flags),
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
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        "ld {tmp}, Z",
                        "ldd {tmp1}, Z+1",
                        "in {sreg}, 0x3F",
                        "cli",
                        "std X+1, {tmp1}",
                        "st X, {tmp}",
                        "out 0x3F, {sreg}",
                        sreg = out(reg) _,
                        tmp = out(reg) _,
                        tmp1 = out(reg) _,
                        in("X") dst,
                        in("Z") val,
                        options(nostack, preserves_flags),
                    );
                }
            }
        }
    };
}

atomic8!(i8);
atomic8!(u8);
atomic16!(i16);
atomic16!(u16);
atomic16!(isize);
atomic16!(usize);

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);
}
