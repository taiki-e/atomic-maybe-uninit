// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
RISC-V

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#risc-v

Refs:
- RISC-V Instruction Set Manual
  https://github.com/riscv/riscv-isa-manual
- RISC-V Atomics ABI Specification
  https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/draft-20250812-301374e92976e298e676e7129a6212926b2299ce/riscv-atomic.adoc
- portable-atomic
  https://github.com/taiki-e/portable-atomic

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

delegate_size!(delegate_load_store);
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zaamo",
    atomic_maybe_uninit_target_feature = "zaamo",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
))]
delegate_size!(delegate_swap);
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
    target_feature = "zacas",
    atomic_maybe_uninit_target_feature = "zacas",
))]
delegate_size!(delegate_cas);

pub(crate) use core::sync::atomic::fence;
use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    num::NonZeroUsize,
    sync::atomic::Ordering,
};

#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
    target_feature = "zacas",
    atomic_maybe_uninit_target_feature = "zacas",
))]
use crate::raw::AtomicCompareExchange;
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zaamo",
    atomic_maybe_uninit_target_feature = "zaamo",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
))]
use crate::raw::AtomicSwap;
use crate::raw::{AtomicLoad, AtomicMemcpy, AtomicStore};
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
    target_feature = "zacas",
    atomic_maybe_uninit_target_feature = "zacas",
))]
use crate::utils::RegSize;
#[cfg(target_arch = "riscv32")]
#[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
use crate::utils::{MaybeUninit64 as MaybeUninitDw, Pair};
#[cfg(target_arch = "riscv64")]
#[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
use crate::utils::{MaybeUninit128 as MaybeUninitDw, Pair};

#[cfg(not(all(
    not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
    any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
cfg_sel!({
    #[cfg(any(
        target_feature = "a",
        atomic_maybe_uninit_target_feature = "a",
        target_feature = "zalrsc",
        atomic_maybe_uninit_target_feature = "zalrsc",
        target_feature = "zacas",
        atomic_maybe_uninit_target_feature = "zacas",
    ))]
    {
        #[cfg(target_arch = "riscv32")]
        macro_rules! w {
            () => {
                ""
            };
        }
        #[cfg(target_arch = "riscv64")]
        macro_rules! w {
            () => {
                "w"
            };
        }

        macro_rules! sllw {
            ($val:expr, $shift:expr) => {{
                let mut val = $val;
                let shift: RegSize = $shift;
                #[allow(unused_unsafe)]
                // SAFETY: calling SLL{,W} is safe
                unsafe {
                    asm!(
                        concat!("sll", w!(), " {val}, {val}, {shift}"), // val <<= shift & 31
                        val = inout(reg) val,
                        shift = in(reg) shift,
                        options(pure, nomem, nostack, preserves_flags),
                    );
                }
                val
            }};
        }
        #[inline(always)]
        fn srlw(mut val: MaybeUninit<u32>, shift: RegSize) -> MaybeUninit<u32> {
            // SAFETY: calling SRL{,W} is safe
            unsafe {
                asm!(
                    concat!("srl", w!(), " {val}, {val}, {shift}"), // val >>= shift & 31
                    val = inout(reg) val,
                    shift = in(reg) shift,
                    options(pure, nomem, nostack, preserves_flags),
                );
            }
            val
        }
    }
});

#[cfg(all(
    any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
))]
#[cfg(target_arch = "riscv32")]
macro_rules! xlen {
    () => {
        "32"
    };
}
#[cfg(all(
    any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
))]
#[cfg(target_arch = "riscv64")]
macro_rules! xlen {
    () => {
        "64"
    };
}

#[cfg(all(
    not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
    any(
        target_feature = "a",
        atomic_maybe_uninit_target_feature = "a",
        target_feature = "zaamo",
        atomic_maybe_uninit_target_feature = "zaamo",
    ),
))]
macro_rules! atomic_rmw_amo {
    ($op:ident, $order:ident) => {
        // op(order)
        match $order {
            Ordering::Relaxed => $op!(""),
            Ordering::Acquire => $op!(".aq"),
            Ordering::Release => $op!(".rl"),
            // AcqRel and SeqCst RMWs are equivalent.
            Ordering::AcqRel | Ordering::SeqCst => $op!(".aqrl"),
            _ => unreachable!(),
        }
    };
}
#[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
macro_rules! atomic_rmw_amocas {
    ($op:ident, $order:ident) => {
        atomic_rmw_amocas!($op, $order, failure = $order)
    };
    ($op:ident, $order:ident, failure = $failure:ident) => {
        // op(fence, order)
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!("", ".aq"),
            Ordering::Release => $op!("", ".rl"),
            Ordering::AcqRel => $op!("", ".aqrl"),
            Ordering::SeqCst if $failure == Ordering::SeqCst => $op!("fence rw,rw", ".aqrl"),
            Ordering::SeqCst => $op!("", ".aqrl"),
            _ => unreachable!(),
        }
    };
}
#[cfg(not(all(
    not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
    any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
