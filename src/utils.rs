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
    ($($ty:ident),+ => $($tt:tt)*) => {{
        // Inspired by https://github.com/nvzqz/static-assertions/issues/40#issuecomment-1458897730.
        struct _Assert<$($ty),+>($($ty),+);
        impl<$($ty),+> _Assert<$($ty,)*> {
            const _CHECK: () = assert!($($tt)*);
        }
        _Assert::<$($ty,)*>::_CHECK
    }};
    ($($tt:tt)*) => {
        const _: () = assert!($($tt)*);
    };
}

/// Uses inline const if available.
///
/// As the name implies, this is intended as a hint. Do not use this for use case
/// that relies on this being computed in a const context (use static_assert instead).
#[cfg(not(atomic_maybe_uninit_no_inline_const))]
#[allow(unused_macros)]
macro_rules! const_hint {
    ({$($tt:tt)*}) => {
        const { $($tt)* }
    }
}
#[cfg(atomic_maybe_uninit_no_inline_const)]
#[allow(unused_macros)]
macro_rules! const_hint {
    ({$($tt:tt)*}) => {
        { $($tt)* }
    }
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

#[allow(dead_code)]
// Stable version of https://doc.rust-lang.org/nightly/std/hint/fn.assert_unchecked.html.
// TODO: use real core::hint::assert_unchecked on 1.81+ https://github.com/rust-lang/rust/pull/123588
#[inline(always)]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) unsafe fn assert_unchecked(cond: bool) {
    if !cond {
        if cfg!(debug_assertions) {
            unreachable!()
        } else {
            // SAFETY: the caller promised `cond` is true.
            unsafe { core::hint::unreachable_unchecked() }
        }
    }
}

// https://github.com/rust-lang/rust/blob/1.84.0/library/core/src/sync/atomic.rs#L3338
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
// https://github.com/rust-lang/rust/blob/1.84.0/library/core/src/sync/atomic.rs#L3323
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
// https://github.com/rust-lang/rust/blob/1.84.0/library/core/src/sync/atomic.rs#L3404
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

