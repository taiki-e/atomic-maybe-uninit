// SPDX-License-Identifier: Apache-2.0 OR MIT

#[allow(unused_imports)]
pub(crate) use self::generated::RegSize;
#[macro_use]
#[path = "gen/utils.rs"]
mod generated;

use core::{
    mem::{self, ManuallyDrop, MaybeUninit},
    sync::atomic::Ordering,
};

/// Static assertion without depending on const block which requires Rust 1.79.
macro_rules! static_assert {
    ($(const $consts:ident: $ty:ty),+ => $($tt:tt)*) => {{
        const_eval!($(const $consts: $ty),+ => () { assert!($($tt)*) })
    }};
    ($($ty_params:ident $(: ?Sized $(+ $bounds:path)?)?),+ => $($tt:tt)*) => {{
        const_eval!($($ty_params $(: ?Sized $(+ $bounds)?)?),+ => () { assert!($($tt)*) })
    }};
    ($($ty_params:ident $(: $bounds:path)?),+ => $($tt:tt)*) => {{
        const_eval!($($ty_params $(: $bounds)?),+ => () { assert!($($tt)*) })
    }};
    // Use const _: () = assert!(..) for no parameter cases instead.
}

/// Const block emulation without depending on real const block which requires Rust 1.79.
// Inspired by https://github.com/nvzqz/static-assertions/issues/40#issuecomment-1458897730.
macro_rules! const_eval {
    ($(const $const_params:ident: $ty:ty),+ => $ret:ty { $($tt:tt)* }) => {{
        struct _Tmp<$(const $const_params: $ty,)*>;
        impl<$(const $const_params: $ty,)*> _Tmp<$($const_params,)*> {
            const _VAL: $ret = { $($tt)* };
        }
        _Tmp::<$($const_params,)*>::_VAL
    }};
    ($($ty_params:ident $(: ?Sized $(+ $bounds:path)?)?),+ => $ret:ty { $($tt:tt)* }) => {{
        struct _Tmp<$($ty_params $(: ?Sized $(+ $bounds)?)?),+>(
            $(::core::marker::PhantomData<$ty_params>),+
        );
        impl<$($ty_params $(: ?Sized $(+ $bounds)?)?),+> _Tmp<$($ty_params,)*> {
            const _VAL: $ret = { $($tt)* };
        }
        _Tmp::<$($ty_params,)*>::_VAL
    }};
    ($($ty_params:ident $(: $bounds:path)?),+ => $ret:ty { $($tt:tt)* }) => {{
        struct _Tmp<$($ty_params $(: $bounds)?),+>($(::core::marker::PhantomData<$ty_params>),+);
        impl<$($ty_params $(: $bounds)?),+> _Tmp<$($ty_params,)*> {
            const _VAL: $ret = { $($tt)* };
        }
        _Tmp::<$($ty_params,)*>::_VAL
    }};
    (=> $ret:ty { $($tt:tt)* }) => {{
        const _VAL: $ret = { $($tt)* };
        _VAL
    }};
}