#[cfg(not(all(
    atomic_maybe_uninit_test_prefer_zacas_over_zalrsc_for_sub_word,
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
))]
macro_rules! atomic_rmw_lr_sc {
    ($op:ident, $order:ident) => {
        // op(acquire, release)
        match $order {
            Ordering::Relaxed => $op!("", ""),
            Ordering::Acquire => $op!(".aq", ""),
            Ordering::Release => $op!("", ".rl"),
            Ordering::AcqRel => $op!(".aq", ".rl"),
            Ordering::SeqCst => $op!(".aqrl", ".rl"),
            _ => unreachable!(),
        }
    };
}

// -----------------------------------------------------------------------------
// Register-width or smaller atomics

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $($size:literal)?, $suffix:tt) => {
        delegate_signed!(delegate_load_store, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! atomic_load {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                  // fence
                                concat!("l", $suffix, " {out}, 0({src})"), // atomic { out = sign_extend(*src) }
                                $acquire,                                  // fence
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("fence r, rw", ""),
                        Ordering::SeqCst => atomic_load!("fence r, rw", "fence rw, rw"),
                        _ => crate::utils::unreachable_unchecked(),
                    }
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
                    macro_rules! atomic_store {
                        ($acquire:tt, $release:tt) => {
                            asm!(
                                $release,                                  // fence
                                concat!("s", $suffix, " {val}, 0({dst})"), // atomic { *dst = val }
                                $acquire,                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "fence rw, w"),
                        // https://github.com/llvm/llvm-project/commit/3ea8f2526541884e03d5bd4f4e46f4eb190990b6
                        Ordering::SeqCst => atomic_store!("fence rw, rw", "fence rw, w"),
                        _ => crate::utils::unreachable_unchecked(),
                    }
                }
            }
        }
        $(
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("l", $suffix, " {tmp0}, 0({src})"), // atomic { tmp0 = *src }
                    concat!("addi {src}, {src}, ", $size),      // src = src.byte_add($size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("l", $suffix, " {tmp1}, ", $size, "({src})"), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("l", $suffix, " {tmp0}, 0({src})"),           // atomic { tmp0 = *src }
                    concat!("addi {src}, {src}, 2*", $size),              // src = src.byte_add(2*$size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("s", $suffix, " {tmp0}, 0({dst})"), // atomic { *dst = tmp0 }
                    concat!("addi {dst}, {dst}, ", $size),      // dst = dst.byte_add($size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("s", $suffix, " {tmp1}, ", $size, "({dst})"), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("s", $suffix, " {tmp0}, 0({dst})"),           // atomic { *dst = tmp0 }
                    concat!("addi {dst}, {dst}, 2*", $size),              // dst = dst.byte_add(2*$size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
        }
        )?
    };
}

