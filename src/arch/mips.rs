// Generated asm:
// - mipsel https://godbolt.org/z/s45qP8x9K
// - mips64el https://godbolt.org/z/hqn6Gehn6

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore};

macro_rules! atomic_load_store {
    ($int_type:ident, $asm_suffix:tt, $asm_u_suffix:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
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
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
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
                                out = inout(reg) out => _,
                                tmp = lateout(reg) _,
                                options(nostack),
                            );
                        }
                        _ => crate::utils::release_unreachable_unchecked(),
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
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
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
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
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
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
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
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout(reg) _,
                                options(nostack),
                            );
                        }
                        _ => crate::utils::release_unreachable_unchecked(),
                    }
                }
            }
        }
    };
}

atomic_load_store!(i8, "b", "u");
atomic_load_store!(u8, "b", "u");
atomic_load_store!(i16, "h", "u");
atomic_load_store!(u16, "h", "u");
atomic_load_store!(i32, "w", "");
atomic_load_store!(u32, "w", "");
#[cfg(target_arch = "mips64")]
atomic_load_store!(i64, "d", "");
#[cfg(target_arch = "mips64")]
atomic_load_store!(u64, "d", "");
#[cfg(target_pointer_width = "32")]
atomic_load_store!(isize, "w", "");
#[cfg(target_pointer_width = "32")]
atomic_load_store!(usize, "w", "");
#[cfg(target_pointer_width = "64")]
atomic_load_store!(isize, "d", "");
#[cfg(target_pointer_width = "64")]
atomic_load_store!(usize, "d", "");

#[cfg(test)]
mod tests {
    test_atomic_load_store!(isize);
    test_atomic_load_store!(usize);
    test_atomic_load_store!(i8);
    test_atomic_load_store!(u8);
    test_atomic_load_store!(i16);
    test_atomic_load_store!(u16);
    test_atomic_load_store!(i32);
    test_atomic_load_store!(u32);
    #[cfg(target_arch = "mips64")]
    test_atomic_load_store!(i64);
    #[cfg(target_arch = "mips64")]
    test_atomic_load_store!(u64);

    stress_test_load_store!();
    // stress_test_load_swap!();
}
