// SPDX-License-Identifier: Apache-2.0 OR MIT

// x86 and x86_64
//
// Refs:
// - x86 and amd64 instruction reference https://www.felixcloutier.com/x86
// - portable-atomic https://github.com/taiki-e/portable-atomic
//
// Generated asm:
// - x86_64 https://godbolt.org/z/4j1brEoKq
// - x86_64 (+cmpxchg16b) https://godbolt.org/z/6j3oTKMn7
// - x86 (i686) https://godbolt.org/z/Ehx43oKef
// - x86 (i686,-sse2) https://godbolt.org/z/PzdGrvM98
// - x86 (i586) https://godbolt.org/z/4cj5qcGo9
// - x86 (i586,-x87) https://godbolt.org/z/41vGvY3j6
// - x86 (i486) https://godbolt.org/z/a5YjTPvxd
// - x86 (i386) https://godbolt.org/z/ovoYPW8jc

#[path = "cfgs/x86.rs"]
mod cfgs;

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};
#[cfg(target_arch = "x86_64")]
#[cfg(any(target_feature = "cmpxchg16b", atomic_maybe_uninit_target_feature = "cmpxchg16b"))]
use crate::utils::{MaybeUninit128, Pair};
#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
use crate::utils::{MaybeUninit64, Pair};

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
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        // (atomic) load from src to out
                        concat!("mov {out", $val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "}]"),
                        src = in(reg) src,
                        out = lateout($val_reg) out,
                        options(nostack, preserves_flags),
                    );
                }
                out
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {
                            asm!(
                                // (atomic) store val to dst
                                concat!("mov ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {val", $val_modifier, "}"),
                                dst = in(reg) dst,
                                val = in($val_reg) val,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::SeqCst => {
                            asm!(
                                // (atomic) store val to dst (SeqCst store is xchg, not mov)
                                concat!("xchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {val", $val_modifier, "}"),
                                dst = in(reg) dst,
                                val = inout($val_reg) val => _,
                                options(nostack, preserves_flags),
                            );
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
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // (atomic) swap val and dst
                        concat!("xchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {val", $val_modifier, "}"),
                        dst = in(reg) dst,
                        val = inout($val_reg) val => out,
                        options(nostack, preserves_flags),
                    );
                }
                out
            }
        }
        #[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg)))]
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg
                unsafe {
                    let r: u8;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // (atomic) CAS
                        // - Compare $cmpxchg_cmp_reg with dst.
                        // - If equal, ZF is set and new is loaded into dst.
                        // - Else, clear ZF and load dst into $cmpxchg_cmp_reg.
                        concat!("lock cmpxchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {new", $val_modifier, "}"),
                        // load ZF to r
                        "sete {r}",
                        dst = in(reg) dst,
                        new = in($val_reg) new,
                        r = out(reg_byte) r,
                        inout($cmpxchg_cmp_reg) old => out,
                        // Do not use `preserves_flags` because CMPXCHG modifies the ZF, CF, PF, AF, SF, and OF flags.
                        options(nostack),
                    );
                    debug_assert!(r == 0 || r == 1, "r={}", r);
                    (out, r != 0)
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