/// Make the given function const if the given condition is true.
macro_rules! const_fn {
    (
        const_if: #[cfg($($cfg:tt)+)];
        $(#[$($attr:tt)*])*
        $vis:vis const $($rest:tt)*
    ) => {
        #[cfg($($cfg)+)]
        $(#[$($attr)*])*
        $vis const $($rest)*
        #[cfg(not($($cfg)+))]
        $(#[$($attr)*])*
        $vis $($rest)*
    };
}

// rustfmt-compatible cfg_select/cfg_if alternative
// Note: This macro is cfg_sel!({ }), not cfg_sel! { }.
// An extra brace is used in input to make contents rustfmt-able.
#[allow(unused_macros)]
macro_rules! cfg_sel {
    ({#[cfg(else)] { $($output:tt)* }}) => {
        $($output)*
    };
    ({
        #[cfg($cfg:meta)]
        { $($output:tt)* }
        $($( $rest:tt )+)?
    }) => {
        #[cfg($cfg)]
        cfg_sel! {{#[cfg(else)] { $($output)* }}}
        $(
            #[cfg(not($cfg))]
            cfg_sel! {{ $($rest)+ }}
        )?
    };
}

// HACK: This is equivalent to transmute_copy by value, but available in const
// context even on older rustc (const transmute_copy requires Rust 1.74), and
// can work around "cannot borrow here, since the borrowed element may contain
// interior mutability" error occurs (until const_refs_to_cell stabilized, i.e.,
// Rust 1.83) when using transmute_copy with generic type in const context
// (because this is a by-value transmutation that doesn't create a reference to
// the source value).
/// # Safety
///
/// This function has the same safety requirements as [`core::mem::transmute_copy`].
///
/// Since this is a by-value transmutation, it copies the bits from the source value
/// into the destination value, then forgets the original, as with the [`core::mem::transmute`].
#[inline]
#[must_use]
pub(crate) const unsafe fn transmute_copy_by_val<Src, Dst>(src: Src) -> Dst {
    #[repr(C)]
    union ConstHack<Src, Dst> {
        src: ManuallyDrop<Src>,
        dst: ManuallyDrop<Dst>,
    }
    static_assert!(Src, Dst => mem::size_of::<Src>() >= mem::size_of::<Dst>()); // assertion copied from transmute_copy (but evaluated at compile time)
    // SAFETY: ConstHack is #[repr(C)] union, and the caller must guarantee that
    // transmuting Src to Dst is safe.
    ManuallyDrop::into_inner(unsafe { ConstHack::<Src, Dst> { src: ManuallyDrop::new(src) }.dst })
}

// Equivalent to core::hint::assert_unchecked, but compatible with pre-1.81 rustc.
#[allow(dead_code)]
#[inline(always)]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) const unsafe fn assert_unchecked(cond: bool) {
    if !cond {
        #[cfg(debug_assertions)]
        unreachable!();
        #[cfg(not(debug_assertions))]
        // SAFETY: the caller promised `cond` is true.
        unsafe {
            core::hint::unreachable_unchecked()
        }
    }
}

// https://github.com/rust-lang/rust/blob/1.90.0/library/core/src/sync/atomic.rs#L3951
#[inline]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) fn assert_load_ordering(order: Ordering) {
    match order {
        Ordering::Acquire | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Release => panic!("there is no such thing as a release load"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire-release load"),
        _ => unreachable!(),
    }
}
// https://github.com/rust-lang/rust/blob/1.90.0/library/core/src/sync/atomic.rs#L3936
#[inline]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) fn assert_store_ordering(order: Ordering) {
    match order {
        Ordering::Release | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Acquire => panic!("there is no such thing as an acquire store"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire-release store"),
        _ => unreachable!(),
    }
}
// https://github.com/rust-lang/rust/blob/1.90.0/library/core/src/sync/atomic.rs#L4020
#[inline]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) fn assert_compare_exchange_ordering(success: Ordering, failure: Ordering) {
    match success {
        Ordering::AcqRel
        | Ordering::Acquire
        | Ordering::Relaxed
        | Ordering::Release
        | Ordering::SeqCst => {}
        _ => unreachable!(),
    }
    match failure {
        Ordering::Acquire | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Release => panic!("there is no such thing as a release failure ordering"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire-release failure ordering"),
        _ => unreachable!(),
    }
}

// https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2016/p0418r2.html
// https://github.com/rust-lang/rust/pull/98383
#[allow(dead_code)]
#[inline]
pub(crate) fn upgrade_success_ordering(success: Ordering, failure: Ordering) -> Ordering {
    match (success, failure) {
        (Ordering::Relaxed, Ordering::Acquire) => Ordering::Acquire,
        (Ordering::Release, Ordering::Acquire) => Ordering::AcqRel,
        (_, Ordering::SeqCst) => Ordering::SeqCst,
        _ => success,
    }
}

#[allow(unused_macros)]
macro_rules! debug_assert_atomic_unsafe_precondition {
    ($ptr:ident, $ty:ident) => {{
        #[cfg(atomic_maybe_uninit_no_strict_provenance)]
        #[allow(unused_imports)]
        use crate::utils::ptr::{ConstPtrExt as _, MutPtrExt as _};
        #[allow(clippy::arithmetic_side_effects)]
        {
            // Using const block here improves codegen on opt-level=0 https://godbolt.org/z/vrrvTqGda
            debug_assert!($ptr.addr() & const_eval!(=> usize { mem::size_of::<$ty>() - 1 }) == 0);
        }
    }};
}

#[allow(unused_macros)]
macro_rules! delegate_load_store {
    ($ty:ident, $base:ident) => {
        const _: () = {
            assert!(mem::size_of::<$ty>() == mem::size_of::<$base>());
            assert!(mem::align_of::<$ty>() == mem::align_of::<$base>());
        };
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                // SAFETY: the caller must uphold the safety contract.
                // cast and transmute are okay because $ty and $base implement the same layout.
                unsafe {
                    mem::transmute::<MaybeUninit<$base>, MaybeUninit<Self>>(
                        <$base as AtomicLoad>::atomic_load(src.cast::<MaybeUninit<$base>>(), order),
                    )
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
                // cast and transmute are okay because $ty and $base implement the same layout.
                unsafe {
                    <$base as AtomicStore>::atomic_store(
                        dst.cast::<MaybeUninit<$base>>(),
                        mem::transmute::<MaybeUninit<Self>, MaybeUninit<$base>>(val),
                        order,
                    );
                }
            }
        }
    };
}
#[allow(unused_macros)]
macro_rules! delegate_swap {
    ($ty:ident, $base:ident) => {
        const _: () = {
            assert!(mem::size_of::<$ty>() == mem::size_of::<$base>());
            assert!(mem::align_of::<$ty>() == mem::align_of::<$base>());
        };
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: MaybeUninit<Self>,
                order: Ordering,
            ) -> MaybeUninit<Self> {
                // SAFETY: the caller must uphold the safety contract.
                // cast and transmute are okay because $ty and $base implement the same layout.
                unsafe {
                    mem::transmute::<MaybeUninit<$base>, MaybeUninit<Self>>(
                        <$base as AtomicSwap>::atomic_swap(
                            dst.cast::<MaybeUninit<$base>>(),
                            mem::transmute::<MaybeUninit<Self>, MaybeUninit<$base>>(val),
                            order,
                        ),
                    )
                }
            }
        }
    };
}
#[allow(unused_macros)]
macro_rules! delegate_cas {
    ($ty:ident, $base:ident) => {
        const _: () = {
            assert!(mem::size_of::<$ty>() == mem::size_of::<$base>());
            assert!(mem::align_of::<$ty>() == mem::align_of::<$base>());
        };
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                current: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                // SAFETY: the caller must uphold the safety contract.
                // cast and transmute are okay because $ty and $base implement the same layout.
                unsafe {
                    let (out, ok) = <$base as AtomicCompareExchange>::atomic_compare_exchange(
                        dst.cast::<MaybeUninit<$base>>(),
                        mem::transmute::<MaybeUninit<Self>, MaybeUninit<$base>>(current),
                        mem::transmute::<MaybeUninit<Self>, MaybeUninit<$base>>(new),
                        success,
                        failure,
                    );
                    (mem::transmute::<MaybeUninit<$base>, MaybeUninit<Self>>(out), ok)
                }
            }
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                current: MaybeUninit<Self>,
                new: MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> (MaybeUninit<Self>, bool) {
                // SAFETY: the caller must uphold the safety contract.
                // cast and transmute are okay because $ty and $base implement the same layout.
                unsafe {
                    let (out, ok) = <$base as AtomicCompareExchange>::atomic_compare_exchange_weak(
                        dst.cast::<MaybeUninit<$base>>(),
                        mem::transmute::<MaybeUninit<Self>, MaybeUninit<$base>>(current),
                        mem::transmute::<MaybeUninit<Self>, MaybeUninit<$base>>(new),
                        success,
                        failure,
                    );
                    (mem::transmute::<MaybeUninit<$base>, MaybeUninit<Self>>(out), ok)
                }
            }
        }
    };
}
#[allow(unused_macros)]
macro_rules! delegate_all {
    ($ty:ident, $base:ident) => {
        delegate_load_store!($ty, $base);
        delegate_swap!($ty, $base);
        delegate_cas!($ty, $base);
    };
}
#[allow(unused_macros)]
macro_rules! delegate_signed {
    ($delegate:ident, u8) => {
        $delegate!(i8, u8);
    };
    ($delegate:ident, u16) => {
        $delegate!(i16, u16);
    };
    ($delegate:ident, u32) => {
        $delegate!(i32, u32);
    };
    ($delegate:ident, u64) => {
        $delegate!(i64, u64);
    };
    ($delegate:ident, u128) => {
        $delegate!(i128, u128);
    };
}
#[allow(unused_macros)]
macro_rules! delegate_size {
    ($delegate:ident) => {
        #[cfg(target_pointer_width = "16")]
        $delegate!(isize, u16);
        #[cfg(target_pointer_width = "16")]
        $delegate!(usize, u16);
        #[cfg(target_pointer_width = "32")]
        $delegate!(isize, u32);
        #[cfg(target_pointer_width = "32")]
        $delegate!(usize, u32);
        #[cfg(target_pointer_width = "64")]
        $delegate!(isize, u64);
        #[cfg(target_pointer_width = "64")]
        $delegate!(usize, u64);
        #[cfg(target_pointer_width = "128")]
        $delegate!(isize, u128);
        #[cfg(target_pointer_width = "128")]
        $delegate!(usize, u128);
    };
}

