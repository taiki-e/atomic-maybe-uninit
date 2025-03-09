// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
x86 and x86_64

See arch/x86.rs for references and notes.

Generated asm:
- x86_64 https://godbolt.org/z/fvqWGT5E6
- x86_64 (+cmpxchg16b) https://godbolt.org/z/fGdj8naT9
- x86 (i686) https://godbolt.org/z/9jKcboaoG
- x86 (i686,-sse2) https://godbolt.org/z/sjYK57r96
- x86 (i586) https://godbolt.org/z/5rrzYGxPe
- x86 (i586,-x87) https://godbolt.org/z/GvcdhqxYo
*/

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
    (
        $ty:ident, $val_reg:tt, $val_modifier:tt, $ptr_size:tt, $cmpxchg_cmp_reg:tt,
        $tmp_new_reg:tt
    ) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // (atomic) load from src to tmp
                        concat!("mov {tmp", $val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "}]"),
                        // store tmp to out
                        concat!("mov ", $ptr_size, " ptr [{out", ptr_modifier!(), "}], {tmp", $val_modifier, "}"),
                        src = in(reg) src,
                        out = inout(reg) out_ptr => _,
                        tmp = lateout($val_reg) _,
                        options(nostack, preserves_flags),
                    );
                }
                out
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
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
                                options(nostack, preserves_flags),
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
                                options(nostack, preserves_flags),
                            );
                        }
                        _ => unreachable!(),
                    }
                }
            }
        }
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
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
                        out = inout(reg) out_ptr => _,
                        tmp = lateout($val_reg) _,
                        options(nostack, preserves_flags),
                    );
                }
                out
            }
        }
        #[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg)))]
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg
                unsafe {
                    let mut r: u8;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // load from old/new to $cmpxchg_cmp_reg/$tmp_new_reg
                        concat!("mov ", $cmpxchg_cmp_reg, ", ", $ptr_size, " ptr [{old", ptr_modifier!(), "}]"),
                        concat!("mov ", $tmp_new_reg, ", ", $ptr_size, " ptr [{new", ptr_modifier!(), "}]"),
                        // (atomic) CAS
                        // - Compare $cmpxchg_cmp_reg with dst.
                        // - If equal, ZF is set and $tmp_new_reg is loaded into dst.
                        // - Else, clear ZF and load dst into $cmpxchg_cmp_reg.
                        concat!("lock cmpxchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], ", $tmp_new_reg),
                        // load ZF to cl
                        "sete cl",
                        // store $cmpxchg_cmp_reg to out
                        concat!("mov ", $ptr_size, " ptr [{out", ptr_modifier!(), "}], ", $cmpxchg_cmp_reg),
                        dst = in(reg) dst,
                        old = in(reg) old,
                        new = in(reg) new,
                        out = in(reg) out_ptr,
                        out("cl") r,
                        out($cmpxchg_cmp_reg) _,
                        // Do not use `preserves_flags` because CMPXCHG modifies the ZF flag.
                        options(nostack),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

atomic!(i8, reg_byte, "", "byte", "al", "cl");
atomic!(u8, reg_byte, "", "byte", "al", "cl");
atomic!(i16, reg, ":x", "word", "ax", "cx");
atomic!(u16, reg, ":x", "word", "ax", "cx");
atomic!(i32, reg, ":e", "dword", "eax", "ecx");
atomic!(u32, reg, ":e", "dword", "eax", "ecx");
#[cfg(target_arch = "x86_64")]
atomic!(i64, reg, "", "qword", "rax", "rcx");
#[cfg(target_arch = "x86_64")]
atomic!(u64, reg, "", "qword", "rax", "rcx");
#[cfg(target_pointer_width = "32")]
atomic!(isize, reg, ":e", "dword", "eax", "ecx");
#[cfg(target_pointer_width = "32")]
atomic!(usize, reg, ":e", "dword", "eax", "ecx");
#[cfg(target_pointer_width = "64")]
atomic!(isize, reg, "", "qword", "rax", "rcx");
#[cfg(target_pointer_width = "64")]
atomic!(usize, reg, "", "qword", "rax", "rcx");

// For load/store, we can use MOVQ(SSE2)/MOVLPS(SSE) instead of CMPXCHG8B.
// Refs: https://github.com/llvm/llvm-project/blob/llvmorg-20.1.0/llvm/test/CodeGen/X86/atomic-load-store-wide.ll
#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
macro_rules! atomic64 {
    ($ty:ident) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                #[cfg(target_feature = "sse")]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports SSE.
                unsafe {
                    #[cfg(target_feature = "sse2")]
                    {
                        // atomic load is always SeqCst.
                        asm!(
                            // Refs:
                            // - https://www.felixcloutier.com/x86/movq (SSE2)
                            // - https://www.felixcloutier.com/x86/movd:movq (SSE2)
                            // - https://www.felixcloutier.com/x86/pshufd (SSE2)
                            // (atomic) load from src to tmp0
                            "movq {tmp0}, qword ptr [{src}]",
                            // extract lower 64-bits
                            "pshufd {tmp1}, {tmp0}, 85",
                            // store tmp0/tmp1 to out
                            "movd dword ptr [{out}], {tmp0}",
                            "movd dword ptr [{out} + 4], {tmp1}",
                            src = in(reg) src,
                            out = in(reg) out_ptr,
                            tmp0 = out(xmm_reg) _,
                            tmp1 = out(xmm_reg) _,
                            options(nostack, preserves_flags),
                        );
                    }
                    #[cfg(not(target_feature = "sse2"))]
                    {
                        // atomic load is always SeqCst.
                        asm!(
                            // Refs:
                            // - https://www.felixcloutier.com/x86/xorps (SSE)
                            // - https://www.felixcloutier.com/x86/movlps (SSE)
                            // - https://www.felixcloutier.com/x86/movss (SSE)
                            // - https://www.felixcloutier.com/x86/shufps (SSE)
                            "xorps {tmp}, {tmp}",
                            // (atomic) load from src to tmp
                            "movlps {tmp}, qword ptr [{src}]",
                            // store tmp to out
                            "movss dword ptr [{out}], {tmp}",
                            "shufps {tmp}, {tmp}, 85",
                            "movss dword ptr [{out} + 4], {tmp}",
                            src = in(reg) src,
                            out = in(reg) out_ptr,
                            tmp = out(xmm_reg) _,
                            options(nostack, preserves_flags),
                        );
                    }
                }
                #[cfg(not(target_feature = "sse"))]
                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        "xchg {esi_tmp}, esi", // save esi which is reserved by LLVM
                        // (atomic) load by cmpxchg(0, 0)
                        "lock cmpxchg8b qword ptr [edi]",
                        // store current value to out
                        "mov dword ptr [esi], eax",
                        "mov dword ptr [esi + 4], edx",
                        "mov esi, {esi_tmp}", // restore esi
                        esi_tmp = inout(reg) out_ptr => _,
                        // set old/new args of cmpxchg8b to 0
                        inout("eax") 0_u32 => _,
                        inout("edx") 0_u32 => _,
                        in("ebx") 0_u32,
                        in("ecx") 0_u32,
                        in("edi") src,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let val = val.as_ptr();

                #[cfg(target_feature = "sse")]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports SSE.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/movlps (SSE)
                // - https://www.felixcloutier.com/x86/xorps (SSE)
                // - https://www.felixcloutier.com/x86/movsd (SSE2)
                // - https://www.felixcloutier.com/x86/lock
                // - https://www.felixcloutier.com/x86/or
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
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::SeqCst => {
                            asm!(
                                // load from val to tmp
                                if_sse2!("", "xorps {tmp}, {tmp}"),
                                if_sse2!("movsd {tmp}, qword ptr [{val}]", "movlps {tmp}, qword ptr [{val}]"),
                                // (atomic) store tmp to dst
                                "movlps qword ptr [{dst}], {tmp}",
                                "lock or dword ptr [esp], 0", // equivalent to mfence, but doesn't require SSE2
                                dst = in(reg) dst,
                                val = in(reg) val,
                                tmp = out(xmm_reg) _,
                                // Do not use `preserves_flags` because OR modifies the OF, CF, SF, ZF, and PF flags.
                                options(nostack),
                            );
                        }
                        _ => unreachable!(),
                    }
                }
                #[cfg(not(target_feature = "sse"))]
                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic store is always SeqCst.
                    let _ = order;
                    asm!(
                        "mov ebx, dword ptr [eax]",
                        "mov ecx, dword ptr [eax + 4]",
                        // This is based on the code generated for the first load in DW RMWs by LLVM,
                        // but it is interesting that they generate code that does mixed-sized atomic access.
                        //
                        // This is not single-copy atomic reads, but this is ok because subsequent
                        // CAS will check for consistency.
                        "mov eax, dword ptr [edi]",
                        "mov edx, dword ptr [edi + 4]",
                        // (atomic) store (CAS loop)
                        "2:",
                            "lock cmpxchg8b qword ptr [edi]",
                            "jne 2b",
                        inout("eax") val => _,
                        out("edx") _,
                        out("ebx") _,
                        out("ecx") _,
                        in("edi") dst,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        "xchg {esi_tmp}, esi", // save esi which is reserved by LLVM
                        "mov ebx, dword ptr [eax]",
                        "mov ecx, dword ptr [eax + 4]",
                        // This is based on the code generated for the first load in DW RMWs by LLVM,
                        // but it is interesting that they generate code that does mixed-sized atomic access.
                        //
                        // This is not single-copy atomic reads, but this is ok because subsequent
                        // CAS will check for consistency.
                        "mov eax, dword ptr [edi]",
                        "mov edx, dword ptr [edi + 4]",
                        // (atomic) swap (CAS loop)
                        "2:",
                            "lock cmpxchg8b qword ptr [edi]",
                            "jne 2b",
                        // store previous value to out
                        "mov dword ptr [esi], eax",
                        "mov dword ptr [esi + 4], edx",
                        "mov esi, {esi_tmp}", // restore esi
                        esi_tmp = inout(reg) out_ptr => _,
                        inout("eax") val => _,
                        out("edx") _,
                        out("ebx") _,
                        out("ecx") _,
                        in("edi") dst,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg
                unsafe {
                    let mut r: u32;
                    // compare_exchange is always SeqCst.
                    asm!(
                        "xchg {esi_tmp}, esi", // save esi which is reserved by LLVM
                        "mov eax, dword ptr [edx]",
                        "mov edx, dword ptr [edx + 4]",
                        "mov ebx, dword ptr [ecx]",
                        "mov ecx, dword ptr [ecx + 4]",
                        // (atomic) CAS
                        "lock cmpxchg8b qword ptr [edi]",
                        "sete cl",
                        // store previous value to out
                        "mov dword ptr [esi], eax",
                        "mov dword ptr [esi + 4], edx",
                        "mov esi, {esi_tmp}", // restore esi
                        esi_tmp = inout(reg) out_ptr => _,
                        out("eax") _,
                        inout("edx") old => _,
                        out("ebx") _,
                        inout("ecx") new => r,
                        in("edi") dst,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                    let r = r.to_ne_bytes()[0];
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
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
    ($ty:ident) => {
        #[cfg(target_pointer_width = "32")]
        atomic128!($ty, "edi", "esi", "r8d", "edx");
        #[cfg(target_pointer_width = "64")]
        atomic128!($ty, "rdi", "rsi", "r8", "rdx");
    };
    ($ty:ident, $rdi:tt, $rsi:tt, $r8:tt, $rdx:tt) => {
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();

                // SAFETY: the caller must guarantee that `src` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports CMPXCHG16B.
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
                        "mov {rbx_tmp}, rbx", // save rbx which is reserved by LLVM
                        "xor rbx, rbx", // zeroed rbx
                        // (atomic) load by cmpxchg(0, 0)
                        concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                        // store current value to out
                        concat!("mov qword ptr [", $rsi, "], rax"),
                        concat!("mov qword ptr [", $rsi, " + 8], rdx"),
                        "mov rbx, {rbx_tmp}", // restore rbx
                        // set old/new args of cmpxchg16b to 0 (rbx is zeroed after saved to rbx_tmp, to avoid xchg)
                        rbx_tmp = out(reg) _,
                        in("rcx") 0_u64,
                        inout("rax") 0_u64 => _,
                        inout("rdx") 0_u64 => _,
                        in($rdi) src,
                        in($rsi) out_ptr,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let val = val.as_ptr();

                // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports CMPXCHG16B.
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
                        "mov {rbx_tmp}, rbx", // save rbx which is reserved by LLVM
                        concat!("mov rbx, qword ptr [", $rsi, "]"),
                        concat!("mov rcx, qword ptr [", $rsi, " + 8]"),
                        // This is based on the code generated for the first load in DW RMWs by LLVM,
                        // but it is interesting that they generate code that does mixed-sized atomic access.
                        //
                        // This is not single-copy atomic reads, but this is ok because subsequent
                        // CAS will check for consistency.
                        concat!("mov rax, qword ptr [", $rdi, "]"),
                        concat!("mov rdx, qword ptr [", $rdi, " + 8]"),
                        // (atomic) store (CAS loop)
                        "2:",
                            concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                            "jne 2b",
                        "mov rbx, {rbx_tmp}", // restore rbx
                        rbx_tmp = out(reg) _,
                        out("rax") _,
                        out("rcx") _,
                        out("rdx") _,
                        in($rdi) dst,
                        in($rsi) val,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let val = val.as_ptr();

                // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports CMPXCHG16B.
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
                        "mov {rbx_tmp}, rbx", // save rbx which is reserved by LLVM
                        concat!("mov rbx, qword ptr [", $rsi, "]"),
                        concat!("mov rcx, qword ptr [", $rsi, " + 8]"),
                        // This is based on the code generated for the first load in DW RMWs by LLVM,
                        // but it is interesting that they generate code that does mixed-sized atomic access.
                        //
                        // This is not single-copy atomic reads, but this is ok because subsequent
                        // CAS will check for consistency.
                        concat!("mov rax, qword ptr [", $rdi, "]"),
                        concat!("mov rdx, qword ptr [", $rdi, " + 8]"),
                        // (atomic) swap (CAS loop)
                        "2:",
                            concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                            "jne 2b",
                        // store previous value to out
                        concat!("mov qword ptr [", $r8, "], rax"),
                        concat!("mov qword ptr [", $r8, " + 8], rdx"),
                        "mov rbx, {rbx_tmp}", // restore rbx
                        rbx_tmp = out(reg) _,
                        out("rax") _,
                        out("rcx") _,
                        out("rdx") _,
                        in($rdi) dst,
                        in($rsi) val,
                        in($r8) out_ptr,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$ty>() == 0);
                let mut out: MaybeUninit<Self> = MaybeUninit::uninit();
                let out_ptr = out.as_mut_ptr();
                let old = old.as_ptr();
                let new = new.as_ptr();

                // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports CMPXCHG16B.
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
                        "mov {rbx_tmp}, rbx", // save rbx which is reserved by LLVM
                        concat!("mov rax, qword ptr [", $rsi, "]"),
                        concat!("mov rsi, qword ptr [", $rsi, " + 8]"),
                        concat!("mov rbx, qword ptr [", $rdx, "]"),
                        concat!("mov rcx, qword ptr [", $rdx, " + 8]"),
                        "mov rdx, rsi",
                        // (atomic) CAS
                        concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                        "sete cl",
                        // store previous value to out
                        concat!("mov qword ptr [", $r8, "], rax"),
                        concat!("mov qword ptr [", $r8, " + 8], rdx"),
                        "mov rbx, {rbx_tmp}", // restore rbx
                        rbx_tmp = out(reg) _,
                        out("rax") _,
                        out("rcx") r,
                        lateout("rdx") _,
                        lateout("rsi") _,
                        in($rdi) dst,
                        in($rsi) old,
                        in($rdx) new,
                        in($r8) out_ptr,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                    let r = r.to_ne_bytes()[0];
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
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

// -----------------------------------------------------------------------------
// cfg macros

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
#[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg8b)))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg8b)))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg8b))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg8b))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(all(
    target_arch = "x86_64",
    any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"),
)))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    target_arch = "x86_64",
    any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"),
)))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "x86_64",
    any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"),
))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "x86_64",
    any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"),
))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg)))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg)))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
