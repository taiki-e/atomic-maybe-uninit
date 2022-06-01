// Generated asm:
// - x86_64 https://godbolt.org/z/Y4jvdx3hj

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

#[cfg(target_pointer_width = "32")]
macro_rules! ptr_modifier {
    () => {
        ":e"
    };
}
#[cfg(target_pointer_width = "64")]
macro_rules! ptr_modifier {
    () => {
        ""
    };
}

macro_rules! atomic {
    ($int_type:ident, $val_reg:tt, $val_modifier:tt, $ptr_size:tt) => {
        impl AtomicLoad for $int_type {
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
                        concat!("mov {tmp", $val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "}]"),
                        // store tmp to out
                        concat!("mov ", $ptr_size, " ptr [{out", ptr_modifier!(), "}], {tmp", $val_modifier, "}"),
                        src = in(reg) src,
                        out = inout(reg) out => _,
                        tmp = lateout($val_reg) _,
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
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {
                            asm!(
                                // load from val to tmp
                                concat!("mov {tmp", $val_modifier, "}, ", $ptr_size, " ptr [{val", ptr_modifier!(), "}]"),
                                // (atomic) store tmp to dst
                                concat!("mov ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {tmp", $val_modifier, "}"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout($val_reg) _,
                                options(nostack),
                            );
                        }
                        Ordering::SeqCst => {
                            asm!(
                                // load from val to tmp
                                concat!("mov {tmp", $val_modifier, "}, ", $ptr_size, " ptr [{val", ptr_modifier!(), "}]"),
                                // (atomic) store tmp to dst (SeqCst store is xchg, not mov)
                                concat!("xchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {tmp", $val_modifier, "}"),
                                dst = inout(reg) dst => _,
                                val = in(reg) val,
                                tmp = lateout($val_reg) _,
                                options(nostack),
                            );
                        }
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
                _order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract for `atomic_swap`.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // load from val to tmp
                        concat!("mov {tmp", $val_modifier, "}, ", $ptr_size, " ptr [{val", ptr_modifier!(), "}]"),
                        // (atomic) swap tmp and dst
                        concat!("xchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {tmp", $val_modifier, "}"),
                        // store tmp to out
                        concat!("mov ", $ptr_size, " ptr [{out", ptr_modifier!(), "}], {tmp", $val_modifier, "}"),
                        dst = inout(reg) dst => _,
                        val = in(reg) val,
                        out = inout(reg) out => _,
                        tmp = lateout($val_reg) _,
                        options(nostack),
                    );
                }
            }
        }
    };
}

atomic!(i8, reg_byte, "", "byte");
atomic!(u8, reg_byte, "", "byte");
atomic!(i16, reg, ":x", "word");
atomic!(u16, reg, ":x", "word");
atomic!(i32, reg, ":e", "dword");
atomic!(u32, reg, ":e", "dword");
#[cfg(target_arch = "x86_64")]
atomic!(i64, reg, "", "qword");
#[cfg(target_arch = "x86_64")]
atomic!(u64, reg, "", "qword");
#[cfg(target_pointer_width = "32")]
atomic!(isize, reg, ":e", "dword");
#[cfg(target_pointer_width = "32")]
atomic!(usize, reg, ":e", "dword");
#[cfg(target_pointer_width = "64")]
atomic!(isize, reg, "", "qword");
#[cfg(target_pointer_width = "64")]
atomic!(usize, reg, "", "qword");

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

    stress_test_load_store!();
    stress_test_load_swap!();
}
