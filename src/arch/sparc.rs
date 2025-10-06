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

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap};

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
        #[allow(unused_macros)]
        macro_rules! leon_align {
            () => {
                ""
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
        use crate::{raw::AtomicCompareExchange, utils::RegSize};

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
        delegate_size!(delegate_swap);
    }
});

// -----------------------------------------------------------------------------
// Register-width or smaller atomics

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
            #[inline]
            unsafe fn atomic_load_consume(
                src: *const MaybeUninit<Self>,
            ) -> Dependent<MaybeUninit<Self>> {
                debug_assert_atomic_unsafe_precondition!(src, $ty);
                let out: MaybeUninit<Self>;
                let dep;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("ld", $load_sign, $suffix, " [{src}], {out}"), // atomic { out = zero_extend(*src) }
                        "xor {dep}, {out}, {out}",                             // dep = out ^ out
                        src = in(reg) ptr_reg!(src),
                        out = lateout(reg) out,
                        dep = lateout(reg) dep,
                        options(nostack, preserves_flags),
                    );
                }
                Dependent::from_parts(out, dep)
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
macro_rules! atomic_swap {
    (u32, $suffix:tt, $cc:tt) => {
        // SWAP instruction has been deprecated in SPARC-V9.
        #[cfg(all(
            any(
                target_arch = "sparc64",
                target_feature = "v9",
                atomic_maybe_uninit_target_feature = "v9",
            ),
            not(atomic_maybe_uninit_test_prefer_swap_over_cas),
        ))]
        atomic_swap_v9!(u32, $suffix, $cc);
        #[cfg(not(any(
            target_arch = "sparc64",
            target_feature = "v9",
            atomic_maybe_uninit_target_feature = "v9",
            target_feature = "leoncasa",
            atomic_maybe_uninit_target_feature = "leoncasa",
        )))]
        delegate_signed!(delegate_swap, u32);
        #[cfg(not(all(
            any(
                target_arch = "sparc64",
                target_feature = "v9",
                atomic_maybe_uninit_target_feature = "v9",
            ),
            not(atomic_maybe_uninit_test_prefer_swap_over_cas),
        )))]
        impl AtomicSwap for u32 {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                debug_assert_atomic_unsafe_precondition!(dst, u32);
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! swap {
                        ($acquire:expr, $release:expr, $leon_nop:expr) => {
                            asm!(
                                $leon_nop, // Workaround for errata (GRLIB-TN-0010).
                                $release,              // fence
                                leon_align!(), // Workaround for errata (GRLIB-TN-0011).
                                "swap [{dst}], {out}", // atomic { _x = *dst; *dst = out; out = zero_extend(_x) }
                                $acquire,              // fence
                                dst = in(reg) ptr_reg!(dst),
                                out = inout(reg) val => out,
                                options(nostack, preserves_flags),
                            )
                        };
                    }
                    atomic_rmw!(swap, order);
                }
                out
            }
        }
    };
    (u64, $suffix:tt, $cc:tt) => {
        atomic_swap_v9!(u64, $suffix, $cc);
    };
}

#[cfg(any(
    target_arch = "sparc64",
    all(
        any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
        not(atomic_maybe_uninit_test_prefer_swap_over_cas),
    ),
))]
#[rustfmt::skip]
macro_rules! atomic_swap_v9 {
    ($ty:ident, $suffix:tt, $cc:tt) => {
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
                                    "cmp {out}, {tmp}",                         // icc.Z = out[:31] == tmp[:31]; xcc.Z = out == tmp
                                    bne_a!($cc, "2b"),                          // if !$cc.Z {
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
    };
}

