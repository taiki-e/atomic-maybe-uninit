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

/// Informs the compiler that this point in the code is not reachable, enabling
/// further optimizations.
///
/// In release mode, this macro calls `core::hint::unreachable_unchecked`.
/// In debug mode, this macro calls `unreachable!` just in case.
///
/// # Safety
///
/// Reaching this function is completely undefined behavior.
macro_rules! unreachable_unchecked {
    ($($tt:tt)*) => {
        if cfg!(debug_assertions) {
            unreachable!($($tt)*);
        } else {
            // SAFETY: the caller must uphold the safety contract for `unreachable_unchecked`.
            // (To force the caller to use unsafe block for this macro, do not use
            // unsafe block here.)
            core::hint::unreachable_unchecked()
        }
    };
}

// https://github.com/rust-lang/rust/blob/1.61.0/library/core/src/sync/atomic.rs#L2566
#[inline]
pub(crate) fn assert_load_ordering(order: Ordering) {
    match order {
        Ordering::Acquire | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Release => panic!("there is no such thing as a release load"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire/release load"),
        _ => unreachable!("{:?}", order),
    }
}

// https://github.com/rust-lang/rust/blob/1.61.0/library/core/src/sync/atomic.rs#L2552
#[inline]
pub(crate) fn assert_store_ordering(order: Ordering) {
    match order {
        Ordering::Release | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Acquire => panic!("there is no such thing as an acquire store"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire/release store"),
        _ => unreachable!("{:?}", order),
    }
}

#[inline]
pub(crate) fn assert_swap_ordering(order: Ordering) {
    match order {
        Ordering::AcqRel
        | Ordering::Acquire
        | Ordering::Relaxed
        | Ordering::Release
        | Ordering::SeqCst => {}
        _ => unreachable!("{:?}", order),
    }
}

// https://github.com/rust-lang/rust/pull/98383
#[inline]
pub(crate) fn assert_compare_exchange_ordering(success: Ordering, failure: Ordering) {
    match success {
        Ordering::AcqRel
        | Ordering::Acquire
        | Ordering::Relaxed
        | Ordering::Release
        | Ordering::SeqCst => {}
        _ => unreachable!("{:?}", success),
    }
    match failure {
        Ordering::Acquire | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Release => panic!("there is no such thing as a release failure ordering"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire/release failure ordering"),
        _ => unreachable!("{:?}", failure),
    }
}

// https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2016/p0418r2.html
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
