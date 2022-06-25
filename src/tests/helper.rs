#![allow(dead_code, unused_macros)]

pub(crate) use std::sync::atomic::Ordering;

macro_rules! test_atomic_load_store {
    ($int_type:ident) => {
        paste::paste! {
            #[allow(clippy::undocumented_unsafe_blocks)]
            mod [<test_atomic_ $int_type>] {
                __test_atomic!(load_store, $int_type);
            }
        }
    };
}
macro_rules! test_atomic {
    ($int_type:ident) => {
        paste::paste! {
            #[allow(clippy::undocumented_unsafe_blocks)]
            mod [<test_atomic_ $int_type>] {
                __test_atomic!(load_store, $int_type);
                __test_atomic!(rmw, $int_type);
            }
        }
    };
}

macro_rules! __test_atomic {
    (load_store, $int_type:ident) => {
        use std::{collections::HashSet, mem::MaybeUninit, vec, vec::Vec};

        use crossbeam_utils::thread;

        use crate::{tests::helper::*, AtomicMaybeUninit};

        #[test]
        fn load_store() {
            static VAR: AtomicMaybeUninit<$int_type> =
                AtomicMaybeUninit::<$int_type>::const_new(MaybeUninit::new(10));
            #[cfg(not(atomic_maybe_uninit_no_const_fn_trait_bound))]
            static _VAR: AtomicMaybeUninit<$int_type> =
                AtomicMaybeUninit::new(MaybeUninit::new(10));
            let var = AtomicMaybeUninit::<$int_type>::const_new(MaybeUninit::new(10));
            unsafe {
                assert_eq!(
                    VAR.load(Ordering::Relaxed).assume_init(),
                    var.load(Ordering::Relaxed).assume_init()
                );
            }
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
        #[cfg(not(all(valgrind, target_arch = "aarch64")))] // TODO: flaky
        ::quickcheck::quickcheck! {
            fn quickcheck_load_store(x: $int_type, y: $int_type) -> bool {
                unsafe {
                    for (load_order, store_order) in
                        load_orderings().into_iter().zip(store_orderings())
                    {
                        let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(x));
                        assert_eq!(a.load(load_order).assume_init(), x);
                        a.store(MaybeUninit::new(y), store_order);
                        assert_eq!(a.load(load_order).assume_init(), y);
                        a.store(MaybeUninit::new(x), store_order);
                        assert_eq!(a.load(load_order).assume_init(), x);
                        a.store(MaybeUninit::uninit(), store_order);
                        let _v = a.load(load_order);
                    }
                }
                true
            }
        }
        #[test]
        fn stress_load_store() {
            unsafe {
                let iterations =
                    if cfg!(valgrind) && cfg!(debug_assertions) { 5_000 } else { 25_000 };
                let threads = if cfg!(debug_assertions) { 2 } else { fastrand::usize(2..=8) };
                let data1 = (0..iterations).map(|_| fastrand::$int_type(..)).collect::<Vec<_>>();
                let set = data1.iter().copied().collect::<HashSet<_>>();
                let a = AtomicMaybeUninit::<$int_type>::from(data1[fastrand::usize(0..iterations)]);
                std::eprintln!("threads={}", threads);
                let now = &std::time::Instant::now();
                thread::scope(|s| {
                    for _ in 0..threads {
                        s.spawn(|_| {
                            let now = *now;
                            for i in 0..iterations {
                                a.store(MaybeUninit::new(data1[i]), rand_store_ordering());
                            }
                            std::eprintln!("store end={:?}", now.elapsed());
                        });
                        s.spawn(|_| {
                            let now = *now;
                            let mut v = vec![0; iterations];
                            for i in 0..iterations {
                                v[i] = a.load(rand_load_ordering()).assume_init();
                            }
                            std::eprintln!("load end={:?}", now.elapsed());
                            for v in v {
                                assert!(set.contains(&v), "v={}", v);
                            }
                        });
                    }
                })
                .unwrap();
            }
        }
    };
    (rmw, $int_type:ident) => {
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
        #[test]
        fn compare_exchange() {
            unsafe {
                let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(5));
                test_compare_exchange_ordering(|success, failure| {
                    a.compare_exchange(MaybeUninit::new(5), MaybeUninit::new(5), success, failure)
                });
                for (success, failure) in compare_exchange_orderings() {
                    let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(5));
                    assert_eq!(
                        a.compare_exchange(
                            MaybeUninit::new(5),
                            MaybeUninit::new(10),
                            success,
                            failure
                        )
                        .unwrap()
                        .assume_init(),
                        5
                    );
                    assert_eq!(a.load(Ordering::Relaxed).assume_init(), 10);
                    assert_eq!(
                        a.compare_exchange(
                            MaybeUninit::new(6),
                            MaybeUninit::new(12),
                            success,
                            failure
                        )
                        .unwrap_err()
                        .assume_init(),
                        10
                    );
                    assert_eq!(a.load(Ordering::Relaxed).assume_init(), 10);

                    if !cfg!(valgrind) {
                        let mut u = MaybeUninit::uninit();
                        let a = AtomicMaybeUninit::<$int_type>::new(u);
                        while let Err(e) =
                            a.compare_exchange(u, MaybeUninit::new(10), success, failure)
                        {
                            u = e;
                        }
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), 10);
                        assert_eq!(
                            a.compare_exchange(
                                MaybeUninit::new(10),
                                MaybeUninit::uninit(),
                                success,
                                failure
                            )
                            .unwrap()
                            .assume_init(),
                            10
                        );
                        let _v = a.load(Ordering::Relaxed);
                    }
                }
            }
        }
        #[test]
        fn compare_exchange_weak() {
            unsafe {
                let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(5));
                test_compare_exchange_ordering(|success, failure| {
                    a.compare_exchange_weak(
                        MaybeUninit::new(5),
                        MaybeUninit::new(5),
                        success,
                        failure,
                    )
                });
                for (success, failure) in compare_exchange_orderings() {
                    let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(4));
                    assert_eq!(
                        a.compare_exchange_weak(
                            MaybeUninit::new(6),
                            MaybeUninit::new(8),
                            success,
                            failure
                        )
                        .unwrap_err()
                        .assume_init(),
                        4
                    );
                    let mut old = a.load(Ordering::Relaxed);
                    loop {
                        let new = MaybeUninit::new(old.assume_init() * 2);
                        match a.compare_exchange_weak(old, new, success, failure) {
                            Ok(_) => break,
                            Err(x) => old = x,
                        }
                    }
                    assert_eq!(a.load(Ordering::Relaxed).assume_init(), 8);
                }
            }
        }
        #[test]
        fn fetch_update() {
            unsafe {
                let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(7));
                test_compare_exchange_ordering(|set, fetch| {
                    a.fetch_update(set, fetch, |x| Some(x))
                });
                for (success, failure) in compare_exchange_orderings() {
                    let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(7));
                    assert_eq!(
                        a.fetch_update(success, failure, |_| None).unwrap_err().assume_init(),
                        7
                    );
                    assert_eq!(
                        a.fetch_update(success, failure, |x| Some(MaybeUninit::new(
                            x.assume_init() + 1
                        )))
                        .unwrap()
                        .assume_init(),
                        7
                    );
                    assert_eq!(
                        a.fetch_update(success, failure, |x| Some(MaybeUninit::new(
                            x.assume_init() + 1
                        )))
                        .unwrap()
                        .assume_init(),
                        8
                    );
                    assert_eq!(a.load(Ordering::Relaxed).assume_init(), 9);
                }
            }
        }
        #[cfg(not(all(valgrind, target_arch = "aarch64")))] // TODO: flaky
        ::quickcheck::quickcheck! {
            fn quickcheck_swap(x: $int_type, y: $int_type) -> bool {
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
            fn quickcheck_compare_exchange(x: $int_type, y: $int_type) -> bool {
                unsafe {
                    let z = loop {
                        let z = fastrand::$int_type(..);
                        if z != y {
                            break z;
                        }
                    };
                    for (success, failure) in compare_exchange_orderings() {
                        let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(x));
                        assert_eq!(
                            a.compare_exchange(
                                MaybeUninit::new(x),
                                MaybeUninit::new(y),
                                success,
                                failure
                            )
                            .unwrap()
                            .assume_init(),
                            x
                        );
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), y);
                        assert_eq!(
                            a.compare_exchange(
                                MaybeUninit::new(z),
                                MaybeUninit::new(z),
                                success,
                                failure
                            )
                            .unwrap_err()
                            .assume_init(),
                            y
                        );
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), y);
                        assert_eq!(
                            a.compare_exchange(
                                MaybeUninit::new(y),
                                MaybeUninit::uninit(),
                                success,
                                failure
                            )
                            .unwrap()
                            .assume_init(),
                            y
                        );
                        let _v = a.load(Ordering::Relaxed);
                    }
                }
                true
            }
            fn quickcheck_fetch_update(x: $int_type, y: $int_type) -> bool {
                unsafe {
                    let z = loop {
                        let z = fastrand::$int_type(..);
                        if z != y {
                            break z;
                        }
                    };
                    for (success, failure) in compare_exchange_orderings() {
                        let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(x));
                        assert_eq!(
                            a.fetch_update(success, failure, |_| Some(MaybeUninit::new(y)))
                            .unwrap()
                            .assume_init(),
                            x
                        );
                        assert_eq!(
                            a.fetch_update(success, failure, |_| Some(MaybeUninit::new(z)))
                            .unwrap()
                            .assume_init(),
                            y
                        );
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), z);
                    }
                }
                true
            }
        }
        #[test]
        fn stress_swap() {
            unsafe {
                let iterations =
                    if cfg!(valgrind) && cfg!(debug_assertions) { 5_000 } else { 25_000 };
                let threads = if cfg!(debug_assertions) { 2 } else { fastrand::usize(2..=8) };
                let data1 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| fastrand::$int_type(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let data2 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| fastrand::$int_type(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let set = &data1
                    .iter()
                    .flat_map(|v| v.iter().copied())
                    .chain(data2.iter().flat_map(|v| v.iter().copied()))
                    .collect::<HashSet<_>>();
                let a =
                    &AtomicMaybeUninit::<$int_type>::from(data2[0][fastrand::usize(0..iterations)]);
                std::eprintln!("threads={}", threads);
                let now = &std::time::Instant::now();
                thread::scope(|s| {
                    for thread in 0..threads {
                        if thread % 2 == 0 {
                            s.spawn(move |_| {
                                let now = *now;
                                for i in 0..iterations {
                                    a.store(
                                        MaybeUninit::new(data1[thread][i]),
                                        rand_store_ordering(),
                                    );
                                }
                                std::eprintln!("store end={:?}", now.elapsed());
                            });
                        } else {
                            s.spawn(|_| {
                                let now = *now;
                                let mut v = vec![0; iterations];
                                for i in 0..iterations {
                                    v[i] = a.load(rand_load_ordering()).assume_init();
                                }
                                std::eprintln!("load end={:?}", now.elapsed());
                                for v in v {
                                    assert!(set.contains(&v), "v={}", v);
                                }
                            });
                        }
                        s.spawn(move |_| {
                            let now = *now;
                            let mut v = vec![0; iterations];
                            for i in 0..iterations {
                                v[i] = a
                                    .swap(MaybeUninit::new(data2[thread][i]), rand_swap_ordering())
                                    .assume_init();
                            }
                            std::eprintln!("swap end={:?}", now.elapsed());
                            for v in v {
                                assert!(set.contains(&v), "v={}", v);
                            }
                        });
                    }
                })
                .unwrap();
            }
        }
        #[test]
        fn stress_compare_exchange() {
            unsafe {
                let iterations =
                    if cfg!(valgrind) && cfg!(debug_assertions) { 5_000 } else { 25_000 };
                let threads = if cfg!(debug_assertions) { 2 } else { fastrand::usize(2..=8) };
                let data1 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| fastrand::$int_type(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let data2 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| fastrand::$int_type(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let set = &data1
                    .iter()
                    .flat_map(|v| v.iter().copied())
                    .chain(data2.iter().flat_map(|v| v.iter().copied()))
                    .collect::<HashSet<_>>();
                let a =
                    &AtomicMaybeUninit::<$int_type>::from(data2[0][fastrand::usize(0..iterations)]);
                std::eprintln!("threads={}", threads);
                let now = &std::time::Instant::now();
                thread::scope(|s| {
                    for thread in 0..threads {
                        if thread % 2 == 0 {
                            s.spawn(move |_| {
                                let now = *now;
                                for i in 0..iterations {
                                    a.store(
                                        MaybeUninit::new(data1[thread][i]),
                                        rand_store_ordering(),
                                    );
                                }
                                std::eprintln!("store end={:?}", now.elapsed());
                            });
                        } else {
                            s.spawn(|_| {
                                let now = *now;
                                let mut v = vec![0; iterations];
                                for i in 0..iterations {
                                    v[i] = a.load(rand_load_ordering()).assume_init();
                                }
                                std::eprintln!("load end={:?}", now.elapsed());
                                for v in v {
                                    assert!(set.contains(&v), "v={}", v);
                                }
                            });
                        }
                        s.spawn(move |_| {
                            let now = *now;
                            let mut v = vec![data2[0][0]; iterations];
                            for i in 0..iterations {
                                let old = if i % 2 == 0 {
                                    MaybeUninit::new(fastrand::$int_type(..))
                                } else {
                                    a.load(Ordering::Relaxed)
                                };
                                let new = MaybeUninit::new(data2[thread][i]);
                                let o = rand_compare_exchange_ordering();
                                match a.compare_exchange(old, new, o.0, o.1) {
                                    Ok(r) => assert_eq!(old.assume_init(), r.assume_init()),
                                    Err(r) => v[i] = r.assume_init(),
                                }
                            }
                            std::eprintln!("compare_exchange end={:?}", now.elapsed());
                            for v in v {
                                assert!(set.contains(&v), "v={}", v);
                            }
                        });
                    }
                })
                .unwrap();
            }
        }
    };
}

macro_rules! __stress_test_coherence {
    ($write:ident, $load_order:ident, $store_order:ident) => {
        use core::{mem::MaybeUninit, sync::atomic::AtomicUsize};
        use std::{sync::atomic::Ordering, vec::Vec};

        use crossbeam_utils::thread;

        use crate::AtomicMaybeUninit;

        const N: usize = if cfg!(debug_assertions) { 500_000 } else { 5_000_000 };

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
        fn stress_coherence_load_relaxed_store_relaxed() {
            __stress_test_coherence!(store, Relaxed, Relaxed);
        }
        #[test]
        // `asm!` implies a compiler fence, so it seems the relaxed load written in
        // `asm!` behaves like a consume load on architectures with weak memory models.
        // #[cfg_attr(weak_memory, should_panic)]
        fn stress_coherence_load_relaxed_store_release() {
            __stress_test_coherence!(store, Relaxed, Release);
        }
        // This test should panic on architectures with weak memory models.
        #[test]
        #[cfg_attr(weak_memory, should_panic)]
        fn stress_coherence_load_acquire_store_relaxed() {
            __stress_test_coherence!(store, Acquire, Relaxed);
        }
        #[test]
        fn stress_coherence_load_acquire_store_release() {
            __stress_test_coherence!(store, Acquire, Release);
        }
        #[test]
        fn stress_coherence_load_seqcst_store_seqcst() {
            __stress_test_coherence!(store, SeqCst, SeqCst);
        }
    };
}

macro_rules! stress_test_load_swap {
    () => {
        // This test should panic on architectures with weak memory models.
        #[test]
        #[cfg_attr(weak_memory, should_panic)]
        fn stress_coherence_load_relaxed_swap_relaxed() {
            __stress_test_coherence!(swap, Relaxed, Relaxed);
        }
        #[test]
        // `asm!` implies a compiler fence, so it seems the relaxed load written in
        // `asm!` behaves like a consume load on architectures with weak memory models.
        // #[cfg_attr(weak_memory, should_panic)]
        fn stress_coherence_load_relaxed_swap_release() {
            __stress_test_coherence!(swap, Relaxed, Release);
        }
        // This test should panic on architectures with weak memory models.
        #[test]
        #[cfg_attr(weak_memory, should_panic)]
        fn stress_coherence_load_acquire_swap_relaxed() {
            __stress_test_coherence!(swap, Acquire, Relaxed);
        }
        #[test]
        fn stress_coherence_load_acquire_swap_release() {
            __stress_test_coherence!(swap, Acquire, Release);
        }
        #[test]
        fn stress_coherence_load_acquire_swap_acqrel() {
            __stress_test_coherence!(swap, Acquire, AcqRel);
        }
        #[test]
        fn stress_coherence_load_seqcst_swap_seqcst() {
            __stress_test_coherence!(swap, SeqCst, SeqCst);
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
pub(crate) fn rand_load_ordering() -> Ordering {
    load_orderings()[fastrand::usize(0..load_orderings().len())]
}
#[track_caller]
pub(crate) fn test_load_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in load_orderings() {
        f(order);
    }

    if skip_should_panic_test() {
        return;
    }
    assert_eq!(assert_panic(|| f(Ordering::Release)), "there is no such thing as a release load");
    assert_eq!(
        assert_panic(|| f(Ordering::AcqRel)),
        "there is no such thing as an acquire/release load"
    );
}
pub(crate) fn store_orderings() -> [Ordering; 3] {
    [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst]
}
pub(crate) fn rand_store_ordering() -> Ordering {
    store_orderings()[fastrand::usize(0..store_orderings().len())]
}
#[track_caller]
pub(crate) fn test_store_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in store_orderings() {
        f(order);
    }

    if skip_should_panic_test() {
        return;
    }
    assert_eq!(assert_panic(|| f(Ordering::Acquire)), "there is no such thing as an acquire store");
    assert_eq!(
        assert_panic(|| f(Ordering::AcqRel)),
        "there is no such thing as an acquire/release store"
    );
}
pub(crate) fn swap_orderings() -> [Ordering; 5] {
    [Ordering::Relaxed, Ordering::Release, Ordering::Acquire, Ordering::AcqRel, Ordering::SeqCst]
}
pub(crate) fn rand_swap_ordering() -> Ordering {
    swap_orderings()[fastrand::usize(0..swap_orderings().len())]
}
pub(crate) fn test_swap_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in swap_orderings() {
        f(order);
    }
}
pub(crate) fn compare_exchange_orderings() -> [(Ordering, Ordering); 15] {
    [
        (Ordering::Relaxed, Ordering::Relaxed),
        (Ordering::Relaxed, Ordering::Acquire),
        (Ordering::Relaxed, Ordering::SeqCst),
        (Ordering::Acquire, Ordering::Relaxed),
        (Ordering::Acquire, Ordering::Acquire),
        (Ordering::Acquire, Ordering::SeqCst),
        (Ordering::Release, Ordering::Relaxed),
        (Ordering::Release, Ordering::Acquire),
        (Ordering::Release, Ordering::SeqCst),
        (Ordering::AcqRel, Ordering::Relaxed),
        (Ordering::AcqRel, Ordering::Acquire),
        (Ordering::AcqRel, Ordering::SeqCst),
        (Ordering::SeqCst, Ordering::Relaxed),
        (Ordering::SeqCst, Ordering::Acquire),
        (Ordering::SeqCst, Ordering::SeqCst),
    ]
}
pub(crate) fn rand_compare_exchange_ordering() -> (Ordering, Ordering) {
    compare_exchange_orderings()[fastrand::usize(0..compare_exchange_orderings().len())]
}
pub(crate) fn test_compare_exchange_ordering<T: std::fmt::Debug>(
    f: impl Fn(Ordering, Ordering) -> T,
) {
    for &(success, failure) in &compare_exchange_orderings() {
        f(success, failure);
    }

    if skip_should_panic_test() {
        return;
    }
    for &order in &swap_orderings() {
        let msg = assert_panic(|| f(order, Ordering::AcqRel));
        assert!(
            msg == "there is no such thing as an acquire/release failure ordering"
                || msg == "there is no such thing as an acquire/release load",
            "{}",
            msg
        );
        let msg = assert_panic(|| f(order, Ordering::Release));
        assert!(
            msg == "there is no such thing as a release failure ordering"
                || msg == "there is no such thing as a release load",
            "{}",
            msg
        );
    }
}
fn skip_should_panic_test() -> bool {
    // Miri's panic handling is slow
    // MSAN false positive: https://gist.github.com/taiki-e/dd6269a8ffec46284fdc764a4849f884
    cfg!(miri)
        || option_env!("CARGO_PROFILE_RELEASE_LTO").map_or(false, |v| v == "fat")
            && option_env!("MSAN_OPTIONS").is_some()
}
