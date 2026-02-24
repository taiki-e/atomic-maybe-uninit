// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
x86 and x86_64

Refs:
- Intel® 64 and IA-32 Architectures Software Developer Manuals
  https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
- x86 and amd64 instruction reference
  https://www.felixcloutier.com/x86
- portable-atomic
  https://github.com/taiki-e/portable-atomic

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

#[cfg(not(atomic_maybe_uninit_no_outline_atomics))]
#[cfg(not(target_env = "sgx"))]
#[cfg_attr(
    not(test),
    cfg(not(any(
        target_feature = "avx",
        all(
            not(target_feature = "avx"),
            any(
                atomic_maybe_uninit_no_outline_atomics,
                target_env = "sgx",
                not(target_feature = "sse"),
            ),
        ),
    )))
)]
#[path = "../detect/x86.rs"]
mod detect;

delegate_size!(delegate_load_store);
delegate_size!(delegate_swap);
#[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg)))]
delegate_size!(delegate_cas);

#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
#[cfg(all(target_feature = "sse", not(atomic_maybe_uninit_test_prefer_x87_over_sse)))]
use core::arch::x86::__m128;
#[cfg(target_arch = "x86")]
#[cfg(not(atomic_maybe_uninit_no_cmpxchg8b))]
#[cfg(all(target_feature = "sse2", not(atomic_maybe_uninit_test_prefer_x87_over_sse)))]
use core::arch::x86::__m128i;
#[cfg(target_arch = "x86_64")]
#[cfg(target_feature = "cmpxchg16b")]
#[cfg(not(all(
    not(target_feature = "avx"),
    any(atomic_maybe_uninit_no_outline_atomics, target_env = "sgx", not(target_feature = "sse")),
)))]
use core::arch::x86_64::__m128i;
pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