#[cfg(not(target_pointer_width = "16"))]
#[allow(dead_code)]
#[repr(C)]
struct Extended<T: Copy, const N: usize> {
    #[cfg(target_endian = "big")]
    pad: [MaybeUninit<T>; N],
    v: MaybeUninit<T>,
    #[cfg(target_endian = "little")]
    pad: [MaybeUninit<T>; N],
}
#[cfg(not(target_pointer_width = "16"))]
#[allow(dead_code)]
pub(crate) mod extend32 {
    macro_rules! extend {
        ($($ty:ident),* => $out:ident) => {$(
            pub(crate) mod $ty {
                use core::mem::{self, MaybeUninit};

                use super::super::Extended;

                const LEN: usize
                    = (mem::size_of::<$out>() - mem::size_of::<$ty>()) / mem::size_of::<$ty>();

                #[allow(clippy::cast_sign_loss)]
                // SAFETY: MaybeUninit returned by $ty is always initialized if the input is initialized.
                const _: () = assert!(unsafe {
                    zero(MaybeUninit::new(!0)).assume_init() == !(0 as $ty) as $out
                });
                /// Zero-extends the given integer to `MaybeUninit<u32>` if it is smaller than 32-bit,
                /// otherwise, return the given value as-is.
                #[inline(always)]
                pub(crate) const fn zero(v: MaybeUninit<$ty>) -> MaybeUninit<$out> {
                    const PAD: [MaybeUninit<$ty>; LEN] = [MaybeUninit::new(0); LEN];
                    // SAFETY: we can safely transmute any same-size value to MaybeUninit<$out>.
                    unsafe { mem::transmute(Extended::<$ty, LEN> { v, pad: PAD }) }
                }
                /// Uninit-extends the given integer to `MaybeUninit<u32>` if it is smaller than 32-bit,
                /// otherwise, return the given value as-is.
                #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
                #[inline(always)]
                pub(crate) const fn uninit(v: MaybeUninit<$ty>) -> MaybeUninit<$out> {
                    const PAD: [MaybeUninit<$ty>; LEN] = [MaybeUninit::uninit(); LEN];
                    // SAFETY: we can safely transmute any same-size value to MaybeUninit<$out>.
                    unsafe { mem::transmute(Extended::<$ty, LEN> { v, pad: PAD }) }
                }
                /// Inverse of extend.
                #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
                #[inline(always)]
                pub(crate) const fn extract(v: MaybeUninit<$out>) -> MaybeUninit<$ty> {
                    // SAFETY: Extended is repr(C) and all fields are MaybeUninit<$ty> or its array,
                    // so we can safely transmute any same-size value to Extended.
                    unsafe { mem::transmute::<MaybeUninit<$out>, Extended::<$ty, LEN>>(v).v }
                }
                #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
                #[inline(always)]
                pub(crate) const fn identity(v: MaybeUninit<$ty>) -> MaybeUninit<$ty> {
                    v
                }
            }
        )*};
        ($($ty:ident),*) => {$(
            pub(crate) mod $ty {
                use core::mem::MaybeUninit;

                #[inline(always)]
                pub(crate) const fn identity(v: MaybeUninit<$ty>) -> MaybeUninit<$ty> {
                    v
                }
                #[allow(unused_imports)]
                pub(crate) use self::identity as zero;
                #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
                #[allow(unused_imports)]
                pub(crate) use self::{identity as uninit, identity as extract};
            }
        )*};
    }
    extend!(u8, u16 => u32);
    extend!(u32, u64);
}
#[cfg(target_pointer_width = "32")]
#[allow(dead_code)]
pub(crate) mod zero_extend64 {
    use core::mem::{self, MaybeUninit};