// For load/store, we can use MOVQ(SSE2)/MOVLPS(SSE) instead of CMPXCHG8B.
// Refs: https://github.com/llvm/llvm-project/blob/llvmorg-17.0.0-rc2/llvm/test/CodeGen/X86/atomic-load-store-wide.ll
#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
macro_rules! atomic64 {
    ($int_type:ident) => {
        impl AtomicLoad for $int_type {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);

                #[cfg(target_feature = "sse")]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports SSE.
                unsafe {
                    let mut out: MaybeUninit<core::arch::x86::__m128>;
                    #[cfg(target_feature = "sse2")]
                    {
                        // atomic load is always SeqCst.
                        asm!(
                            // Refs:
                            // - https://www.felixcloutier.com/x86/movq (SSE2)
                            // - https://www.felixcloutier.com/x86/movd:movq (SSE2)
                            // (atomic) load from src to out
                            "movq {out}, qword ptr [{src}]",
                            src = in(reg) src,
                            out = out(xmm_reg) out,
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
                            "xorps {out}, {out}",
                            // (atomic) load from src to out
                            "movlps {out}, qword ptr [{src}]",
                            src = in(reg) src,
                            out = out(xmm_reg) out,
                            options(nostack, preserves_flags),
                        );
                    }
                    core::mem::transmute::<_, [MaybeUninit<Self>; 2]>(out)[0]
                }
                #[cfg(not(target_feature = "sse"))]
                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let (prev_lo, prev_hi);
                    // atomic load is always SeqCst.
                    asm!(
                        // (atomic) load by cmpxchg(0, 0)
                        "lock cmpxchg8b qword ptr [edi]",
                        // set old/new args of cmpxchg8b to 0
                        in("ebx") 0_u32,
                        in("ecx") 0_u32,
                        inout("eax") 0_u32 => prev_lo,
                        inout("edx") 0_u32 => prev_hi,
                        in("edi") src,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);

                #[cfg(target_feature = "sse")]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports SSE.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/movlps (SSE)
                // - https://www.felixcloutier.com/x86/lock
                // - https://www.felixcloutier.com/x86/or
                unsafe {
                    let val: MaybeUninit<core::arch::x86::__m128>
                        = core::mem::transmute([val, MaybeUninit::uninit()]);
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {
                            asm!(
                                // (atomic) store val to dst
                                "movlps qword ptr [{dst}], {val}",
                                dst = in(reg) dst,
                                val = in(xmm_reg) val,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::SeqCst => {
                            let p = core::cell::UnsafeCell::new(0_u32);
                            asm!(
                                // (atomic) store val to dst
                                "movlps qword ptr [{dst}], {val}",
                                "lock or dword ptr [{p}], 0", // equivalent to mfence, but doesn't require SSE2
                                dst = in(reg) dst,
                                val = in(xmm_reg) val,
                                p = in(reg) p.get(),
                                // Do not use `preserves_flags` because OR modifies the OF, CF, SF, ZF, and PF flags.
                                options(nostack),
                            );
                        }
                        _ => unreachable!("{:?}", order),
                    }
                }
                #[cfg(not(target_feature = "sse"))]
                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let val = MaybeUninit64 { $int_type: val };
                    // atomic store is always SeqCst.
                    let _ = order;
                    asm!(
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
                        in("ebx") val.pair.lo,
                        in("ecx") val.pair.hi,
                        out("eax") _,
                        out("edx") _,
                        in("edi") dst,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit64 { $int_type: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
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
                        in("ebx") val.pair.lo,
                        in("ecx") val.pair.hi,
                        out("eax") prev_lo,
                        out("edx") prev_hi,
                        in("edi") dst,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let old = MaybeUninit64 { $int_type: old };
                let new = MaybeUninit64 { $int_type: new };
                let (prev_lo, prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let r: u32;
                    // compare_exchange is always SeqCst.
                    asm!(
                        // (atomic) CAS
                        "lock cmpxchg8b qword ptr [edi]",
                        "sete cl",
                        in("ebx") new.pair.lo,
                        inout("ecx") new.pair.hi => r,
                        inout("eax") old.pair.lo => prev_lo,
                        inout("edx") old.pair.hi => prev_hi,
                        in("edi") dst,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                    debug_assert!(r as u8 == 0 || r as u8 == 1, "r={}", r as u8);
                    (
                        MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type,
                        r as u8 != 0
                    )
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
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(src as usize % mem::size_of::<$int_type>() == 0);
                let (prev_lo, prev_hi);

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
                        // rbx is reserved by LLVM
                        "mov {rbx_tmp}, rbx",
                        "xor rbx, rbx", // zeroed rbx
                        // (atomic) load by cmpxchg(0, 0)
                        concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                        "mov rbx, {rbx_tmp}", // restore rbx
                        // set old/new args of cmpxchg16b to 0 (rbx is zeroed after saved to rbx_tmp, to avoid xchg)
                        rbx_tmp = out(reg) _,
                        in("rcx") 0_u64,
                        inout("rax") 0_u64 => prev_lo,
                        inout("rdx") 0_u64 => prev_hi,
                        in($rdi) src,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        impl AtomicStore for $int_type {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit128 { $int_type: val };

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
                        // rbx is reserved by LLVM
                        "xchg {rbx_tmp}, rbx",
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
                        rbx_tmp = inout(reg) val.pair.lo => _,
                        in("rcx") val.pair.hi,
                        out("rax") _,
                        out("rdx") _,
                        in($rdi) dst,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                }
            }
        }
        impl AtomicSwap for $int_type {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let val = MaybeUninit128 { $int_type: val };
                let (mut prev_lo, mut prev_hi);

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
                        // rbx is reserved by LLVM
                        "xchg {rbx_tmp}, rbx",
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
                        "mov rbx, {rbx_tmp}", // restore rbx
                        rbx_tmp = inout(reg) val.pair.lo => _,
                        in("rcx") val.pair.hi,
                        out("rax") prev_lo,
                        out("rdx") prev_hi,
                        in($rdi) dst,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type
                }
            }
        }
        impl AtomicCompareExchange for $int_type {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                _failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert!(dst as usize % mem::size_of::<$int_type>() == 0);
                let old = MaybeUninit128 { $int_type: old };
                let new = MaybeUninit128 { $int_type: new };
                let (prev_lo, prev_hi);

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
                        // rbx is reserved by LLVM
                        "xchg {rbx_tmp}, rbx",
                        // (atomic) CAS
                        concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"),
                        "sete cl",
                        "mov rbx, {rbx_tmp}", // restore rbx
                        rbx_tmp = inout(reg) new.pair.lo => _,
                        inout("rcx") new.pair.hi => r,
                        inout("rax") old.pair.lo => prev_lo,
                        inout("rdx") old.pair.hi => prev_hi,
                        in($rdi) dst,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                    debug_assert!(r as u8 == 0 || r as u8 == 1, "r={}", r as u8);
                    (
                        MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.$int_type,
                        r as u8 != 0
                    )
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
