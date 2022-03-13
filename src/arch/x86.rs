// Generated asm:
// - x86_64 https://godbolt.org/z/Mq93KhhKe
// - i686 https://godbolt.org/z/aaoq657Wz

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! delegate {
    ($from:ident, $($to:ident),*) => {$(
        impl AtomicLoad for $to {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                unsafe { $from::atomic_load(src.cast(), out.cast(), order) }
            }
        }
        impl AtomicStore for $to {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                order: Ordering,
            ) {
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe { $from::atomic_store(dst.cast(), val.cast(), order) }
            }
        }
        impl AtomicSwap for $to {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe { $from::atomic_swap(dst.cast(), val.cast(), out.cast(), order) }
            }
        }
    )*};
}

delegate!(u8, i8);
impl AtomicLoad for u8 {
    #[inline]
    unsafe fn atomic_load(
        src: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        _order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_store`.
        unsafe {
            // atomic load is always SeqCst.
            asm!(
                // (atomic) load from src to tmp
                "mov {tmp}, byte ptr [{src}]",
                // store tmp to out
                "mov byte ptr [{out}], {tmp}",
                src = in(reg) src,
                out = in(reg) out,
                tmp = out(reg_byte) _,
                options(nostack),
            );
        }
    }
}
impl AtomicStore for u8 {
    #[inline]
    unsafe fn atomic_store(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_store`.
        unsafe {
            match order {
                // Relaxed and Release stores are equivalent.
                Ordering::Relaxed | Ordering::Release => {
                    asm!(
                        // load from val to tmp
                        "mov {tmp}, byte ptr [{val}]",
                        // (atomic) store tmp to dst
                        "mov byte ptr [{dst}], {tmp}",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        tmp = out(reg_byte) _,
                        options(nostack),
                    );
                }
                Ordering::SeqCst => {
                    asm!(
                        // load from val to tmp
                        "mov {tmp}, byte ptr [{val}]",
                        // (atomic) store tmp to dst (SeqCst store is xchg, not mov)
                        "xchg byte ptr [{dst}], {tmp}",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        tmp = out(reg_byte) _,
                        options(nostack),
                    );
                }
                _ => crate::utils::ordering_unreachable_unchecked(order),
            }
        }
    }
}
impl AtomicSwap for u8 {
    #[inline]
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        _order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
        unsafe {
            // atomic swap is always SeqCst.
            asm!(
                // load from val to tmp
                "mov {tmp}, byte ptr [{val}]",
                // (atomic) swap tmp and dst
                "xchg byte ptr [{dst}], {tmp}",
                // store tmp to out
                "mov byte ptr [{out}], {tmp}",
                dst = in(reg) dst,
                val = in(reg) val,
                out = in(reg) out,
                tmp = out(reg_byte) _,
                options(nostack),
            );
        }
    }
}

delegate!(u16, i16);
impl AtomicLoad for u16 {
    #[inline]
    unsafe fn atomic_load(
        src: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        _order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_store`.
        unsafe {
            // atomic load is always SeqCst.
            asm!(
                // (atomic) load from src to ax
                "mov ax, word ptr [{src}]",
                // store ax to out
                "mov word ptr [{out}], ax",
                src = in(reg) src,
                out = in(reg) out,
                out("ax") _,
                options(nostack),
            );
        }
    }
}
impl AtomicStore for u16 {
    #[inline]
    unsafe fn atomic_store(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_store`.
        unsafe {
            match order {
                // Relaxed and Release stores are equivalent.
                Ordering::Relaxed | Ordering::Release => {
                    asm!(
                        // load from val to ax
                        "mov ax, word ptr [{val}]",
                        // (atomic) store ax to dst
                        "mov word ptr [{dst}], ax",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        out("ax") _,
                        options(nostack),
                    );
                }
                Ordering::SeqCst => {
                    asm!(
                        // load from val to ax
                        "mov ax, word ptr [{val}]",
                        // (atomic) store ax to dst (SeqCst store is xchg, not mov)
                        "xchg word ptr [{dst}], ax",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        out("ax") _,
                        options(nostack),
                    );
                }
                _ => crate::utils::ordering_unreachable_unchecked(order),
            }
        }
    }
}
impl AtomicSwap for u16 {
    #[inline]
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        _order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
        unsafe {
            // atomic swap is always SeqCst.
            asm!(
                // load from val to ax
                "mov ax, word ptr [{val}]",
                // (atomic) swap ax and dst
                "xchg word ptr [{dst}], ax",
                // store ax to out
                "mov word ptr [{out}], ax",
                dst = in(reg) dst,
                val = in(reg) val,
                out = in(reg) out,
                out("ax") _,
                options(nostack),
            );
        }
    }
}