    use super::Extended;

    // SAFETY: MaybeUninit returned by ptr is always initialized.
    const _: () = assert!(unsafe {
        ptr(super::ptr::without_provenance_mut(!0)).assume_init() == !0_u32 as u64
    });
    /// Zero-extends the given 32-bit pointer to `MaybeUninit<u64>`.
    /// This is used for 64-bit architecture's 32-bit ABI (e.g., AArch64 ILP32 ABI).
    /// See ptr_reg! macro in src/gen/utils.rs for details.
    #[inline]
    pub(crate) const fn ptr(v: *mut ()) -> MaybeUninit<u64> {
        const PAD: [MaybeUninit<*mut ()>; 1] = [MaybeUninit::new(core::ptr::null_mut()); 1];
        // SAFETY: we can safely transmute any 64-bit value to MaybeUninit<u64>.
        unsafe { mem::transmute(Extended::<*mut (), 1> { v: MaybeUninit::new(v), pad: PAD }) }
    }
}

/// A 128-bit value represented as a pair of 64-bit values.
///
/// This type is `#[repr(C)]`, both fields have the same in-memory representation
/// and are plain old data types, so access to the fields is always safe.
#[allow(dead_code)]
#[derive(Clone, Copy)]
#[repr(C)]
pub(crate) union MaybeUninit128 {
    pub(crate) whole: MaybeUninit<u128>,
    pub(crate) pair: Pair<u64>,
}
/// A 64-bit value represented as a pair of 32-bit values.
///
/// This type is `#[repr(C)]`, both fields have the same in-memory representation
/// and are plain old data types, so access to the fields is always safe.
#[allow(dead_code)]
#[derive(Clone, Copy)]
#[repr(C)]
pub(crate) union MaybeUninit64 {
    pub(crate) whole: MaybeUninit<u64>,
    pub(crate) pair: Pair<u32>,
}
#[allow(dead_code)]
#[derive(Clone, Copy)]
#[repr(C)]
pub(crate) struct Pair<T: Copy> {
    // little endian order
    #[cfg(any(
        target_endian = "little",
        target_arch = "aarch64",
        target_arch = "arm",
        target_arch = "arm64ec",
    ))]
    pub(crate) lo: MaybeUninit<T>,
    pub(crate) hi: MaybeUninit<T>,
    // big endian order
    #[cfg(not(any(
        target_endian = "little",
        target_arch = "aarch64",
        target_arch = "arm",
        target_arch = "arm64ec",
    )))]
    pub(crate) lo: MaybeUninit<T>,
}