#[cfg(all(
    not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
    any(
        target_feature = "a",
        atomic_maybe_uninit_target_feature = "a",
        target_feature = "zaamo",
        atomic_maybe_uninit_target_feature = "zaamo",
    ),
))]
#[rustfmt::skip]
macro_rules! atomic_zaamo {
    ($ty:ident, $suffix:tt) => {
        delegate_signed!(delegate_swap, $ty);
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zaamo extension.
                unsafe {
                    macro_rules! swap {
                        ($order:tt) => {
                            asm!(
                                concat!("amoswap.", $suffix, $order, " {out}, {val}, 0({dst})"), // atomic { _x = *dst; *dst = val; out = sign_extend(_x) }
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_amo!(swap, order);
                }
                out
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $($size:literal)?, $suffix:tt) => {
        atomic_load_store!($ty, $($size)?, $suffix);

        // swap
        cfg_sel!({
            #[cfg(all(
                not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
                any(
                    target_feature = "a",
                    atomic_maybe_uninit_target_feature = "a",
                    target_feature = "zaamo",
                    atomic_maybe_uninit_target_feature = "zaamo",
                ),
            ))]
            {
                atomic_zaamo!($ty, $suffix);
            }
            #[cfg(any(
                target_feature = "a",
                atomic_maybe_uninit_target_feature = "a",
                target_feature = "zalrsc",
                atomic_maybe_uninit_target_feature = "zalrsc",
            ))]
            {
                delegate_signed!(delegate_swap, $ty);
                impl AtomicSwap for $ty {
                    #[inline]
                    unsafe fn atomic_swap(
                        dst: *mut MaybeUninit<Self>,
                        val: MaybeUninit<Self>,
                        order: Ordering,
                    ) -> MaybeUninit<Self> {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let mut out: MaybeUninit<Self>;

                        // SAFETY: the caller must uphold the safety contract,
                        // the cfg guarantee that the CPU supports Zalrsc extension.
                        unsafe {
                            macro_rules! swap {
                                ($acquire:tt, $release:tt) => {
                                    asm!(
                                        "2:", // 'retry:
                                            concat!("lr.", $suffix, $acquire, " {out}, 0({dst})"),      // atomic { out = sign_extend(*dst); RS = dst }
                                            concat!("sc.", $suffix, $release, " {r}, {val}, 0({dst})"), // atomic { if RS == dst { *dst = val; r = 0 } else { r = nonzero }; RS = None }
                                            "bnez {r}, 2b",                                             // if r != 0 { jump 'retry }
                                        dst = in(reg) ptr_reg!(dst),
                                        val = in(reg) val,
                                        out = out(reg) out,
                                        r = out(reg) _,
                                        options(nostack, preserves_flags),
                                    )
                                };
                            }
                            atomic_rmw_lr_sc!(swap, order);
                        }
                        out
                    }
                }
            }
        });

        // compare_exchange
        cfg_sel!({
            #[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
            {
                delegate_signed!(delegate_cas, $ty);
                impl AtomicCompareExchange for $ty {
                    #[inline]
                    unsafe fn atomic_compare_exchange(
                        dst: *mut MaybeUninit<Self>,
                        old: MaybeUninit<Self>,
                        new: MaybeUninit<Self>,
                        success: Ordering,
                        failure: Ordering,
                    ) -> (MaybeUninit<Self>, bool) {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let order = crate::utils::upgrade_success_ordering(success, failure);
                        let mut out: MaybeUninit<Self>;
                        let mut r: RegSize;

                        // SAFETY: the caller must uphold the safety contract,
                        // the cfg guarantee that the CPU supports Zacas extension.
                        unsafe {
                            macro_rules! cmpxchg {
                                ($fence:tt, $order:tt) => {
                                    asm!(
                                        $fence,                                                         // fence
                                        // old will be used for later comparison.
                                        "mv {out}, {old}",                                              // out = old
                                        concat!("amocas.", $suffix, $order, " {out}, {new}, 0({dst})"), // atomic { if *dst == out { *dst = new } else { out = sign_extend(*dst) } }
                                        "xor {r}, {out}, {old}",                                        // r = out ^ old
                                        "seqz {r}, {r}",                                                // if r == 0 { r = 1 } else { r = 0 }
                                        dst = in(reg) ptr_reg!(dst),
                                        old = in(reg) old,
                                        new = in(reg) new,
                                        out = out(reg) out,
                                        r = lateout(reg) r,
                                        options(nostack, preserves_flags),
                                    )
                                };
                            }
                            atomic_rmw_amocas!(cmpxchg, order, failure = failure);
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                        }
                        (out, r != 0)
                    }
                }
            }
            #[cfg(any(
                target_feature = "a",
                atomic_maybe_uninit_target_feature = "a",
                target_feature = "zalrsc",
                atomic_maybe_uninit_target_feature = "zalrsc",
            ))]
            {
                delegate_signed!(delegate_cas, $ty);
                impl AtomicCompareExchange for $ty {
                    // Note: both GCC 15 and LLVM 22 implement weak CAS with strong CAS: https://godbolt.org/z/3jab5WGK3
                    #[inline]
                    unsafe fn atomic_compare_exchange(
                        dst: *mut MaybeUninit<Self>,
                        old: MaybeUninit<Self>,
                        new: MaybeUninit<Self>,
                        success: Ordering,
                        failure: Ordering,
                    ) -> (MaybeUninit<Self>, bool) {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let order = crate::utils::upgrade_success_ordering(success, failure);
                        let mut out: MaybeUninit<Self>;
                        let mut r: RegSize = 1;

                        // SAFETY: the caller must uphold the safety contract,
                        // the cfg guarantee that the CPU supports Zalrsc extension.
                        unsafe {
                            macro_rules! cmpxchg {
                                ($acquire:tt, $release:tt) => {
                                    asm!(
                                        "2:", // 'retry:
                                            concat!("lr.", $suffix, $acquire, " {out}, 0({dst})"),      // atomic { out = sign_extend(*dst); RS = dst }
                                            "bne {out}, {old}, 3f",                                     // if out != old { jump 'cmp-fail }
                                            concat!("sc.", $suffix, $release, " {r}, {new}, 0({dst})"), // atomic { if RS == dst { *dst = new; r = 0 } else { r = nonzero }; RS = None }
                                            "bnez {r}, 2b",                                             // if r != 0 { jump 'retry }
                                        "3:", // 'cmp-fail:
                                        dst = in(reg) ptr_reg!(dst),
                                        old = in(reg) old,
                                        new = in(reg) new,
                                        out = out(reg) out,
                                        r = inout(reg) r,
                                        options(nostack, preserves_flags),
                                    )
                                };
                            }
                            atomic_rmw_lr_sc!(cmpxchg, order);
                        }
                        // 0 if the store was successful, 1 or nonzero if no store was performed
                        (out, r == 0)
                    }
                }
            }
        });
    };
}