#[allow(unused_macros)]
macro_rules! debug_assert_atomic_unsafe_precondition {
    ($ptr:ident, $ty:ident) => {{
        #[cfg(atomic_maybe_uninit_no_strict_provenance)]
        #[allow(unused_imports)]
        use crate::utils::ptr::{ConstPtrExt as _, MutPtrExt as _};
        #[allow(clippy::arithmetic_side_effects)]
        {
            // Using const block here improves codegen on opt-level=0 https://godbolt.org/z/vrrvTqGda
            debug_assert!($ptr.addr() & const_hint!({ core::mem::size_of::<$ty>() - 1 }) == 0);
        }
    }};
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

#[cfg(target_pointer_width = "32")]
// SAFETY: MaybeUninit returned by zero_extend64_ptr is always initialized.
static_assert!(unsafe {
    zero_extend64_ptr(ptr::without_provenance_mut(!0)).assume_init() == !0_u32 as u64
});
/// Zero-extends the given 32-bit pointer to `MaybeUninit<u64>`.
/// This is used for 64-bit architecture's 32-bit ABI (e.g., AArch64 ILP32 ABI).
/// See ptr_reg! macro in src/gen/utils.rs for details.
#[cfg(target_pointer_width = "32")]
#[allow(dead_code)]
#[inline]
pub(crate) const fn zero_extend64_ptr(v: *mut ()) -> MaybeUninit<u64> {
    // SAFETY: we can safely transmute any 64-bit value to MaybeUninit<u64>.
    unsafe {
        mem::transmute(ZeroExtended::<*mut (), 1> {
            v: MaybeUninit::new(v),
            pad: [core::ptr::null_mut(); 1],
        })
    }
}
#[allow(dead_code)]
pub(crate) trait ZeroExtend: Copy {
    type Out: Copy;
    /// Zero-extends the given `MaybeUninit<Self>` to `MaybeUninit<u32>` if it is smaller than 32-bit,
    /// otherwise, return the given value as-is.
    fn zero_extend(v: MaybeUninit<Self>) -> Self::Out;
}
#[allow(dead_code)]
#[repr(C)]
struct ZeroExtended<T: Copy, const N: usize> {
    #[cfg(target_endian = "big")]
    pad: [T; N],
    v: MaybeUninit<T>,
    #[cfg(target_endian = "little")]
    pad: [T; N],
}
macro_rules! zero_extend {
    ($($ty:ident),* => $out:ident) => {$(
        impl ZeroExtend for $ty {
            type Out = MaybeUninit<$out>;
            #[inline(always)]
            fn zero_extend(v: MaybeUninit<Self>) -> Self::Out {
                const LEN: usize
                    = (mem::size_of::<$out>() - mem::size_of::<$ty>()) / mem::size_of::<$ty>();
                // SAFETY: we can safely transmute any same-size value to MaybeUninit<$out>.
                unsafe {
                    mem::transmute(ZeroExtended::<$ty, LEN> { v, pad: [0; LEN] })
                }
            }
        }
    )*};
    ($($ty:ident),*) => {$(
        impl ZeroExtend for $ty {
            type Out = MaybeUninit<Self>;
            #[inline(always)]
            fn zero_extend(v: MaybeUninit<Self>) -> Self::Out {
                v
            }
        }
    )*};
}
zero_extend!(i8, u8, i16, u16 => u32);
zero_extend!(i32, u32, i64, u64, isize, usize);

/// A 128-bit value represented as a pair of 64-bit values.
///
/// This type is `#[repr(C)]`, both fields have the same in-memory representation
/// and are plain old data types, so access to the fields is always safe.
#[allow(dead_code)]
#[derive(Clone, Copy)]
#[repr(C)]
pub(crate) union MaybeUninit128 {
    pub(crate) u128: MaybeUninit<u128>,
    pub(crate) i128: MaybeUninit<i128>,
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
    pub(crate) u64: MaybeUninit<u64>,
    pub(crate) i64: MaybeUninit<i64>,
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

type MinWord = u32;
#[cfg(target_arch = "s390x")]
type RetInt = u32;
#[cfg(not(target_arch = "s390x"))]
type RetInt = RegSize;
// Helper for implementing sub-word atomic operations using word-sized LL/SC loop or CAS loop.
//
// Refs: https://github.com/llvm/llvm-project/blob/llvmorg-21.1.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L812
// (aligned_ptr, shift, mask)
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
    #[allow(clippy::arithmetic_side_effects)]
    let ptr_mask = const_hint!({ mem::size_of::<MinWord>() - 1 });
    let aligned_ptr = ptr.with_addr(ptr.addr() & !ptr_mask).cast::<MinWord>();
    let ptr_lsb = if SHIFT_MASK {
        ptr.addr() & ptr_mask
    } else {
        // We use 32-bit wrapping shift instructions in asm on these platforms.
        ptr.addr()
    };
    #[allow(clippy::arithmetic_side_effects)]
    let shift = if cfg!(any(target_endian = "little", target_arch = "s390x")) {
        ptr_lsb << 3
    } else {
        (ptr_lsb ^ const_hint!({ mem::size_of::<MinWord>() - mem::size_of::<T>() })) << 3
    };
    #[allow(clippy::arithmetic_side_effects)]
    let mut mask: RetInt = const_hint!({ (1 << (mem::size_of::<T>() << 3)) - 1 }); // !(0 as T) as RetInt
    if SHIFT_MASK {
        mask <<= shift;
    }
    // ptr_lsb << 3 will never overflow u32
    #[cfg_attr(target_arch = "s390x", allow(clippy::cast_possible_truncation))]
    {
        (aligned_ptr, shift as RetInt, mask)
    }
}

// This module provides core::ptr strict_provenance/exposed_provenance polyfill for pre-1.84 rustc.
#[allow(dead_code)]
pub(crate) mod ptr {
    #[cfg(atomic_maybe_uninit_no_strict_provenance)]
    use core::mem;
    #[cfg(not(atomic_maybe_uninit_no_strict_provenance))]
    #[allow(unused_imports)]
    pub(crate) use core::ptr::{with_exposed_provenance, without_provenance_mut};

    #[cfg(atomic_maybe_uninit_no_strict_provenance)]
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
    #[cfg(atomic_maybe_uninit_no_strict_provenance)]
    #[inline(always)]
    #[must_use]
    #[cfg_attr(miri, track_caller)] // even without panics, this helps for Miri backtraces
    pub(crate) fn with_exposed_provenance<T>(addr: usize) -> *const T {
        addr as *const T
    }

    #[cfg(atomic_maybe_uninit_no_strict_provenance)]
    pub(crate) trait ConstPtrExt<T: ?Sized>: Copy {
        #[must_use]
        fn addr(self) -> usize;
    }
    #[cfg(atomic_maybe_uninit_no_strict_provenance)]
    pub(crate) trait MutPtrExt<T: ?Sized>: Copy {
        #[must_use]
        fn addr(self) -> usize;
        #[must_use]
        fn with_addr(self, addr: usize) -> Self
        where
            T: Sized;
    }
    #[cfg(atomic_maybe_uninit_no_strict_provenance)]
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
    #[cfg(atomic_maybe_uninit_no_strict_provenance)]
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
