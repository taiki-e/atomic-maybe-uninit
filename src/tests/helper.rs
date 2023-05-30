#![allow(dead_code, unused_macros)]

pub(crate) use std::sync::atomic::Ordering;

macro_rules! test_atomic_load_store {
    ($int_type:ident) => {
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks,
            )]
            mod [<test_atomic_ $int_type>] {
                __test_atomic!(load_store, $int_type);
            }
        }
    };
}
macro_rules! test_atomic_load_store_swap {
    ($int_type:ident) => {
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks,
            )]
            mod [<test_atomic_ $int_type>] {
                __test_atomic!(load_store, $int_type);
                __test_atomic!(swap, $int_type);
            }
        }
    };
}
macro_rules! test_atomic {
    ($int_type:ident) => {
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks,
            )]
            mod [<test_atomic_ $int_type>] {
                __test_atomic!(load_store, $int_type);
                __test_atomic!(swap, $int_type);
                __test_atomic!(cas, $int_type);
            }
        }
    };
}

macro_rules! __test_atomic {
    (load_store, $int_type:ident) => {
        use std::{collections::BTreeSet, mem::MaybeUninit, vec, vec::Vec};

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
                for (load_order, store_order) in LOAD_ORDERINGS.into_iter().zip(STORE_ORDERINGS) {
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
                        LOAD_ORDERINGS.into_iter().zip(STORE_ORDERINGS)
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
                let (iterations, threads) = stress_test_config();
                let data1 = (0..iterations).map(|_| fastrand::$int_type(..)).collect::<Vec<_>>();
                let set = data1.iter().copied().collect::<BTreeSet<_>>();
                let a = AtomicMaybeUninit::<$int_type>::from(data1[fastrand::usize(0..iterations)]);
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
    (swap, $int_type:ident) => {
        #[test]
        fn swap() {
            unsafe {
                let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(5));
                test_swap_ordering(|order| a.swap(MaybeUninit::new(5), order));
                for order in SWAP_ORDERINGS {
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
        #[cfg(not(all(valgrind, target_arch = "aarch64")))] // TODO: flaky
        ::quickcheck::quickcheck! {
            fn quickcheck_swap(x: $int_type, y: $int_type) -> bool {
                unsafe {
                    for order in SWAP_ORDERINGS {
                        let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(x));
                        assert_eq!(a.swap(MaybeUninit::new(y), order).assume_init(), x);
                        assert_eq!(a.swap(MaybeUninit::new(x), order).assume_init(), y);
                        assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), x);
                    }
                }
                true
            }
        }
        #[test]
        fn stress_swap() {
            unsafe {
                let (iterations, threads) = stress_test_config();
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
                    .collect::<BTreeSet<_>>();
                let a =
                    &AtomicMaybeUninit::<$int_type>::from(data2[0][fastrand::usize(0..iterations)]);
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
    };
    (cas, $int_type:ident) => {
        #[test]
        fn compare_exchange() {
            unsafe {
                let a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(5));
                test_compare_exchange_ordering(|success, failure| {
                    a.compare_exchange(MaybeUninit::new(5), MaybeUninit::new(5), success, failure)
                });
                for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
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
                for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
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
                for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
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
            fn quickcheck_compare_exchange(x: $int_type, y: $int_type) -> bool {
                unsafe {
                    let z = loop {
                        let z = fastrand::$int_type(..);
                        if z != y {
                            break z;
                        }
                    };
                    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
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
                    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
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
                        assert_eq!(
                            a.fetch_update(success, failure, |z| if z.assume_init() == y {
                                Some(z)
                            } else {
                                None
                            })
                            .unwrap_err()
                            .assume_init(),
                            z
                        );
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), z);
                    }
                }
                true
            }
        }
        #[test]
        fn stress_compare_exchange() {
            unsafe {
                let (iterations, threads) = stress_test_config();
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
                    .collect::<BTreeSet<_>>();
                let a =
                    &AtomicMaybeUninit::<$int_type>::from(data2[0][fastrand::usize(0..iterations)]);
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
pub(crate) const LOAD_ORDERINGS: [Ordering; 3] =
    [Ordering::Relaxed, Ordering::Acquire, Ordering::SeqCst];
pub(crate) fn rand_load_ordering() -> Ordering {
    LOAD_ORDERINGS[fastrand::usize(0..LOAD_ORDERINGS.len())]
}
#[track_caller]
pub(crate) fn test_load_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in LOAD_ORDERINGS {
        f(order);
    }

    assert_eq!(assert_panic(|| f(Ordering::Release)), "there is no such thing as a release load");
    assert_eq!(
        assert_panic(|| f(Ordering::AcqRel)),
        "there is no such thing as an acquire-release load"
    );
}
pub(crate) const STORE_ORDERINGS: [Ordering; 3] =
    [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst];
pub(crate) fn rand_store_ordering() -> Ordering {
    STORE_ORDERINGS[fastrand::usize(0..STORE_ORDERINGS.len())]
}
#[track_caller]
pub(crate) fn test_store_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in STORE_ORDERINGS {
        f(order);
    }

    assert_eq!(assert_panic(|| f(Ordering::Acquire)), "there is no such thing as an acquire store");
    assert_eq!(
        assert_panic(|| f(Ordering::AcqRel)),
        "there is no such thing as an acquire-release store"
    );
}
pub(crate) const SWAP_ORDERINGS: [Ordering; 5] =
    [Ordering::Relaxed, Ordering::Release, Ordering::Acquire, Ordering::AcqRel, Ordering::SeqCst];
pub(crate) fn rand_swap_ordering() -> Ordering {
    SWAP_ORDERINGS[fastrand::usize(0..SWAP_ORDERINGS.len())]
}
pub(crate) fn test_swap_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in SWAP_ORDERINGS {
        f(order);
    }
}
pub(crate) const COMPARE_EXCHANGE_ORDERINGS: [(Ordering, Ordering); 15] = [
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
];
pub(crate) fn rand_compare_exchange_ordering() -> (Ordering, Ordering) {
    COMPARE_EXCHANGE_ORDERINGS[fastrand::usize(0..COMPARE_EXCHANGE_ORDERINGS.len())]
}
pub(crate) fn test_compare_exchange_ordering<T: std::fmt::Debug>(
    f: impl Fn(Ordering, Ordering) -> T,
) {
    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
        f(success, failure);
    }

    for order in SWAP_ORDERINGS {
        let msg = assert_panic(|| f(order, Ordering::AcqRel));
        assert!(
            msg == "there is no such thing as an acquire-release failure ordering"
                || msg == "there is no such thing as an acquire-release load",
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
// for stress test generated by __test_atomic macro
pub(crate) fn stress_test_config() -> (usize, usize) {
    let iterations = if cfg!(debug_assertions) { 5_000 } else { 25_000 };
    let threads = if cfg!(debug_assertions) { 2 } else { fastrand::usize(2..=8) };
    std::eprintln!("threads={threads}");
    (iterations, threads)
}

// For -C panic=abort -Z panic_abort_tests: https://github.com/rust-lang/rust/issues/67650
fn is_panic_abort() -> bool {
    build_context::PANIC.contains("abort")
}

// Test the cases that should not fail if the memory ordering is implemented correctly.
// This is still not exhaustive and only tests a few cases.
// This currently only supports 32-bit or more integers.
macro_rules! __stress_test_acquire_release {
    (should_pass, $int_type:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            #[test]
            fn [<load_ $load_order:lower _ $write _ $store_order:lower>]() {
                __stress_test_acquire_release!(
                    $int_type, $write, $load_order, $store_order);
            }
        }
    };
    (can_panic, $int_type:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            // Currently, to make this test work well enough outside of Miri, tens of thousands
            // of iterations are needed, but this test is slow in some environments.
            // So, ignore by default.
            #[test]
            #[ignore]
            fn [<load_ $load_order:lower _ $write _ $store_order:lower>]() {
                can_panic("a=", || __stress_test_acquire_release!(
                    $int_type, $write, $load_order, $store_order));
            }
        }
    };
    ($int_type:ident, $write:ident, $load_order:ident, $store_order:ident) => {{
        use std::{
            mem::MaybeUninit,
            sync::atomic::{AtomicUsize, Ordering},
        };

        use crossbeam_utils::thread;

        use crate::AtomicMaybeUninit;

        let mut n: usize = 50_000;
        // This test is relatively fast because it spawns only one thread, but
        // the iterations are limited to a maximum value of integers.
        if $int_type::try_from(n).is_err() {
            n = $int_type::MAX as usize;
        }
        let a = &AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(0));
        let b = &AtomicUsize::new(0);
        thread::scope(|s| unsafe {
            s.spawn(|_| {
                for i in 0..n {
                    b.store(i, Ordering::Relaxed);
                    a.$write(MaybeUninit::new(i as _), Ordering::$store_order);
                }
            });
            loop {
                let a = a.load(Ordering::$load_order).assume_init();
                let b = b.load(Ordering::Relaxed);
                assert!(a as usize <= b, "a={},b={}", a, b);
                if a as usize == n - 1 {
                    break;
                }
            }
        })
        .unwrap();
    }};
}
macro_rules! __stress_test_seqcst {
    (should_pass, $int_type:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            // Currently, to make this test work well enough outside of Miri, tens of thousands
            // of iterations are needed, but this test is very slow in some environments because
            // it creates two threads for each iteration.
            // So, ignore on QEMU by default.
            #[test]
            #[cfg_attr(qemu, ignore)]
            fn [<load_ $load_order:lower _ $write _ $store_order:lower>]() {
                __stress_test_seqcst!(
                    $int_type, $write, $load_order, $store_order);
            }
        }
    };
    (can_panic, $int_type:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            // Currently, to make this test work well enough outside of Miri, tens of thousands
            // of iterations are needed, but this test is very slow in some environments because
            // it creates two threads for each iteration.
            // So, ignore by default.
            #[test]
            #[ignore]
            fn [<load_ $load_order:lower _ $write _ $store_order:lower>]() {
                can_panic("c=2", || __stress_test_seqcst!(
                    $int_type, $write, $load_order, $store_order));
            }
        }
    };
    ($int_type:ident, $write:ident, $load_order:ident, $store_order:ident) => {{
        use std::{
            mem::MaybeUninit,
            sync::atomic::{AtomicUsize, Ordering},
        };

        use crossbeam_utils::thread;

        use crate::AtomicMaybeUninit;

        const N: usize = if cfg!(valgrind) { 50 } else { 50_000 };
        let a = &AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(0));
        let b = &AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(0));
        let c = &AtomicUsize::new(0);
        let ready = &AtomicUsize::new(0);
        thread::scope(|s| unsafe {
            for n in 0..N {
                a.store(MaybeUninit::new(0), Ordering::Relaxed);
                b.store(MaybeUninit::new(0), Ordering::Relaxed);
                c.store(0, Ordering::Relaxed);
                let h_a = s.spawn(|_| {
                    while ready.load(Ordering::Relaxed) == 0 {}
                    a.$write(MaybeUninit::new(1), Ordering::$store_order);
                    if b.load(Ordering::$load_order).assume_init() == 0 {
                        c.fetch_add(1, Ordering::Relaxed);
                    }
                });
                let h_b = s.spawn(|_| {
                    while ready.load(Ordering::Relaxed) == 0 {}
                    b.$write(MaybeUninit::new(1), Ordering::$store_order);
                    if a.load(Ordering::$load_order).assume_init() == 0 {
                        c.fetch_add(1, Ordering::Relaxed);
                    }
                });
                ready.store(1, Ordering::Relaxed);
                h_a.join().unwrap();
                h_b.join().unwrap();
                let c = c.load(Ordering::Relaxed);
                assert!(c == 0 || c == 1, "c={},n={}", c, n);
            }
        })
        .unwrap();
    }};
}
// Catches unwinding panic on architectures with weak memory models.
#[allow(dead_code, clippy::used_underscore_binding)]
pub(crate) fn catch_unwind_on_weak_memory_arch(pat: &str, f: impl Fn()) {
    // With x86 TSO, RISC-V TSO (optional, not default), SPARC TSO (optional, default),
    // and IBM-370 memory models should never be a panic here.
    if cfg!(any(
        target_arch = "x86",
        target_arch = "x86_64",
        target_arch = "s390x",
        target_arch = "sparc",
        target_arch = "sparc64",
    )) {
        f();
    } else if !is_panic_abort() {
        // This could be is_err on architectures with weak memory models.
        // However, this does not necessarily mean that it will always be panic,
        // and implementing it with stronger orderings is also okay.
        match std::panic::catch_unwind(std::panic::AssertUnwindSafe(f)) {
            Ok(()) => {
                // panic!();
            }
            Err(msg) => {
                let msg = msg
                    .downcast_ref::<std::string::String>()
                    .cloned()
                    .unwrap_or_else(|| msg.downcast_ref::<&'static str>().copied().unwrap().into());
                assert!(msg.contains(pat), "{}", msg);
            }
        }
    }
}
// Catches unwinding panic on architectures with non-sequentially consistent memory models.
#[allow(dead_code, clippy::used_underscore_binding)]
pub(crate) fn catch_unwind_on_non_seqcst_arch(pat: &str, f: impl Fn()) {
    if !is_panic_abort() {
        // This could be Err on architectures with non-sequentially consistent memory models.
        // However, this does not necessarily mean that it will always be panic,
        // and implementing it with stronger orderings is also okay.
        match std::panic::catch_unwind(std::panic::AssertUnwindSafe(f)) {
            Ok(()) => {
                // panic!();
            }
            Err(msg) => {
                let msg = msg
                    .downcast_ref::<std::string::String>()
                    .cloned()
                    .unwrap_or_else(|| msg.downcast_ref::<&'static str>().copied().unwrap().into());
                assert!(msg.contains(pat), "{}", msg);
            }
        }
    }
}
macro_rules! stress_test_load_store {
    ($int_type:ident) => {
        // debug mode is slow.
        #[cfg(not(debug_assertions))]
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_acquire_release_load_store_ $int_type>] {
                use crate::tests::helper::catch_unwind_on_weak_memory_arch as can_panic;
                __stress_test_acquire_release!(can_panic, $int_type, store, Relaxed, Relaxed);
                __stress_test_acquire_release!(can_panic, $int_type, store, Relaxed, Release);
                __stress_test_acquire_release!(can_panic, $int_type, store, Relaxed, SeqCst);
                __stress_test_acquire_release!(can_panic, $int_type, store, Acquire, Relaxed);
                __stress_test_acquire_release!(should_pass, $int_type, store, Acquire, Release);
                __stress_test_acquire_release!(should_pass, $int_type, store, Acquire, SeqCst);
                __stress_test_acquire_release!(can_panic, $int_type, store, SeqCst, Relaxed);
                __stress_test_acquire_release!(should_pass, $int_type, store, SeqCst, Release);
                __stress_test_acquire_release!(should_pass, $int_type, store, SeqCst, SeqCst);
            }
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_seqcst_load_store_ $int_type>] {
                use crate::tests::helper::catch_unwind_on_non_seqcst_arch as can_panic;
                __stress_test_seqcst!(can_panic, $int_type, store, Relaxed, Relaxed);
                __stress_test_seqcst!(can_panic, $int_type, store, Relaxed, Release);
                __stress_test_seqcst!(can_panic, $int_type, store, Relaxed, SeqCst);
                __stress_test_seqcst!(can_panic, $int_type, store, Acquire, Relaxed);
                __stress_test_seqcst!(can_panic, $int_type, store, Acquire, Release);
                __stress_test_seqcst!(can_panic, $int_type, store, Acquire, SeqCst);
                __stress_test_seqcst!(can_panic, $int_type, store, SeqCst, Relaxed);
                __stress_test_seqcst!(can_panic, $int_type, store, SeqCst, Release);
                __stress_test_seqcst!(should_pass, $int_type, store, SeqCst, SeqCst);
            }
        }
    };
}
macro_rules! stress_test {
    ($int_type:ident) => {
        stress_test_load_store!($int_type);
        // debug mode is slow.
        #[cfg(not(debug_assertions))]
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_acquire_release_load_swap_ $int_type>] {
                use crate::tests::helper::catch_unwind_on_weak_memory_arch as can_panic;
                __stress_test_acquire_release!(can_panic, $int_type, swap, Relaxed, Relaxed);
                __stress_test_acquire_release!(can_panic, $int_type, swap, Relaxed, Acquire);
                __stress_test_acquire_release!(can_panic, $int_type, swap, Relaxed, Release);
                __stress_test_acquire_release!(can_panic, $int_type, swap, Relaxed, AcqRel);
                __stress_test_acquire_release!(can_panic, $int_type, swap, Relaxed, SeqCst);
                __stress_test_acquire_release!(can_panic, $int_type, swap, Acquire, Relaxed);
                __stress_test_acquire_release!(can_panic, $int_type, swap, Acquire, Acquire);
                __stress_test_acquire_release!(should_pass, $int_type, swap, Acquire, Release);
                __stress_test_acquire_release!(should_pass, $int_type, swap, Acquire, AcqRel);
                __stress_test_acquire_release!(should_pass, $int_type, swap, Acquire, SeqCst);
                __stress_test_acquire_release!(can_panic, $int_type, swap, SeqCst, Relaxed);
                __stress_test_acquire_release!(can_panic, $int_type, swap, SeqCst, Acquire);
                __stress_test_acquire_release!(should_pass, $int_type, swap, SeqCst, Release);
                __stress_test_acquire_release!(should_pass, $int_type, swap, SeqCst, AcqRel);
                __stress_test_acquire_release!(should_pass, $int_type, swap, SeqCst, SeqCst);
            }
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_seqcst_load_swap_ $int_type>] {
                use crate::tests::helper::catch_unwind_on_non_seqcst_arch as can_panic;
                __stress_test_seqcst!(can_panic, $int_type, swap, Relaxed, Relaxed);
                __stress_test_seqcst!(can_panic, $int_type, swap, Relaxed, Acquire);
                __stress_test_seqcst!(can_panic, $int_type, swap, Relaxed, Release);
                __stress_test_seqcst!(can_panic, $int_type, swap, Relaxed, AcqRel);
                __stress_test_seqcst!(can_panic, $int_type, swap, Relaxed, SeqCst);
                __stress_test_seqcst!(can_panic, $int_type, swap, Acquire, Relaxed);
                __stress_test_seqcst!(can_panic, $int_type, swap, Acquire, Acquire);
                __stress_test_seqcst!(can_panic, $int_type, swap, Acquire, Release);
                __stress_test_seqcst!(can_panic, $int_type, swap, Acquire, AcqRel);
                __stress_test_seqcst!(can_panic, $int_type, swap, Acquire, SeqCst);
                __stress_test_seqcst!(can_panic, $int_type, swap, SeqCst, Relaxed);
                __stress_test_seqcst!(can_panic, $int_type, swap, SeqCst, Acquire);
                __stress_test_seqcst!(can_panic, $int_type, swap, SeqCst, Release);
                __stress_test_seqcst!(can_panic, $int_type, swap, SeqCst, AcqRel);
                __stress_test_seqcst!(should_pass, $int_type, swap, SeqCst, SeqCst);
            }
        }
    };
}