#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($ty:ident, $size:literal, $suffix:tt) => {
        atomic_load_store!($ty, $size, $suffix);

        // swap
        cfg_sel!({
            #[cfg(all(
                not(atomic_maybe_uninit_test_prefer_zalrsc_over_zaamo),
                any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
            ))]
            {
                atomic_zaamo!($ty, $suffix);
            }
            #[cfg(all(
                not(all(
                    atomic_maybe_uninit_test_prefer_zacas_over_zalrsc_for_sub_word,
                    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
                )),
                any(
                    target_feature = "a",
                    atomic_maybe_uninit_target_feature = "a",
                    target_feature = "zalrsc",
                    atomic_maybe_uninit_target_feature = "zalrsc",
                ),
            ))]
            {
                delegate_signed!(delegate_swap, $ty);
                impl AtomicSwap for $ty {
                    #[inline]
                    unsafe fn atomic_swap(
                        dst: *mut MaybeUninit<Self>,
                        val: MaybeUninit<Self>,
                        order: Ordering,
                    ) -> MaybeUninit<Self> {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                        let mut out: MaybeUninit<u32>;

                        // SAFETY: the caller must uphold the safety contract,
                        // the cfg guarantee that the CPU supports Zalrsc extension.
                        unsafe {
                            // Implement sub-word atomic operations using word-sized LL/SC loop.
                            // See also create_sub_word_mask_values.
                            macro_rules! swap {
                                ($acquire:tt, $release:tt) => {
                                    asm!(
                                        "2:", // 'retry:
                                            concat!("lr.w", $acquire, " {out}, 0({dst})"),        // atomic { out = sign_extend(*dst); RS = dst }
                                            "and {tmp}, {out}, {mask}",                           // tmp = out & mask
                                            "or {tmp}, {tmp}, {val}",                             // tmp |= val
                                            concat!("sc.w", $release, " {tmp}, {tmp}, 0({dst})"), // atomic { if RS == dst { *dst = tmp; tmp = 0 } else { tmp = nonzero }; RS = None }
                                            "bnez {tmp}, 2b",                                     // if tmp != 0 { jump 'retry }
                                        dst = in(reg) ptr_reg!(dst),
                                        val = in(reg) sllw!(crate::utils::extend32::$ty::zero(val), shift),
                                        out = out(reg) out,
                                        mask = in(reg) !sllw!(mask, shift),
                                        tmp = out(reg) _,
                                        options(nostack, preserves_flags),
                                    )
                                };
                            }
                            atomic_rmw_lr_sc!(swap, order);
                        }
                        crate::utils::extend32::$ty::extract(srlw(out, shift))
                    }
                }
            }
            #[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
            {
                delegate_signed!(delegate_swap, $ty);
                impl AtomicSwap for $ty {
                    #[inline]
                    unsafe fn atomic_swap(
                        dst: *mut MaybeUninit<Self>,
                        val: MaybeUninit<Self>,
                        order: Ordering,
                    ) -> MaybeUninit<Self> {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                        let mut out: MaybeUninit<u32>;

                        // SAFETY: the caller must uphold the safety contract.
                        unsafe {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            macro_rules! swap {
                                // fence is not emitted because we retry until CAS success
                                ($_fence:tt, $order:tt) => {
                                    asm!(
                                        "lw {out}, 0({dst})",                                       // atomic { out = sign_extend(*dst) }
                                        "2:", // 'retry:
                                            // out_tmp will be used for later comparison.
                                            "mv {out_tmp}, {out}",                                  // out_tmp = out
                                            "and {tmp}, {out}, {mask}",                             // tmp = out & mask
                                            "or {tmp}, {tmp}, {val}",                               // tmp |= val
                                            concat!("amocas.w", $order, " {out}, {tmp}, 0({dst})"), // atomic { if *dst == out { *dst = tmp } else { out = sign_extend(*dst) } }
                                            "bne {out}, {out_tmp}, 2b",                             // if out != out_tmp { jump 'retry }
                                        dst = in(reg) ptr_reg!(dst),
                                        val = in(reg) sllw!(crate::utils::extend32::$ty::zero(val), shift),
                                        out = out(reg) out,
                                        mask = in(reg) !sllw!(mask, shift),
                                        tmp = out(reg) _,
                                        out_tmp = out(reg) _,
                                        options(nostack, preserves_flags),
                                    )
                                };
                            }
                            atomic_rmw_amocas!(swap, order);
                        }
                        crate::utils::extend32::$ty::extract(srlw(out, shift))
                    }
                }
            }
        });

        // compare_exchange
        cfg_sel!({
            #[cfg(all(
                any(target_feature = "zabha", atomic_maybe_uninit_target_feature = "zabha"),
                any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
            ))]
            {
                delegate_signed!(delegate_cas, $ty);
                impl AtomicCompareExchange for $ty {
                    #[inline]
                    unsafe fn atomic_compare_exchange(
                        dst: *mut MaybeUninit<Self>,
                        old: MaybeUninit<Self>,
                        new: MaybeUninit<Self>,
                        success: Ordering,
                        failure: Ordering,
                    ) -> (MaybeUninit<Self>, bool) {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let order = crate::utils::upgrade_success_ordering(success, failure);
                        let mut out: MaybeUninit<Self>;
                        let mut r: RegSize;

                        // SAFETY: the caller must uphold the safety contract,
                        // the cfg guarantee that the CPU supports Zacas extension.
                        unsafe {
                            macro_rules! cmpxchg {
                                ($fence:tt, $order:tt) => {
                                    asm!(
                                        $fence,                                                         // fence
                                        // old will be used for later comparison.
                                        "mv {out}, {old}",                                              // out = old
                                        concat!("slli {old}, {old}, ", xlen!(), "-", $size, "*8"),      // old <<= XLEN - $size * 8
                                        concat!("amocas.", $suffix, $order, " {out}, {new}, 0({dst})"), // atomic { if *dst == out { *dst = new } else { out = sign_extend(*dst) } }
                                        concat!("srai {old}, {old}, ", xlen!(), "-", $size, "*8"),      // old >>= XLEN - $size * 8
                                        "xor {r}, {out}, {old}",                                        // r = out ^ old
                                        "seqz {r}, {r}",                                                // if r == 0 { r = 1 } else { r = 0 }
                                        dst = in(reg) ptr_reg!(dst),
                                        old = inout(reg) old => _,
                                        new = in(reg) new,
                                        out = out(reg) out,
                                        r = lateout(reg) r,
                                        options(nostack, preserves_flags),
                                    )
                                };
                            }
                            atomic_rmw_amocas!(cmpxchg, order, failure = failure);
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                        }
                        (out, r != 0)
                    }
                }
            }
            #[cfg(all(
                not(all(
                    atomic_maybe_uninit_test_prefer_zacas_over_zalrsc_for_sub_word,
                    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
                )),
                any(
                    target_feature = "a",
                    atomic_maybe_uninit_target_feature = "a",
                    target_feature = "zalrsc",
                    atomic_maybe_uninit_target_feature = "zalrsc",
                ),
            ))]
            {
                delegate_signed!(delegate_cas, $ty);
                impl AtomicCompareExchange for $ty {
                    // Note: both GCC 15 and LLVM 22 implement weak CAS with strong CAS: https://godbolt.org/z/3jab5WGK3
                    #[inline]
                    unsafe fn atomic_compare_exchange(
                        dst: *mut MaybeUninit<Self>,
                        old: MaybeUninit<Self>,
                        new: MaybeUninit<Self>,
                        success: Ordering,
                        failure: Ordering,
                    ) -> (MaybeUninit<Self>, bool) {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let order = crate::utils::upgrade_success_ordering(success, failure);
                        let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                        let mut out: MaybeUninit<u32>;
                        let mut r: RegSize;

                        // SAFETY: the caller must uphold the safety contract,
                        // the cfg guarantee that the CPU supports Zalrsc extension.
                        unsafe {
                            // Implement sub-word atomic operations using word-sized LL/SC loop.
                            // Based on assemblies generated by rustc/LLVM.
                            // See also create_sub_word_mask_values.
                            macro_rules! cmpxchg {
                                ($acquire:tt, $release:tt) => {
                                    asm!(
                                        "2:", // 'retry:
                                            concat!("lr.w", $acquire, " {out}, 0({dst})"),        // atomic { out = sign_extend(*dst); RS = dst }
                                            "and {tmp}, {out}, {mask}",                           // tmp = out & mask
                                            "bne {tmp}, {old}, 3f",                               // if tmp != old { jump 'cmp-fail }
                                            "xor {tmp}, {out}, {new}",                            // tmp = out ^ new
                                            "and {tmp}, {tmp}, {mask}",                           // tmp &= mask
                                            "xor {tmp}, {tmp}, {out}",                            // tmp ^= out
                                            concat!("sc.w", $release, " {tmp}, {tmp}, 0({dst})"), // atomic { if RS == dst { *dst = tmp; tmp = 0 } else { tmp = nonzero }; RS = None }
                                            "bnez {tmp}, 2b",                                     // if tmp != 0 { jump 'retry }
                                        "3:", // 'cmp-fail:
                                        "and {tmp}, {out}, {mask}",                               // tmp = out & mask
                                        "xor {tmp}, {tmp}, {old}",                                // tmp ^= old
                                        "seqz {tmp}, {tmp}",                                      // if tmp == 0 { tmp = 1 } else { tmp = 0 }
                                        dst = in(reg) ptr_reg!(dst),
                                        old = in(reg) sllw!(crate::utils::extend32::$ty::zero(old), shift),
                                        new = in(reg) sllw!(crate::utils::extend32::$ty::zero(new), shift),
                                        out = out(reg) out,
                                        mask = in(reg) sllw!(mask, shift),
                                        tmp = out(reg) r,
                                        options(nostack, preserves_flags),
                                    )
                                };
                            }
                            atomic_rmw_lr_sc!(cmpxchg, order);
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                        }
                        (crate::utils::extend32::$ty::extract(srlw(out, shift)), r != 0)
                    }
                }
            }
            #[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
            {
                delegate_signed!(delegate_cas, $ty);
                impl AtomicCompareExchange for $ty {
                    #[inline]
                    unsafe fn atomic_compare_exchange(
                        dst: *mut MaybeUninit<Self>,
                        old: MaybeUninit<Self>,
                        new: MaybeUninit<Self>,
                        success: Ordering,
                        failure: Ordering,
                    ) -> (MaybeUninit<Self>, bool) {
                        debug_assert_atomic_unsafe_precondition!(dst, $ty);
                        let order = crate::utils::upgrade_success_ordering(success, failure);
                        let (dst, shift, mask) = crate::utils::create_sub_word_mask_values(dst);
                        let mut out: MaybeUninit<u32>;
                        let mut r: RegSize;

                        // SAFETY: the caller must uphold the safety contract.
                        unsafe {
                            use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            macro_rules! cmpxchg_fail_relaxed {
                                ($failure_release:tt, $order:tt) => {
                                    asm!(
                                        $failure_release,                                           // fence
                                        "lw {out}, 0({dst})",                                       // atomic { out = sign_extend(*dst) }
                                        "2:", // 'retry:
                                            // out_tmp will be used for later comparison.
                                            "mv {out_tmp}, {out}",                                  // out_tmp = out
                                            "and {tmp}, {out}, {mask}",                             // tmp = out & mask
                                            "bne {tmp}, {old}, 3f",                                 // if tmp != old { jump 'cmp-fail }
                                            "xor {tmp}, {out}, {new}",                              // tmp = out ^ new
                                            "and {tmp}, {tmp}, {mask}",                             // tmp &= mask
                                            "xor {tmp}, {tmp}, {out}",                              // tmp ^= out
                                            concat!("amocas.w", $order, " {out}, {tmp}, 0({dst})"), // atomic { if *dst == out { *dst = tmp } else { tmp = sign_extend(*dst) } }
                                            "bne {out}, {out_tmp}, 2b",                             // if out != out_tmp { jump 'retry }
                                        "3:", // 'cmp-fail:
                                        "and {tmp}, {out}, {mask}",                                 // tmp = out & mask
                                        "xor {tmp}, {old}, {tmp}",                                  // tmp ^= old
                                        "seqz {tmp}, {tmp}",                                        // if tmp == 0 { tmp = 1 } else { tmp = 0 }
                                        dst = in(reg) ptr_reg!(dst),
                                        old = in(reg) sllw!(crate::utils::extend32::$ty::zero(old), shift),
                                        new = in(reg) sllw!(crate::utils::extend32::$ty::zero(new), shift),
                                        out = out(reg) out,
                                        mask = in(reg) sllw!(mask, shift),
                                        tmp = out(reg) r,
                                        out_tmp = out(reg) _,
                                        options(nostack, preserves_flags),
                                    )
                                };
                            }
                            macro_rules! cmpxchg {
                                ($failure_release:tt, $order:tt) => {
                                    asm!(
                                        $failure_release,                                           // fence
                                        "lw {out}, 0({dst})",                                       // atomic { out = sign_extend(*dst) }
                                        "2:", // 'retry:
                                            // out_tmp will be used for later comparison.
                                            "mv {out_tmp}, {out}",                                  // out_tmp = out
                                            "and {tmp}, {out}, {mask}",                             // tmp = out & mask
                                            "bne {tmp}, {old}, 3f",                                 // if tmp != old { jump 'cmp-fail }
                                            "xor {tmp}, {out}, {new}",                              // tmp = out ^ new
                                            "and {tmp}, {tmp}, {mask}",                             // tmp &= mask
                                            "xor {tmp}, {tmp}, {out}",                              // tmp ^= out
                                            concat!("amocas.w", $order, " {out}, {tmp}, 0({dst})"), // atomic { if *dst == out { *dst = tmp } else { tmp = sign_extend(*dst) } }
                                            "bne {out}, {out_tmp}, 2b",                             // if out != out_tmp { jump 'retry }
                                            "j 4f",                                                 // jump 'success
                                        "3:", // 'cmp-fail:
                                            "fence r, rw",                                          // fence
                                        "4:", // 'success:
                                        "and {tmp}, {out}, {mask}",                                 // tmp = out & mask
                                        "xor {tmp}, {old}, {tmp}",                                  // tmp ^= old
                                        "seqz {tmp}, {tmp}",                                        // if tmp == 0 { tmp = 1 } else { tmp = 0 }
                                        dst = in(reg) ptr_reg!(dst),
                                        old = in(reg) sllw!(crate::utils::extend32::$ty::zero(old), shift),
                                        new = in(reg) sllw!(crate::utils::extend32::$ty::zero(new), shift),
                                        out = out(reg) out,
                                        mask = in(reg) sllw!(mask, shift),
                                        tmp = out(reg) r,
                                        out_tmp = out(reg) _,
                                        options(nostack, preserves_flags),
                                    )
                                };
                            }
                            match (order, failure) {
                                (Relaxed, _) => cmpxchg_fail_relaxed!("", ""),
                                (Acquire, Relaxed) => cmpxchg_fail_relaxed!("", ".aq"),
                                (Acquire, Acquire) => cmpxchg!("", ".aq"),
                                (Release, _) => cmpxchg_fail_relaxed!("", ".rl"),
                                (AcqRel | SeqCst, Relaxed) => cmpxchg_fail_relaxed!("", ".aqrl"),
                                (AcqRel | SeqCst, Acquire) => cmpxchg!("", ".aqrl"),
                                (SeqCst, SeqCst) => cmpxchg!("fence rw,rw", ".aqrl"),
                                _ => unreachable!(),
                            }
                            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                        }
                        (crate::utils::extend32::$ty::extract(srlw(out, shift)), r != 0)
                    }
                }
            }
        });
    };
}

