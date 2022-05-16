#![allow(dead_code, unused_macros)]

use std::sync::atomic::Ordering;

macro_rules! test_atomic_load_store {
    ($int_type:ident) => {
        paste::paste! {
            #[allow(clippy::undocumented_unsafe_blocks)]
            mod [<test_atomic_ $int_type>] {
                __test_atomic_load_store!($int_type);
            }
        }
    };
}
macro_rules! test_atomic {
    ($int_type:ident) => {
        paste::paste! {
            #[allow(clippy::undocumented_unsafe_blocks)]
            mod [<test_atomic_ $int_type>] {
                __test_atomic_load_store!($int_type);
                __test_atomic!($int_type);
            }
        }
    };
}

macro_rules! __test_atomic_load_store {
    ($int_type:ident) => {
        use std::mem::MaybeUninit;

        use crate::{tests::helper::*, AtomicMaybeUninit};

        #[test]
        fn load_store() {
            static VAR: AtomicMaybeUninit<$int_type> =
                AtomicMaybeUninit::<$int_type>::const_new(MaybeUninit::new(10));
            #[cfg(atomic_maybe_uninit_const_fn_trait_bound)]
            static _VAR: AtomicMaybeUninit<$int_type> =
                AtomicMaybeUninit::new(MaybeUninit::new(10));
            test_load_ordering(|order| VAR.load(order));
            test_store_ordering(|order| VAR.store(MaybeUninit::new(10), order));
            unsafe {
                for (load_order, store_order) in load_orderings().into_iter().zip(store_orderings())
                {
                    assert_eq!(VAR.load(load_order).assume_init(), 10);
                    VAR.store(MaybeUninit::new(5), store_order);
                    assert_eq!(VAR.load(load_order).assume_init(), 5);
                    VAR.store(MaybeUninit::uninit(), store_order);
                    let _v = VAR.load(load_order);
                    VAR.store(MaybeUninit::new(10), store_order);

                    let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(1));
                    assert_eq!(a.load(load_order).assume_init(), 1);
                    a.store(MaybeUninit::new(2), store_order);
                    assert_eq!(a.load(load_order).assume_init(), 2);
                    let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::uninit());
                    let _v = a.load(load_order);
                    a.store(MaybeUninit::new(2), store_order);
                    assert_eq!(a.load(load_order).assume_init(), 2);
                    a.store(MaybeUninit::uninit(), store_order);
                    let _v = a.load(load_order);
                }
            }
        }
    };
}
macro_rules! __test_atomic {
    ($int_type:ident) => {
        #[test]
        fn swap() {
            unsafe {
                let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(5));
                test_swap_ordering(|order| a.swap(MaybeUninit::new(5), order));
                for order in swap_orderings() {
                    let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(5));
                    assert_eq!(a.swap(MaybeUninit::new(10), order).assume_init(), 5);
                    assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                    let _v = a.swap(MaybeUninit::new(15), order);
                    let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::uninit());
                    let _v = a.swap(MaybeUninit::new(10), order);
                    assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                }
            }
        }
        mod quickcheck {
            use std::mem::MaybeUninit;

            use crate::{tests::helper::*, AtomicMaybeUninit};
            ::quickcheck::quickcheck! {
                fn swap(x: $int_type, y: $int_type) -> bool {
                    unsafe {
                        for order in swap_orderings() {
                            let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(x));
                            assert_eq!(a.swap(MaybeUninit::new(y), order).assume_init(), x);
                            assert_eq!(a.swap(MaybeUninit::new(x), order).assume_init(), y);
                            assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), x);
                        }
                    }
                    true
                }
            }
        }
    };
}

macro_rules! __stress_test {
    ($write:ident, $load_order:ident, $store_order:ident) => {
        use core::{mem::MaybeUninit, sync::atomic::AtomicUsize};
        use std::{sync::atomic::Ordering, vec::Vec};

        use crossbeam_utils::thread;

        use crate::AtomicMaybeUninit;

        const N: usize = if cfg!(debug_assertions) { 500_000 } else { 4_000_000 };

        #[allow(clippy::undocumented_unsafe_blocks)]
        unsafe {
            let v = &(0..N).map(|_| AtomicUsize::new(0)).collect::<Vec<_>>();
            let a = &AtomicMaybeUninit::from(0_usize);
            thread::scope(|s| {
                s.spawn(|_| {
                    for i in 0..N {
                        if let Some(b) = (a.load(Ordering::$load_order).assume_init()
                            as *const AtomicUsize)
                            .as_ref()
                        {
                            assert_eq!(b.load(Ordering::Relaxed), 1, "i={i}");
                        }
                    }
                });
                for b in v {
                    b.store(1, Ordering::Relaxed);
                    a.$write(MaybeUninit::new(b as *const _ as usize), Ordering::$store_order);
                }
            })
            .unwrap();
        }
    };
}

