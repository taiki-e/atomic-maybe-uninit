// SPDX-License-Identifier: Apache-2.0 OR MIT

#[allow(unused_imports)]
pub(crate) use gen::RegSize;
#[macro_use]
#[path = "gen/utils.rs"]
mod gen;

use core::{
    mem::{self, ManuallyDrop, MaybeUninit},
    sync::atomic::Ordering,
};

macro_rules! static_assert {
    ($($tt:tt)*) => {
        const _: () = assert!($($tt)*);
    };
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
// interior mutability" error occurs when using transmute_copy with generic type
// in const context (because this is a by-value transmutation that doesn't
// create a reference to the source value).
/// # Safety
///
/// This function has the same safety requirements as [`core::mem::transmute_copy`].
///
/// Since this is a by-value transmutation, it copies the bits from the source value
/// into the destination value, then forgets the original, as with the [`core::mem::transmute`].
#[inline]
#[must_use]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) const unsafe fn transmute_copy_by_val<Src, Dst>(src: Src) -> Dst {
    #[repr(C)]
    union ConstHack<Src, Dst> {
        src: ManuallyDrop<Src>,
        dst: ManuallyDrop<Dst>,
    }
    assert!(
        mem::size_of::<Src>() >= mem::size_of::<Dst>(), // assertion copied from transmute_copy
        "cannot transmute_copy if Dst is larger than Src"
    );
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

// https://github.com/rust-lang/rust/blob/1.80.0/library/core/src/sync/atomic.rs#L3294
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

// https://github.com/rust-lang/rust/blob/1.80.0/library/core/src/sync/atomic.rs#L3279
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

// https://github.com/rust-lang/rust/blob/1.80.0/library/core/src/sync/atomic.rs#L3360
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

/// Zero-extends the given 32-bit pointer to `MaybeUninit<u64>`.
/// This is used for 64-bit architecture's 32-bit ABI (e.g., AArch64 ILP32 ABI).
/// See ptr_reg! macro in src/gen/utils.rs for details.
#[cfg(target_pointer_width = "32")]
#[allow(dead_code)]
#[inline]
pub(crate) fn zero_extend64_ptr(v: *mut ()) -> MaybeUninit<u64> {
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
#[repr(C)]
struct ZeroExtended<T, const N: usize> {
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

#[allow(dead_code)]
#[cfg(any(
    target_arch = "aarch64",
    target_arch = "arm64ec",
    target_arch = "powerpc64",
    target_arch = "s390x",
    target_arch = "x86_64",
))]
/// A 128-bit value represented as a pair of 64-bit values.
///
/// This type is `#[repr(C)]`, both fields have the same in-memory representation
/// and are plain old data types, so access to the fields is always safe.
#[derive(Clone, Copy)]
#[repr(C)]
pub(crate) union MaybeUninit128 {
    pub(crate) u128: MaybeUninit<u128>,
    pub(crate) i128: MaybeUninit<i128>,
    pub(crate) pair: Pair<u64>,
}
#[allow(dead_code)]
#[cfg(any(target_arch = "arm", target_arch = "hexagon", target_arch = "x86"))]
/// A 64-bit value represented as a pair of 32-bit values.
///
/// This type is `#[repr(C)]`, both fields have the same in-memory representation
/// and are plain old data types, so access to the fields is always safe.
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
// Refs: https://github.com/llvm/llvm-project/blob/llvmorg-19.1.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L737
// (aligned_ptr, shift, mask)
#[allow(dead_code)]
#[inline]
pub(crate) fn create_sub_word_mask_values<T>(ptr: *mut T) -> (*mut MinWord, RetInt, RetInt) {
    const SHIFT_MASK: bool = !cfg!(any(
        target_arch = "riscv32",
        target_arch = "riscv64",
        target_arch = "loongarch64",
        target_arch = "s390x",
    ));
    let ptr_mask = mem::size_of::<MinWord>() - 1;
    let aligned_ptr = strict::with_addr(ptr, ptr as usize & !ptr_mask).cast::<MinWord>();
    let ptr_lsb = if SHIFT_MASK {
        ptr as usize & ptr_mask
    } else {
        // We use 32-bit wrapping shift instructions in asm on these platforms.
        ptr as usize
    };
    let shift = if cfg!(any(target_endian = "little", target_arch = "s390x")) {
        ptr_lsb.wrapping_mul(8)
    } else {
        (ptr_lsb ^ (mem::size_of::<MinWord>() - mem::size_of::<T>())).wrapping_mul(8)
    };
    let mut mask: RetInt = (1 << (mem::size_of::<T>() * 8)) - 1; // !(0 as T) as RetInt
    if SHIFT_MASK {
        mask <<= shift;
    }
    (aligned_ptr, shift as RetInt, mask)
}

/// Emulate strict provenance.
///
/// Once strict_provenance is stable, migrate to the standard library's APIs.
#[allow(dead_code)]
mod strict {
    #[inline]
    #[must_use]
    pub(crate) fn with_addr<T>(ptr: *mut T, addr: usize) -> *mut T {
        // FIXME(strict_provenance_magic): I am magic and should be a compiler intrinsic.
        //
        // In the mean-time, this operation is defined to be "as if" it was
        // a wrapping_add, so we can emulate it as such. This should properly
        // restore pointer provenance even under today's compiler.
        let offset = addr.wrapping_sub(ptr as usize);

        // This is the canonical desugaring of this operation.
        ptr.cast::<u8>().wrapping_add(offset).cast::<T>()
    }
}
