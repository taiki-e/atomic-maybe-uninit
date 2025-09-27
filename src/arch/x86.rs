// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
x86 and x86_64

Refs:
- x86 and amd64 instruction reference https://www.felixcloutier.com/x86
- portable-atomic https://github.com/taiki-e/portable-atomic

Generated asm:
- x86_64 https://godbolt.org/z/xKzj4WcaE
- x86_64 (+cmpxchg16b) https://godbolt.org/z/jzMoM9nhq
- x86 (i686) https://godbolt.org/z/sM6MPjYWf
- x86 (i686,-sse2) https://godbolt.org/z/MsrxfbcMG
- x86 (i586) https://godbolt.org/z/KEo6P7YEo
- x86 (i586,-x87) https://godbolt.org/z/P8cdjY7h1
*/

delegate_size!(delegate_load_store);
delegate_size!(delegate_swap);
#[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg)))]
delegate_size!(delegate_cas);

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

#[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg)))]
use crate::raw::AtomicCompareExchange;
use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};
#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
use crate::utils::{MaybeUninit64, Pair};
#[cfg(target_arch = "x86_64")]
#[cfg(target_feature = "cmpxchg16b")]
use crate::utils::{MaybeUninit128, Pair};

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
    (
        $ty:ident, $val_reg:tt, $val_modifier:tt, $ptr_size:tt, $cmpxchg_cmp_reg:tt,
        $new_reg:tt
    ) => {
        delegate_signed!(delegate_load_store, $ty);
        delegate_signed!(delegate_swap, $ty);
        #[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg)))]
        delegate_signed!(delegate_cas, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        concat!("mov {out", $val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "}]"), // atomic { out = *src }
                        src = in(reg) src,
                        out = lateout($val_reg) out,
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
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {
                            asm!(
                                concat!("mov ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {val", $val_modifier, "}"), // atomic { *dst = val }
                                dst = in(reg) dst,
                                val = in($val_reg) val,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::SeqCst => {
                            asm!(
                                // SeqCst store is xchg, not mov
                                concat!("xchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {val", $val_modifier, "}"), // atomic { _x = *dst; *dst = val; val = _x }
                                dst = in(reg) dst,
                                val = inout($val_reg) val => _,
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
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        concat!("xchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {val", $val_modifier, "}"), // atomic { _x = *dst; *dst = val; val = _x }
                        dst = in(reg) dst,
                        val = inout($val_reg) val => out,
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
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg
                unsafe {
                    let r: u8;
                    // compare_exchange is always SeqCst.
                    asm!(
                        concat!("lock cmpxchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], ", $new_reg), // atomic { if *dst == $cmpxchg_cmp_reg { ZF = 1; *dst = $new_reg } else { ZF = 0; $cmpxchg_cmp_reg = *dst } }
                        "sete cl",                                                                            // cl = ZF
                        dst = in(reg) dst,
                        in($new_reg) new,
                        lateout("cl") r,
                        inout($cmpxchg_cmp_reg) old => out,
                        // Do not use `preserves_flags` because CMPXCHG modifies the ZF, CF, PF, AF, SF, and OF flags.
                        options(nostack),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

atomic!(u8, reg_byte, "", "byte", "al", "cl");
atomic!(u16, reg, ":x", "word", "ax", "cx");
atomic!(u32, reg, ":e", "dword", "eax", "ecx");
#[cfg(target_arch = "x86_64")]
atomic!(u64, reg, "", "qword", "rax", "rcx");

// For load/store, we can use MOVQ(SSE2)/MOVLPS(SSE)/FILD&FISTP(x87) instead of CMPXCHG8B.
// Refs: https://github.com/llvm/llvm-project/blob/llvmorg-21.1.0/llvm/test/CodeGen/X86/atomic-load-store-wide.ll
#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
macro_rules! atomic64 {
    ($ty:ident) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);

                #[cfg(all(
                    target_feature = "sse2",
                    not(atomic_maybe_uninit_test_prefer_x87_over_sse),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports SSE.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/movq (SSE2)
                // - https://www.felixcloutier.com/x86/movd:movq (SSE2)
                unsafe {
                    let out;
                    // atomic load is always SeqCst.
                    asm!(
                        "movq {out}, qword ptr [{src}]", // atomic { out[:] = *src }
                        src = in(reg) src,
                        out = out(xmm_reg) out,
                        options(nostack, preserves_flags),
                    );
                    mem::transmute::<
                        MaybeUninit<core::arch::x86::__m128i>,
                        [MaybeUninit<Self>; 2],
                    >(out)[0]
                }
                #[cfg(all(
                    not(target_feature = "sse2"),
                    target_feature = "sse",
                    not(atomic_maybe_uninit_test_prefer_x87_over_sse),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports SSE.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/movlps (SSE)
                unsafe {
                    let out;
                    // atomic load is always SeqCst.
                    asm!(
                        "movlps {out}, qword ptr [{src}]", // atomic { out[:] = *src }
                        src = in(reg) src,
                        out = out(xmm_reg) out,
                        options(nostack, preserves_flags),
                    );
                    mem::transmute::<
                        MaybeUninit<core::arch::x86::__m128>,
                        [MaybeUninit<Self>; 2],
                    >(out)[0]
                }
                #[cfg(all(
                    any(
                        not(target_feature = "sse"),
                        atomic_maybe_uninit_test_prefer_x87_over_sse,
                    ),
                    all(
                        any(target_feature = "x87", atomic_maybe_uninit_target_feature = "x87"),
                        not(atomic_maybe_uninit_test_prefer_cmpxchg8b_over_x87),
                    ),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/fild
                // - https://www.felixcloutier.com/x86/fist:fistp
                unsafe {
                    let mut out = MaybeUninit::<Self>::uninit();
                    // atomic load is always SeqCst.
                    asm!(
                        "fild qword ptr [{src}]",  // atomic { st.push(*src) }
                        "fistp qword ptr [{out}]", // *out = st.pop()
                        src = in(reg) src,
                        out = in(reg) out.as_mut_ptr(),
                        out("st(0)") _,
                        out("st(1)") _,
                        out("st(2)") _,
                        out("st(3)") _,
                        out("st(4)") _,
                        out("st(5)") _,
                        out("st(6)") _,
                        out("st(7)") _,
                        // Do not use `preserves_flags` because FILD and FISTP modify C1 in x87 FPU status word.
                        options(nostack),
                    );
                    out
                }
                #[cfg(all(
                    any(
                        not(target_feature = "sse"),
                        atomic_maybe_uninit_test_prefer_x87_over_sse,
                    ),
                    not(all(
                        any(target_feature = "x87", atomic_maybe_uninit_target_feature = "x87"),
                        not(atomic_maybe_uninit_test_prefer_cmpxchg8b_over_x87),
                    )),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let (prev_lo, prev_hi);
                    // atomic load is always SeqCst.
                    asm!(
                        "lock cmpxchg8b qword ptr [edi]", // atomic { if *edi == edx:eax { ZF = 1; *edi = ecx:ebx } else { ZF = 0; edx:eax = *edi } }
                        // set old/new args of CMPXCHG8B to 0
                        in("ebx") 0_u32,
                        in("ecx") 0_u32,
                        inout("eax") 0_u32 => prev_lo,
                        inout("edx") 0_u32 => prev_hi,
                        in("edi") src,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                }
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

                #[cfg(all(
                    target_feature = "sse",
                    not(atomic_maybe_uninit_test_prefer_x87_over_sse),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports SSE.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/movlps (SSE)
                // - https://www.felixcloutier.com/x86/lock
                // - https://www.felixcloutier.com/x86/or
                unsafe {
                    let val: MaybeUninit<core::arch::x86::__m128>
                        = mem::transmute([val, MaybeUninit::uninit()]);
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {
                            asm!(
                                "movlps qword ptr [{dst}], {val}", // atomic { *dst = val[:] }
                                dst = in(reg) dst,
                                val = in(xmm_reg) val,
                                options(nostack, preserves_flags),
                            );
                        }
                        Ordering::SeqCst => {
                            let p = core::cell::UnsafeCell::new(MaybeUninit::<u32>::uninit());
                            asm!(
                                "movlps qword ptr [{dst}], {val}", // atomic { *dst = val[:] }
                                // Equivalent to `mfence`, but is up to 3.1x faster on Coffee Lake and up to 2.4x faster on Raptor Lake-H at least in simple cases.
                                // - https://github.com/taiki-e/portable-atomic/pull/156
                                // - LLVM uses `lock or` for x86_32 64-bit atomic SeqCst store using SSE https://godbolt.org/z/9sKEr8YWc
                                // - Windows uses `xchg` for x86_32 for MemoryBarrier https://learn.microsoft.com/en-us/windows/win32/api/winnt/nf-winnt-memorybarrier
                                // - MSVC STL uses `lock inc` https://github.com/microsoft/STL/pull/740
                                // - boost uses `lock or` https://github.com/boostorg/atomic/commit/559eba81af71386cedd99f170dc6101c6ad7bf22
                                "xchg dword ptr [{p}], {tmp}",     // fence
                                dst = in(reg) dst,
                                val = in(xmm_reg) val,
                                p = inout(reg) p.get() => _,
                                tmp = lateout(reg) _,
                                options(nostack, preserves_flags),
                            );
                        }
                        _ => unreachable!(),
                    }
                }
                #[cfg(all(
                    any(
                        not(target_feature = "sse"),
                        atomic_maybe_uninit_test_prefer_x87_over_sse,
                    ),
                    all(
                        any(target_feature = "x87", atomic_maybe_uninit_target_feature = "x87"),
                        not(atomic_maybe_uninit_test_prefer_cmpxchg8b_over_x87),
                    ),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/fild
                // - https://www.felixcloutier.com/x86/fist:fistp
                unsafe {
                    match order {
                        // Relaxed and Release stores are equivalent.
                        Ordering::Relaxed | Ordering::Release => {
                            asm!(
                                "fild qword ptr [{val}]",  // st.push(*val)
                                "fistp qword ptr [{dst}]", // atomic { *dst = st.pop() }
                                dst = in(reg) dst,
                                val = in(reg) val.as_ptr(),
                                out("st(0)") _,
                                out("st(1)") _,
                                out("st(2)") _,
                                out("st(3)") _,
                                out("st(4)") _,
                                out("st(5)") _,
                                out("st(6)") _,
                                out("st(7)") _,
                                // Do not use `preserves_flags` because FILD and FISTP modify condition code flags in x87 FPU status word.
                                options(nostack),
                            );
                        }
                        Ordering::SeqCst => {
                            let p = core::cell::UnsafeCell::new(MaybeUninit::<u32>::uninit());
                            asm!(
                                "fild qword ptr [{val}]",      // st.push(*val)
                                "fistp qword ptr [{dst}]",     // atomic { *dst = st.pop() }
                                // Equivalent to `mfence`, but is up to 3.1x faster on Coffee Lake and up to 2.4x faster on Raptor Lake-H at least in simple cases.
                                // - https://github.com/taiki-e/portable-atomic/pull/156
                                // - LLVM uses `lock or` for x86_32 64-bit atomic SeqCst store using SSE https://godbolt.org/z/9sKEr8YWc
                                // - Windows uses `xchg` for x86_32 for MemoryBarrier https://learn.microsoft.com/en-us/windows/win32/api/winnt/nf-winnt-memorybarrier
                                // - MSVC STL uses `lock inc` https://github.com/microsoft/STL/pull/740
                                // - boost uses `lock or` https://github.com/boostorg/atomic/commit/559eba81af71386cedd99f170dc6101c6ad7bf22
                                "xchg dword ptr [{p}], {tmp}", // fence
                                dst = in(reg) dst,
                                val = in(reg) val.as_ptr(),
                                p = inout(reg) p.get() => _,
                                tmp = lateout(reg) _,
                                out("st(0)") _,
                                out("st(1)") _,
                                out("st(2)") _,
                                out("st(3)") _,
                                out("st(4)") _,
                                out("st(5)") _,
                                out("st(6)") _,
                                out("st(7)") _,
                                // Do not use `preserves_flags` because FILD and FISTP modify condition code flags in x87 FPU status word.
                                options(nostack),
                            );
                        }
                        _ => unreachable!(),
                    }
                }
                #[cfg(all(
                    any(
                        not(target_feature = "sse"),
                        atomic_maybe_uninit_test_prefer_x87_over_sse,
                    ),
                    not(all(
                        any(target_feature = "x87", atomic_maybe_uninit_target_feature = "x87"),
                        not(atomic_maybe_uninit_test_prefer_cmpxchg8b_over_x87),
                    )),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let val = MaybeUninit64 { whole: val };
                    // atomic store by CMPXCHG8B is always SeqCst.
                    let _ = order;
                    asm!(
                        // This is based on the code generated for the first load in DW RMWs by LLVM,
                        // but it is interesting that they generate code that does mixed-sized atomic access.
                        //
                        // This is not single-copy atomic reads, but this is ok because subsequent
                        // CAS will check for consistency.
                        "mov eax, dword ptr [edi]",           // atomic { eax = *edi }
                        "mov edx, dword ptr [edi + 4]",       // atomic { edx = *edi.byte_add(4) }
                        "2:", // 'retry:
                            "lock cmpxchg8b qword ptr [edi]", // atomic { if *edi == edx:eax { ZF = 1; *edi = ecx:ebx } else { ZF = 0; edx:eax = *edi } }
                            "jne 2b",                         // if ZF == 0 { jump 'retry }
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
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit64 { whole: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        // This is based on the code generated for the first load in DW RMWs by LLVM,
                        // but it is interesting that they generate code that does mixed-sized atomic access.
                        //
                        // This is not single-copy atomic reads, but this is ok because subsequent
                        // CAS will check for consistency.
                        "mov eax, dword ptr [edi]",           // atomic { eax = *edi }
                        "mov edx, dword ptr [edi + 4]",       // atomic { edx = *edi.byte_add(4) }
                        "2:", // 'retry:
                            "lock cmpxchg8b qword ptr [edi]", // atomic { if *edi == edx:eax { ZF = 1; *edi = ecx:ebx } else { ZF = 0; edx:eax = *edi } }
                            "jne 2b",                         // if ZF == 0 { jump 'retry }
                        in("ebx") val.pair.lo,
                        in("ecx") val.pair.hi,
                        out("eax") prev_lo,
                        out("edx") prev_hi,
                        in("edi") dst,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                    MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                }
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
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let old = MaybeUninit64 { whole: old };
                let new = MaybeUninit64 { whole: new };
                let (prev_lo, prev_hi);

                // SAFETY: the caller must uphold the safety contract.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let r: u8;
                    // compare_exchange is always SeqCst.
                    asm!(
                        "lock cmpxchg8b qword ptr [edi]", // atomic { if *edi == edx:eax { ZF = 1; *edi = ecx:ebx } else { ZF = 0; edx:eax = *edi } }
                        "sete cl",                        // cl = ZF
                        in("ebx") new.pair.lo,
                        in("ecx") new.pair.hi,
                        inout("eax") old.pair.lo => prev_lo,
                        inout("edx") old.pair.hi => prev_hi,
                        in("edi") dst,
                        lateout("cl") r,
                        // Do not use `preserves_flags` because CMPXCHG8B modifies the ZF flag.
                        options(nostack),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (
                        MaybeUninit64 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole,
                        r != 0
                    )
                }
            }
        }
    };
}

#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
atomic64!(u64);

#[cfg(target_arch = "x86_64")]
#[cfg(target_feature = "cmpxchg16b")]
macro_rules! atomic128 {
    ($ty:ident) => {
        #[cfg(target_pointer_width = "32")]
        atomic128!($ty, "edi");
        #[cfg(target_pointer_width = "64")]
        atomic128!($ty, "rdi");
    };
    ($ty:ident, $rdi:tt) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let (prev_lo, prev_hi);

                // SAFETY: the caller must guarantee that `src` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports CMPXCHG16B.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic load is always SeqCst.
                    asm!(
                        "mov {rbx_tmp}, rbx", // save rbx which is reserved by LLVM
                        "xor rbx, rbx",       // zeroed rbx
                        concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"), // atomic { if *$rdi == rdx:rax { ZF = 1; *$rdi = rcx:rbx } else { ZF = 0; rdx:rax = *$rdi } }
                        "mov rbx, {rbx_tmp}", // restore rbx
                        // set old/new args of CMPXCHG16B to 0 (rbx is zeroed after saved to rbx_tmp, to avoid xchg)
                        rbx_tmp = out(reg) _,
                        in("rcx") 0_u64,
                        inout("rax") 0_u64 => prev_lo,
                        inout("rdx") 0_u64 => prev_hi,
                        in($rdi) src,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                }
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit128 { whole: val };

                // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports CMPXCHG16B.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic store is always SeqCst.
                    asm!(
                        "xchg {rbx_tmp}, rbx", // save rbx which is reserved by LLVM
                        // This is based on the code generated for the first load in DW RMWs by LLVM,
                        // but it is interesting that they generate code that does mixed-sized atomic access.
                        //
                        // This is not single-copy atomic reads, but this is ok because subsequent
                        // CAS will check for consistency.
                        concat!("mov rax, qword ptr [", $rdi, "]"),              // atomic { rax = *$rdi }
                        concat!("mov rdx, qword ptr [", $rdi, " + 8]"),          // atomic { rdx = *$rdi.byte_add(8) }
                        "2:", // 'retry:
                            concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"), // atomic { if *$rdi == rdx:rax { ZF = 1; *$rdi = rcx:rbx } else { ZF = 0; rdx:rax = *$rdi } }
                            "jne 2b",                                            // if ZF == 0 { jump 'retry }
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
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninit128 { whole: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports CMPXCHG16B.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    // atomic swap is always SeqCst.
                    asm!(
                        "xchg {rbx_tmp}, rbx", // save rbx which is reserved by LLVM
                        // This is based on the code generated for the first load in DW RMWs by LLVM,
                        // but it is interesting that they generate code that does mixed-sized atomic access.
                        //
                        // This is not single-copy atomic reads, but this is ok because subsequent
                        // CAS will check for consistency.
                        concat!("mov rax, qword ptr [", $rdi, "]"),              // atomic { rax = *$rdi }
                        concat!("mov rdx, qword ptr [", $rdi, " + 8]"),          // atomic { rdx = *$rdi.byte_add(8) }
                        "2:", // 'retry:
                            concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"), // atomic { if *$rdi == rdx:rax { ZF = 1; *$rdi = rcx:rbx } else { ZF = 0; rdx:rax = *$rdi } }
                            "jne 2b",                                            // if ZF == 0 { jump 'retry }
                        "mov rbx, {rbx_tmp}", // restore rbx
                        rbx_tmp = inout(reg) val.pair.lo => _,
                        in("rcx") val.pair.hi,
                        out("rax") prev_lo,
                        out("rdx") prev_hi,
                        in($rdi) dst,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                    MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                }
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
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let old = MaybeUninit128 { whole: old };
                let new = MaybeUninit128 { whole: new };
                let (prev_lo, prev_hi);

                // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                // cfg guarantees that the CPU supports CMPXCHG16B.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let r: u8;
                    // compare_exchange is always SeqCst.
                    asm!(
                        "xchg {rbx_tmp}, rbx", // save rbx which is reserved by LLVM
                        concat!("lock cmpxchg16b xmmword ptr [", $rdi, "]"), // atomic { if *$rdi == rdx:rax { ZF = 1; *$rdi = rcx:rbx } else { ZF = 0; rdx:rax = *$rdi } }
                        "sete cl",                                           // cl = ZF
                        "mov rbx, {rbx_tmp}", // restore rbx
                        rbx_tmp = inout(reg) new.pair.lo => _,
                        in("rcx") new.pair.hi,
                        inout("rax") old.pair.lo => prev_lo,
                        inout("rdx") old.pair.hi => prev_hi,
                        in($rdi) dst,
                        lateout("cl") r,
                        // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                        options(nostack),
                    );
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (
                        MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole,
                        r != 0
                    )
                }
            }
        }
    };
}

#[cfg(target_arch = "x86_64")]
#[cfg(target_feature = "cmpxchg16b")]
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
#[cfg(not(all(target_arch = "x86_64", target_feature = "cmpxchg16b")))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(target_arch = "x86_64", target_feature = "cmpxchg16b")))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(target_arch = "x86_64", target_feature = "cmpxchg16b"))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(target_arch = "x86_64", target_feature = "cmpxchg16b"))]
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
#[macro_export]
macro_rules! cfg_has_fast_consume {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_fast_consume {
    ($($tt:tt)*) => { $($tt)* };
}
