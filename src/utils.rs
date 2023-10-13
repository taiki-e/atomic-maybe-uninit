// SPDX-License-Identifier: Apache-2.0 OR MIT

#[allow(unused_imports)]
pub(crate) use gen::RegSize;
#[macro_use]
#[path = "gen/utils.rs"]
mod gen;

use core::{
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

macro_rules! static_assert {
    ($cond:expr $(, $($msg:tt)*)?) => {
        const _: () = {
            if !$cond {
                panic!($($msg)*)
            }
        };
    };
}

/// Make the given function const if the given condition is true.
macro_rules! const_fn {
    (
        const_if: #[cfg($($cfg:tt)+)];
        $(#[$($attr:tt)*])*
        $vis:vis const fn $($rest:tt)*
    ) => {
        #[cfg($($cfg)+)]
        $(#[$($attr)*])*
        $vis const fn $($rest)*
        #[cfg(not($($cfg)+))]
        $(#[$($attr)*])*
        $vis fn $($rest)*
    };
}

// https://github.com/rust-lang/rust/blob/1.70.0/library/core/src/sync/atomic.rs#L3155
#[inline]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) fn assert_load_ordering(order: Ordering) {
    match order {
        Ordering::Acquire | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Release => panic!("there is no such thing as a release load"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire-release load"),
        _ => unreachable!("{:?}", order),
    }
}

// https://github.com/rust-lang/rust/blob/1.70.0/library/core/src/sync/atomic.rs#L3140
#[inline]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) fn assert_store_ordering(order: Ordering) {
    match order {
        Ordering::Release | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Acquire => panic!("there is no such thing as an acquire store"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire-release store"),
        _ => unreachable!("{:?}", order),
    }
}

// https://github.com/rust-lang/rust/blob/1.70.0/library/core/src/sync/atomic.rs#L3221
#[inline]
#[cfg_attr(debug_assertions, track_caller)]
pub(crate) fn assert_compare_exchange_ordering(success: Ordering, failure: Ordering) {
    match success {
        Ordering::AcqRel
        | Ordering::Acquire
        | Ordering::Relaxed
        | Ordering::Release
        | Ordering::SeqCst => {}
        _ => unreachable!("{:?}, {:?}", success, failure),
    }
    match failure {
        Ordering::Acquire | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Release => panic!("there is no such thing as a release failure ordering"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire-release failure ordering"),
        _ => unreachable!("{:?}, {:?}", success, failure),
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

/// Zero-extends the given `MaybeUninit<T>` to `MaybeUninit<u32>` if it is smaller than 32-bit,
/// otherwise, return the given value as-is.
#[allow(dead_code)]
#[inline]
pub(crate) fn zero_extend<T: ZeroExtend>(v: MaybeUninit<T>) -> T::Out {
    T::zero_extend(v)
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
pub(crate) trait ZeroExtend: Copy {
    type Out: Copy;
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
            #[inline]
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
            #[inline]
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
    #[cfg(any(target_endian = "little", target_arch = "aarch64", target_arch = "arm"))]
    pub(crate) lo: MaybeUninit<T>,
    pub(crate) hi: MaybeUninit<T>,
    // big endian order
    #[cfg(not(any(target_endian = "little", target_arch = "aarch64", target_arch = "arm")))]
    pub(crate) lo: MaybeUninit<T>,
}

type MinWord = u32;
// Helper for implementing sub-word atomic operations using word-sized LL/SC loop or CAS loop.
//
// Refs: https://github.com/llvm/llvm-project/blob/llvmorg-17.0.0-rc2/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
// (aligned_ptr, shift, mask)
#[allow(dead_code)]
#[inline]
pub(crate) fn create_sub_word_mask_values<T>(ptr: *mut T) -> (*mut MinWord, RegSize, RegSize) {
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
    let mut mask: RegSize = (1 << (mem::size_of::<T>() * 8)) - 1; // !(0 as T) as RegSize
    if SHIFT_MASK {
        mask <<= shift;
    }
    (aligned_ptr, shift as RegSize, mask)
}

/// Emulate strict provenance.
///
/// Once strict_provenance is stable, migrate to the standard library's APIs.
#[allow(dead_code)]
#[allow(clippy::cast_possible_wrap)]
mod strict {
    #[inline]
    #[must_use]
    pub(crate) fn with_addr<T>(ptr: *mut T, addr: usize) -> *mut T {
        // FIXME(strict_provenance_magic): I am magic and should be a compiler intrinsic.
        //
        // In the mean-time, this operation is defined to be "as if" it was
        // a wrapping_offset, so we can emulate it as such. This should properly
        // restore pointer provenance even under today's compiler.
        let self_addr = ptr as usize as isize;
        let dest_addr = addr as isize;
        let offset = dest_addr.wrapping_sub(self_addr);

        // This is the canonical desugaring of this operation.
        ptr.cast::<u8>().wrapping_offset(offset).cast::<T>()
    }
}
