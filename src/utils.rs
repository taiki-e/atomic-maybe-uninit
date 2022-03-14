use core::{hint, sync::atomic::Ordering};

macro_rules! static_assert {
    ($cond:expr $(, $($msg:tt)*)?) => {
        const _: () = {
            if !$cond {
                panic!($($msg)*)
            }
        };
    };
}

// https://github.com/rust-lang/rust/blob/1.59.0/library/core/src/sync/atomic.rs#L2359
#[inline]
pub(crate) fn assert_load_ordering(order: Ordering) {
    match order {
        Ordering::Acquire | Ordering::Relaxed | Ordering::SeqCst => {}
        Ordering::Release => panic!("there is no such thing as a release load"),
        Ordering::AcqRel => panic!("there is no such thing as an acquire/release load"),
        _ => unreachable!("{:?}", order),
    }
}

// https://github.com/rust-lang/rust/blob/1.59.0/library/core/src/sync/atomic.rs#L2345
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

/// Informs the compiler that this point in the code is not reachable, enabling
/// further optimizations.
///
/// # Safety
///
/// Reaching this function is completely undefined behavior.
#[inline]
pub(crate) unsafe fn release_unreachable_unchecked() -> ! {
    if cfg!(debug_assertions) {
        unreachable!();
    } else {
        // SAFETY: the caller must uphold the safety contract for `release_unreachable_unchecked`.
        unsafe { hint::unreachable_unchecked() }
    }
}