#[rustfmt::skip]
macro_rules! atomic {
    ($ty:ident, $suffix:tt, $cc:tt) => {
        atomic_load_store!($ty, $suffix, "");
        atomic_swap!($ty, $suffix, $cc);
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
                let mut r: RegSize;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! cmpxchg {
                        ($acquire:expr, $release:expr, $leon_nop:expr) => {
                            asm!(
                                $leon_nop, // Workaround for errata (GRLIB-TN-0010).
                                $release,                                   // fence
                                cas!($suffix, "[{dst}]", "{old}", "{out}"), // atomic { _x = *dst; if _x == old { *dst = out }; out = zero_extend(_x) }
                                "cmp {out}, {old}",                         // icc.Z = out[:31] == old[:31]; xcc.Z = out == old
                                "mov %g0, {r}",                             // r = 0
                                move_!($cc, "1", "{r}"),                    // if $cc.Z { r = 1 }
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
                }
                (out, r != 0)
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
                                    "cmp {out}, {tmp}",                    // icc.Z = out[:31] == tmp[:31]; xcc.Z = out == tmp
                                    bne_a!("%icc", "2b"),                  // if !icc.Z {
                                      "mov {out}, {tmp}",                  //   tmp = out; jump 'retry }
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
                let mut r: RegSize;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    macro_rules! cmpxchg {
                        ($acquire:expr, $release:expr, $_leon_nop:expr) => {
                            // Implement sub-word atomic operations using word-sized CAS loop.
                            // See also create_sub_word_mask_values.
                            asm!(
                                $release,                                  // fence
                                "ld [{dst}], {out}",                       // atomic { out = zero_extend(*dst) }
                                "2:", // 'retry:
                                    "and {out}, {mask}, {tmp}",            // tmp = out & mask
                                    "cmp {old}, {tmp}",                    // icc.Z = old[:31] == tmp[:31]; xcc.Z = old == tmp
                                    bne_a!("%icc", "3f"),                  // if !icc.Z {
                                      "mov %g0, {tmp}",                    //   tmp = 0; jump 'cmp-fail }
                                    "mov {out}, {tmp}",                    // tmp = out
                                    "andn {out}, {mask}, {out}",           // out &= !mask
                                    "or {out}, {new}, {out}",              // out |= new
                                    cas!("", "[{dst}]", "{tmp}", "{out}"), // atomic { _x = *dst; if _x == tmp { *dst = out }; out = zero_extend(_x) }
                                    "cmp {out}, {tmp}",                    // icc.Z = out[:31] == tmp[:31]; xcc.Z = out == tmp
                                    bne!("%icc", "2b"),                    // if !icc.Z {
                                      "mov 1, {tmp}",                      //   tmp = 1; jump 'retry } else { tmp = 1 }
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
                }
                (crate::utils::extend32::$ty::extract(srl(out, shift)), r != 0)
            }
        }
    };
}

atomic_sub_word!(u8, "b");
atomic_sub_word!(u16, "h");
atomic!(u32, "", "%icc");
#[cfg(target_arch = "sparc64")]
atomic!(u64, "x", "%xcc");

// -----------------------------------------------------------------------------
// 64-bit atomics on SPARC-V8+

// Use .4byte directive because "error: instruction requires a CPU feature not currently enabled" error (as of LLVM 22)

#[cfg(all(
    target_arch = "sparc",
    any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
    any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
))]
const _: () = assert!(mem::align_of::<u64>() >= mem::size_of::<u64>());
#[cfg(all(
    target_arch = "sparc",
    any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
    any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
))]
delegate_signed!(delegate_all, u64);
#[cfg(all(
    target_arch = "sparc",
    any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
    any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
))]
impl AtomicLoad for u64 {
    #[inline]
    unsafe fn atomic_load(src: *const MaybeUninit<Self>, order: Ordering) -> MaybeUninit<Self> {
        debug_assert_atomic_unsafe_precondition!(src, u64);
        let mut out = MaybeUninit::<Self>::uninit();

        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            macro_rules! atomic_load {
                ($acquire:expr) => {
                    asm!(
                        // "ldx [%i0], %o0", // atomic { o0 = *i0 }
                        ".4byte 0xd05e0000",
                        $acquire,         // fence
                        // "stx %o0, [%i1]", // *i1 = o0
                        ".4byte 0xd0764000",
                        in("i0") src,
                        in("i1") out.as_mut_ptr(),
                        out("o0") _,
                        options(nostack, preserves_flags),
                    )
                    // asm!(
                    //     "ldx [{src}], %o0", // atomic { o0 = *src }
                    //     $acquire,           // fence
                    //     "stx %o0, [{out}]", // *out = o0
                    //     src = in(reg) src,
                    //     out = in(reg) out.as_mut_ptr(),
                    //     out("o0") _,
                    //     options(nostack, preserves_flags),
                    // )
                };
            }
            match order {
                Ordering::Relaxed => atomic_load!(""),
                // Acquire and SeqCst loads are equivalent.
                Ordering::Acquire | Ordering::SeqCst => atomic_load!("membar #LoadStore|#LoadLoad"),
                _ => crate::utils::unreachable_unchecked(),
            }
        }
        out
    }
}
#[cfg(all(
    target_arch = "sparc",
    any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
    any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
))]
impl AtomicStore for u64 {
    #[inline]
    unsafe fn atomic_store(dst: *mut MaybeUninit<Self>, val: MaybeUninit<Self>, order: Ordering) {
        debug_assert_atomic_unsafe_precondition!(dst, u64);
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            macro_rules! atomic_store {
                ($acquire:expr, $release:expr) => {
                    asm!(
                        // "ldx [%i1], %o0", // o0 = *i1
                        ".4byte 0xd05e4000",
                        $release,         // fence
                        // "stx %o0, [%i0]", // atomic { *i0 = o0 }
                        ".4byte 0xd0760000",
                        $acquire,         // fence
                        in("i0") dst,
                        in("i1") val.as_ptr(),
                        out("o0") _,
                        options(nostack, preserves_flags),
                    )
                    // asm!(
                    //     "ldx [{val}], %o0", // o0 = *val
                    //     $release,           // fence
                    //     "stx %o0, [{dst}]", // atomic { *dst = o0 }
                    //     $acquire,           // fence
                    //     dst = in(reg) dst,
                    //     val = in(reg) val.as_ptr(),
                    //     out("o0") _,
                    //     options(nostack, preserves_flags),
                    // )
                };
            }
            match order {
                Ordering::Relaxed => atomic_store!("", ""),
                Ordering::Release => atomic_store!("", "membar #StoreStore|#LoadStore"),
                Ordering::SeqCst => atomic_store!(
                    "membar #StoreStore|#LoadStore|#StoreLoad|#LoadLoad",
                    "membar #StoreStore|#LoadStore"
                ),
                _ => crate::utils::unreachable_unchecked(),
            }
        }
    }
}
#[cfg(all(
    target_arch = "sparc",
    any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
    any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
))]
impl AtomicSwap for u64 {
    #[inline]
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: MaybeUninit<Self>,
        order: Ordering,
    ) -> MaybeUninit<Self> {
        debug_assert_atomic_unsafe_precondition!(dst, u64);
        let mut out = MaybeUninit::<Self>::uninit();

        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            macro_rules! swap {
                ($acquire:expr, $release:expr, $_leon_nop:expr) => {
                    asm!(
                        // "ldx [%i1], %o0",                     // o0 = *i1
                        ".4byte 0xd05e4000",
                        $release,                             // fence
                        // "ldx [%i0], %o2",                     // atomic { o2 = *i0 }
                        ".4byte 0xd45e0000",
                        "2:", // 'retry:
                            "mov %o0, %o1",                   // o1 = o0
                            // cas!("x", "[%i0]", "%o2", "%o1"), // atomic { _x = *i0; if _x == o2 { *i0 = o1 }; o1 = _x }
                            ".4byte 0xd3f6100a",
                            "cmp %o1, %o2",                   // icc.Z = o1[:31] == o2[:31]; xcc.Z = o1 == o2
                            "mov %g0, %i3",                   // i3 = 0
                            // move_!("%xcc", "1", "%i3"),       // if xcc.Z { i3 = 1 }
                            ".4byte 0xb7647001",
                            "cmp %i3, 1",                     // icc.Z = i3 == 1
                            bne_a!("%icc", "2b"),             // if !icc.Z {
                              "mov %o1, %o2",                 //   o2 = o1; jump 'retry }
                        $acquire,                             // fence
                        // "stx %o1, [%i2]",                     // *i2 = o1
                        ".4byte 0xd2768000",
                        in("i0") dst,
                        in("i1") val.as_ptr(),
                        in("i2") out.as_mut_ptr(),
                        out("o0") _, // val
                        out("o1") _, // out
                        out("o2") _, // tmp
                        out("i3") _,
                        // Do not use `preserves_flags` because CMP modifies the condition codes.
                        options(nostack),
                    )
                    // asm!(
                    //     "ldx [{val}], %o0",                     // o0 = *val
                    //     $release,                               // fence
                    //     "ldx [{dst}], %o2",                     // atomic { o2 = *dst }
                    //     "2:", // 'retry:
                    //         "mov %o0, %o1",                     // o1 = o0
                    //         cas!("x", "[{dst}]", "%o2", "%o1"), // atomic { _x = *dst; if _x == o2 { *dst = o1 }; o1 = _x }
                    //         "cmp %o1, %o2",                     // icc.Z = o1[:31] == o2[:31]; xcc.Z = o1 == o2
                    //         bne_a!("%xcc", "2b"),               // if !xcc.Z {
                    //           "mov %o1, %o2",                   //   o2 = o1; jump 'retry }
                    //     $acquire,                               // fence
                    //     "stx %o1, [{out}]",                     // *out = o1
                    //     dst = in(reg) dst,
                    //     val = in(reg) val.as_ptr(),
                    //     out = in(reg) out.as_mut_ptr(),
                    //     out("o0") _, // val
                    //     out("o1") _, // out
                    //     out("o2") _, // tmp
                    //     // Do not use `preserves_flags` because CMP modifies the condition codes.
                    //     options(nostack),
                    // )
                };
            }
            atomic_rmw!(swap, order);
        }
        out
    }
}
#[cfg(all(
    target_arch = "sparc",
    any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
    any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
))]
impl AtomicCompareExchange for u64 {
    #[inline]
    unsafe fn atomic_compare_exchange(
        dst: *mut MaybeUninit<Self>,
        old: MaybeUninit<Self>,
        new: MaybeUninit<Self>,
        success: Ordering,
        failure: Ordering,
    ) -> (MaybeUninit<Self>, bool) {
        debug_assert_atomic_unsafe_precondition!(dst, u64);
        let order = crate::utils::upgrade_success_ordering(success, failure);
        let mut out = new;
        let mut r: RegSize;

        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            macro_rules! cmpxchg {
                ($acquire:expr, $release:expr, $_leon_nop:expr) => {
                    asm!(
                        // "ldx [%i1], %o0",                 // o0 = *i1
                        ".4byte 0xd05e4000",
                        // "ldx [%i2], %o1",                 // o1 = *i2
                        ".4byte 0xd25e8000",
                        $release,                         // fence
                        // cas!("x", "[%i0]", "%o0", "%o1"), // atomic { _x = *i0; if _x == o0 { *i0 = o1 }; o1 = _x }
                        ".4byte 0xd3f61008",
                        "cmp %o1, %o0",                   // icc.Z = o1[:31] == o0[:31]; xcc.Z = o1 == o0
                        $acquire,                         // fence
                        // "stx %o1, [%i2]",                 // *i2 = o1
                        ".4byte 0xd2768000",
                        "mov %g0, %i2",                   // i2 = 0
                        // move_!("%xcc", "1", "%i2"),       // if xcc.Z { i2 = 1 }
                        ".4byte 0xb5647001",
                        in("i0") dst,
                        in("i1") old.as_ptr(),
                        in("i2") out.as_mut_ptr(),
                        lateout("i2") r,
                        out("o0") _, // old
                        out("o1") _, // new => out
                        // Do not use `preserves_flags` because CMP modifies the condition codes.
                        options(nostack),
                    )
                    // asm!(
                    //     "ldx [{old}], %o0",                 // o0 = *old
                    //     "ldx [{out}], %o1",                 // o1 = *out
                    //     $release,                           // fence
                    //     cas!("x", "[{dst}]", "%o0", "%o1"), // atomic { _x = *dst; if _x == o0 { *dst = o1 }; o1 = _x }
                    //     "cmp %o1, %o0",                     // icc.Z = o1[:31] == o0[:31]; xcc.Z = o1 == o0
                    //     $acquire,                           // fence
                    //     "stx %o1, [{out}]",                 // *out = o1
                    //     "mov %g0, {r}",                     // r = 0
                    //     move_!("%xcc", "1", "{r}"),         // if xcc.Z { r = 1 }
                    //     dst = in(reg) dst,
                    //     old = in(reg) old.as_ptr(),
                    //     out = in(reg) out.as_mut_ptr(),
                    //     r = lateout(reg) r,
                    //     out("o0") _, // old
                    //     out("o1") _, // new => out
                    //     // Do not use `preserves_flags` because CMP modifies the condition codes.
                    //     options(nostack),
                    // )
                };
            }
            atomic_rmw!(cmpxchg, order);
            crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
        }
        (out, r != 0)
    }
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
#[cfg(not(any(
    target_arch = "sparc64",
    all(
        target_arch = "sparc",
        any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
        any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
    ),
)))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    target_arch = "sparc64",
    all(
        target_arch = "sparc",
        any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
        any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
    ),
)))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    target_arch = "sparc64",
    all(
        target_arch = "sparc",
        any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
        any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
    ),
))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    target_arch = "sparc64",
    all(
        target_arch = "sparc",
        any(target_feature = "v9", atomic_maybe_uninit_target_feature = "v9"),
        any(target_feature = "v8plus", atomic_maybe_uninit_target_feature = "v8plus"),
    ),
))]
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
#[macro_export]
macro_rules! cfg_has_fast_consume {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_fast_consume {
    ($($tt:tt)*) => {};
}
