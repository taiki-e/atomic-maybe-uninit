#[macro_use]
#[path = "gen/utils.rs"]
mod gen;

use core::sync::atomic::Ordering;

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

macro_rules! delegate_load_store {
    ($ty:ident, $base:ident) => {
        static_assert!(core::mem::size_of::<$ty>() == core::mem::size_of::<$base>());
        impl AtomicLoad for $ty {
            #[inline]
            unsafe fn atomic_load(
                src: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    <$base as AtomicLoad>::atomic_load(
                        src.cast::<MaybeUninit<$base>>(),
                        out.cast::<MaybeUninit<$base>>(),
                        order,
                    );
                }
            }
        }
        impl AtomicStore for $ty {
            #[inline]
            unsafe fn atomic_store(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    <$base as AtomicStore>::atomic_store(
                        dst.cast::<MaybeUninit<$base>>(),
                        val.cast::<MaybeUninit<$base>>(),
                        order,
                    );
                }
            }
        }
    };
}
#[allow(unused_macros)]
macro_rules! delegate_swap_only {
    ($ty:ident, $base:ident) => {
        static_assert!(core::mem::size_of::<$ty>() == core::mem::size_of::<$base>());
        impl AtomicSwap for $ty {
            #[inline]
            unsafe fn atomic_swap(
                dst: *mut MaybeUninit<Self>,
                val: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                order: Ordering,
            ) {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    <$base as AtomicSwap>::atomic_swap(
                        dst.cast::<MaybeUninit<$base>>(),
                        val.cast::<MaybeUninit<$base>>(),
                        out.cast::<MaybeUninit<$base>>(),
                        order,
                    );
                }
            }
        }
    };
}
#[allow(unused_macros)]
macro_rules! delegate_cas {
    ($ty:ident, $base:ident) => {
        delegate_swap_only!($ty, $base);
        impl AtomicCompareExchange for $ty {
            #[inline]
            unsafe fn atomic_compare_exchange(
                dst: *mut MaybeUninit<Self>,
                current: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> bool {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    <$base as AtomicCompareExchange>::atomic_compare_exchange(
                        dst.cast::<MaybeUninit<$base>>(),
                        current.cast::<MaybeUninit<$base>>(),
                        new.cast::<MaybeUninit<$base>>(),
                        out.cast::<MaybeUninit<$base>>(),
                        success,
                        failure,
                    )
                }
            }
            #[inline]
            unsafe fn atomic_compare_exchange_weak(
                dst: *mut MaybeUninit<Self>,
                current: *const MaybeUninit<Self>,
                new: *const MaybeUninit<Self>,
                out: *mut MaybeUninit<Self>,
                success: Ordering,
                failure: Ordering,
            ) -> bool {
                // SAFETY: the caller must uphold the safety contract.
                unsafe {
                    <$base as AtomicCompareExchange>::atomic_compare_exchange_weak(
                        dst.cast::<MaybeUninit<$base>>(),
                        current.cast::<MaybeUninit<$base>>(),
                        new.cast::<MaybeUninit<$base>>(),
                        out.cast::<MaybeUninit<$base>>(),
                        success,
                        failure,
                    )
                }
            }
        }
    };
}
macro_rules! atomic_size {
    ($delegate:ident) => {
        #[cfg(target_pointer_width = "16")]
        $delegate!(isize, i16);
        #[cfg(target_pointer_width = "16")]
        $delegate!(usize, u16);
        #[cfg(target_pointer_width = "32")]
        $delegate!(isize, i32);
        #[cfg(target_pointer_width = "32")]
        $delegate!(usize, u32);
        #[cfg(target_pointer_width = "64")]
        $delegate!(isize, i64);
        #[cfg(target_pointer_width = "64")]
        $delegate!(usize, u64);
        #[cfg(target_pointer_width = "128")]
        $delegate!(isize, i128);
        #[cfg(target_pointer_width = "128")]
        $delegate!(usize, u128);
    };
}
