// SPDX-License-Identifier: Apache-2.0 OR MIT

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

#[allow(dead_code)]
#[inline]
pub(crate) fn zero_extend<T: ZeroExtend>(v: MaybeUninit<T>) -> T::Out {
    T::zero_extend(v)
}
pub(crate) trait ZeroExtend: Copy {
    type Out: Copy;
    fn zero_extend(v: MaybeUninit<Self>) -> Self::Out;
}
#[derive(Clone, Copy)]
#[repr(C)]
struct ZeroExtend8 {
    #[cfg(target_endian = "big")]
    pad: [u8; 3],
    v: MaybeUninit<u8>,
    #[cfg(target_endian = "little")]
    pad: [u8; 3],
}
#[derive(Clone, Copy)]
#[repr(C)]
struct ZeroExtend16 {
    #[cfg(target_endian = "big")]
    pad: u16,
    v: MaybeUninit<u16>,
    #[cfg(target_endian = "little")]
    pad: u16,
}
macro_rules! zero_extend {
    (8; $ty:ident) => {
        impl ZeroExtend for $ty {
            type Out = MaybeUninit<u32>;
            #[inline]
            fn zero_extend(v: MaybeUninit<$ty>) -> Self::Out {
                #[allow(clippy::useless_transmute)]
                // SAFETY: we can safely transmute any 32-bit value to MaybeUninit<u32>.
                unsafe {
                    mem::transmute(ZeroExtend8 { v: mem::transmute(v), pad: [0; 3] })
                }
            }
        }
    };
    (16; $ty:ident) => {
        impl ZeroExtend for $ty {
            type Out = MaybeUninit<u32>;
            #[inline]
            fn zero_extend(v: MaybeUninit<$ty>) -> Self::Out {
                #[allow(clippy::useless_transmute)]
                // SAFETY: we can safely transmute any 32-bit value to MaybeUninit<u32>.
                unsafe {
                    mem::transmute(ZeroExtend16 { v: mem::transmute(v), pad: 0 })
                }
            }
        }
    };
    ($ty:ident) => {
        impl ZeroExtend for $ty {
            type Out = MaybeUninit<$ty>;
            #[inline]
            fn zero_extend(v: MaybeUninit<$ty>) -> Self::Out {
                v
            }
        }
    };
}
zero_extend!(8; i8);
zero_extend!(8; u8);
zero_extend!(16; i16);
zero_extend!(16; u16);
zero_extend!(i32);
zero_extend!(u32);
zero_extend!(i64);
zero_extend!(u64);
zero_extend!(isize);
zero_extend!(usize);

#[cfg(any(
    target_arch = "aarch64",
    target_arch = "powerpc64",
    target_arch = "s390x",
    target_arch = "x86_64",
))]
pub(crate) use imp::Pair128 as Pair;
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
    pub(crate) pair: Pair,
}

#[cfg(any(target_arch = "arm", target_arch = "hexagon", target_arch = "x86"))]
pub(crate) use imp::Pair64 as Pair;
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
    pub(crate) pair: Pair,
}

// little endian order
#[allow(dead_code)]
#[cfg(any(target_endian = "little", target_arch = "aarch64", target_arch = "arm"))]
mod imp {
    use core::mem::MaybeUninit;
    // A pair of 32-bit values.
    #[derive(Clone, Copy)]
    #[repr(C)]
    pub(crate) struct Pair64 {
        pub(crate) lo: MaybeUninit<u32>,
        pub(crate) hi: MaybeUninit<u32>,
    }
    // A pair of 64-bit values.
    #[derive(Clone, Copy)]
    #[repr(C)]
    pub(crate) struct Pair128 {
        pub(crate) lo: MaybeUninit<u64>,
        pub(crate) hi: MaybeUninit<u64>,
    }
}
// big endian order
#[allow(dead_code)]
#[cfg(not(any(target_endian = "little", target_arch = "aarch64", target_arch = "arm")))]
mod imp {
    use core::mem::MaybeUninit;
    // A pair of 32-bit values.
    #[derive(Clone, Copy)]
    #[repr(C)]
    pub(crate) struct Pair64 {
        pub(crate) hi: MaybeUninit<u32>,
        pub(crate) lo: MaybeUninit<u32>,
    }
    // A pair of 64-bit values.
    #[derive(Clone, Copy)]
    #[repr(C)]
    pub(crate) struct Pair128 {
        pub(crate) hi: MaybeUninit<u64>,
        pub(crate) lo: MaybeUninit<u64>,
    }
}
