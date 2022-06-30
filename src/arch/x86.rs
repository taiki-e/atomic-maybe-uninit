// Generated asm:
// - x86_64 https://godbolt.org/z/bPaTcc155
// - x86_64 (+cmpxchg16b) https://godbolt.org/z/9Y5zherqE
// - x86 (i686) https://godbolt.org/z/9bcoEzY1x
// - x86 (i686,-sse2) https://godbolt.org/z/Wj8h3Pcdv
// - x86 (i586) https://godbolt.org/z/8W65E8ohs
// - x86 (i486) https://godbolt.org/z/63feGWrne
// - x86 (i386) https://godbolt.org/z/6qnf41j68

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

#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
#[cfg(target_feature = "sse")]
#[cfg(target_feature = "sse2")]
macro_rules! if_sse2 {
    ($then:expr, $else:expr) => {
        $then
    };
}
#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
#[cfg(target_feature = "sse")]
#[cfg(not(target_feature = "sse2"))]
macro_rules! if_sse2 {
    ($then:expr, $else:expr) => {
        $else
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
        #[cfg(not(atomic_maybe_uninit_no_cmpxchg))]
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

#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
macro_rules! atomic64 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                debug_assert!(out as usize % mem::align_of::<$int_type>() == 0);

                #[cfg(target_feature = "sse")]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                // cfg guarantees that the CPU supports SSE.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/movlps (SSE)
                // - https://www.felixcloutier.com/x86/shufps (SSE)
                // - https://www.felixcloutier.com/x86/movq (SSE2)
                // - https://www.felixcloutier.com/x86/pshufd (SSE2)
                // - https://github.com/llvm/llvm-project/blob/016342e319fd31e41cf5ed16a6140a8ea2de74dd/llvm/lib/Target/X86/X86ISelLowering.cpp
                unsafe {
                    if cfg!(target_feature = "sse2") {
                        // atomic load is always SeqCst.
                        asm!(
                            // (atomic) load from src to tmp0
                            "movq {tmp0}, qword ptr [{src}]",
                            // extract lower 64-bits
                            "pshufd {tmp1}, {tmp0}, 85",
                            // store tmp0/tmp1 to out
                            "movd dword ptr [{out}], {tmp0}",
                            "movd dword ptr [{out} + 4], {tmp1}",
                            src = in(reg) src,
                            out = in(reg) out,
                            tmp0 = out(xmm_reg) _,
                            tmp1 = out(xmm_reg) _,
                            options(nostack),
                        );
                    } else {
                        // atomic load is always SeqCst.
                        asm!(
                            "xorps {tmp}, {tmp}",
                            // (atomic) load from src to tmp
                            "movlps {tmp}, qword ptr [{src}]",
                            // store tmp to out
                            "movss dword ptr [{out}], {tmp}",
                            "shufps {tmp}, {tmp}, 85",
                            "movss dword ptr [{out} + 4], {tmp}",
                            src = in(reg) src,
                            out = in(reg) out,
                            tmp = out(xmm_reg) _,
                            options(nostack),
                        );
                    }
                }
                #[cfg(not(target_feature = "sse"))]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // esi is reserved by LLVM
                        "xchg {esi_tmp}, esi",
                        // (atomic) load by cmpxchg(0, 0)
                        "lock cmpxchg8b qword ptr [edi]",
                        // store current value to out
                        "mov dword ptr [esi], eax",
                        "mov dword ptr [esi + 4], edx",
                        // restore esi
                        "mov esi, {esi_tmp}",
                        esi_tmp = inout(reg) out => _,
                        // set old/new args of cmpxchg to 0
                        inout("eax") 0_u32 => _,
                        inout("ebx") 0_u32 => _,
                        inout("ecx") 0_u32 => _,
                        inout("edx") 0_u32 => _,
                        in("edi") src,
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

                #[cfg(target_feature = "sse")]
                // SAFETY: the caller must uphold the safety contract for `atomic_store`.
                // cfg guarantees that the CPU supports SSE.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/movlps (SSE)
                // - https://www.felixcloutier.com/x86/movsd (SSE2)
                // - https://github.com/llvm/llvm-project/blob/016342e319fd31e41cf5ed16a6140a8ea2de74dd/llvm/lib/Target/X86/X86ISelLowering.cpp
                unsafe {
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {
                            asm!(
                                if_sse2!("", "xorps {tmp}, {tmp}"),
                                // load from val to tmp
                                if_sse2!("movsd {tmp}, qword ptr [{val}]", "movlps {tmp}, qword ptr [{val}]"),
                                // (atomic) store tmp to dst
                                "movlps qword ptr [{dst}], {tmp}",
                                dst = in(reg) dst,
                                val = in(reg) val,
                                tmp = out(xmm_reg) _,
                                options(nostack),
                            );
                        }
                        Ordering::SeqCst => {
                            let p = core::cell::UnsafeCell::new(0_u32);
                            asm!(
                                // load from val to tmp
                                if_sse2!("", "xorps {tmp}, {tmp}"),
                                if_sse2!("movsd {tmp}, qword ptr [{val}]", "movlps {tmp}, qword ptr [{val}]"),
                                // (atomic) store tmp to dst
                                "movlps qword ptr [{dst}], {tmp}",
                                "lock or dword ptr [{p}], 0", // equivalent to mfence
                                dst = in(reg) dst,
                                val = in(reg) val,
                                tmp = out(xmm_reg) _,
                                p = in(reg) p.get(),
                                options(nostack),
                            );
                        }
                        _ => unreachable_unchecked!("{:?}", order),
                    }
                }
                #[cfg(not(target_feature = "sse"))]
                // SAFETY: the caller must uphold the safety contract for `atomic_load`.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic store is always SeqCst.
                    let _ = order;
                    asm!(
                        "mov ebx, dword ptr [eax]",
                        "mov ecx, dword ptr [eax + 4]",
                        // This is based on the code generated by LLVM, but it is
                        // interesting that they generate code that mixes atomic
                        // operations of different sizes.
                        "mov eax, dword ptr [edi]",
                        "mov edx, dword ptr [edi + 4]",
                        // (atomic) store by CAS loop
                        "2:",
                            "lock cmpxchg8b qword ptr [edi]",
                            "jne 2b",
                        inout("eax") val => _,
                        out("ebx") _,
                        out("ecx") _,
                        out("edx") _,
                        in("edi") dst,
                        options(nostack),
                    );
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
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        // esi is reserved by LLVM
                        "xchg {esi_tmp}, esi",
                        "mov ebx, dword ptr [eax]",
                        "mov ecx, dword ptr [eax + 4]",
                        // This is based on the code generated by LLVM, but it is
                        // interesting that they generate code that mixes atomic
                        // operations of different sizes.
                        "mov eax, dword ptr [edi]",
                        "mov edx, dword ptr [edi + 4]",
                        // (atomic) store by CAS loop
                        "2:",
                            "lock cmpxchg8b qword ptr [edi]",
                            "jne 2b",
                        // store previous value to out
                        "mov dword ptr [esi], eax",
                        "mov dword ptr [esi + 4], edx",
                        // restore esi
                        "mov esi, {esi_tmp}",
                        esi_tmp = inout(reg) out => _,
                        inout("eax") val => _,
                        out("ebx") _,
                        out("ecx") _,
                        out("edx") _,
                        in("edi") dst,
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
                    let mut r: u32;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // esi is reserved by LLVM
                        "xchg {esi_tmp}, esi",
                        "mov eax, dword ptr [edx]",
                        "mov edx, dword ptr [edx + 4]",
                        "mov ebx, dword ptr [ecx]",
                        "mov ecx, dword ptr [ecx + 4]",
                        // (atomic) compare and exchange
                        "lock cmpxchg8b qword ptr [edi]",
                        "sete cl",
                        // store previous value to out
                        "mov dword ptr [esi], eax",
                        "mov dword ptr [esi + 4], edx",
                        // restore rbx
                        "mov esi, {esi_tmp}",
                        esi_tmp = inout(reg) out => _,
                        out("eax") _,
                        out("ebx") _,
                        inout("ecx") new => r,
                        inout("edx") old => _,
                        in("edi") dst,
                        options(nostack),
                    );
                    debug_assert!(r as u8 == 0 || r as u8 == 1, "r={}", r as u8);
                    r as u8 != 0
                }
            }
        }
    };
}

#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
atomic64!(i64);
#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
atomic64!(u64);

#[cfg(target_arch = "x86_64")]
#[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
macro_rules! atomic128 {
    ($int_type:ident) => {
        #[cfg(target_pointer_width = "32")]
        atomic128!($int_type, "edi", "esi", "r8d", "edx");
        #[cfg(target_pointer_width = "64")]
        atomic128!($int_type, "rdi", "rsi", "r8", "rdx");
    };
    ($int_type:ident, $rdi:tt, $rsi:tt, $r8:tt, $rdx:tt) => {
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
#[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
atomic128!(i128);
#[cfg(target_arch = "x86_64")]
#[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
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
    #[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
    test_atomic!(i64);
    #[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
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