macro_rules! stress_test_load_store {
    () => {
        // This test should panic on architectures with weak memory models.
        #[test]
        // This should be `any(target_arch = ...)`, but qemu-user running on x86_64 does
        // not seem to support weak memory emulation.
        // Therefore, explicitly enable should_panic only on actual aarch64 hardware.
        #[cfg_attr(weak_memory, should_panic)]
        fn stress_load_relaxed_store_relaxed() {
            __stress_test!(store, Relaxed, Relaxed);
        }
        #[test]
        // `asm!` implies a compiler fence, so it seems the relaxed load written in
        // `asm!` behaves like a consume load on architectures with weak memory models.
        // #[cfg_attr(weak_memory, should_panic)]
        fn stress_load_relaxed_store_release() {
            __stress_test!(store, Relaxed, Release);
        }
        // This test should panic on architectures with weak memory models.
        #[test]
        #[cfg_attr(weak_memory, should_panic)]
        fn stress_load_acquire_store_relaxed() {
            __stress_test!(store, Acquire, Relaxed);
        }
        #[test]
        fn stress_load_acquire_store_release() {
            __stress_test!(store, Acquire, Release);
        }
        #[test]
        fn stress_load_seqcst_store_seqcst() {
            __stress_test!(store, SeqCst, SeqCst);
        }
    };
}

macro_rules! stress_test_load_swap {
    () => {
        // This test should panic on architectures with weak memory models.
        #[test]
        #[cfg_attr(weak_memory, should_panic)]
        fn stress_load_relaxed_swap_relaxed() {
            __stress_test!(swap, Relaxed, Relaxed);
        }
        #[test]
        // `asm!` implies a compiler fence, so it seems the relaxed load written in
        // `asm!` behaves like a consume load on architectures with weak memory models.
        // #[cfg_attr(weak_memory, should_panic)]
        fn stress_load_relaxed_swap_release() {
            __stress_test!(swap, Relaxed, Release);
        }
        // This test should panic on architectures with weak memory models.
        #[test]
        #[cfg_attr(weak_memory, should_panic)]
        fn stress_load_acquire_swap_relaxed() {
            __stress_test!(swap, Acquire, Relaxed);
        }
        #[test]
        fn stress_load_acquire_swap_release() {
            __stress_test!(swap, Acquire, Release);
        }
        #[test]
        fn stress_load_acquire_swap_acqrel() {
            __stress_test!(swap, Acquire, AcqRel);
        }
        #[test]
        fn stress_load_seqcst_swap_seqcst() {
            __stress_test!(swap, SeqCst, SeqCst);
        }
    };
}

#[track_caller]
fn assert_panic<T: std::fmt::Debug>(f: impl FnOnce() -> T) -> std::string::String {
    let backtrace = std::env::var_os("RUST_BACKTRACE");
    let hook = std::panic::take_hook();
    std::env::set_var("RUST_BACKTRACE", "0"); // Suppress backtrace
    std::panic::set_hook(std::boxed::Box::new(|_| {})); // Suppress panic msg
    let res = std::panic::catch_unwind(std::panic::AssertUnwindSafe(f));
    std::panic::set_hook(hook);
    match backtrace {
        Some(v) => std::env::set_var("RUST_BACKTRACE", v),
        None => std::env::remove_var("RUST_BACKTRACE"),
    }
    let msg = res.unwrap_err();
    msg.downcast_ref::<std::string::String>()
        .cloned()
        .unwrap_or_else(|| msg.downcast_ref::<&'static str>().copied().unwrap().into())
}
pub(crate) fn load_orderings() -> [Ordering; 3] {
    [Ordering::Relaxed, Ordering::Acquire, Ordering::SeqCst]
}
#[track_caller]
pub(crate) fn test_load_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in load_orderings() {
        f(order);
    }

    if option_env!("CARGO_PROFILE_RELEASE_LTO").map_or(false, |v| v == "fat")
        && option_env!("MSAN_OPTIONS").is_some()
    {
        // MSAN false positive: https://gist.github.com/taiki-e/dd6269a8ffec46284fdc764a4849f884
        return;
    }

    // Miri's panic handling is slow
    if !cfg!(miri) {
        assert_eq!(
            assert_panic(|| f(Ordering::Release)),
            "there is no such thing as a release load"
        );
        assert_eq!(
            assert_panic(|| f(Ordering::AcqRel)),
            "there is no such thing as an acquire/release load"
        );
    }
}
pub(crate) fn store_orderings() -> [Ordering; 3] {
    [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst]
}
#[track_caller]
pub(crate) fn test_store_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in store_orderings() {
        f(order);
    }

    if option_env!("CARGO_PROFILE_RELEASE_LTO").map_or(false, |v| v == "fat")
        && option_env!("MSAN_OPTIONS").is_some()
    {
        // MSAN false positive: https://gist.github.com/taiki-e/dd6269a8ffec46284fdc764a4849f884
        return;
    }

    // Miri's panic handling is slow
    if !cfg!(miri) {
        assert_eq!(
            assert_panic(|| f(Ordering::Acquire)),
            "there is no such thing as an acquire store"
        );
        assert_eq!(
            assert_panic(|| f(Ordering::AcqRel)),
            "there is no such thing as an acquire/release store"
        );
    }
}
pub(crate) fn swap_orderings() -> [Ordering; 5] {
    [Ordering::Relaxed, Ordering::Release, Ordering::Acquire, Ordering::AcqRel, Ordering::SeqCst]
}
pub(crate) fn test_swap_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in swap_orderings() {
        f(order);
    }
}
