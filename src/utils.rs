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

// https://github.com/rust-lang/rust/blob/1.59.0/library/core/src/sync/atomic.rs#L2359
#[inline]
pub(crate) fn assert_load_ordering(order: Ordering) {
    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
    match order {
        Acquire | Relaxed | SeqCst => {}
        Release => panic!("there is no such thing as a release load"),
        AcqRel => panic!("there is no such thing as an acquire/release load"),
        _ => unreachable!("{:?}", order),
    }
}

// https://github.com/rust-lang/rust/blob/1.59.0/library/core/src/sync/atomic.rs#L2345
#[inline]
pub(crate) fn assert_store_ordering(order: Ordering) {
    use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
    match order {
        Release | Relaxed | SeqCst => {}
        Acquire => panic!("there is no such thing as an acquire store"),
        AcqRel => panic!("there is no such thing as an acquire/release store"),
        _ => unreachable!("{:?}", order),
    }
}

#[inline]
pub(crate) unsafe fn ordering_unreachable_unchecked(order: Ordering) -> ! {
    match order {
        // SAFETY: the caller must uphold the safety contract for `ordering_unreachable_unchecked`.
        #[cfg(not(debug_assertions))]
        Ordering::AcqRel
        | Ordering::Acquire
        | Ordering::Relaxed
        | Ordering::Release
        | Ordering::SeqCst => unsafe { core::hint::unreachable_unchecked() },
        _ => unreachable!("{:?}", order),
    }
}