atomic_sub_word!(u8, "1", "b");
atomic_sub_word!(u16, "2", "h");
atomic!(u32, "4", "w");
#[cfg(target_arch = "riscv64")]
atomic!(u64,    , "d");

#[cfg(target_arch = "riscv64")]
impl AtomicMemcpy for u64 {
    load_memcpy_opt64! { |src, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7|
        asm!(
            "ld {tmp0}, 0({src})",  // atomic { tmp0 = *src }
            "addi {src}, {src}, 8", // src = src.byte_add(8)
            src = inout(reg) src,
            tmp0 = out(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            "ld {tmp1}, 8({src})",      // atomic { tmp1 = *src.byte_add(8) }
            "ld {tmp0}, 0({src})",      // atomic { tmp0 = *src }
            "addi {src}, {src}, 2*8",   // src = src.byte_add(2*8)
            src = inout(reg) src,
            tmp0 = out(reg) tmp0,
            tmp1 = out(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            "ld {tmp7}, 8*7({src})",    // atomic { tmp7 = *src.byte_add(8*7) }
            "ld {tmp6}, 8*6({src})",    // atomic { tmp6 = *src.byte_add(8*6) }
            "ld {tmp5}, 8*5({src})",    // atomic { tmp5 = *src.byte_add(8*5) }
            "ld {tmp4}, 8*4({src})",    // atomic { tmp4 = *src.byte_add(8*4) }
            "ld {tmp3}, 8*3({src})",    // atomic { tmp3 = *src.byte_add(8*3) }
            "ld {tmp2}, 8*2({src})",    // atomic { tmp2 = *src.byte_add(8*2) }
            "ld {tmp1}, 8*1({src})",    // atomic { tmp1 = *src.byte_add(8*1) }
            "ld {tmp0}, 0({src})",      // atomic { tmp0 = *src }
            "addi {src}, {src}, 8*8",   // src = src.byte_add(8*8)
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
        ),
    }
    store_memcpy_opt64! { |dst, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7|
        asm!(
            "sd {tmp0}, 0({dst})",  // atomic { *dst = tmp0 }
            "addi {dst}, {dst}, 8", // dst = dst.byte_add(8)
            dst = inout(reg) dst,
            tmp0 = in(reg) tmp0,
            options(nostack, preserves_flags),
        ),
        asm!(
            "sd {tmp1}, 8({dst})",      // atomic { *dst.byte_add(8) = tmp1 }
            "sd {tmp0}, 0({dst})",      // atomic { *dst = tmp0 }
            "addi {dst}, {dst}, 2*8",   // dst = dst.byte_add(2*8)
            dst = inout(reg) dst,
            tmp0 = in(reg) tmp0,
            tmp1 = in(reg) tmp1,
            options(nostack, preserves_flags),
        ),
        asm!(
            "sd {tmp7}, 8*7({dst})",    // atomic { *dst.byte_add(8*7) = tmp7 }
            "sd {tmp6}, 8*6({dst})",    // atomic { *dst.byte_add(8*6) = tmp6 }
            "sd {tmp5}, 8*5({dst})",    // atomic { *dst.byte_add(8*5) = tmp5 }
            "sd {tmp4}, 8*4({dst})",    // atomic { *dst.byte_add(8*4) = tmp4 }
            "sd {tmp3}, 8*3({dst})",    // atomic { *dst.byte_add(8*3) = tmp3 }
            "sd {tmp2}, 8*2({dst})",    // atomic { *dst.byte_add(8*2) = tmp2 }
            "sd {tmp1}, 8*1({dst})",    // atomic { *dst.byte_add(8*1) = tmp1 }
            "sd {tmp0}, 0({dst})",      // atomic { *dst = tmp0 }
            "addi {dst}, {dst}, 8*8",   // dst = dst.byte_add(8*8)
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
        ),
    }
}

// -----------------------------------------------------------------------------
// 64-bit atomics on RV32, 128-bit atomics on RV64

#[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
#[rustfmt::skip]
macro_rules! atomic_dw {
    ($ty:ident, $suffix:tt, $reg_size:tt, $reg_size_offset:tt) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let (out_lo, out_hi);

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zacas extension.
                unsafe {
                    macro_rules! atomic_load {
                        ($fence:tt, $order:tt) => {
                            asm!(
                                $fence,                                                   // fence
                                concat!("amocas.", $suffix, $order, " a2, a2, 0({src})"), // atomic { if *dst == a2:a3 { *dst = a2:a3 } else { a2:a3 = *dst } }
                                src = in(reg) ptr_reg!(src),
                                inout("a2") 0 as RegSize => out_lo,
                                inout("a3") 0 as RegSize => out_hi,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        Ordering::Acquire => atomic_load!("", ".aq"),
                        Ordering::SeqCst => atomic_load!("fence rw,rw", ".aqrl"),
                        _ => crate::utils::unreachable_unchecked(),
                    }
                    MaybeUninitDw { pair: Pair { lo: out_lo, hi: out_hi } }.whole
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
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    <$ty as AtomicSwap>::atomic_swap(dst, val, order);
                }
            }
        }
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let val = MaybeUninitDw { whole: val };
                let (mut prev_lo, mut prev_hi);

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zacas extension.
                unsafe {
                    macro_rules! swap {
                        // fence is not emitted because we retry until CAS success
                        ($_fence:tt, $order:tt) => {
                            asm!(
                                // This is not single-copy atomic reads, but this is ok because subsequent
                                // CAS will check for consistency.
                                concat!("l", $reg_size, " a4, ({dst})"),                       // atomic { a4 = *dst }
                                concat!("l", $reg_size, " a5, ", $reg_size_offset, "({dst})"), // atomic { a5 = *dst.byte_add($reg_size_offset) }
                                "2:", // 'retry:
                                    // tmp_lo:tmp_hi will be used for later comparison.
                                    "mv {tmp_lo}, a4",                                         // tmp_lo = a4
                                    "mv {tmp_hi}, a5",                                         // tmp_hi = a5
                                    concat!("amocas.", $suffix, $order, " a4, a2, 0({dst})"),  // atomic { if *dst == a4:a5 { *dst = a2:a3 } else { a4:a5 = *dst } }
                                    "xor {tmp_lo}, {tmp_lo}, a4",                              // tmp_lo ^= a4
                                    "xor {tmp_hi}, {tmp_hi}, a5",                              // tmp_hi ^= a5
                                    "or {tmp_lo}, {tmp_lo}, {tmp_hi}",                         // tmp_lo |= tmp_hi
                                    "bnez {tmp_lo}, 2b",                                       // if tmp_lo != 0 { jump 'retry }
                                dst = in(reg) ptr_reg!(dst),
                                tmp_lo = out(reg) _,
                                tmp_hi = out(reg) _,
                                // must be allocated to even/odd register pair
                                out("a4") prev_lo,
                                out("a5") prev_hi,
                                // must be allocated to even/odd register pair
                                in("a2") val.pair.lo,
                                in("a3") val.pair.hi,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_amocas!(swap, order);
                    MaybeUninitDw { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole
                }
            }
        }
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let order = crate::utils::upgrade_success_ordering(success, failure);
                let old = MaybeUninitDw { whole: old };
                let new = MaybeUninitDw { whole: new };
                let (prev_lo, prev_hi);
                let mut r: RegSize;

                // SAFETY: the caller must uphold the safety contract,
                // the cfg guarantee that the CPU supports Zacas extension.
                unsafe {
                    macro_rules! cmpxchg {
                        ($fence:tt, $order:tt) => {
                            asm!(
                                $fence,                                                   // fence
                                // tmp_lo:tmp_hi will be used for later comparison.
                                "mv {tmp_lo}, a4",                                        // tmp_lo = a4
                                "mv {tmp_hi}, a5",                                        // tmp_hi = a5
                                concat!("amocas.", $suffix, $order, " a4, a2, 0({dst})"), // atomic { if *dst == a4:a5 { *dst = a2:a3 } else { a4:a5 = *dst } }
                                "xor {tmp_lo}, {tmp_lo}, a4",                             // tmp_lo ^= a4
                                "xor {tmp_hi}, {tmp_hi}, a5",                             // tmp_hi ^= a5
                                "or {tmp_lo}, {tmp_lo}, {tmp_hi}",                        // tmp_lo |= tmp_hi
                                "seqz {tmp_lo}, {tmp_lo}",                                // if tmp_lo == 0 { tmp_lo = 1 } else { tmp_lo = 0 }
                                dst = in(reg) ptr_reg!(dst),
                                tmp_lo = out(reg) r,
                                tmp_hi = out(reg) _,
                                // must be allocated to even/odd register pair
                                inout("a4") old.pair.lo => prev_lo,
                                inout("a5") old.pair.hi => prev_hi,
                                // must be allocated to even/odd register pair
                                in("a2") new.pair.lo,
                                in("a3") new.pair.hi,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw_amocas!(cmpxchg, order, failure = failure);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (
                        MaybeUninitDw { pair: Pair { lo: prev_lo, hi: prev_hi } }.whole,
                        r != 0
                    )
                }
            }
        }
    };
}

#[cfg(target_arch = "riscv32")]
#[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
atomic_dw!(u64, "d", "w", "4");
#[cfg(target_arch = "riscv64")]
#[cfg(any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"))]
atomic_dw!(u128, "q", "d", "8");

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
#[cfg(any(
    all(
        target_arch = "riscv32",
        any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
    ),
    target_arch = "riscv64",
))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    all(
        target_arch = "riscv32",
        any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
    ),
    target_arch = "riscv64",
))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    all(
        target_arch = "riscv32",
        any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
    ),
    target_arch = "riscv64",
)))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    all(
        target_arch = "riscv32",
        any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
    ),
    target_arch = "riscv64",
)))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "riscv64",
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "riscv64",
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    target_arch = "riscv64",
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    target_arch = "riscv64",
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
    target_feature = "zacas",
    atomic_maybe_uninit_target_feature = "zacas",
))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
    target_feature = "zacas",
    atomic_maybe_uninit_target_feature = "zacas",
))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
    target_feature = "zacas",
    atomic_maybe_uninit_target_feature = "zacas",
)))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
    target_feature = "zacas",
    atomic_maybe_uninit_target_feature = "zacas",
)))]
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
