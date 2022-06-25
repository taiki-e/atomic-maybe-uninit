// Generated asm:
// - x86_64 https://godbolt.org/z/aW7vsqr9h
// - x86_64 (+cmpxchg16b) https://godbolt.org/z/jdYrfddjf

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

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
    ($int_type:ident, $val_reg:tt, $val_modifier:tt, $ptr_size:tt, $cmpxchg_cmp_reg:tt) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

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
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

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

                // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange`.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg
                unsafe {
                    let r: u8;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // load from old/new to $cmpxchg_cmp_reg/tmp_new
                        concat!("mov ", $cmpxchg_cmp_reg, ", ", $ptr_size, " ptr [{old", ptr_modifier!(), "}]"),
                        concat!("mov {tmp_new", $val_modifier, "}, ", $ptr_size, " ptr [{new", ptr_modifier!(), "}]"),
                        // (atomic) compare and exchange
                        // - Compare $cmpxchg_cmp_reg with dst.
                        // - If equal, ZF is set and tmp_new is loaded into dst.
                        // - Else, clear ZF and load dst into $cmpxchg_cmp_reg.
                        concat!("lock cmpxchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {tmp_new", $val_modifier, "}"),
                        // load ZF to dl
                        "sete {r}",
                        // store $cmpxchg_cmp_reg to out
                        concat!("mov ", $ptr_size, " ptr [{out", ptr_modifier!(), "}], ", $cmpxchg_cmp_reg, ""),
                        dst = in(reg) dst,
                        old = in(reg) old,
                        new = in(reg) new,
                        out = in(reg) out,
                        tmp_new = out($val_reg) _,
                        r = out(reg_byte) r,
                        out($cmpxchg_cmp_reg) _,
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    r != 0
                }
            }
        }
    };
}

atomic!(i8, reg_byte, "", "byte", "al");
atomic!(u8, reg_byte, "", "byte", "al");
atomic!(i16, reg, ":x", "word", "ax");
atomic!(u16, reg, ":x", "word", "ax");
atomic!(i32, reg, ":e", "dword", "eax");
atomic!(u32, reg, ":e", "dword", "eax");
#[cfg(target_arch = "x86_64")]
atomic!(i64, reg, "", "qword", "rax");
#[cfg(target_arch = "x86_64")]
atomic!(u64, reg, "", "qword", "rax");
#[cfg(target_pointer_width = "32")]
atomic!(isize, reg, ":e", "dword", "eax");
#[cfg(target_pointer_width = "32")]
atomic!(usize, reg, ":e", "dword", "eax");
#[cfg(target_pointer_width = "64")]
atomic!(isize, reg, "", "qword", "rax");
#[cfg(target_pointer_width = "64")]
atomic!(usize, reg, "", "qword", "rax");