delegate!(u32, i32);
impl AtomicLoad for u32 {
    #[inline]
    unsafe fn atomic_load(
        src: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        _order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_store`.
        unsafe {
            // atomic load is always SeqCst.
            asm!(
                // (atomic) load from src to tmp
                "mov {tmp:e}, dword ptr [{src}]",
                // store tmp to out
                "mov dword ptr [{out}], {tmp:e}",
                src = in(reg) src,
                out = in(reg) out,
                tmp = out(reg) _,
                options(nostack),
            );
        }
    }
}
impl AtomicStore for u32 {
    #[inline]
    unsafe fn atomic_store(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_store`.
        unsafe {
            match order {
                // Relaxed and Release stores are equivalent.
                Ordering::Relaxed | Ordering::Release => {
                    asm!(
                        // load from val to tmp
                        "mov {tmp:e}, dword ptr [{val}]",
                        // (atomic) store tmp to dst
                        "mov dword ptr [{dst}], {tmp:e}",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        tmp = out(reg) _,
                        options(nostack),
                    );
                }
                Ordering::SeqCst => {
                    asm!(
                        // load from val to tmp
                        "mov {tmp:e}, dword ptr [{val}]",
                        // (atomic) store tmp to dst (SeqCst store is xchg, not mov)
                        "xchg dword ptr [{dst}], {tmp:e}",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        tmp = out(reg) _,
                        options(nostack),
                    );
                }
                _ => crate::utils::ordering_unreachable_unchecked(order),
            }
        }
    }
}
impl AtomicSwap for u32 {
    #[inline]
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        _order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
        unsafe {
            // atomic swap is always SeqCst.
            asm!(
                // load from val to tmp
                "mov {tmp:e}, dword ptr [{val}]",
                // (atomic) swap tmp and dst
                "xchg dword ptr [{dst}], {tmp:e}",
                // store tmp to out
                "mov dword ptr [{out}], {tmp:e}",
                dst = in(reg) dst,
                val = in(reg) val,
                out = in(reg) out,
                tmp = out(reg) _,
                options(nostack),
            );
        }
    }
}

#[cfg(target_arch = "x86_64")]
delegate!(u64, i64);
#[cfg(target_arch = "x86_64")]
impl AtomicLoad for u64 {
    #[inline]
    unsafe fn atomic_load(
        src: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        _order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_store`.
        unsafe {
            // atomic load is always SeqCst.
            asm!(
                // (atomic) load from src to tmp
                "mov {tmp}, qword ptr [{src}]",
                // store tmp to out
                "mov qword ptr [{out}], {tmp}",
                src = in(reg) src,
                out = in(reg) out,
                tmp = out(reg) _,
                options(nostack),
            );
        }
    }
}
#[cfg(target_arch = "x86_64")]
impl AtomicStore for u64 {
    #[inline]
    unsafe fn atomic_store(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_store`.
        unsafe {
            match order {
                // Relaxed and Release stores are equivalent.
                Ordering::Relaxed | Ordering::Release => {
                    asm!(
                        // load from val to tmp
                        "mov {tmp}, qword ptr [{val}]",
                        // (atomic) store tmp to dst
                        "mov qword ptr [{dst}], {tmp}",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        tmp = out(reg) _,
                        options(nostack),
                    );
                }
                Ordering::SeqCst => {
                    asm!(
                        // load from val to tmp
                        "mov {tmp}, qword ptr [{val}]",
                        // (atomic) store tmp to dst (SeqCst store is xchg, not mov)
                        "xchg qword ptr [{dst}], {tmp}",
                        dst = in(reg) dst,
                        val = in(reg) val,
                        tmp = out(reg) _,
                        options(nostack),
                    );
                }
                _ => crate::utils::ordering_unreachable_unchecked(order),
            }
        }
    }
}
#[cfg(target_arch = "x86_64")]
impl AtomicSwap for u64 {
    #[inline]
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        _order: Ordering,
    ) {
        // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
        unsafe {
            // atomic swap is always SeqCst.
            asm!(
                // load from val to tmp
                "mov {tmp}, qword ptr [{val}]",
                // (atomic) swap tmp and dst
                "xchg qword ptr [{dst}], {tmp}",
                // store tmp to out
                "mov qword ptr [{out}], {tmp}",
                dst = in(reg) dst,
                val = in(reg) val,
                out = in(reg) out,
                tmp = out(reg) _,
                options(nostack),
            );
        }
    }
}

#[cfg(target_pointer_width = "32")]
delegate!(u32, isize, usize);
#[cfg(target_pointer_width = "64")]
delegate!(u64, isize, usize);

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
    #[cfg(target_arch = "x86_64")]
    test_atomic!(i64);
    #[cfg(target_arch = "x86_64")]
    test_atomic!(u64);
}