#[cfg(not(target_pointer_width = "16"))]
type MinWord = u32;
#[cfg(not(target_pointer_width = "16"))]
#[cfg(target_arch = "s390x")]
type RetInt = u32;
#[cfg(not(target_pointer_width = "16"))]
#[cfg(not(target_arch = "s390x"))]
type RetInt = RegSize;
// Helper for implementing sub-word atomic operations using word-sized LL/SC loop or CAS loop.
//
// Refs: https://github.com/llvm/llvm-project/blob/llvmorg-21.1.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L812
// (aligned_ptr, shift, mask)
#[cfg(not(target_pointer_width = "16"))]
#[allow(dead_code)]
#[inline]
pub(crate) fn create_sub_word_mask_values<T>(ptr: *mut T) -> (*mut MinWord, RetInt, RetInt) {
    #[cfg(atomic_maybe_uninit_no_strict_provenance)]
    use self::ptr::MutPtrExt as _;
    // RISC-V, MIPS, SPARC, LoongArch, Xtensa, BPF: shift amount of 32-bit shift instructions is 5 bits unsigned (0-31).
    // PowerPC, C-SKY: shift amount of 32-bit shift instructions is 6 bits unsigned (0-63) and shift amount 32-63 means "clear".
    // Arm: shift amount of 32-bit shift instructions is 8 bits unsigned (0-255).
    // Hexagon: shift amount of 32-bit shift instructions is 7 bits signed (-64-63) and negative shift amount means "reverse the direction of the shift".
    // (On s390x, we don't use the mask returned from this function.)
    // (See also https://devblogs.microsoft.com/oldnewthing/20230904-00/?p=108704 for others)
    const SHIFT_MASK: bool = !cfg!(any(
        target_arch = "bpf",
        target_arch = "loongarch32",
        target_arch = "loongarch64",
        target_arch = "mips",
        target_arch = "mips32r6",
        target_arch = "mips64",
        target_arch = "mips64r6",
        target_arch = "riscv32",
        target_arch = "riscv64",
        target_arch = "s390x",
        target_arch = "sparc",
        target_arch = "sparc64",
        target_arch = "xtensa",
    ));
    const PTR_MASK: usize = mem::size_of::<MinWord>() - 1;
    const PTR_INV_MASK: usize = !PTR_MASK;
    let aligned_ptr = ptr.with_addr(ptr.addr() & PTR_INV_MASK).cast::<MinWord>();
    let ptr_lsb = if SHIFT_MASK {
        ptr.addr() & PTR_MASK
    } else {
        // We use 32-bit wrapping shift instructions in asm on these platforms.
        ptr.addr()
    };
    #[allow(clippy::arithmetic_side_effects)]
    let shift = if cfg!(any(target_endian = "little", target_arch = "s390x")) {
        ptr_lsb << 3
    } else {
        (ptr_lsb ^ const_eval!(T => usize { mem::size_of::<MinWord>() - mem::size_of::<T>() })) << 3
    };
    #[allow(clippy::arithmetic_side_effects)]
    let mut mask = const_eval!(T => RetInt { (1 << (mem::size_of::<T>() << 3)) - 1 }); // !(0 as T) as RetInt
    if SHIFT_MASK {
        mask <<= shift;
    }
    // ptr_lsb << 3 will never overflow u32, cast usize to u32 is no-op on 32-bit targets.
    #[cfg_attr(
        any(target_arch = "s390x", target_pointer_width = "32"),
        allow(clippy::cast_possible_truncation)
    )]
    {
        (aligned_ptr, shift as RetInt, mask)
    }
}

