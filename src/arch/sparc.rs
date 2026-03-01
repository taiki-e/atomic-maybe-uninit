// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
SPARC and SPARC64

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#sparc

Refs:
- The SPARC Architecture Manual, Version 9
  The SPARC Architecture Manual, Version 8
  https://sparc.org/technical-documents
- The V8+ Technical Specification
  https://temlib.org/pub/SparcStation/Standards/V8plus.pdf

See tests/asm-test/asm/atomic-maybe-uninit for generated assembly.
*/

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicLoad, AtomicStore};

cfg_sel!({
    #[cfg(any(
        target_arch = "sparc64",
        target_feature = "v9",
        atomic_maybe_uninit_target_feature = "v9",
    ))]
    {
        // Bicc instructions are deprecated in V9.
        macro_rules! bne {
            ($cc:tt, $label:tt) => {
                concat!("bne ", $cc, ", ", $label)
            };
        }
        macro_rules! bne_a {
            ($cc:tt, $label:tt) => {
                concat!("bne,a ", $cc, ", ", $label)
            };
        }
        // MOVcc instructions are unavailable in V8.
        macro_rules! move_ {
            ($cc:tt, $val:tt, $rd:tt) => {
                concat!("move ", $cc, ", ", $val, ", ", $rd)
            };
        }
        macro_rules! cas {
            ($suffix:tt, $rs1:tt, $rs2:tt, $rd:tt) => {
                concat!("cas", $suffix, " ", $rs1, ", ", $rs2, ", ", $rd)
            };
        }
        macro_rules! atomic_rmw {
            ($op:ident, $order:ident) => {
                // op(acquire, release, leon_nop)
                match $order {
                    Ordering::Relaxed => $op!("", "", ""),
                    Ordering::Acquire => $op!("membar #LoadStore|#LoadLoad", "", ""),
                    Ordering::Release => $op!("", "membar #StoreStore|#LoadStore", ""),
                    Ordering::AcqRel | Ordering::SeqCst => {
                        $op!("membar #LoadStore|#LoadLoad", "membar #StoreStore|#LoadStore", "")
                    }
                    _ => unreachable!(),
                }
            };
        }
    }
    #[cfg(else)]
    {
        #[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
        macro_rules! bne {
            ("%icc", $label:tt) => {
                concat!("bne ", $label)
            };
        }
        #[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
        macro_rules! bne_a {
            ("%icc", $label:tt) => {
                concat!("bne,a ", $label)
            };
        }
        #[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
        #[rustfmt::skip]
        macro_rules! move_ {
            ($cc:tt, $val:tt, $rd:tt) => {
                concat!(
                    bne!($cc, "99f"), "\n",
                      "nop", "\n",
                    "mov ", $val, ", ", $rd, "\n",
                    "99:"
                )
            };
        }
        #[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
        macro_rules! cas {
            ("", $rs1:tt, $rs2:tt, $rd:tt) => {
                concat!(leon_align!(), "casa ", $rs1, " 10, ", $rs2, ", ", $rd)
            };
        }
        // Not all CPUs require workarounds, but since we currently have no way to accurately catch
        // the flag that tells LLVM to enable workarounds for these (see comments in build script),
        // we always do them for now.
        // Workaround for errata:
        // - GRLIB-TN-0004:
        //   - Insert this or others between a load instruction and a memory accessing instruction.
        // - GRLIB-TN-0009:
        //   - Insert this or others twice between a <= 32-bit store instruction and a store instruction.
        //   - Insert this or others between a 64-bit store instruction and a store instruction.
        // - GRLIB-TN-0010:
        //   - Insert this or others between a load instruction and an atomic instruction (swap, ldstub, casa).
        // Refs: https://www.gaisler.com/app-notes-tech-notes-and-white-papers
        macro_rules! leon_nop {
            () => {
                "nop\n"
            };
        }
        // Workaround for errata:
        // - GRLIB-TN-0011:
        //   - Insert this before an atomic instruction (swap, ldstub, casa).
        //   - Do not place atomic instructions in delay slot.
        // Refs: https://www.gaisler.com/app-notes-tech-notes-and-white-papers
        macro_rules! leon_align {
            () => {
                ".balign 16\n"
            };
        }
        #[cfg(any(target_feature = "leoncasa", atomic_maybe_uninit_target_feature = "leoncasa"))]
        macro_rules! atomic_rmw {
            ($op:ident, $order:ident) => {
                // op(acquire, release, leon_nop)
                match $order {
                    // leon_nop for GRLIB-TN-0010
                    Ordering::Relaxed => $op!("", "", leon_nop!()),
                    Ordering::Acquire => $op!("", "", leon_nop!()),
                    // LLVM doesn't emits ldstub here, but GCC does. https://godbolt.org/z/bsGqWzEfM
                    Ordering::Release => {
                        $op!("", concat!("stbar\n", leon_align!(), "ldstub [%sp-1], %g0"), "")
                    }
                    Ordering::AcqRel | Ordering::SeqCst => {
                        $op!("", concat!("stbar\n", leon_align!(), "ldstub [%sp-1], %g0"), "")
                    }
                    _ => unreachable!(),
                }
            };
        }
    }
});

