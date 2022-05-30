// Generated asm:
// - x86_64 https://godbolt.org/z/Y4jvdx3hj

use core::{arch::asm, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap};

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
    ($int_type:ident, $val_reg:tt, $val_modifier:tt, $ptr_size:tt, $size:tt) => {
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
        impl AtomicMemcpy for $int_type {
            #[inline]
            unsafe fn atomic_load_memcpy(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                count: usize,
            ) {
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_load_memcpy {
                        ($i:tt) => {
                            asm!(
                                // (atomic) load from src to tmp
                                concat!("mov {tmp", $val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "} + ", $i, "*", $size, "]"),
                                // store tmp to out
                                concat!("mov ", $ptr_size, " ptr [{out", ptr_modifier!(), "} + ", $i, "*", $size, "], {tmp", $val_modifier, "}"),
                                src = in(reg) src,
                                out = in(reg) out,
                                tmp = out($val_reg) _,
                                options(nostack),
                            );
                        };
                    }
                    match count {
                        1 => {
                            atomic_load_memcpy!("0");
                        }
                        2 => {
                            atomic_load_memcpy!("0");
                            atomic_load_memcpy!("1");
                        }
                        3 => {
                            atomic_load_memcpy!("0");
                            atomic_load_memcpy!("1");
                            atomic_load_memcpy!("2");
                        }
                        4 => {
                            atomic_load_memcpy!("0");
                            atomic_load_memcpy!("1");
                            atomic_load_memcpy!("2");
                            atomic_load_memcpy!("3");
                        }
                        8 => {
                            atomic_load_memcpy!("0");
                            atomic_load_memcpy!("1");
                            atomic_load_memcpy!("2");
                            atomic_load_memcpy!("3");
                            atomic_load_memcpy!("4");
                            atomic_load_memcpy!("5");
                            atomic_load_memcpy!("6");
                            atomic_load_memcpy!("7");
                        }
                        16 => {
                            atomic_load_memcpy!("0");
                            atomic_load_memcpy!("1");
                            atomic_load_memcpy!("2");
                            atomic_load_memcpy!("3");
                            atomic_load_memcpy!("4");
                            atomic_load_memcpy!("5");
                            atomic_load_memcpy!("6");
                            atomic_load_memcpy!("7");
                            atomic_load_memcpy!("8");
                            atomic_load_memcpy!("9");
                            atomic_load_memcpy!("10");
                            atomic_load_memcpy!("11");
                            atomic_load_memcpy!("12");
                            atomic_load_memcpy!("13");
                            atomic_load_memcpy!("14");
                            atomic_load_memcpy!("15");
                        }
                        32 => {
                            atomic_load_memcpy!("0");
                            atomic_load_memcpy!("1");
                            atomic_load_memcpy!("2");
                            atomic_load_memcpy!("3");
                            atomic_load_memcpy!("4");
                            atomic_load_memcpy!("5");
                            atomic_load_memcpy!("6");
                            atomic_load_memcpy!("7");
                            atomic_load_memcpy!("8");
                            atomic_load_memcpy!("9");
                            atomic_load_memcpy!("10");
                            atomic_load_memcpy!("11");
                            atomic_load_memcpy!("12");
                            atomic_load_memcpy!("13");
                            atomic_load_memcpy!("14");
                            atomic_load_memcpy!("15");
                            atomic_load_memcpy!("16");
                            atomic_load_memcpy!("17");
                            atomic_load_memcpy!("18");
                            atomic_load_memcpy!("19");
                            atomic_load_memcpy!("20");
                            atomic_load_memcpy!("21");
                            atomic_load_memcpy!("22");
                            atomic_load_memcpy!("23");
                            atomic_load_memcpy!("24");
                            atomic_load_memcpy!("25");
                            atomic_load_memcpy!("26");
                            atomic_load_memcpy!("27");
                            atomic_load_memcpy!("28");
                            atomic_load_memcpy!("29");
                            atomic_load_memcpy!("30");
                            atomic_load_memcpy!("31");
                        }
                        _ => {
                            for i in 0..count {
                                asm!(
                                    // (atomic) load from src to tmp
                                    concat!("mov {tmp", $val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "} + {i}*", $size, "]"),
                                    // store tmp to out
                                    concat!("mov ", $ptr_size, " ptr [{out", ptr_modifier!(), "} + {i}*", $size, "], {tmp", $val_modifier, "}"),
                                    src = in(reg) src,
                                    out = in(reg) out,
                                    tmp = out($val_reg) _,
                                    i = in(reg) i,
                                    options(nostack),
                                );
                            }
                        }
                    }
                }
            }
            #[inline]
            unsafe fn atomic_store_memcpy(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                count: usize,
            ) {
                // clippy bug that does not recognize safety comments inside macros.
                #[allow(clippy::undocumented_unsafe_blocks)]
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                unsafe {
                    macro_rules! atomic_store_memcpy {
                        ($i:tt) => {
                            asm!(
                                // load from val to tmp
                                concat!("mov {tmp", $val_modifier, "}, ", $ptr_size, " ptr [{val", ptr_modifier!(), "} + ", $i, "*", $size, "]"),
                                // (atomic) store tmp to dst
                                concat!("mov ", $ptr_size, " ptr [{dst", ptr_modifier!(), "} + ", $i, "*", $size, "], {tmp", $val_modifier, "}"),
                                dst = in(reg) dst,
                                val = in(reg) val,
                                tmp = out($val_reg) _,
                                options(nostack),
                            );
                        };
                    }
                    match count {
                        1 => {
                            atomic_store_memcpy!("0");
                        }
                        2 => {
                            atomic_store_memcpy!("0");
                            atomic_store_memcpy!("1");
                        }
                        3 => {
                            atomic_store_memcpy!("0");
                            atomic_store_memcpy!("1");
                            atomic_store_memcpy!("2");
                        }
                        4 => {
                            atomic_store_memcpy!("0");
                            atomic_store_memcpy!("1");
                            atomic_store_memcpy!("2");
                            atomic_store_memcpy!("3");
                        }
                        8 => {
                            atomic_store_memcpy!("0");
                            atomic_store_memcpy!("1");
                            atomic_store_memcpy!("2");
                            atomic_store_memcpy!("3");
                            atomic_store_memcpy!("4");
                            atomic_store_memcpy!("5");
                            atomic_store_memcpy!("6");
                            atomic_store_memcpy!("7");
                        }
                        16 => {
                            atomic_store_memcpy!("0");
                            atomic_store_memcpy!("1");
                            atomic_store_memcpy!("2");
                            atomic_store_memcpy!("3");
                            atomic_store_memcpy!("4");
                            atomic_store_memcpy!("5");
                            atomic_store_memcpy!("6");
                            atomic_store_memcpy!("7");
                            atomic_store_memcpy!("8");
                            atomic_store_memcpy!("9");
                            atomic_store_memcpy!("10");
                            atomic_store_memcpy!("11");
                            atomic_store_memcpy!("12");
                            atomic_store_memcpy!("13");
                            atomic_store_memcpy!("14");
                            atomic_store_memcpy!("15");
                        }
                        32 => {
                            atomic_store_memcpy!("0");
                            atomic_store_memcpy!("1");
                            atomic_store_memcpy!("2");
                            atomic_store_memcpy!("3");
                            atomic_store_memcpy!("4");
                            atomic_store_memcpy!("5");
                            atomic_store_memcpy!("6");
                            atomic_store_memcpy!("7");
                            atomic_store_memcpy!("8");
                            atomic_store_memcpy!("9");
                            atomic_store_memcpy!("10");
                            atomic_store_memcpy!("11");
                            atomic_store_memcpy!("12");
                            atomic_store_memcpy!("13");
                            atomic_store_memcpy!("14");
                            atomic_store_memcpy!("15");
                            atomic_store_memcpy!("16");
                            atomic_store_memcpy!("17");
                            atomic_store_memcpy!("18");
                            atomic_store_memcpy!("19");
                            atomic_store_memcpy!("20");
                            atomic_store_memcpy!("21");
                            atomic_store_memcpy!("22");
                            atomic_store_memcpy!("23");
                            atomic_store_memcpy!("24");
                            atomic_store_memcpy!("25");
                            atomic_store_memcpy!("26");
                            atomic_store_memcpy!("27");
                            atomic_store_memcpy!("28");
                            atomic_store_memcpy!("29");
                            atomic_store_memcpy!("30");
                            atomic_store_memcpy!("31");
                        }
                        _ => {
                            for i in 0..count {
                                asm!(
                                    // load from val to tmp
                                    concat!("mov {tmp", $val_modifier, "}, ", $ptr_size, " ptr [{val", ptr_modifier!(), "} + {i}*", $size, "]"),
                                    // (atomic) store tmp to dst
                                    concat!("mov ", $ptr_size, " ptr [{dst", ptr_modifier!(), "} + {i}*", $size, "], {tmp", $val_modifier, "}"),
                                    dst = in(reg) dst,
                                    val = in(reg) val,
                                    tmp = out($val_reg) _,
                                    i = in(reg) i,
                                    options(nostack),
                                );
                            }
                        }
                    }
                }
            }
        }
    };
}

atomic!(i8, reg_byte, "", "byte", "1");
atomic!(u8, reg_byte, "", "byte", "1");
atomic!(i16, reg, ":x", "word", "2");
atomic!(u16, reg, ":x", "word", "2");
atomic!(i32, reg, ":e", "dword", "4");
atomic!(u32, reg, ":e", "dword", "4");
#[cfg(target_arch = "x86_64")]
atomic!(i64, reg, "", "qword", "8");
#[cfg(target_arch = "x86_64")]
atomic!(u64, reg, "", "qword", "8");
#[cfg(target_pointer_width = "32")]
atomic!(isize, reg, ":e", "dword", "4");
#[cfg(target_pointer_width = "32")]
atomic!(usize, reg, ":e", "dword", "4");
#[cfg(target_pointer_width = "64")]
atomic!(isize, reg, "", "qword", "8");
#[cfg(target_pointer_width = "64")]
atomic!(usize, reg, "", "qword", "8");

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