#[cfg(not(all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg)))]
use crate::raw::AtomicCompareExchange;
use crate::raw::{AtomicLoad, AtomicMemcpy, AtomicStore, AtomicSwap};
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
        $ty:ident, $($size:literal)?, $val_reg:ident, $ux_reg:ident, $ux:ident,
        $zx:literal, $val_modifier:literal, $reg_val_modifier:tt, $zx_val_modifier:tt, $ptr_size:tt,
        $cmpxchg_cmp_reg:tt
    ) => {
        #[cfg(target_arch = "x86")]
        atomic!($ty, $($size)?, $val_reg, $ux_reg, reg_abcd, $ux, $zx, $val_modifier,
            $reg_val_modifier, $zx_val_modifier, $ptr_size, $cmpxchg_cmp_reg);
        #[cfg(target_arch = "x86_64")]
        atomic!($ty, $($size)?, $val_reg, $ux_reg, reg, $ux, $zx, $val_modifier,
            $reg_val_modifier, $zx_val_modifier, $ptr_size, $cmpxchg_cmp_reg);
    };
    (
        $ty:ident, $($size:literal)?, $val_reg:ident, $ux_reg:ident, $r_reg:ident, $ux:ident,
        $zx:literal, $val_modifier:literal, $reg_val_modifier:tt, $zx_val_modifier:tt, $ptr_size:tt,
        $cmpxchg_cmp_reg:tt
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
                let out;

                // SAFETY: the caller must uphold the safety contract.
                // load by MOV has SeqCst semantics.
                unsafe {
                    asm!(
                        concat!("mov", $zx, " {out", $zx_val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "}]"), // atomic { out = *src }
                        src = in(reg) src,
                        out = lateout(reg) out,
                        options(nostack, preserves_flags),
                    );
                }
                crate::utils::extend32::$ty::extract(out)
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                mut val: MaybeUninit<Self>,
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
                        #[allow(unused_assignments)] // TODO(gcc): Workaround for rustc_codegen_gcc bug
                        Ordering::SeqCst => {
                            asm!(
                                // SeqCst store is xchg, not mov
                                concat!("xchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {val", $val_modifier, "}"), // atomic { _x = *dst; *dst = val; val = _x }
                                dst = in(reg) dst,
                                val = inout($val_reg) val,
                                options(nostack, preserves_flags),
                            );
                        }
                        _ => unreachable!(),
                    }
                }
            }
        }
        $(
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("mov", $zx, " {tmp0", $zx_val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "}]"), // atomic { tmp0 = *src }
                    concat!("lea {src", ptr_modifier!(), "}, [{src", ptr_modifier!(), "} + ", $size, "]"),                  // src = src.byte_add($size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("mov", $zx, " {tmp1", $zx_val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "} + ", $size, "]"), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("mov", $zx, " {tmp0", $zx_val_modifier, "}, ", $ptr_size, " ptr [{src", ptr_modifier!(), "}]"),               // atomic { tmp0 = *src }
                    concat!("lea {src", ptr_modifier!(), "}, [{src", ptr_modifier!(), "} + 2*", $size, "]"),                              // src = src.byte_add(2*$size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            // Avoid reg_byte ($val_reg) to work around cranelift bug with multiple or lateout reg_byte.
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("mov ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {tmp0", $reg_val_modifier, "}"), // atomic { *dst = tmp0 }
                    concat!("lea {dst", ptr_modifier!(), "}, [{dst", ptr_modifier!(), "} + ", $size, "]"),          // dst = dst.byte_add($size)
                    dst = inout(reg) dst,
                    tmp0 = in($ux_reg) crate::utils::extend32::$ty::$ux(tmp0),
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("mov ", $ptr_size, " ptr [{dst", ptr_modifier!(), "} + ", $size, "], {tmp1", $reg_val_modifier, "}"), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("mov ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {tmp0", $reg_val_modifier, "}"),               // atomic { *dst = tmp0 }
                    concat!("lea {dst", ptr_modifier!(), "}, [{dst", ptr_modifier!(), "} + 2*", $size, "]"),                      // dst = dst.byte_add(2*$size)
                    dst = inout(reg) dst,
                    tmp0 = in($ux_reg) crate::utils::extend32::$ty::$ux(tmp0),
                    tmp1 = in($ux_reg) crate::utils::extend32::$ty::$ux(tmp1),
                    options(nostack, preserves_flags),
                ),
            }
        }
        )?
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
                // XCHG has SeqCst semantics.
                unsafe {
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
                // CMPXCHG has SeqCst semantics.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg
                unsafe {
                    let r: MaybeUninit<u32>;
                    asm!(
                        concat!("lock cmpxchg ", $ptr_size, " ptr [{dst", ptr_modifier!(), "}], {new", $reg_val_modifier, "}"), // atomic { if *dst == $cmpxchg_cmp_reg { ZF = 1; *dst = new } else { ZF = 0; $cmpxchg_cmp_reg = *dst } }
                        "sete {r:l}",                                                                                           // r = ZF
                        dst = in(reg) dst,
                        // Avoid reg_byte ($val_reg) in new and r to work around cranelift bug with multiple or lateout reg_byte.
                        new = in($ux_reg) crate::utils::extend32::$ty::$ux(new),
                        r = lateout($r_reg) r,
                        inout($cmpxchg_cmp_reg) old => out,
                        // Do not use `preserves_flags` because CMPXCHG modifies the ZF, CF, PF, AF, SF, and OF flags.
                        options(nostack),
                    );
                    let r = crate::utils::extend32::u8::extract(r).assume_init();
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

#[cfg(target_arch = "x86")]
atomic!(u8, "1", reg_byte, reg_abcd, uninit, "zx", "", ":l", ":e", "byte", "al");
#[cfg(target_arch = "x86_64")]
atomic!(u8, "1", reg_byte, reg, uninit, "zx", "", ":l", ":e", "byte", "al");
atomic!(u16, "2", reg, reg, identity, "zx", ":x", ":x", ":e", "word", "ax");
atomic!(u32, "4", reg, reg, identity, "", ":e", ":e", ":e", "dword", "eax");
#[cfg(target_arch = "x86_64")]
atomic!(u64,    , reg, reg, identity, "", "", "", "", "qword", "rax");

#[cfg(target_arch = "x86_64")]
impl AtomicMemcpy for u64 {
    #[inline]
    unsafe fn atomic_load_memcpy<const DST_ALIGNED: bool>(
        dst: *mut MaybeUninit<Self>,
        src: *const MaybeUninit<Self>,
        count: NonZeroUsize,
    ) {
        load_memcpy! { u64, |src, tmp0, tmp1|
            asm!(
                concat!("mov {tmp0}, qword ptr [{src", ptr_modifier!(), "}]"),                  // atomic { tmp0 = *src }
                concat!("lea {src", ptr_modifier!(), "}, [{src", ptr_modifier!(), "} + 8]"),    // src = src.byte_add(8)
                src = inout(reg) src,
                tmp0 = out(reg) tmp0,
                options(nostack, preserves_flags),
            ),
            asm!(
                concat!("mov {tmp1}, qword ptr [{src", ptr_modifier!(), "} + 8]"),              // atomic { tmp1 = *src.byte_add(8) }
                concat!("mov {tmp0}, qword ptr [{src", ptr_modifier!(), "}]"),                  // atomic { tmp0 = *src }
                concat!("lea {src", ptr_modifier!(), "}, [{src", ptr_modifier!(), "} + 2*8]"),  // src = src.byte_add(2*8)
                src = inout(reg) src,
                tmp0 = out(reg) tmp0,
                tmp1 = out(reg) tmp1,
                options(nostack, preserves_flags),
            ),
        }
        // if count.get() >= 32
        //     && (cfg!(atomic_maybe_uninit_test_prefer_movsb) || detect::detect().fsrm())
        // {
        //     // SAFETY: the caller must uphold the safety contract.
        //     unsafe {
        //         asm!(
        //             // https://doc.rust-lang.org/nightly/reference/inline-assembly.html#r-asm.rules.x86-df
        //             "cld",
        //             "rep movsb",
        //             inout("rdi") ptr_reg!(dst) => _,
        //             inout("rsi") ptr_reg!(src) => _,
        //             inout("rcx") (count.get() as u64) << 3 => _,
        //             options(nostack, preserves_flags),
        //         );
        //     }
        //     return;
        // }
        #[cfg(not(all(
            not(target_feature = "avx"),
            any(
                atomic_maybe_uninit_no_outline_atomics,
                target_env = "sgx",
                not(target_feature = "sse")
            ),
        )))]
        #[target_feature(enable = "avx")]
        #[inline]
        unsafe fn atomic_load_memcpy_large_avx(
            mut dst: *mut MaybeUninit<u64>,
            src: *const MaybeUninit<u64>,
            count: NonZeroUsize,
        ) {
            const DST_ALIGNED: bool = false;
            load_memcpy_opt_pre!(u64, crate::Align32, dst, src, count, last);
            // SAFETY: the caller must uphold the safety contract.
            unsafe {
                'mid: {
                    // 1 (0b0001): -          ->  x
                    // 2 (0b0010): - -        ->  - -
                    // 3 (0b0011): - - -      ->  x - -
                    // 4 (0b0100): - - - -    ->  - - - -
                    // 5 (0b0101): - - - - -  ->  x - - - -
                    if count & 0b1 != 0 {
                        asm!(
                            concat!("vmovdqa ymm0, ymmword ptr [{src", ptr_modifier!(), "}]"), // ymm0 = *src
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "}], ymm0"), // *dst = ymm0
                            dst = in(reg) dst,
                            src = in(reg) src,
                            out("ymm0") _,
                            options(nostack, preserves_flags),
                        );
                        src = src.add(4);
                        dst = dst.add(4);
                        count = count.wrapping_sub(1); // can use unchecked_sub
                        if count == 0 {
                            break 'mid;
                        }
                    }
                    // 2x
                    // 2 (0b0010): - -        ->  x x
                    // 3 (0b0011): x - -      ->  x x x
                    // 4 (0b0100): - - - -    ->  - - - -
                    // 5 (0b0101): x - - - -  ->  x - - - -
                    if count & 0b10 != 0 {
                        asm!(
                            concat!("vmovdqa ymm0, ymmword ptr [{src", ptr_modifier!(), "}]"),        // ymm0 = *src
                            concat!("vmovdqa ymm1, ymmword ptr [{src", ptr_modifier!(), "} + 32*1]"), // ymm1 = *src.byte_add(32*1)
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "}], ymm0"),        // *dst = ymm0
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*1], ymm1"), // *dst.byte_add(32*1) = ymm1
                            dst = in(reg) dst,
                            src = in(reg) src,
                            out("ymm0") _,
                            out("ymm1") _,
                            options(nostack, preserves_flags),
                        );
                        src = src.add(8);
                        dst = dst.add(8);
                        count = count.wrapping_sub(2); // can use unchecked_sub
                        if count == 0 {
                            break 'mid;
                        }
                    }
                    // 4x
                    // 4 (0b0100): - - - -    ->  x x x x
                    // 5 (0b0101): x - - - -  ->  x x x x x
                    if count & 0b100 != 0 {
                        asm!(
                            concat!("vmovdqa ymm0, ymmword ptr [{src", ptr_modifier!(), "}]"),        // ymm0 = *src
                            concat!("vmovdqa ymm1, ymmword ptr [{src", ptr_modifier!(), "} + 32*1]"), // ymm1 = *src.byte_add(32*1)
                            concat!("vmovdqa ymm2, ymmword ptr [{src", ptr_modifier!(), "} + 32*2]"), // ymm1 = *src.byte_add(32*2)
                            concat!("vmovdqa ymm3, ymmword ptr [{src", ptr_modifier!(), "} + 32*3]"), // ymm1 = *src.byte_add(32*3)
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "}], ymm0"),        // *dst = ymm0
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*1], ymm1"), // *dst.byte_add(32*1) = ymm1
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*2], ymm2"), // *dst.byte_add(32*2) = ymm1
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*3], ymm3"), // *dst.byte_add(32*3) = ymm1
                            dst = in(reg) dst,
                            src = in(reg) src,
                            out("ymm0") _,
                            out("ymm1") _,
                            out("ymm2") _,
                            out("ymm3") _,
                            options(nostack, preserves_flags),
                        );
                        src = src.add(16);
                        dst = dst.add(16);
                        count = count.wrapping_sub(4); // can use unchecked_sub
                        if count == 0 {
                            break 'mid;
                        }
                    }
                    // 8x
                    count >>= 3;
                    loop {
                        asm!(
                            concat!("vmovdqa ymm0, ymmword ptr [{src", ptr_modifier!(), "}]"),        // ymm0 = *src
                            concat!("vmovdqa ymm1, ymmword ptr [{src", ptr_modifier!(), "} + 32*1]"), // ymm1 = *src.byte_add(32*1)
                            concat!("vmovdqa ymm2, ymmword ptr [{src", ptr_modifier!(), "} + 32*2]"), // ymm1 = *src.byte_add(32*2)
                            concat!("vmovdqa ymm3, ymmword ptr [{src", ptr_modifier!(), "} + 32*3]"), // ymm1 = *src.byte_add(32*3)
                            concat!("vmovdqa ymm4, ymmword ptr [{src", ptr_modifier!(), "} + 32*4]"), // ymm1 = *src.byte_add(32*4)
                            concat!("vmovdqa ymm5, ymmword ptr [{src", ptr_modifier!(), "} + 32*5]"), // ymm1 = *src.byte_add(32*5)
                            concat!("vmovdqa ymm6, ymmword ptr [{src", ptr_modifier!(), "} + 32*6]"), // ymm1 = *src.byte_add(32*6)
                            concat!("vmovdqa ymm7, ymmword ptr [{src", ptr_modifier!(), "} + 32*7]"), // ymm1 = *src.byte_add(32*7)
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "}], ymm0"),        // *dst = ymm0
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*1], ymm1"), // *dst.byte_add(32*1) = ymm1
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*2], ymm2"), // *dst.byte_add(32*2) = ymm1
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*3], ymm3"), // *dst.byte_add(32*3) = ymm1
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*4], ymm4"), // *dst.byte_add(32*4) = ymm1
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*5], ymm5"), // *dst.byte_add(32*5) = ymm1
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*6], ymm6"), // *dst.byte_add(32*6) = ymm1
                            concat!("vmovdqu ymmword ptr [{dst", ptr_modifier!(), "} + 32*7], ymm7"), // *dst.byte_add(32*7) = ymm1
                            dst = in(reg) dst,
                            src = in(reg) src,
                            out("ymm0") _,
                            out("ymm1") _,
                            out("ymm2") _,
                            out("ymm3") _,
                            out("ymm4") _,
                            out("ymm5") _,
                            out("ymm6") _,
                            out("ymm7") _,
                            options(nostack, preserves_flags),
                        );
                        src = src.add(32);
                        dst = dst.add(32);
                        count = count.wrapping_sub(1); // can use unchecked_sub
                        if count == 0 {
                            break 'mid;
                        }
                    }
                }
                core::arch::x86_64::_mm256_zeroupper();
            }
            load_memcpy_opt_post!(dst, last);
        }
        #[cfg(not(target_feature = "avx"))]
        #[inline]
        unsafe fn atomic_load_memcpy_large_scalar<const DST_ALIGNED: bool>(
            mut dst: *mut MaybeUninit<u64>,
            src: *const MaybeUninit<u64>,
            count: NonZeroUsize,
        ) {
            const DST_ALIGNED: bool = false;
            load_memcpy_opt_pre!(u64, [crate::Align8; 8], dst, src, count, last);
            // SAFETY: the caller must uphold the safety contract.
            unsafe {
                let mut tmp0;
                let mut tmp1;
                let mut tmp2;
                let mut tmp3;
                let mut tmp4;
                let mut tmp5;
                let mut tmp6;
                let mut tmp7;
                loop {
                    asm!(
                        concat!("mov {tmp7}, qword ptr [{src", ptr_modifier!(), "} + 8*7]"),            // atomic { tmp7 = *src.byte_add(8*7) }
                        concat!("mov {tmp6}, qword ptr [{src", ptr_modifier!(), "} + 8*6]"),            // atomic { tmp6 = *src.byte_add(8*6) }
                        concat!("mov {tmp5}, qword ptr [{src", ptr_modifier!(), "} + 8*5]"),            // atomic { tmp5 = *src.byte_add(8*5) }
                        concat!("mov {tmp4}, qword ptr [{src", ptr_modifier!(), "} + 8*4]"),            // atomic { tmp4 = *src.byte_add(8*4) }
                        concat!("mov {tmp3}, qword ptr [{src", ptr_modifier!(), "} + 8*3]"),            // atomic { tmp3 = *src.byte_add(8*3) }
                        concat!("mov {tmp2}, qword ptr [{src", ptr_modifier!(), "} + 8*2]"),            // atomic { tmp2 = *src.byte_add(8*2) }
                        concat!("mov {tmp1}, qword ptr [{src", ptr_modifier!(), "} + 8*1]"),            // atomic { tmp1 = *src.byte_add(8*1) }
                        concat!("mov {tmp0}, qword ptr [{src", ptr_modifier!(), "}]"),                  // atomic { tmp0 = *src }
                        concat!("lea {src", ptr_modifier!(), "}, [{src", ptr_modifier!(), "} + 8*8]"),  // src = src.byte_add(8*8)
                        src = inout(reg) src,
                        tmp0 = out(reg) tmp0,
                        tmp1 = out(reg) tmp1,
                        tmp2 = out(reg) tmp2,
                        tmp3 = out(reg) tmp3,
                        tmp4 = out(reg) tmp4,
                        tmp5 = out(reg) tmp5,
                        tmp6 = out(reg) tmp6,
                        tmp7 = out(reg) tmp7,
                        options(nostack, preserves_flags),
                    );
                    inc_addr!(src, 1);
                    if DST_ALIGNED {
                        dst.add(7).write(tmp7);
                        dst.add(6).write(tmp6);
                        dst.add(5).write(tmp5);
                        dst.add(4).write(tmp4);
                        dst.add(3).write(tmp3);
                        dst.add(2).write(tmp2);
                        dst.add(1).write(tmp1);
                        dst.write(tmp0);
                    } else {
                        dst.add(7).write_unaligned(tmp7);
                        dst.add(6).write_unaligned(tmp6);
                        dst.add(5).write_unaligned(tmp5);
                        dst.add(4).write_unaligned(tmp4);
                        dst.add(3).write_unaligned(tmp3);
                        dst.add(2).write_unaligned(tmp2);
                        dst.add(1).write_unaligned(tmp1);
                        dst.write_unaligned(tmp0);
                    }
                    dst = dst.add(8);
                    count = count.wrapping_sub(1); // can use unchecked_sub
                    if count == 0 {
                        break;
                    }
                }
            }
            load_memcpy_opt_post!(dst, last);
        }
        #[cfg(target_feature = "avx")]
        // SAFETY: the caller must uphold the safety contract.
        // cfg guarantees that the CPU supports AVX.
        unsafe {
            atomic_load_memcpy_large_avx(dst, src, count);
        }
        #[cfg(not(target_feature = "avx"))]
        #[cfg(not(all(
            not(target_feature = "avx"),
            any(
                atomic_maybe_uninit_no_outline_atomics,
                target_env = "sgx",
                not(target_feature = "sse")
            ),
        )))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            ifunc!(unsafe fn(
                dst: *mut MaybeUninit<u64>,
                src: *const MaybeUninit<u64>,
                count: NonZeroUsize,
            ) {
                if detect::detect().avx2() {
                    atomic_load_memcpy_large_avx
                } else {
                    atomic_load_memcpy_large_scalar::<true>
                }
            })
        };
        #[cfg(not(target_feature = "avx"))]
        #[cfg(all(
            not(target_feature = "avx"),
            any(
                atomic_maybe_uninit_no_outline_atomics,
                target_env = "sgx",
                not(target_feature = "sse")
            ),
        ))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            atomic_load_memcpy_large_scalar::<{ DST_ALIGNED }>(dst, src, count);
        }
    }
    #[inline]
    unsafe fn atomic_store_memcpy<const SRC_ALIGNED: bool>(
        dst: *mut MaybeUninit<Self>,
        src: *const MaybeUninit<Self>,
        count: NonZeroUsize,
    ) {
        store_memcpy! { u64, |dst, tmp0, tmp1|
            asm!(
                concat!("mov qword ptr [{dst", ptr_modifier!(), "}], {tmp0}"),                  // atomic { *dst = tmp0 }
                concat!("lea {dst", ptr_modifier!(), "}, [{dst", ptr_modifier!(), "} + 8]"),    // dst = dst.byte_add(8)
                dst = inout(reg) dst,
                tmp0 = in(reg) tmp0,
                options(nostack, preserves_flags),
            ),
            asm!(
                concat!("mov qword ptr [{dst", ptr_modifier!(), "} + 8], {tmp1}"),              // atomic { *dst.byte_add(8) = tmp1 }
                concat!("mov qword ptr [{dst", ptr_modifier!(), "}], {tmp0}"),                  // atomic { *dst = tmp0 }
                concat!("lea {dst", ptr_modifier!(), "}, [{dst", ptr_modifier!(), "} + 2*8]"),  // dst = dst.byte_add(2*8)
                dst = inout(reg) dst,
                tmp0 = in(reg) tmp0,
                tmp1 = in(reg) tmp1,
                options(nostack, preserves_flags),
            ),
        }
        // if count.get() >= 32
        //     && (cfg!(atomic_maybe_uninit_test_prefer_movsb) || detect::detect().fsrm())
        // {
        //     // SAFETY: the caller must uphold the safety contract.
        //     unsafe {
        //         asm!(
        //             // https://doc.rust-lang.org/nightly/reference/inline-assembly.html#r-asm.rules.x86-df
        //             "cld",
        //             "rep movsb",
        //             inout("rdi") ptr_reg!(dst) => _,
        //             inout("rsi") ptr_reg!(src) => _,
        //             inout("rcx") (count.get() as u64) << 3 => _,
        //             options(nostack, preserves_flags),
        //         );
        //     }
        //     return;
        // }
        #[cfg(not(all(
            not(target_feature = "avx"),
            any(
                atomic_maybe_uninit_no_outline_atomics,
                target_env = "sgx",
                not(target_feature = "sse")
            ),
        )))]
        #[target_feature(enable = "avx")]
        #[inline]
        unsafe fn atomic_store_memcpy_large_avx(
            dst: *mut MaybeUninit<u64>,
            mut src: *const MaybeUninit<u64>,
            count: NonZeroUsize,
        ) {
            const SRC_ALIGNED: bool = false;
            store_memcpy_opt_pre!(u64, crate::Align32, dst, src, count, last);
            // SAFETY: the caller must uphold the safety contract.
            unsafe {
                'mid: {
                    // 1 (0b0001): -          ->  x
                    // 2 (0b0010): - -        ->  - -
                    // 3 (0b0011): - - -      ->  x - -
                    // 4 (0b0100): - - - -    ->  - - - -
                    // 5 (0b0101): - - - - -  ->  x - - - -
                    if count & 0b1 != 0 {
                        asm!(
                            concat!("vmovdqu ymm0, ymmword ptr [{src", ptr_modifier!(), "}]"), // ymm0 = *src
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "}], ymm0"), // *dst = ymm0
                            dst = in(reg) dst,
                            src = in(reg) src,
                            out("ymm0") _,
                            options(nostack, preserves_flags),
                        );
                        src = src.add(4);
                        dst = dst.add(4);
                        count = count.wrapping_sub(1); // can use unchecked_sub
                        if count == 0 {
                            break 'mid;
                        }
                    }
                    // 2x
                    // 2 (0b0010): - -        ->  x x
                    // 3 (0b0011): x - -      ->  x x x
                    // 4 (0b0100): - - - -    ->  - - - -
                    // 5 (0b0101): x - - - -  ->  x - - - -
                    if count & 0b10 != 0 {
                        asm!(
                            concat!("vmovdqu ymm0, ymmword ptr [{src", ptr_modifier!(), "}]"),        // ymm0 = *src
                            concat!("vmovdqu ymm1, ymmword ptr [{src", ptr_modifier!(), "} + 32*1]"), // ymm1 = *src.byte_add(32*1)
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "}], ymm0"),        // *dst = ymm0
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*1], ymm1"), // *dst.byte_add(32*1) = ymm1
                            dst = in(reg) dst,
                            src = in(reg) src,
                            out("ymm0") _,
                            out("ymm1") _,
                            options(nostack, preserves_flags),
                        );
                        src = src.add(8);
                        dst = dst.add(8);
                        count = count.wrapping_sub(2); // can use unchecked_sub
                        if count == 0 {
                            break 'mid;
                        }
                    }
                    // 4x
                    // 4 (0b0100): - - - -    ->  x x x x
                    // 5 (0b0101): x - - - -  ->  x x x x x
                    if count & 0b100 != 0 {
                        asm!(
                            concat!("vmovdqu ymm0, ymmword ptr [{src", ptr_modifier!(), "}]"),        // ymm0 = *src
                            concat!("vmovdqu ymm1, ymmword ptr [{src", ptr_modifier!(), "} + 32*1]"), // ymm1 = *src.byte_add(32*1)
                            concat!("vmovdqu ymm2, ymmword ptr [{src", ptr_modifier!(), "} + 32*2]"), // ymm1 = *src.byte_add(32*2)
                            concat!("vmovdqu ymm3, ymmword ptr [{src", ptr_modifier!(), "} + 32*3]"), // ymm1 = *src.byte_add(32*3)
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "}], ymm0"),        // *dst = ymm0
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*1], ymm1"), // *dst.byte_add(32*1) = ymm1
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*2], ymm2"), // *dst.byte_add(32*2) = ymm1
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*3], ymm3"), // *dst.byte_add(32*3) = ymm1
                            dst = in(reg) dst,
                            src = in(reg) src,
                            out("ymm0") _,
                            out("ymm1") _,
                            out("ymm2") _,
                            out("ymm3") _,
                            options(nostack, preserves_flags),
                        );
                        src = src.add(16);
                        dst = dst.add(16);
                        count = count.wrapping_sub(4); // can use unchecked_sub
                        if count == 0 {
                            break 'mid;
                        }
                    }
                    // 8x
                    count >>= 3;
                    loop {
                        asm!(
                            concat!("vmovdqu ymm0, ymmword ptr [{src", ptr_modifier!(), "}]"),        // ymm0 = *src
                            concat!("vmovdqu ymm1, ymmword ptr [{src", ptr_modifier!(), "} + 32*1]"), // ymm1 = *src.byte_add(32*1)
                            concat!("vmovdqu ymm2, ymmword ptr [{src", ptr_modifier!(), "} + 32*2]"), // ymm1 = *src.byte_add(32*2)
                            concat!("vmovdqu ymm3, ymmword ptr [{src", ptr_modifier!(), "} + 32*3]"), // ymm1 = *src.byte_add(32*3)
                            concat!("vmovdqu ymm4, ymmword ptr [{src", ptr_modifier!(), "} + 32*4]"), // ymm1 = *src.byte_add(32*4)
                            concat!("vmovdqu ymm5, ymmword ptr [{src", ptr_modifier!(), "} + 32*5]"), // ymm1 = *src.byte_add(32*5)
                            concat!("vmovdqu ymm6, ymmword ptr [{src", ptr_modifier!(), "} + 32*6]"), // ymm1 = *src.byte_add(32*6)
                            concat!("vmovdqu ymm7, ymmword ptr [{src", ptr_modifier!(), "} + 32*7]"), // ymm1 = *src.byte_add(32*7)
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "}], ymm0"),        // *dst = ymm0
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*1], ymm1"), // *dst.byte_add(32*1) = ymm1
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*2], ymm2"), // *dst.byte_add(32*2) = ymm1
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*3], ymm3"), // *dst.byte_add(32*3) = ymm1
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*4], ymm4"), // *dst.byte_add(32*4) = ymm1
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*5], ymm5"), // *dst.byte_add(32*5) = ymm1
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*6], ymm6"), // *dst.byte_add(32*6) = ymm1
                            concat!("vmovdqa ymmword ptr [{dst", ptr_modifier!(), "} + 32*7], ymm7"), // *dst.byte_add(32*7) = ymm1
                            dst = in(reg) dst,
                            src = in(reg) src,
                            out("ymm0") _,
                            out("ymm1") _,
                            out("ymm2") _,
                            out("ymm3") _,
                            out("ymm4") _,
                            out("ymm5") _,
                            out("ymm6") _,
                            out("ymm7") _,
                            options(nostack, preserves_flags),
                        );
                        src = src.add(32);
                        dst = dst.add(32);
                        count = count.wrapping_sub(1); // can use unchecked_sub
                        if count == 0 {
                            break 'mid;
                        }
                    }
                }
                core::arch::x86_64::_mm256_zeroupper();
            }
            store_memcpy_opt_post!(src, last);
        }
        #[cfg(not(target_feature = "avx"))]
        #[inline]
        unsafe fn atomic_store_memcpy_large_scalar(
            dst: *mut MaybeUninit<u64>,
            mut src: *const MaybeUninit<u64>,
            count: NonZeroUsize,
        ) {
            const SRC_ALIGNED: bool = false;
            store_memcpy_opt_pre!(u64, [crate::Align8; 8], dst, src, count, last);
            // SAFETY: the caller must uphold the safety contract.
            unsafe {
                let mut tmp0;
                let mut tmp1;
                let mut tmp2;
                let mut tmp3;
                let mut tmp4;
                let mut tmp5;
                let mut tmp6;
                let mut tmp7;
                loop {
                    if SRC_ALIGNED {
                        tmp7 = src.add(7).read();
                        tmp6 = src.add(6).read();
                        tmp5 = src.add(5).read();
                        tmp4 = src.add(4).read();
                        tmp3 = src.add(3).read();
                        tmp2 = src.add(2).read();
                        tmp1 = src.add(1).read();
                        tmp0 = src.read();
                    } else {
                        tmp7 = src.add(7).read_unaligned();
                        tmp6 = src.add(6).read_unaligned();
                        tmp5 = src.add(5).read_unaligned();
                        tmp4 = src.add(4).read_unaligned();
                        tmp3 = src.add(3).read_unaligned();
                        tmp2 = src.add(2).read_unaligned();
                        tmp1 = src.add(1).read_unaligned();
                        tmp0 = src.read_unaligned();
                    }
                    src = src.add(8);
                    asm!(
                        concat!("mov qword ptr [{dst", ptr_modifier!(), "} + 8*7], {tmp7}"),            // atomic { *dst.byte_add(8*7) = tmp7 }
                        concat!("mov qword ptr [{dst", ptr_modifier!(), "} + 8*6], {tmp6}"),            // atomic { *dst.byte_add(8*6) = tmp6 }
                        concat!("mov qword ptr [{dst", ptr_modifier!(), "} + 8*5], {tmp5}"),            // atomic { *dst.byte_add(8*5) = tmp5 }
                        concat!("mov qword ptr [{dst", ptr_modifier!(), "} + 8*4], {tmp4}"),            // atomic { *dst.byte_add(8*4) = tmp4 }
                        concat!("mov qword ptr [{dst", ptr_modifier!(), "} + 8*3], {tmp3}"),            // atomic { *dst.byte_add(8*3) = tmp3 }
                        concat!("mov qword ptr [{dst", ptr_modifier!(), "} + 8*2], {tmp2}"),            // atomic { *dst.byte_add(8*2) = tmp2 }
                        concat!("mov qword ptr [{dst", ptr_modifier!(), "} + 8*1], {tmp1}"),            // atomic { *dst.byte_add(8*1) = tmp1 }
                        concat!("mov qword ptr [{dst", ptr_modifier!(), "}], {tmp0}"),                  // atomic { *dst = tmp0 }
                        concat!("lea {dst", ptr_modifier!(), "}, [{dst", ptr_modifier!(), "} + 8*8]"),  // dst = dst.byte_add(8*8)
                        dst = inout(reg) dst,
                        tmp0 = in(reg) tmp0,
                        tmp1 = in(reg) tmp1,
                        tmp2 = in(reg) tmp2,
                        tmp3 = in(reg) tmp3,
                        tmp4 = in(reg) tmp4,
                        tmp5 = in(reg) tmp5,
                        tmp6 = in(reg) tmp6,
                        tmp7 = in(reg) tmp7,
                        options(nostack, preserves_flags),
                    );
                    inc_addr!(dst, 8);
                    count = count.wrapping_sub(1); // can use unchecked_sub
                    if count == 0 {
                        break;
                    }
                }
            }
            store_memcpy_opt_post!(src, last);
        }
        #[cfg(target_feature = "avx")]
        // SAFETY: the caller must uphold the safety contract.
        // cfg guarantees that the CPU supports AVX.
        unsafe {
            atomic_store_memcpy_large_avx(dst, src, count);
        }
        #[cfg(not(target_feature = "avx"))]
        #[cfg(not(all(
            not(target_feature = "avx"),
            any(
                atomic_maybe_uninit_no_outline_atomics,
                target_env = "sgx",
                not(target_feature = "sse")
            ),
        )))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            ifunc!(unsafe fn(
                dst: *mut MaybeUninit<u64>,
                src: *const MaybeUninit<u64>,
                count: NonZeroUsize,
            ) {
                if detect::detect().avx2() {
                    atomic_store_memcpy_large_avx
                } else {
                    atomic_store_memcpy_large_scalar
                }
            })
        }
        #[cfg(not(target_feature = "avx"))]
        #[cfg(all(
            not(target_feature = "avx"),
            any(
                atomic_maybe_uninit_no_outline_atomics,
                target_env = "sgx",
                not(target_feature = "sse")
            ),
        ))]
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            atomic_store_memcpy_large_scalar::<{ SRC_ALIGNED }>(dst, src, count);
        }
    }
}