cfg_sel!({
    #[cfg(any(
        target_arch = "sparc64",
        target_feature = "v9",
        atomic_maybe_uninit_target_feature = "v9",
        target_feature = "leoncasa",
        atomic_maybe_uninit_target_feature = "leoncasa",
    ))]
    {
        use crate::{
            raw::{AtomicCompareExchange, AtomicSwap},
            utils::RegSize,
        };

        delegate_size!(delegate_all);

        macro_rules! sll {
            ($val:expr, $shift:expr) => {{
                let mut val = $val;
                let shift: RegSize = $shift;
                #[allow(unused_unsafe)]
                // SAFETY: calling SLL is safe
                unsafe {
                    asm!(
                        "sll {val}, {shift}, {val}", // val <<= shift & 31
                        val = inout(reg) val,
                        shift = in(reg) shift,
                        options(pure, nomem, nostack, preserves_flags),
                    );
                }
                val
            }};
        }
        #[inline(always)]
        fn srl(mut val: MaybeUninit<u32>, shift: RegSize) -> MaybeUninit<u32> {
            // SAFETY: calling SRL is safe
            unsafe {
                asm!(
                    "srl {val}, {shift}, {val}", // val >>= shift & 31
                    val = inout(reg) val,
                    shift = in(reg) shift,
                    options(pure, nomem, nostack, preserves_flags),
                );
            }
            val
        }
    }
    #[cfg(else)]
    {
        delegate_size!(delegate_load_store);
    }
});

