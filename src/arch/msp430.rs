use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore};

macro_rules! atomic {
    ($int_type:ident, $asm_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // TODO: use mem to mem mov?
                        // (atomic) load from src to tmp
                        concat!("mov", $asm_suffix, " @{src}, {tmp}"),
                        // store tmp to out
                        concat!("mov", $asm_suffix, " {tmp}, 0({out})"),
                        src = in(reg) src,
                        out = inout(reg) out => _,
                        tmp = lateout(reg) _,
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
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        // TODO: use mem to mem mov?
                        // load from val to tmp
                        concat!("mov", $asm_suffix, " @{val}, {tmp}"),
                        // (atomic) store tmp to dst
                        concat!("mov", $asm_suffix, " {tmp}, 0({dst})"),
                        dst = inout(reg) dst => _,
                        val = in(reg) val,
                        tmp = lateout(reg) _,
                        options(nostack),
                    );
                }
            }
        }
    };
}

atomic!(i8, ".b");
atomic!(u8, ".b");
atomic!(i16, ".w");
atomic!(u16, ".w");
atomic!(isize, ".w");
atomic!(usize, ".w");

#[cfg(test)]
mod tests {
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);

    stress_test_load_store!();
}