// For load/store, we can use MOVQ(SSE2)/MOVLPS(SSE)/FILD&FISTP(x87) instead of CMPXCHG8B.
// Refs: https://github.com/llvm/llvm-project/blob/llvmorg-22.1.0-rc1/llvm/test/CodeGen/X86/atomic-load-store-wide.ll
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
                // load by MOVQ has SeqCst semantics.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/movq (SSE2)
                // - https://www.felixcloutier.com/x86/movd:movq (SSE2)
                unsafe {
                    let out;
                    asm!(
                        "movq {out}, qword ptr [{src}]", // atomic { out[:] = *src }
                        src = in(reg) src,
                        out = out(xmm_reg) out,
                        options(nostack, preserves_flags),
                    );
                    mem::transmute::<MaybeUninit<__m128i>, [MaybeUninit<Self>; 2]>(out)[0]
                }
                #[cfg(all(
                    not(target_feature = "sse2"),
                    target_feature = "sse",
                    not(atomic_maybe_uninit_test_prefer_x87_over_sse),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports SSE.
                // load by MOVLPS has SeqCst semantics.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/movlps (SSE)
                unsafe {
                    let out;
                    asm!(
                        "movlps {out}, qword ptr [{src}]", // atomic { out[:] = *src }
                        src = in(reg) src,
                        out = out(xmm_reg) out,
                        options(nostack, preserves_flags),
                    );
                    mem::transmute::<MaybeUninit<__m128>, [MaybeUninit<Self>; 2]>(out)[0]
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
                // load by FILD has SeqCst semantics.
                //
                // Refs:
                // - https://www.felixcloutier.com/x86/fild
                // - https://www.felixcloutier.com/x86/fist:fistp
                unsafe {
                    let mut out = MaybeUninit::<Self>::uninit();
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
                // CMPXCHG8B has SeqCst semantics.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let (prev_lo, prev_hi);
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
                    let val: MaybeUninit<__m128> = mem::transmute([val, MaybeUninit::uninit()]);
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
                                // - LLVM uses `lock or` https://godbolt.org/z/vv6rjzfYd
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
                                // - LLVM uses `lock or` https://godbolt.org/z/vv6rjzfYd
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
                    // CMPXCHG8B has SeqCst semantics.
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
                // CMPXCHG8B has SeqCst semantics.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
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
                // CMPXCHG8B has SeqCst semantics.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let r: u8;
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
        // rdi and rsi are call-preserved on Windows.
        #[cfg(not(windows))]
        #[cfg(target_pointer_width = "32")]
        atomic128!($ty, "edi", "esi", "rsi");
        #[cfg(not(windows))]
        #[cfg(target_pointer_width = "64")]
        atomic128!($ty, "rdi", "rsi", "rsi");
        #[cfg(windows)]
        #[cfg(target_pointer_width = "32")]
        atomic128!($ty, "r9d", "r11d", "r8");
        #[cfg(windows)]
        #[cfg(target_pointer_width = "64")]
        atomic128!($ty, "r9", "r11", "r8");
    };
    ($ty:ident, $dst:tt, $cas_dst:tt, $save:tt) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                // VMOVDQA is atomic when AVX is available.
                // See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104688 for details.
                //
                // Refs: https://www.felixcloutier.com/x86/movdqa:vmovdqa32:vmovdqa64
                #[cfg(not(all(
                    not(target_feature = "avx"),
                    any(atomic_maybe_uninit_no_outline_atomics, target_env = "sgx", not(target_feature = "sse")),
                )))]
                #[target_feature(enable = "avx")]
                #[inline]
                unsafe fn atomic_load_avx(
                    src: *const MaybeUninit<$ty>,
                ) -> MaybeUninit<$ty> {
                    // SAFETY: the caller must guarantee that `src` is valid for reads,
                    // 16-byte aligned, and that there are no concurrent non-atomic operations.
                    // load by VMOVDQA has SeqCst semantics.
                    unsafe {
                        let out;
                        asm!(
                            concat!("vmovdqa {out}, xmmword ptr [{src", ptr_modifier!(), "}]"), // atomic { out = *src }
                            src = in(reg) src,
                            out = lateout(xmm_reg) out,
                            options(nostack, preserves_flags),
                        );
                        mem::transmute::<MaybeUninit<__m128i>, MaybeUninit<$ty>>(out)
                    }
                }
                #[cfg(not(target_feature = "avx"))]
                #[inline]
                unsafe fn atomic_load_cmpxchg16b(
                    src: *const MaybeUninit<$ty>,
                ) -> MaybeUninit<$ty> {
                    // SAFETY: the caller must guarantee that `src` is valid for both writes and
                    // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                    // CMPXCHG16B has SeqCst semantics.
                    //
                    // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                    unsafe {
                        let (prev_lo, prev_hi);
                        asm!(
                            concat!("mov ", $save, ", rbx"), // save rbx which is reserved by LLVM
                            "xor rbx, rbx",       // zeroed rbx
                            concat!("lock cmpxchg16b xmmword ptr [", $dst, "]"), // atomic { if *$rdi == rdx:rax { ZF = 1; *$rdi = rcx:rbx } else { ZF = 0; rdx:rax = *$rdi } }
                            concat!("mov rbx, ", $save), // restore rbx
                            // set old/new args of CMPXCHG16B to 0 (rbx is zeroed after saved to rbx_tmp, to avoid xchg)
                            out($save) _,
                            in("rcx") 0_u64,
                            inout("rax") 0_u64 => prev_lo,
                            inout("rdx") 0_u64 => prev_hi,
                            in($dst) src,
                            // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                            options(nostack),
                        );
                        MaybeUninit128 { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                    }
                }
                debug_assert_atomic_unsafe_precondition!(src, $ty);

                #[cfg(target_feature = "avx")]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports AVX.
                unsafe {
                    atomic_load_avx(src)
                }
                #[cfg(not(target_feature = "avx"))]
                #[cfg(not(all(
                    not(target_feature = "avx"),
                    any(atomic_maybe_uninit_no_outline_atomics, target_env = "sgx", not(target_feature = "sse")),
                )))]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports CMPXCHG16B.
                unsafe {
                    ifunc!(unsafe fn(src: *const MaybeUninit<$ty>) -> MaybeUninit<$ty> {
                        if detect::detect().avx2() {
                            atomic_load_avx
                        } else {
                            atomic_load_cmpxchg16b
                        }
                    })
                }
                #[cfg(not(target_feature = "avx"))]
                #[cfg(all(
                    not(target_feature = "avx"),
                    any(atomic_maybe_uninit_no_outline_atomics, target_env = "sgx", not(target_feature = "sse")),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports CMPXCHG16B.
                unsafe {
                    atomic_load_cmpxchg16b(src)
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
                // VMOVDQA is atomic when AVX is available.
                // See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104688 for details.
                //
                // Refs: https://www.felixcloutier.com/x86/movdqa:vmovdqa32:vmovdqa64
                #[cfg(not(all(
                    not(target_feature = "avx"),
                    any(atomic_maybe_uninit_no_outline_atomics, target_env = "sgx", not(target_feature = "sse")),
                )))]
                #[target_feature(enable = "avx")]
                #[inline]
                unsafe fn atomic_store_avx(
                    dst: *mut MaybeUninit<$ty>,
                    val: MaybeUninit<$ty>,
                    order: Ordering,
                ) {
                    // SAFETY: the caller must guarantee that `dst` is valid for writes,
                    // 16-byte aligned, and that there are no concurrent non-atomic operations.
                    // cfg guarantees that the CPU supports AVX.
                    unsafe {
                        let val: MaybeUninit<__m128i> = mem::transmute(val);
                        match order {
                            // Relaxed and Release stores are equivalent.
                            Ordering::Relaxed | Ordering::Release => {
                                asm!(
                                    concat!("vmovdqa xmmword ptr [{dst", ptr_modifier!(), "}], {val}"), // atomic { *dst = val }
                                    dst = in(reg) dst,
                                    val = in(xmm_reg) val,
                                    options(nostack, preserves_flags),
                                );
                            }
                            Ordering::SeqCst => {
                                let p = core::cell::UnsafeCell::new(MaybeUninit::<u64>::uninit());
                                asm!(
                                    concat!("vmovdqa xmmword ptr [{dst", ptr_modifier!(), "}], {val}"), // atomic { *dst = val }
                                    // Equivalent to `mfence`, but is up to 3.1x faster on Coffee Lake and up to 2.4x faster on Raptor Lake-H at least in simple cases.
                                    // - https://github.com/taiki-e/portable-atomic/pull/156
                                    // - LLVM uses `lock or` https://godbolt.org/z/vv6rjzfYd
                                    // - Windows uses `xchg` for x86_32 for MemoryBarrier https://learn.microsoft.com/en-us/windows/win32/api/winnt/nf-winnt-memorybarrier
                                    // - MSVC STL uses `lock inc` https://github.com/microsoft/STL/pull/740
                                    // - boost uses `lock or` https://github.com/boostorg/atomic/commit/559eba81af71386cedd99f170dc6101c6ad7bf22
                                    concat!("xchg qword ptr [{p", ptr_modifier!(), "}], {tmp}"),        // fence
                                    dst = in(reg) dst,
                                    val = in(xmm_reg) val,
                                    p = in(reg) p.get(),
                                    tmp = out(reg) _,
                                    options(nostack, preserves_flags),
                                );
                            }
                            _ => unreachable!(),
                        }
                    }
                }
                #[cfg(not(target_feature = "avx"))]
                #[inline]
                unsafe fn atomic_store_cmpxchg16b(
                    dst: *mut MaybeUninit<$ty>,
                    val: MaybeUninit<$ty>,
                ) {
                    // SAFETY: the caller must guarantee that `dst` is valid for both writes and
                    // reads, 16-byte aligned, and that there are no concurrent non-atomic operations.
                    // cfg guarantees that the CPU supports CMPXCHG16B.
                    // CMPXCHG16B has SeqCst semantics.
                    //
                    // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                    unsafe {
                        let val = MaybeUninit128 { whole: val };
                        asm!(
                            concat!("xchg ", $save, ", rbx"), // save rbx which is reserved by LLVM
                            // This is based on the code generated for the first load in DW RMWs by LLVM,
                            // but it is interesting that they generate code that does mixed-sized atomic access.
                            //
                            // This is not single-copy atomic reads, but this is ok because subsequent
                            // CAS will check for consistency.
                            concat!("mov rax, qword ptr [", $dst, "]"),              // atomic { rax = *$rdi }
                            concat!("mov rdx, qword ptr [", $dst, " + 8]"),          // atomic { rdx = *$rdi.byte_add(8) }
                            "2:", // 'retry:
                                concat!("lock cmpxchg16b xmmword ptr [", $dst, "]"), // atomic { if *$rdi == rdx:rax { ZF = 1; *$rdi = rcx:rbx } else { ZF = 0; rdx:rax = *$rdi } }
                                "jne 2b",                                            // if ZF == 0 { jump 'retry }
                            concat!("mov rbx, ", $save), // restore rbx
                            inout($save) val.pair.lo => _,
                            in("rcx") val.pair.hi,
                            out("rax") _,
                            out("rdx") _,
                            in($dst) dst,
                            // Do not use `preserves_flags` because CMPXCHG16B modifies the ZF flag.
                            options(nostack),
                        );
                    }
                }
                debug_assert_atomic_unsafe_precondition!(dst, $ty);

                #[cfg(target_feature = "avx")]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports AVX.
                unsafe {
                    atomic_store_avx(dst, val, order);
                }
                #[cfg(not(target_feature = "avx"))]
                #[cfg(not(all(
                    not(target_feature = "avx"),
                    any(atomic_maybe_uninit_no_outline_atomics, target_env = "sgx", not(target_feature = "sse")),
                )))]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports CMPXCHG16B.
                unsafe {
                    fn_alias! {
                        #[target_feature(enable = "avx")]
                        unsafe fn(dst: *mut MaybeUninit<$ty>, val: MaybeUninit<$ty>);
                        // atomic store by vmovdqa has at least release semantics.
                        atomic_store_avx_non_seqcst = atomic_store_avx(Ordering::Release);
                        atomic_store_avx_seqcst = atomic_store_avx(Ordering::SeqCst);
                    }
                    match order {
                        // Relaxed and Release stores are equivalent in all implementations
                        // that may be called here.
                        Ordering::Relaxed | Ordering::Release => {
                            ifunc!(unsafe fn(dst: *mut MaybeUninit<$ty>, val: MaybeUninit<$ty>) {
                                if detect::detect().avx2() {
                                    atomic_store_avx_non_seqcst
                                } else {
                                    atomic_store_cmpxchg16b
                                }
                            });
                        }
                        Ordering::SeqCst => {
                            ifunc!(unsafe fn(dst: *mut MaybeUninit<$ty>, val: MaybeUninit<$ty>) {
                                if detect::detect().avx2() {
                                    atomic_store_avx_seqcst
                                } else {
                                    atomic_store_cmpxchg16b
                                }
                            });
                        }
                        _ => unreachable!(),
                    }
                }
                #[cfg(not(target_feature = "avx"))]
                #[cfg(all(
                    not(target_feature = "avx"),
                    any(atomic_maybe_uninit_no_outline_atomics, target_env = "sgx", not(target_feature = "sse")),
                ))]
                // SAFETY: the caller must uphold the safety contract.
                // cfg guarantees that the CPU supports CMPXCHG16B.
                unsafe {
                    // CMPXCHG16B has SeqCst semantics.
                    let _ = order;
                    atomic_store_cmpxchg16b(dst, val);
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
                // CMPXCHG16B has SeqCst semantics.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    asm!(
                        concat!("xchg ", $save, ", rbx"), // save rbx which is reserved by LLVM
                        // This is based on the code generated for the first load in DW RMWs by LLVM,
                        // but it is interesting that they generate code that does mixed-sized atomic access.
                        //
                        // This is not single-copy atomic reads, but this is ok because subsequent
                        // CAS will check for consistency.
                        concat!("mov rax, qword ptr [", $dst, "]"),              // atomic { rax = *$rdi }
                        concat!("mov rdx, qword ptr [", $dst, " + 8]"),          // atomic { rdx = *$rdi.byte_add(8) }
                        "2:", // 'retry:
                            concat!("lock cmpxchg16b xmmword ptr [", $dst, "]"), // atomic { if *$rdi == rdx:rax { ZF = 1; *$rdi = rcx:rbx } else { ZF = 0; rdx:rax = *$rdi } }
                            "jne 2b",                                            // if ZF == 0 { jump 'retry }
                        concat!("mov rbx, ", $save), // restore rbx
                        inout($save) val.pair.lo => _,
                        in("rcx") val.pair.hi,
                        out("rax") prev_lo,
                        out("rdx") prev_hi,
                        in($dst) dst,
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
                // CMPXCHG16B has SeqCst semantics.
                //
                // Refs: https://www.felixcloutier.com/x86/cmpxchg8b:cmpxchg16b
                unsafe {
                    let r: u8;
                    asm!(
                        "xchg r8, rbx", // save rbx which is reserved by LLVM
                        concat!("lock cmpxchg16b xmmword ptr [", $cas_dst, "]"), // atomic { if *$rdi == rdx:rax { ZF = 1; *$rdi = rcx:rbx } else { ZF = 0; rdx:rax = *$rdi } }
                        "sete cl",                                           // cl = ZF
                        "mov rbx, r8", // restore rbx
                        inout("r8") new.pair.lo => _,
                        in("rcx") new.pair.hi,
                        inout("rax") old.pair.lo => prev_lo,
                        inout("rdx") old.pair.hi => prev_hi,
                        in($cas_dst) dst,
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

#[cfg(target_feature = "sse2")]
#[inline]
pub(crate) unsafe fn atomic_memcpy<const IS_LOAD: bool>(
    dst: *mut MaybeUninit<u8>,
    src: *const MaybeUninit<u8>,
    count: NonZeroUsize, // in bytes
) {
    debug_assert!(count.get() >= 16);
    if count.get() <= 32 {
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            if IS_LOAD {
                atomic_load_memcpy_sse2(dst, src, count)
            } else {
                atomic_store_memcpy_sse2(dst, src, count)
            }
        }
        return;
    }
    if count.get() <= 64 {
        // SAFETY: the caller must uphold the safety contract.
        #[cfg(target_feature = "avx2")]
        unsafe {
            if IS_LOAD {
                atomic_load_memcpy_avx(dst, src, count)
            } else {
                atomic_store_memcpy_avx(dst, src, count)
            }
        }
        #[cfg(not(target_feature = "avx2"))]
        unsafe {
            if IS_LOAD {
                atomic_load_memcpy_sse2(dst, src, count)
            } else {
                atomic_store_memcpy_sse2(dst, src, count)
            }
        }
        return;
    }

    #[cfg(target_feature = "avx")]
    // SAFETY: the caller must uphold the safety contract.
    // cfg guarantees that the CPU supports AVX.
    unsafe {
        if IS_LOAD {
            atomic_load_memcpy_avx(dst, src, count);
        } else {
            atomic_store_memcpy_avx(dst, src, count);
        }
    }
    #[cfg(not(target_feature = "avx"))]
    #[cfg(not(all(
        not(target_feature = "avx"),
        any(
            atomic_maybe_uninit_no_outline_atomics,
            target_env = "sgx",
            not(target_feature = "sse")
        ),
    )))]
    // SAFETY: the caller must uphold the safety contract.
    unsafe {
        if IS_LOAD {
            ifunc!(unsafe fn(
                dst: *mut MaybeUninit<u8>,
                src: *const MaybeUninit<u8>,
                count: NonZeroUsize,
            ) {
                let cpuinfo = detect::detect();
                if cpuinfo.icelake_or_later() {
                    atomic_load_memcpy_avx512f
                } else if cpuinfo.avx2() {
                    atomic_load_memcpy_avx
                } else {
                    atomic_load_memcpy_sse2
                }
            })
        } else {
            ifunc!(unsafe fn(
                dst: *mut MaybeUninit<u8>,
                src: *const MaybeUninit<u8>,
                count: NonZeroUsize,
            ) {
                let cpuinfo = detect::detect();
                if cpuinfo.icelake_or_later() {
                    atomic_store_memcpy_avx512f
                } else if cpuinfo.avx2() {
                    atomic_store_memcpy_avx
                } else {
                    atomic_store_memcpy_sse2
                }
            })
        }
    }
    #[cfg(not(target_feature = "avx"))]
    #[cfg(all(
        not(target_feature = "avx"),
        any(
            atomic_maybe_uninit_no_outline_atomics,
            target_env = "sgx",
            not(target_feature = "sse")
        ),
    ))]
    // SAFETY: the caller must uphold the safety contract.
    unsafe {
        if IS_LOAD {
            atomic_load_memcpy_sse2(dst, src, count)
        } else {
            atomic_store_memcpy_sse2(dst, src, count)
        }
    }
}