#[rustfmt::skip]
macro_rules! atomic_load_store {
    ($ty:ident, $suffix:tt, $load_sign:tt) => {
        #[cfg(any(
            target_arch = "sparc64",
            target_feature = "v9",
            atomic_maybe_uninit_target_feature = "v9",
            target_feature = "leoncasa",
            atomic_maybe_uninit_target_feature = "leoncasa",
        ))]
        delegate_signed!(delegate_all, $ty);
        #[cfg(not(any(
            target_arch = "sparc64",
            target_feature = "v9",
            atomic_maybe_uninit_target_feature = "v9",
            target_feature = "leoncasa",
            atomic_maybe_uninit_target_feature = "leoncasa",
        )))]
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
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                $release,                                              // fence
                                concat!("ld", $load_sign, $suffix, " [{src}], {out}"), // atomic { out = zero_extend(*src) }
                                $acquire,                                              // fence
                                src = in(reg) ptr_reg!(src),
                                out = lateout(reg) out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(any(
                        target_arch = "sparc64",
                        target_feature = "v9",
                        atomic_maybe_uninit_target_feature = "v9",
                    ))]
                    match order {
                        Ordering::Relaxed => atomic_load!("", ""),
                        // Acquire and SeqCst loads are equivalent.
                        Ordering::Acquire | Ordering::SeqCst => atomic_load!("membar #LoadStore|#LoadLoad", ""),
                        _ => crate::utils::unreachable_unchecked(),
                    }
                    #[cfg(not(any(
                        target_arch = "sparc64",
                        target_feature = "v9",
                        atomic_maybe_uninit_target_feature = "v9",
                    )))]
                    match order {
                        // leon_nop for GRLIB-TN-0004
                        Ordering::Relaxed => atomic_load!(leon_nop!(), ""),
                        Ordering::Acquire => atomic_load!(leon_nop!(), ""),
                        // LLVM doesn't emits ldstub here, but GCC does. https://godbolt.org/z/bsGqWzEfM
                        Ordering::SeqCst => atomic_load!(leon_nop!(), concat!(leon_nop!() /* for GRLIB-TN-0010 */, leon_align!(), "ldstub [%sp-1], %g0")),
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
                        ($acquire:expr, $release:expr) => {
                            asm!(
                                $release,                                  // fence
                                concat!("st", $suffix, " {val}, [{dst}]"), // atomic { *dst = val }
                                $acquire,                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    #[cfg(any(
                        target_arch = "sparc64",
                        target_feature = "v9",
                        atomic_maybe_uninit_target_feature = "v9",
                    ))]
                    match order {
                        Ordering::Relaxed => atomic_store!("", ""),
                        Ordering::Release => atomic_store!("", "membar #StoreStore|#LoadStore"),
                        Ordering::SeqCst => atomic_store!("membar #StoreStore|#LoadStore|#StoreLoad|#LoadLoad", "membar #StoreStore|#LoadStore"),
                        _ => crate::utils::unreachable_unchecked(),
                    }
                    #[cfg(not(any(
                        target_arch = "sparc64",
                        target_feature = "v9",
                        atomic_maybe_uninit_target_feature = "v9",
                    )))]
                    match order {
                        // leon_nop for GRLIB-TN-0009
                        Ordering::Relaxed => atomic_store!(concat!(leon_nop!(), leon_nop!()), ""),
                        Ordering::Release => atomic_store!(concat!(leon_nop!(), leon_nop!()), "stbar"),
                        Ordering::SeqCst => atomic_store!(concat!("stbar\n", leon_align!(), "ldstub [%sp-1], %g0"), "stbar"),
                        _ => crate::utils::unreachable_unchecked(),
                    }
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $suffix:tt, $cc:tt) => {
        atomic_load_store!($ty, $suffix, "");
        #[cfg(any(
            target_arch = "sparc64",
            target_feature = "v9",
            atomic_maybe_uninit_target_feature = "v9",
            target_feature = "leoncasa",
            atomic_maybe_uninit_target_feature = "leoncasa",
        ))]
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, $ty);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:expr, $release:expr, $_leon_nop:expr) => {
                            asm!(
                                $release,                                       // fence
                                concat!("ld", $suffix, " [{dst}], {tmp}"),      // atomic { tmp = zero_extend(*dst) }
                                "2:", // 'retry:
                                    "mov {val}, {out}",                         // out = val
                                    cas!($suffix, "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = zero_extend(_x) }
                                    "cmp {out}, {tmp}",                         // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne_a!($cc, "2b"),                          // if !cc.Z {
                                      "mov {out}, {tmp}",                       //   tmp = out; jump 'retry }
                                $acquire,                                       // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) val,
                                out = out(reg) out,
                                tmp = out(reg) _,
                                // Do not use `preserves_flags` because CMP modifies the condition codes.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
                out
            }
        }
        #[cfg(any(
            target_arch = "sparc64",
            target_feature = "v9",
            atomic_maybe_uninit_target_feature = "v9",
            target_feature = "leoncasa",
            atomic_maybe_uninit_target_feature = "leoncasa",
        ))]
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
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: RegSize;
                    macro_rules! cmpxchg {
                        ($acquire:expr, $release:expr, $leon_nop:expr) => {
                            asm!(
                                $leon_nop, // Workaround for errata (GRLIB-TN-0010).
                                $release,                                   // fence
                                cas!($suffix, "[{dst}]", "{old}", "{out}"), // atomic { _x = *dst; if _x == old { *dst = out }; out = zero_extend(_x) }
                                "cmp {out}, {old}",                         // if out == old { cc.Z = true } else { cc.Z = false }
                                "mov %g0, {r}",                             // r = 0
                                move_!($cc, "1", "{r}"),                    // if cc.Z { r = 1 }
                                $acquire,                                   // fence
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) old,
                                out = inout(reg) new => out,
                                r = lateout(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition codes.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r != 0)
                }
            }
        }
    };
}