#[cfg(target_arch = "x86_64")]
macro_rules! atomic128 {
    ($int_type:ident) => {
        #[cfg(target_pointer_width = "32")]
        atomic128!($int_type, "edi", "esi", "r8d", "edx");
        #[cfg(target_pointer_width = "64")]
        atomic128!($int_type, "rdi", "rsi", "r8", "rdx");
    };
    ($int_type:ident, $rdi:tt, $rsi:tt, $r8:tt, $rdx:tt) => {
        #[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must guarantee that `src` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports cmpxchg16b.
                //
                // If the value at `dst` (destination operand) and rdx:rax are equal, the
                // 128-bit value in rcx:rbx is stored in the `dst`, otherwise the value at
                // `dst` is loaded to rdx:rax.
                //
                // The ZF flag is set if the value at `dst` and rdx:rax are equal,
                // otherwise it is cleared. Other flags are unaffected.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // rbx is reserved by LLVM
                        "xchg {rbx_tmp}, rbx",
                        // (atomic) load by cmpxchg(0, 0)
                        concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                        // store current value to out
                        concat!("mov qword ptr [", $rsi, "], rax"),
                        concat!("mov qword ptr [", $rsi, " + 8], rdx"),
                        // restore rbx
                        "mov rbx, {rbx_tmp}",
                        // set old/new args of cmpxchg to 0
                        rbx_tmp = inout(reg) 0_u64 => _,
                        inout("rax") 0_u64 => _,
                        inout("rcx") 0_u64 => _,
                        inout("rdx") 0_u64 => _,
                        in($rdi) src,
                        in($rsi) out,
                        options(nostack),
                    );
                }
            }
        }
        #[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(val as usize % mem::align_of::<$int_type>() == 0);

                // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports cmpxchg16b.
                //
                // If the value at `dst` (destination operand) and rdx:rax are equal, the
                // 128-bit value in rcx:rbx is stored in the `dst`, otherwise the value at
                // `dst` is loaded to rdx:rax.
                //
                // The ZF flag is set if the value at `dst` and rdx:rax are equal,
                // otherwise it is cleared. Other flags are unaffected.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        // rbx is reserved by LLVM
                        "xchg {rbx_tmp}, rbx",
                        concat!("mov rbx, qword ptr [", $rsi, "]"),
                        concat!("mov rcx, qword ptr [", $rsi, " + 8]"),
                        // This is based on the code generated by LLVM, but it is
                        // interesting that they generate code that mixes atomic
                        // operations of different sizes.
                        concat!("mov rax, qword ptr [", $rdi, "]"),
                        concat!("mov rdx, qword ptr [", $rdi, " + 8]"),
                        // (atomic) store by CAS loop
                        "2:",
                            concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                            "jne 2b",
                        // restore rbx
                        "mov rbx, {rbx_tmp}",
                        rbx_tmp = out(reg) _,
                        out("rax") _,
                        out("rcx") _,
                        out("rdx") _,
                        in($rdi) dst,
                        in($rsi) val,
                        options(nostack),
                    );
                }
            }
        }
        #[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
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

                // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports cmpxchg16b.
                //
                // If the value at `dst` (destination operand) and rdx:rax are equal, the
                // 128-bit value in rcx:rbx is stored in the `dst`, otherwise the value at
                // `dst` is loaded to rdx:rax.
                //
                // The ZF flag is set if the value at `dst` and rdx:rax are equal,
                // otherwise it is cleared. Other flags are unaffected.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // rbx is reserved by LLVM
                        "xchg {rbx_tmp}, rbx",
                        concat!("mov rbx, qword ptr [", $rsi, "]"),
                        concat!("mov rcx, qword ptr [", $rsi, " + 8]"),
                        // This is based on the code generated by LLVM, but it is
                        // interesting that they generate code that mixes atomic
                        // operations of different sizes.
                        concat!("mov rax, qword ptr [", $rdi, "]"),
                        concat!("mov rdx, qword ptr [", $rdi, " + 8]"),
                        // (atomic) swap by CAS loop
                        "2:",
                            concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                            "jne 2b",
                        // store previous value to out
                        concat!("mov qword ptr [", $r8, "], rax"),
                        concat!("mov qword ptr [", $r8, " + 8], rdx"),
                        // restore rbx
                        "mov rbx, {rbx_tmp}",
                        rbx_tmp = out(reg) _,
                        out("rax") _,
                        out("rcx") _,
                        out("rdx") _,
                        in($rdi) dst,
                        in($rsi) val,
                        in($r8) out,
                        options(nostack),
                    );
                }
            }
        }
        #[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
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

                // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports cmpxchg16b.
                //
                // If the value at `dst` (destination operand) and rdx:rax are equal, the
                // 128-bit value in rcx:rbx is stored in the `dst`, otherwise the value at
                // `dst` is loaded to rdx:rax.
                //
                // The ZF flag is set if the value at `dst` and rdx:rax are equal,
                // otherwise it is cleared. Other flags are unaffected.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let mut r: u64;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // rbx is reserved by LLVM
                        "xchg {rbx_tmp}, rbx",
                        concat!("mov rax, qword ptr [", $rsi, "]"),
                        concat!("mov rsi, qword ptr [", $rsi, " + 8]"),
                        concat!("mov rbx, qword ptr [", $rdx, "]"),
                        concat!("mov rcx, qword ptr [", $rdx, " + 8]"),
                        "mov rdx, rsi",
                        // (atomic) compare and exchange
                        concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                        "sete cl",
                        // store previous value to out
                        concat!("mov qword ptr [", $r8, "], rax"),
                        concat!("mov qword ptr [", $r8, " + 8], rdx"),
                        // restore rbx
                        "mov rbx, {rbx_tmp}",
                        rbx_tmp = out(reg) _,
                        out("rax") _,
                        out("rcx") r,
                        lateout("rdx") _,
                        lateout("rsi") _,
                        in($rdi) dst,
                        in($rsi) old,
                        in($rdx) new,
                        in($r8) out,
                        options(nostack),
                    );
                    debug_assert!(r as u8 == 0 || r as u8 == 1, "r={}", r as u8);
                    r as u8 != 0
                }
            }
        }
    };
}

#[cfg(target_arch = "x86_64")]
atomic128!(i128);
#[cfg(target_arch = "x86_64")]
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
    #[cfg(target_arch = "x86_64")]
    test_atomic!(i64);
    #[cfg(target_arch = "x86_64")]
    test_atomic!(u64);
    #[cfg(target_arch = "x86_64")]
    #[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
    test_atomic!(i128);
    #[cfg(target_arch = "x86_64")]
    #[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
    test_atomic!(u128);

    stress_test_load_store!();
    stress_test_load_swap!();
}