macro_rules! atomic_memcpy_vec {
    (
        $(#[$attrs:meta])*
        $load_name:ident, $store_name:ident, $vec_size:tt, $align:ty, $movdqa:tt, $movdqu:tt,
        $word:tt, $mm0:tt, $mm1:tt, $mm2:tt, $mm3:tt, $mm4:tt, $mm5:tt, $mm6:tt, $mm7:tt,
    ) => {
        atomic_memcpy_vec! {@
            $load_name, $vec_size, $align, $movdqa, $movdqu, $movdqu, true,
            $word, $mm0, $mm1, $mm2, $mm3, $mm4, $mm5, $mm6, $mm7,
        }
        atomic_memcpy_vec! {@
            $store_name, $vec_size, $align, $movdqu, $movdqa, $movdqu, false,
            $word, $mm0, $mm1, $mm2, $mm3, $mm4, $mm5, $mm6, $mm7,
        }
    };
    (@
        $(#[$attrs:meta])*
        $name:ident, $vec_size:tt, $align:ty, $load:tt, $store:tt, $movdqu:tt, $is_load:tt,
        $word:tt, $mm0:tt, $mm1:tt, $mm2:tt, $mm3:tt, $mm4:tt, $mm5:tt, $mm6:tt, $mm7:tt,
    ) => {
        $(#[$attrs])*
        #[inline]
        unsafe fn $name(
            mut dst: *mut MaybeUninit<u8>,
            mut src: *const MaybeUninit<u8>,
            count: NonZeroUsize,
        ) {
            let count = count.get();
            debug_assert!(count >= $vec_size);
            if count <= $vec_size << 1 {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!($movdqu, " ", $mm0, ", ", $word, " ptr [{src", ptr_modifier!(), "}]"), // ymm0 = *src
                        concat!($movdqu, " ", $mm1, ", ", $word, " ptr [{src_end", ptr_modifier!(), "} - ", $vec_size, "]"), // ymm0 = *src
                        concat!($movdqu, " ", $word, " ptr [{dst", ptr_modifier!(), "}], ", $mm0), // *dst = ymm0
                        concat!($movdqu, " ", $word, " ptr [{dst_end", ptr_modifier!(), "} - ", $vec_size, "], ", $mm1), // *dst = ymm0
                        dst = in(reg) dst,
                        src = in(reg) src,
                        dst_end = in(reg) dst.add(count),
                        src_end = in(reg) src.add(count),
                        out($mm0) _,
                        out($mm1) _,
                        options(nostack, preserves_flags),
                    );
                }
                if $vec_size >= 32 {
                    #[cfg(target_arch = "x86")]
                    unsafe { core::arch::x86::_mm256_zeroupper() }
                    #[cfg(target_arch = "x86_64")]
                    unsafe { core::arch::x86_64::_mm256_zeroupper() }
                }
                return
            }

            let (first, mid, last) = if $is_load {
                // SAFETY: MaybeUninit is valid representation for all types.
                let (first, mid, last) = unsafe {
                    core::slice::from_raw_parts(src, count)
                        .align_to::<core::cell::UnsafeCell<MaybeUninit<$align>>>()
                };
                (first.len(), mid.len(), last.len())
            } else {
                // SAFETY: MaybeUninit is valid representation for all types.
                let (first, mid, last) = unsafe {
                    core::slice::from_raw_parts(dst, count)
                        .align_to::<core::cell::UnsafeCell<MaybeUninit<$align>>>()
                };
                (first.len(), mid.len(), last.len())
            };

            if let Some(count) = NonZeroUsize::new(first) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!($movdqu, " ", $mm0, ", ", $word, " ptr [{src", ptr_modifier!(), "}]"), // ymm0 = *src
                        concat!($movdqu, " ", $word, " ptr [{dst", ptr_modifier!(), "}], ", $mm0), // *dst = ymm0
                        dst = in(reg) dst,
                        src = in(reg) src,
                        out($mm0) _,
                        options(nostack, preserves_flags),
                    );
                    dst = dst.add(count.get());
                    src = src.add(count.get());
                }
            }

            if let Some(count) = NonZeroUsize::new(mid) {
                let mut count = count.get();
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    'mid: {
                        // 1 (0b0001): -          ->  x
                        // 2 (0b0010): - -        ->  - -
                        // 3 (0b0011): - - -      ->  x - -
                        // 4 (0b0100): - - - -    ->  - - - -
                        // 5 (0b0101): - - - - -  ->  x - - - -
                        if count & 0b1 != 0 {
                            asm!(
                                concat!($load, " ", $mm0, ", ", $word, " ptr [{src", ptr_modifier!(), "}]"), // ymm0 = *src
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "}], ", $mm0), // *dst = ymm0
                                dst = in(reg) dst,
                                src = in(reg) src,
                                out($mm0) _,
                                options(nostack, preserves_flags),
                            );
                            src = src.add($vec_size);
                            dst = dst.add($vec_size);
                            count = count.wrapping_sub(1); // can use unchecked_sub
                            if count == 0 {
                                break 'mid;
                            }
                        }
                        // 2x
                        // 2 (0b0010): - -        ->  x x
                        // 3 (0b0011): x - -      ->  x x x
                        // 4 (0b0100): - - - -    ->  - - - -
                        // 5 (0b0101): x - - - -  ->  x - - - -
                        if count & 0b10 != 0 {
                            asm!(
                                concat!($load, " ", $mm0, ", ", $word, " ptr [{src", ptr_modifier!(), "}]"),        // ymm0 = *src
                                concat!($load, " ", $mm1, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*1]"), // ymm1 = *src.byte_add(32*1)
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "}], ", $mm0),        // *dst = ymm0
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*1], ", $mm1, ""), // *dst.byte_add(32*1) = ymm1
                                dst = in(reg) dst,
                                src = in(reg) src,
                                out($mm0) _,
                                out($mm1) _,
                                options(nostack, preserves_flags),
                            );
                            src = src.add($vec_size * 2);
                            dst = dst.add($vec_size * 2);
                            count = count.wrapping_sub(2); // can use unchecked_sub
                            if count == 0 {
                                break 'mid;
                            }
                        }
                        // 4x
                        // 4 (0b0100): - - - -    ->  x x x x
                        // 5 (0b0101): x - - - -  ->  x x x x x
                        if count & 0b100 != 0 {
                            asm!(
                                concat!($load, " ", $mm0, ", ", $word, " ptr [{src", ptr_modifier!(), "}]"),        // ymm0 = *src
                                concat!($load, " ", $mm1, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*1]"), // ymm1 = *src.byte_add(32*1)
                                concat!($load, " ", $mm2, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*2]"), // ymm1 = *src.byte_add(32*2)
                                concat!($load, " ", $mm3, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*3]"), // ymm1 = *src.byte_add(32*3)
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "}], ", $mm0),        // *dst = ymm0
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*1], ", $mm1), // *dst.byte_add(32*1) = ymm1
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*2], ", $mm2), // *dst.byte_add(32*2) = ymm1
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*3], ", $mm3), // *dst.byte_add(32*3) = ymm1
                                dst = in(reg) dst,
                                src = in(reg) src,
                                out($mm0) _,
                                out($mm1) _,
                                out($mm2) _,
                                out($mm3) _,
                                options(nostack, preserves_flags),
                            );
                            src = src.add($vec_size * 4);
                            dst = dst.add($vec_size * 4);
                            count = count.wrapping_sub(4); // can use unchecked_sub
                            if count == 0 {
                                break 'mid;
                            }
                        }
                        // 8x
                        count >>= 3;
                        loop {
                            asm!(
                                concat!($load, " ", $mm0, ", ", $word, " ptr [{src", ptr_modifier!(), "}]"),        // ymm0 = *src
                                concat!($load, " ", $mm1, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*1]"), // ymm1 = *src.byte_add(32*1)
                                concat!($load, " ", $mm2, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*2]"), // ymm1 = *src.byte_add(32*2)
                                concat!($load, " ", $mm3, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*3]"), // ymm1 = *src.byte_add(32*3)
                                concat!($load, " ", $mm4, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*4]"), // ymm1 = *src.byte_add(32*4)
                                concat!($load, " ", $mm5, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*5]"), // ymm1 = *src.byte_add(32*5)
                                concat!($load, " ", $mm6, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*6]"), // ymm1 = *src.byte_add(32*6)
                                concat!($load, " ", $mm7, ", ", $word, " ptr [{src", ptr_modifier!(), "} + ", $vec_size, "*7]"), // ymm1 = *src.byte_add(32*7)
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "}], ", $mm0),        // *dst = ymm0
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*1], ", $mm1), // *dst.byte_add(32*1) = ymm1
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*2], ", $mm2), // *dst.byte_add(32*2) = ymm1
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*3], ", $mm3), // *dst.byte_add(32*3) = ymm1
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*4], ", $mm4), // *dst.byte_add(32*4) = ymm1
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*5], ", $mm5), // *dst.byte_add(32*5) = ymm1
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*6], ", $mm6), // *dst.byte_add(32*6) = ymm1
                                concat!($store, " ", $word, " ptr [{dst", ptr_modifier!(), "} + ", $vec_size, "*7], ", $mm7), // *dst.byte_add(32*7) = ymm1
                                dst = in(reg) dst,
                                src = in(reg) src,
                                out($mm0) _,
                                out($mm1) _,
                                out($mm2) _,
                                out($mm3) _,
                                out($mm4) _,
                                out($mm5) _,
                                out($mm6) _,
                                out($mm7) _,
                                options(nostack, preserves_flags),
                            );
                            src = src.add($vec_size * 8);
                            dst = dst.add($vec_size * 8);
                            count = count.wrapping_sub(1); // can use unchecked_sub
                            if count == 0 {
                                break 'mid;
                            }
                        }
                    }
                }
            }

            if let Some(count) = NonZeroUsize::new(last) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    dst = dst.add(count.get());
                    src = src.add(count.get());
                    asm!(
                        concat!($movdqu, " ", $mm0, ", ", $word, " ptr [{src", ptr_modifier!(), "} - ", $vec_size, "]"), // ymm0 = *src
                        concat!($movdqu, " ", $word, " ptr [{dst", ptr_modifier!(), "} - ", $vec_size, "], ", $mm0), // *dst = ymm0
                        dst = in(reg) dst,
                        src = in(reg) src,
                        out($mm0) _,
                        options(nostack, preserves_flags),
                    );
                }
            }

            if $vec_size >= 32 {
                #[cfg(target_arch = "x86")]
                unsafe { core::arch::x86::_mm256_zeroupper() }
                #[cfg(target_arch = "x86_64")]
                unsafe { core::arch::x86_64::_mm256_zeroupper() }
            }
        }
    };
}
atomic_memcpy_vec! {
    #[cfg(target_feature = "sse2")]
    atomic_load_memcpy_sse2, atomic_store_memcpy_sse2,
    16, crate::Align16, "movdqa", "movdqu",
    "xmmword", "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6", "xmm7",
}
atomic_memcpy_vec! {
    #[cfg(target_feature = "sse2")]
    #[cfg(not(all(
        not(target_feature = "avx"),
        any(
            atomic_maybe_uninit_no_outline_atomics,
            target_env = "sgx",
            not(target_feature = "sse"),
        ),
    )))]
    #[target_feature(enable = "avx")]
    atomic_load_memcpy_avx, atomic_store_memcpy_avx,
    32, crate::Align32, "vmovdqa", "vmovdqu",
    "ymmword", "ymm0", "ymm1", "ymm2", "ymm3", "ymm4", "ymm5", "ymm6", "ymm7",
}
atomic_memcpy_vec! {
    #[cfg(target_feature = "sse2")]
    #[cfg(not(all(
        not(target_feature = "avx512f"),
        any(
            atomic_maybe_uninit_no_outline_atomics,
            target_env = "sgx",
            not(target_feature = "sse"),
        ),
    )))]
    #[target_feature(enable = "avx512f")]
    atomic_load_memcpy_avx512f, atomic_store_memcpy_avx512f,
    64, crate::Align64, "vmovdqa64", "vmovdqu64",
    "zmmword", "zmm0", "zmm1", "zmm2", "zmm3", "zmm4", "zmm5", "zmm6", "zmm7",
}

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
macro_rules! cfg_has_atomic_memcpy {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_memcpy {
    ($($tt:tt)*) => {};
}
