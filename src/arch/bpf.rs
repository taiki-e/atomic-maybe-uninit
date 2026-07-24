// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
BPF

See "Atomic operation overview by architecture" for atomic operations in this architecture:
https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md#bpf

Refs:
- BPF Instruction Set Architecture (ISA)
https://github.com/torvalds/linux/blob/v7.1/Documentation/bpf/standardization/instruction-set.rst
*/

// TODO(bpf): Implementing sub-word atomic operations using word-sized CAS loop
// doesn't work due to "bitwise operator &= on pointer prohibited" verification error.

delegate_size!(delegate_all);

use core::{
    arch::asm,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap};

macro_rules! atomic {
    ($ty:ident, $reg:ident, $r0:tt, $cmpxchg:tt, $xchg:tt, $reg_in:ident $($reg_in_out:tt)*) => {
        delegate_signed!(delegate_all, $ty);
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                let out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    // TODO(bpf): add cfg to assume host is 64-bit
                    const IS_32_BIT: bool = core::mem::size_of::<$ty>() == 4;
                    match order {
                        Ordering::Relaxed if IS_32_BIT => {
                            asm!(
                                concat!("{out} = *(", stringify!($ty), " *) ({src} + 0)"), // atomic { out = *src }
                                src = in(reg) src,
                                out = lateout($reg) out,
                                options(nostack, preserves_flags),
                            );
                        }
                        // TODO(bpf): Enable once https://github.com/aya-rs/bpf-linker/pull/386 released.
                        // #[cfg(atomic_maybe_uninit_v4)]
                        // Ordering::Relaxed | Ordering::Acquire => {
                        //     asm!(
                        //         concat!("{out} = load_acquire((", stringify!($ty), " *)({src} + 0))"), // atomic { out = *src }
                        //         src = in(reg) src,
                        //         out = lateout($reg) out,
                        //         options(nostack, preserves_flags),
                        //     );
                        // }
                        _ => {
                            const ZERO: $ty = 0;
                            asm!(
                                // We cannot use cmpxchg without extra instruction here because it is CAS(SeqCst, Relaxed).
                                concat!("{out} = atomic_fetch_add((", stringify!($ty), " *)({src} + 0), {out})"), // atomic { _x = *src; *src += 0; out = _x }
                                src = in(reg) src,
                                out = inout($reg) ZERO => out,
                                options(nostack, preserves_flags),
                            );
                        }
                    }
                }
                out
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn __atomic_store_impl(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    const IS_32_BIT: bool = core::mem::size_of::<$ty>() == 4;
                    match order {
                        Ordering::Relaxed if IS_32_BIT => {
                            asm!(
                                concat!("*(", stringify!($ty), " *) ({dst} + 0) = {val}"), // atomic { *dst = val }
                                dst = in(reg) dst,
                                // TODO(bpf): use inout to avoid rustc or LLVM bug (last checked: nightly-2026-07-22 / LLVM 22): in(wreg) sometimes allocated to reg
                                val = $reg_in($reg) val $($reg_in_out)*,
                                options(nostack, preserves_flags),
                            );
                        }
                        // TODO(bpf): Enable once https://github.com/aya-rs/bpf-linker/pull/386 released.
                        // #[cfg(atomic_maybe_uninit_v4)]
                        // Ordering::Relaxed | Ordering::Release => {
                        //     asm!(
                        //         concat!("store_release((", stringify!($ty), " *)({dst} + 0), {val})"), // atomic { *dst = val }
                        //         dst = in(reg) dst,
                        //         // TODO(bpf): use inout to avoid rustc or LLVM bug (last checked: nightly-2026-07-22 / LLVM 22): in(wreg) sometimes allocated to reg
                        //         val = $reg_in($reg) val $($reg_in_out)*,
                        //         options(nostack, preserves_flags),
                        //     );
                        // }
                        _ => {
                            <$ty as AtomicSwap>::atomic_swap(
                                dst,
                                val,
                                Ordering::SeqCst, // swap is always SeqCst
                            );
                        }
                    }
                }
            }
        }
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn __atomic_swap_impl(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                _order: Ordering,
            ) -> MaybeUninit<Self> {
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    asm!(
                        concat!("{val} = ", $xchg, "({dst} + 0, {val})"), // atomic { _x = *dst; *dst = val; val = _x }
                        dst = in(reg) dst,
                        val = inout($reg) val => out,
                        options(nostack, preserves_flags),
                    );
                }
                out
            }
        }
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn __atomic_compare_exchange_impl(
                dst: *mut MaybeUninit<Self>,
                old: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                _success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                let mut out: MaybeUninit<Self>;

                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    let mut r: $ty = 0;
                    if failure == Ordering::Relaxed {
                        asm!(
                            concat!($r0, " = {old}"),                                       // r0 = old
                            concat!($r0, " = ", $cmpxchg, "({dst} + 0, ", $r0, ", {new})"), // atomic { _x = *dst; if _x == r0 { *dst = new }; r0 = _x }
                            concat!("if ", $r0, " == {old} goto 2f"),                       // if r0 == old { jump 'success }
                            "{r} = 1",                                                      // r = 1
                            "2:", // 'success
                            dst = in(reg) dst,
                            // TODO(bpf): use inout to avoid rustc or LLVM bug (last checked: nightly-2026-07-22 / LLVM 22): in(wreg) sometimes allocated to reg
                            old = $reg_in($reg) old $($reg_in_out)*,
                            new = $reg_in($reg) new $($reg_in_out)*,
                            r = inout($reg) r,
                            out($r0) out,
                            options(nostack, preserves_flags),
                        );
                    } else {
                        asm!(
                            concat!($r0, " = {old}"),                                                     // r0 = old
                            concat!($r0, " = ", $cmpxchg, "({dst} + 0, ", $r0, ", {new})"),               // atomic { _x = *dst; if _x == r0 { *dst = new }; r0 = _x }
                            concat!("if ", $r0, " == {old} goto 2f"),                                     // if r0 == old { jump 'success }
                            // Emulate fence using SeqCst fetch_add(0)
                            concat!("{r} = atomic_fetch_add((", stringify!($ty), " *)({dst} + 0), {r})"), // atomic { _x = *dst; *dst += 0; r = _x }
                            "{r} = 1",                                                                    // r = 1
                            "2:", // 'success
                            dst = in(reg) dst,
                            // TODO(bpf): use inout to avoid rustc or LLVM bug (last checked: nightly-2026-07-22 / LLVM 22): in(wreg) sometimes allocated to reg
                            old = $reg_in($reg) old $($reg_in_out)*,
                            new = $reg_in($reg) new $($reg_in_out)*,
                            r = inout($reg) r,
                            out($r0) out,
                            options(nostack, preserves_flags),
                        );
                    }
                    crate::utils::assert_unchecked(r == 0 || r == 1); // may help remove extra test
                    (out, r == 0)
                }
            }
        }
    };
}

atomic!(u32, wreg, "w0", "cmpxchg32_32", "xchg32_32", inout => _);
atomic!(u64, reg, "r0", "cmpxchg_64", "xchg_64", in);

// -----------------------------------------------------------------------------
// cfg macros

#[macro_export]
macro_rules! cfg_has_atomic_8 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_8 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_16 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_16 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
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
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