#[rustfmt::skip]
macro_rules! atomic_sub_word {
    ($ty:ident, $suffix:tt) => {
        atomic_load_store!($ty, $suffix, "u");
        #[cfg(any(
            target_arch = "sparc64",
            target_feature = "v9",
            atomic_maybe_uninit_target_feature = "v9",
            target_feature = "leoncasa",
            atomic_maybe_uninit_target_feature = "leoncasa",
        ))]
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
                    macro_rules! swap {
                        ($acquire:expr, $release:expr, $_leon_nop:expr) => {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                $release,                                  // fence
                                "ld [{dst}], {tmp}",                       // atomic { tmp = zero_extend(*dst) }
                                "2:", // 'retry:
                                    "andn {tmp}, {mask}, {out}",           // out = tmp & !mask
                                    "or {out}, {val}, {out}",              // out |= val
                                    cas!("", "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = zero_extend(_x) }
                                    "cmp {out}, {tmp}",                    // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne_a!("%icc", "2b"),                  // if !cc.Z {
                                      "mov {out}, {tmp}",                //   tmp = out; jump 'retry }
                                $acquire,                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                val = in(reg) sll!(crate::utils::extend32::$ty::zero(val), shift),
                                out = out(reg) out,
                                mask = in(reg) sll!(mask, shift),
                                tmp = out(reg) _,
                                // Do not use `preserves_flags` because CMP modifies the condition codes.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
                crate::utils::extend32::$ty::extract(srl(out, shift))
            }
        }
        #[cfg(any(
            target_arch = "sparc64",
            target_feature = "v9",
            atomic_maybe_uninit_target_feature = "v9",
            target_feature = "leoncasa",
            atomic_maybe_uninit_target_feature = "leoncasa",
        ))]
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

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: RegSize;
                    macro_rules! cmpxchg {
                        ($acquire:expr, $release:expr, $_leon_nop:expr) => {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                $release,                                  // fence
                                "ld [{dst}], {out}",                       // atomic { out = zero_extend(*dst) }
                                "2:", // 'retry:
                                    "and {out}, {mask}, {tmp}",            // tmp = out & mask
                                    "cmp {old}, {tmp}",                    // if old == tmp { cc.Z = true } else { cc.Z = false }
                                    bne_a!("%icc", "3f"),                  // if !cc.Z {
                                      "mov %g0, {tmp}",                  //   tmp = 0; jump 'cmp-fail }
                                    "mov {out}, {tmp}",                    // tmp = out
                                    "andn {out}, {mask}, {out}",           // out &= !mask
                                    "or {out}, {new}, {out}",              // out |= new
                                    cas!("", "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = zero_extend(_x) }
                                    "cmp {out}, {tmp}",                    // if out == tmp { cc.Z = true } else { cc.Z = false }
                                    bne!("%icc", "2b"),                    // if !cc.Z {
                                      "mov 1, {tmp}",                    //   tmp = 1; jump 'retry } else { tmp = 1 }
                                "3:", // 'cmp-fail:
                                $acquire,                                  // fence
                                dst = in(reg) ptr_reg!(dst),
                                old = in(reg) sll!(crate::utils::extend32::$ty::zero(old), shift),
                                new = in(reg) sll!(crate::utils::extend32::$ty::zero(new), shift),
                                out = out(reg) out,
                                mask = in(reg) sll!(mask, shift),
                                tmp = out(reg) r,
                                // Do not use `preserves_flags` because CMP modifies the condition codes.
                                options(nostack),
                            )
                        };
                    }
                    atomic_rmw!(cmpxchg, order);
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (crate::utils::extend32::$ty::extract(srl(out, shift)), r != 0)
                }
            }
        }
    };
}

atomic_sub_word!(u8, "b");
atomic_sub_word!(u16, "h");
atomic!(u32, "", "%icc");
// TODO: V8+ with 64-bit g/o reg
#[cfg(target_arch = "sparc64")]
atomic!(u64, "x", "%xcc");

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
// TODO: V8+ with 64-bit g/o reg
#[cfg(target_arch = "sparc")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
// TODO: V8+ with 64-bit g/o reg
#[cfg(target_arch = "sparc")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "sparc64")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "sparc64")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
    target_feature = "leoncasa",
    atomic_maybe_uninit_target_feature = "leoncasa",
))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
    target_feature = "leoncasa",
    atomic_maybe_uninit_target_feature = "leoncasa",
))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
    target_feature = "leoncasa",
    atomic_maybe_uninit_target_feature = "leoncasa",
)))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    target_arch = "sparc64",
    target_feature = "v9",
    atomic_maybe_uninit_target_feature = "v9",
    target_feature = "leoncasa",
    atomic_maybe_uninit_target_feature = "leoncasa",
)))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