// This module provides core::ptr strict_provenance/exposed_provenance polyfill for pre-1.84 rustc.
#[allow(dead_code)]
pub(crate) mod ptr {
    cfg_sel!({
        #[cfg(not(atomic_maybe_uninit_no_strict_provenance))]
        {
            #[allow(unused_imports)]
            pub(crate) use core::ptr::{with_exposed_provenance, without_provenance_mut};
        }
        #[cfg(else)]
        {
            use core::mem;

            #[inline(always)]
            #[must_use]
            pub(crate) const fn without_provenance_mut<T>(addr: usize) -> *mut T {
                // An int-to-pointer transmute currently has exactly the intended semantics: it creates a
                // pointer without provenance. Note that this is *not* a stable guarantee about transmute
                // semantics, it relies on sysroot crates having special status.
                // SAFETY: every valid integer is also a valid pointer (as long as you don't dereference that
                // pointer).
                unsafe { mem::transmute(addr) }
            }
            #[inline(always)]
            #[must_use]
            #[cfg_attr(miri, track_caller)] // even without panics, this helps for Miri backtraces
            pub(crate) fn with_exposed_provenance<T>(addr: usize) -> *const T {
                addr as *const T
            }

            pub(crate) trait ConstPtrExt<T: ?Sized>: Copy {
                #[must_use]
                fn addr(self) -> usize;
            }
            pub(crate) trait MutPtrExt<T: ?Sized>: Copy {
                #[must_use]
                fn addr(self) -> usize;
                #[must_use]
                fn with_addr(self, addr: usize) -> Self
                where
                    T: Sized;
            }
            impl<T: ?Sized> ConstPtrExt<T> for *const T {
                #[inline(always)]
                #[must_use]
                fn addr(self) -> usize {
                    // A pointer-to-integer transmute currently has exactly the right semantics: it returns the
                    // address without exposing the provenance. Note that this is *not* a stable guarantee about
                    // transmute semantics, it relies on sysroot crates having special status.
                    // SAFETY: Pointer-to-integer transmutes are valid (if you are okay with losing the
                    // provenance).
                    unsafe { mem::transmute(self.cast::<()>()) }
                }
            }
            impl<T: ?Sized> MutPtrExt<T> for *mut T {
                #[inline(always)]
                #[must_use]
                fn addr(self) -> usize {
                    // A pointer-to-integer transmute currently has exactly the right semantics: it returns the
                    // address without exposing the provenance. Note that this is *not* a stable guarantee about
                    // transmute semantics, it relies on sysroot crates having special status.
                    // SAFETY: Pointer-to-integer transmutes are valid (if you are okay with losing the
                    // provenance).
                    unsafe { mem::transmute(self.cast::<()>()) }
                }
                #[inline]
                #[must_use]
                fn with_addr(self, addr: usize) -> Self
                where
                    T: Sized,
                {
                    // This should probably be an intrinsic to avoid doing any sort of arithmetic, but
                    // meanwhile, we can implement it with `wrapping_offset`, which preserves the pointer's
                    // provenance.
                    let self_addr = self.addr() as isize;
                    let dest_addr = addr as isize;
                    let offset = dest_addr.wrapping_sub(self_addr);
                    self.cast::<u8>().wrapping_offset(offset).cast::<T>()
                }
            }
        }
    });
}
