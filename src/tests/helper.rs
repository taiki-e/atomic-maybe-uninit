// SPDX-License-Identifier: Apache-2.0 OR MIT

#![allow(dead_code, unused_macros)]

pub(crate) use std::sync::atomic::Ordering;

use crate::*;

macro_rules! test_common {
    ($ty:ident) => {
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks,
            )]
            mod [<test_common_ $ty>] {
                use std::{
                    boxed::Box,
                    mem::{self, MaybeUninit},
                };

                #[cfg(atomic_maybe_uninit_no_strict_provenance)]
                use crate::utils::ptr::MutPtrExt as _;
                use crate::{tests::helper::*, AtomicMaybeUninit};

                #[test]
                fn assert_auto_traits() {
                    fn _assert<
                        T: Send + Sync + Unpin + std::panic::UnwindSafe + std::panic::RefUnwindSafe,
                    >() {
                    }
                    _assert::<AtomicMaybeUninit<$ty>>();
                }
                #[test]
                fn accessor() {
                    #[cfg(not(atomic_maybe_uninit_no_const_fn_trait_bound))]
                    const INTO_INNER: MaybeUninit<$ty> = {
                        let a = AtomicMaybeUninit::new(MaybeUninit::new(10));
                        a.into_inner()
                    };
                    #[cfg(not(atomic_maybe_uninit_no_const_mut_refs))]
                    const GET_MUT: AtomicMaybeUninit<$ty> = {
                        let mut a = AtomicMaybeUninit::new(MaybeUninit::uninit());
                        let _ = unsafe { AtomicMaybeUninit::from_ptr(a.as_ptr()) };
                        *a.get_mut() = MaybeUninit::new(5);
                        a
                    };
                    #[allow(clippy::ptr_as_ptr)]
                    unsafe {
                        #[cfg(not(atomic_maybe_uninit_no_const_fn_trait_bound))]
                        {
                            assert_eq!(INTO_INNER.assume_init(), 10);
                        }
                        #[cfg(not(atomic_maybe_uninit_no_const_mut_refs))]
                        {
                            assert_eq!(GET_MUT.into_inner().assume_init(), 5);
                        }
                        let mut a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(10));
                        assert_eq!(*a.get_mut().as_mut_ptr(), 10);
                        assert_eq!(a.as_ptr() as *const (), &a as *const _ as *const ());
                        *a.get_mut() = MaybeUninit::new(5);
                        assert_eq!(a.into_inner().assume_init(), 5);

                        let ptr: *mut Align16<MaybeUninit<$ty>>
                            = Box::into_raw(Box::new(Align16(MaybeUninit::new(0))));
                        assert!(ptr.addr() % mem::align_of::<AtomicMaybeUninit<$ty>>() == 0);
                        {
                            let a = AtomicMaybeUninit::<$ty>::from_ptr(
                                ptr.cast::<MaybeUninit<$ty>>()
                            );
                            *a.as_ptr() = MaybeUninit::new(1);
                        }
                        assert_eq!((*ptr).0.assume_init(), 1);
                        drop(Box::from_raw(ptr));
                    }
                }
                #[test]
                fn impls() {
                    unsafe {
                        let a = AtomicMaybeUninit::<$ty>::from(MaybeUninit::new(0));
                        let b = AtomicMaybeUninit::<$ty>::from(0);
                        assert_eq!(
                            std::format!("{a:?}"),
                            concat!("atomic_maybe_uninit::AtomicMaybeUninit<", stringify!($ty), ">"),
                        );
                        assert_eq!(a.into_inner().assume_init(), b.into_inner().assume_init());
                    }
                }
            }
        }
    };
}

macro_rules! test_atomic_load_store {
    ($ty:ident) => {
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks,
            )]
            mod [<test_atomic_ $ty>] {
                __test_atomic!(load_store, $ty);
            }
        }
    };
}
macro_rules! test_atomic_load_store_swap {
    ($ty:ident) => {
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks,
            )]
            mod [<test_atomic_ $ty>] {
                __test_atomic!(load_store, $ty);
                __test_atomic!(swap, $ty);
            }
        }
    };
}
macro_rules! test_atomic {
    ($ty:ident) => {
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks,
            )]
            mod [<test_atomic_ $ty>] {
                __test_atomic!(load_store, $ty);
                __test_atomic!(swap, $ty);
                __test_atomic!(cas, $ty);
            }
        }
    };
}

macro_rules! __test_atomic {
    (load_store, $ty:ident) => {
        use std::{collections::BTreeSet, mem::MaybeUninit, vec, vec::Vec};

        use crossbeam_utils::thread;

        use crate::{AtomicMaybeUninit, tests::helper::*};

        #[test]
        fn load_store() {
            static VAR_RO: Align16<$ty> = Align16(10);
            static VAR: AtomicMaybeUninit<$ty> =
                AtomicMaybeUninit::<$ty>::const_new(MaybeUninit::new(10));
            #[cfg(not(atomic_maybe_uninit_no_const_fn_trait_bound))]
            static _VAR: AtomicMaybeUninit<$ty> = AtomicMaybeUninit::new(MaybeUninit::new(10));
            let var = AtomicMaybeUninit::<$ty>::const_new(MaybeUninit::new(10));
            unsafe {
                assert_eq!(
                    VAR.load(Ordering::Relaxed).assume_init(),
                    var.load(Ordering::Relaxed).assume_init()
                );
                #[allow(clippy::ptr_as_ptr)]
                if core::mem::size_of::<$ty>() <= core::mem::size_of::<usize>()
                    || cfg!(all(
                        any(target_arch = "aarch64", target_arch = "arm64ec"),
                        any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"),
                    ))
                    || cfg!(all(
                        target_arch = "powerpc64",
                        any(
                            target_feature = "quadword-atomics",
                            atomic_maybe_uninit_target_feature = "quadword-atomics",
                        ),
                    ))
                    || cfg!(target_arch = "s390x")
                    || cfg!(target_arch = "hexagon")
                {
                    assert_eq!(
                        (*(&VAR_RO as *const Align16<$ty> as *const AtomicMaybeUninit<$ty>))
                            .load(Ordering::Relaxed)
                            .assume_init(),
                        var.load(Ordering::Relaxed).assume_init()
                    );
                }
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

                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(1));
                    assert_eq!(a.load(load_order).assume_init(), 1);
                    a.store(MaybeUninit::new($ty::MIN), store_order);
                    assert_eq!(a.load(load_order).assume_init(), $ty::MIN);
                    a.store(MaybeUninit::new($ty::MAX), store_order);
                    assert_eq!(a.load(load_order).assume_init(), $ty::MAX);
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::uninit());
                    let _v = a.load(load_order);
                    a.store(MaybeUninit::new(2), store_order);
                    assert_eq!(a.load(load_order).assume_init(), 2);
                    a.store(MaybeUninit::uninit(), store_order);
                    let _v = a.load(load_order);
                }
            }
        }
        ::quickcheck::quickcheck! {
            fn quickcheck_load_store(x: $ty, y: $ty) -> bool {
                let mut rng = fastrand::Rng::new();
                unsafe {
                    for (load_order, store_order) in
                        LOAD_ORDERINGS.into_iter().zip(STORE_ORDERINGS)
                    {
                        for base in [0, !0] {
                            let mut arr = Array::new(base, &mut rng);
                            arr.set(x);
                            let a = arr.get();
                            assert_eq!(a.load(load_order).assume_init(), x);
                            a.store(MaybeUninit::new(y), store_order);
                            assert_eq!(a.load(load_order).assume_init(), y);
                            a.store(MaybeUninit::new(x), store_order);
                            assert_eq!(a.load(load_order).assume_init(), x);
                            if !cfg!(all(valgrind, target_arch = "aarch64")) {
                                a.store(MaybeUninit::uninit(), store_order);
                                let _v = a.load(load_order);
                            }
                            arr.assert();
                        }
                    }
                }
                true
            }
        }
        #[test]
        fn stress_load_store() {
            unsafe {
                let mut rng = fastrand::Rng::new();
                let (iterations, threads) = stress_test_config(&mut rng);
                let data1 = (0..iterations).map(|_| rng.$ty(..)).collect::<Vec<_>>();
                let set = data1.iter().copied().collect::<BTreeSet<_>>();
                let a = AtomicMaybeUninit::<$ty>::from(data1[rng.usize(0..iterations)]);
                let now = &std::time::Instant::now();
                thread::scope(|s| {
                    for _ in 0..threads {
                        s.spawn(|_| {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            for i in 0..iterations {
                                a.store(MaybeUninit::new(data1[i]), rand_store_ordering(&mut rng));
                            }
                            std::eprintln!("store end={:?}", now.elapsed());
                        });
                        s.spawn(|_| {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            let mut v = vec![0; iterations];
                            for i in 0..iterations {
                                v[i] = a.load(rand_load_ordering(&mut rng)).assume_init();
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
    (swap, $ty:ident) => {
        #[test]
        fn swap() {
            unsafe {
                let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                test_swap_ordering(|order| a.swap(MaybeUninit::new(5), order));
                for order in SWAP_ORDERINGS {
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                    assert_eq!(a.swap(MaybeUninit::new($ty::MIN), order).assume_init(), 5);
                    assert_eq!(a.swap(MaybeUninit::new($ty::MAX), order).assume_init(), $ty::MIN);
                    assert_eq!(a.swap(MaybeUninit::new(10), order).assume_init(), $ty::MAX);
                    if !cfg!(all(valgrind, target_arch = "aarch64")) {
                        assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                        let _v = a.swap(MaybeUninit::new(15), order);
                        let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::uninit());
                        let _v = a.swap(MaybeUninit::new(10), order);
                        assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                    }
                }
            }
        }
        ::quickcheck::quickcheck! {
            fn quickcheck_swap(x: $ty, y: $ty) -> bool {
                let mut rng = fastrand::Rng::new();
                unsafe {
                    for order in SWAP_ORDERINGS {
                        for base in [0, !0] {
                            let mut arr = Array::new(base, &mut rng);
                            arr.set(x);
                            let a = arr.get();
                            assert_eq!(a.swap(MaybeUninit::new(y), order).assume_init(), x);
                            assert_eq!(a.swap(MaybeUninit::new(x), order).assume_init(), y);
                            if !cfg!(all(valgrind, target_arch = "aarch64")) {
                                assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), x);
                            }
                            arr.assert();
                        }
                    }
                }
                true
            }
        }
        #[test]
        fn stress_swap() {
            unsafe {
                let mut rng = fastrand::Rng::new();
                let (iterations, threads) = stress_test_config(&mut rng);
                let data1 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| rng.$ty(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let data2 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| rng.$ty(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let set = &data1
                    .iter()
                    .flat_map(|v| v.iter().copied())
                    .chain(data2.iter().flat_map(|v| v.iter().copied()))
                    .collect::<BTreeSet<_>>();
                let a = &AtomicMaybeUninit::<$ty>::from(data2[0][rng.usize(0..iterations)]);
                let now = &std::time::Instant::now();
                thread::scope(|s| {
                    for thread in 0..threads {
                        if thread % 2 == 0 {
                            s.spawn(move |_| {
                                let mut rng = fastrand::Rng::new();
                                let now = *now;
                                for i in 0..iterations {
                                    a.store(
                                        MaybeUninit::new(data1[thread][i]),
                                        rand_store_ordering(&mut rng),
                                    );
                                }
                                std::eprintln!("store end={:?}", now.elapsed());
                            });
                        } else {
                            s.spawn(|_| {
                                let mut rng = fastrand::Rng::new();
                                let now = *now;
                                let mut v = vec![0; iterations];
                                for i in 0..iterations {
                                    v[i] = a.load(rand_load_ordering(&mut rng)).assume_init();
                                }
                                std::eprintln!("load end={:?}", now.elapsed());
                                for v in v {
                                    assert!(set.contains(&v), "v={}", v);
                                }
                            });
                        }
                        s.spawn(move |_| {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            let mut v = vec![0; iterations];
                            for i in 0..iterations {
                                v[i] = a
                                    .swap(
                                        MaybeUninit::new(data2[thread][i]),
                                        rand_swap_ordering(&mut rng),
                                    )
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
    (cas, $ty:ident) => {
        #[test]
        fn compare_exchange() {
            unsafe {
                let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                test_compare_exchange_ordering(|success, failure| {
                    a.compare_exchange(MaybeUninit::new(5), MaybeUninit::new(5), success, failure)
                });
                for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                    for (x, y) in [(5, 10), ($ty::MAX, $ty::MIN), ($ty::MIN, $ty::MAX)] {
                        let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(x));
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
                                MaybeUninit::new(6),
                                MaybeUninit::new(12),
                                success,
                                failure
                            )
                            .unwrap_err()
                            .assume_init(),
                            y
                        );
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), y);
                    }

                    if !cfg!(valgrind) {
                        let mut u = MaybeUninit::uninit();
                        let a = AtomicMaybeUninit::<$ty>::new(u);
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
                let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                test_compare_exchange_ordering(|success, failure| {
                    a.compare_exchange_weak(
                        MaybeUninit::new(5),
                        MaybeUninit::new(5),
                        success,
                        failure,
                    )
                });
                for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                    for x in [4, $ty::MAX, $ty::MIN] {
                        let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(x));
                        assert_eq!(
                            a.compare_exchange_weak(
                                MaybeUninit::new(6),
                                MaybeUninit::new(8),
                                success,
                                failure
                            )
                            .unwrap_err()
                            .assume_init(),
                            x
                        );
                        let mut old = a.load(Ordering::Relaxed);
                        loop {
                            let new = MaybeUninit::new(old.assume_init().wrapping_add(2));
                            match a.compare_exchange_weak(old, new, success, failure) {
                                Ok(_) => break,
                                Err(x) => old = x,
                            }
                        }
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), x.wrapping_add(2));
                    }
                }
            }
        }
        #[test]
        fn fetch_update() {
            unsafe {
                let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(7));
                test_compare_exchange_ordering(|set, fetch| {
                    a.fetch_update(set, fetch, |x| Some(x))
                });
                for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(7));
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
        ::quickcheck::quickcheck! {
            fn quickcheck_compare_exchange(x: $ty, y: $ty) -> bool {
                let mut rng = fastrand::Rng::new();
                unsafe {
                    let z = loop {
                        let z = rng.$ty(..);
                        if z != y {
                            break z;
                        }
                    };
                    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                        for base in [0, !0] {
                            let mut arr = Array::new(base, &mut rng);
                            arr.set(x);
                            let a = arr.get();
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
                            if !cfg!(all(valgrind, target_arch = "aarch64")) {
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
                            arr.assert();
                        }
                    }
                }
                true
            }
            fn quickcheck_fetch_update(x: $ty, y: $ty) -> bool {
                let mut rng = fastrand::Rng::new();
                unsafe {
                    let z = loop {
                        let z = rng.$ty(..);
                        if z != y {
                            break z;
                        }
                    };
                    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                        for base in [0, !0] {
                            let mut arr = Array::new(base, &mut rng);
                            arr.set(x);
                            let a = arr.get();
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
                            arr.assert();
                        }
                    }
                }
                true
            }
        }
        #[test]
        fn stress_compare_exchange() {
            unsafe {
                let mut rng = fastrand::Rng::new();
                let (iterations, threads) = stress_test_config(&mut rng);
                let data1 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| rng.$ty(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let data2 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| rng.$ty(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let set = &data1
                    .iter()
                    .flat_map(|v| v.iter().copied())
                    .chain(data2.iter().flat_map(|v| v.iter().copied()))
                    .collect::<BTreeSet<_>>();
                let a = &AtomicMaybeUninit::<$ty>::from(data2[0][rng.usize(0..iterations)]);
                let now = &std::time::Instant::now();
                thread::scope(|s| {
                    for thread in 0..threads {
                        if thread % 2 == 0 {
                            s.spawn(move |_| {
                                let mut rng = fastrand::Rng::new();
                                let now = *now;
                                for i in 0..iterations {
                                    a.store(
                                        MaybeUninit::new(data1[thread][i]),
                                        rand_store_ordering(&mut rng),
                                    );
                                }
                                std::eprintln!("store end={:?}", now.elapsed());
                            });
                        } else {
                            s.spawn(|_| {
                                let mut rng = fastrand::Rng::new();
                                let now = *now;
                                let mut v = vec![0; iterations];
                                for i in 0..iterations {
                                    v[i] = a.load(rand_load_ordering(&mut rng)).assume_init();
                                }
                                std::eprintln!("load end={:?}", now.elapsed());
                                for v in v {
                                    assert!(set.contains(&v), "v={}", v);
                                }
                            });
                        }
                        s.spawn(move |_| {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            let mut v = vec![data2[0][0]; iterations];
                            for i in 0..iterations {
                                let old = if i % 2 == 0 {
                                    MaybeUninit::new(rng.$ty(..))
                                } else {
                                    a.load(Ordering::Relaxed)
                                };
                                let new = MaybeUninit::new(data2[thread][i]);
                                let o = rand_compare_exchange_ordering(&mut rng);
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
        #[test]
        fn stress_fetch_update() {
            unsafe {
                let mut rng = fastrand::Rng::new();
                let (iterations, threads) = stress_test_config(&mut rng);
                let data1 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| rng.$ty(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let data2 = &(0..threads)
                    .map(|_| (0..iterations).map(|_| rng.$ty(..)).collect::<Vec<_>>())
                    .collect::<Vec<_>>();
                let set = &data1
                    .iter()
                    .flat_map(|v| v.iter().copied())
                    .chain(data2.iter().flat_map(|v| v.iter().copied()))
                    .collect::<BTreeSet<_>>();
                let a = &AtomicMaybeUninit::<$ty>::from(data2[0][rng.usize(0..iterations)]);
                let now = &std::time::Instant::now();
                thread::scope(|s| {
                    for thread in 0..threads {
                        if thread % 2 == 0 {
                            s.spawn(move |_| {
                                let mut rng = fastrand::Rng::new();
                                let now = *now;
                                for i in 0..iterations {
                                    a.store(
                                        MaybeUninit::new(data1[thread][i]),
                                        rand_store_ordering(&mut rng),
                                    );
                                }
                                std::eprintln!("store end={:?}", now.elapsed());
                            });
                        } else {
                            s.spawn(|_| {
                                let mut rng = fastrand::Rng::new();
                                let now = *now;
                                let mut v = vec![0; iterations];
                                for i in 0..iterations {
                                    v[i] = a.load(rand_load_ordering(&mut rng)).assume_init();
                                }
                                std::eprintln!("load end={:?}", now.elapsed());
                                for v in v {
                                    assert!(set.contains(&v), "v={}", v);
                                }
                            });
                        }
                        s.spawn(move |_| {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            let mut v = vec![0; iterations];
                            for i in 0..iterations {
                                v[i] = a
                                    .fetch_update(
                                        rand_swap_ordering(&mut rng),
                                        rand_load_ordering(&mut rng),
                                        |_| Some(MaybeUninit::new(data2[thread][i])),
                                    )
                                    .unwrap()
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
}

#[allow(unused_unsafe)] // for old rustc
#[track_caller]
fn assert_panic<T: std::fmt::Debug>(f: impl FnOnce() -> T) -> std::string::String {
    let backtrace = std::env::var_os("RUST_BACKTRACE");
    let hook = std::panic::take_hook();
    // set_var/remove_var is fine as we run tests with RUST_TEST_THREADS=1
    // std::panic::set_backtrace_style is better way here, but is unstable.
    unsafe { std::env::set_var("RUST_BACKTRACE", "0") } // Suppress backtrace
    std::panic::set_hook(std::boxed::Box::new(|_| {})); // Suppress panic msg
    let res = std::panic::catch_unwind(std::panic::AssertUnwindSafe(f));
    std::panic::set_hook(hook);
    match backtrace {
        Some(v) => unsafe { std::env::set_var("RUST_BACKTRACE", v) },
        None => unsafe { std::env::remove_var("RUST_BACKTRACE") },
    }
    let msg = res.unwrap_err();
    msg.downcast_ref::<std::string::String>()
        .cloned()
        .unwrap_or_else(|| msg.downcast_ref::<&'static str>().copied().unwrap().into())
}
pub(crate) const LOAD_ORDERINGS: [Ordering; 3] =
    [Ordering::Relaxed, Ordering::Acquire, Ordering::SeqCst];
pub(crate) fn rand_load_ordering(rng: &mut fastrand::Rng) -> Ordering {
    LOAD_ORDERINGS[rng.usize(0..LOAD_ORDERINGS.len())]
}
#[track_caller]
pub(crate) fn test_load_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in LOAD_ORDERINGS {
        f(order);
    }

    if !skip_should_panic_test() {
        assert_eq!(
            assert_panic(|| f(Ordering::Release)),
            "there is no such thing as a release load"
        );
        assert_eq!(
            assert_panic(|| f(Ordering::AcqRel)),
            "there is no such thing as an acquire-release load"
        );
    }
}
pub(crate) const STORE_ORDERINGS: [Ordering; 3] =
    [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst];
pub(crate) fn rand_store_ordering(rng: &mut fastrand::Rng) -> Ordering {
    STORE_ORDERINGS[rng.usize(0..STORE_ORDERINGS.len())]
}
#[track_caller]
pub(crate) fn test_store_ordering<T: std::fmt::Debug>(f: impl Fn(Ordering) -> T) {
    for order in STORE_ORDERINGS {
        f(order);
    }

    if !skip_should_panic_test() {
        assert_eq!(
            assert_panic(|| f(Ordering::Acquire)),
            "there is no such thing as an acquire store"
        );
        assert_eq!(
            assert_panic(|| f(Ordering::AcqRel)),
            "there is no such thing as an acquire-release store"
        );
    }
}
pub(crate) const SWAP_ORDERINGS: [Ordering; 5] =
    [Ordering::Relaxed, Ordering::Release, Ordering::Acquire, Ordering::AcqRel, Ordering::SeqCst];
pub(crate) fn rand_swap_ordering(rng: &mut fastrand::Rng) -> Ordering {
    SWAP_ORDERINGS[rng.usize(0..SWAP_ORDERINGS.len())]
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
pub(crate) fn rand_compare_exchange_ordering(rng: &mut fastrand::Rng) -> (Ordering, Ordering) {
    COMPARE_EXCHANGE_ORDERINGS[rng.usize(0..COMPARE_EXCHANGE_ORDERINGS.len())]
}
pub(crate) fn test_compare_exchange_ordering<T: std::fmt::Debug>(
    f: impl Fn(Ordering, Ordering) -> T,
) {
    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
        f(success, failure);
    }

    if !skip_should_panic_test() {
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
}
// for stress test generated by __test_atomic macro
pub(crate) fn stress_test_config(rng: &mut fastrand::Rng) -> (usize, usize) {
    let iterations = if cfg!(debug_assertions) { 5_000 } else { 25_000 };
    let threads = if cfg!(debug_assertions) { 2 } else { rng.usize(2..=8) };
    std::eprintln!("threads={threads}");
    (iterations, threads)
}

fn skip_should_panic_test() -> bool {
    is_panic_abort()
}

// For -C panic=abort -Z panic_abort_tests: https://github.com/rust-lang/rust/issues/67650
fn is_panic_abort() -> bool {
    build_context::PANIC.contains("abort")
}

#[repr(C, align(16))]
pub(crate) struct Align16<T>(pub(crate) T);

pub(crate) struct Array<T: Primitive> {
    arr: Align16<[AtomicMaybeUninit<T>; 10]>,
    base: T,
    idx: usize,
}
impl<T: raw::AtomicLoad + PartialEq + core::fmt::Debug> Array<T> {
    pub(crate) fn new(base: T, rng: &mut fastrand::Rng) -> Self {
        Self {
            arr: Align16([
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
                AtomicMaybeUninit::<T>::new(MaybeUninit::new(base)),
            ]),
            base,
            // 0 1 2 3 4 5 6 7 8 9
            //       ^ ^ ^ ^
            idx: rng.usize(3..=6),
        }
    }
    pub(crate) fn get(&self) -> &AtomicMaybeUninit<T> {
        &self.arr.0[self.idx]
    }
    pub(crate) fn set(&mut self, new: T) {
        self.arr.0[self.idx] = AtomicMaybeUninit::<T>::new(MaybeUninit::new(new));
    }
    #[track_caller]
    pub(crate) unsafe fn assert(&self) {
        for i in (0..self.idx).chain(self.idx + 1..self.arr.0.len()) {
            assert_eq!(
                unsafe { self.arr.0[i].load(Ordering::Relaxed).assume_init() },
                self.base,
                "value at index {i} has changed, but must not change other than value at index {}",
                self.idx,
            );
        }
    }
}

// Test the cases that should not fail if the memory ordering is implemented correctly.
// This is still not exhaustive and only tests a few cases.
// This currently only supports 32-bit or more integers.
macro_rules! __stress_test_acquire_release {
    (should_pass, $ty:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            #[test]
            #[cfg_attr(debug_assertions, ignore = "slow in some environments")] // debug mode is slow.
            #[allow(clippy::cast_possible_truncation)]
            fn [<load_ $load_order:lower _ $write _ $store_order:lower>]() {
                __stress_test_acquire_release!(
                    $ty, $write, $load_order, $store_order);
            }
        }
    };
    (can_panic, $ty:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            #[test]
            // Currently, to make this test work well enough outside of Miri, tens of thousands
            // of iterations are needed, but this test is slow in some environments.
            // So, ignore by default. See also catch_unwind_on_weak_memory_arch.
            #[ignore = "slow in some environments"]
            #[allow(clippy::cast_possible_truncation)]
            fn [<load_ $load_order:lower _ $write _ $store_order:lower>]() {
                can_panic("a=", || __stress_test_acquire_release!(
                    $ty, $write, $load_order, $store_order));
            }
        }
    };
    ($ty:ident, $write:ident, $load_order:ident, $store_order:ident) => {{
        use std::{
            mem::MaybeUninit,
            sync::atomic::{AtomicUsize, Ordering},
        };

        use crossbeam_utils::thread;

        use crate::AtomicMaybeUninit;

        let mut n: usize = 50_000;
        // This test is relatively fast because it spawns only one thread, but
        // the iterations are limited to a maximum value of integers.
        if $ty::try_from(n).is_err() {
            n = $ty::MAX as usize;
        }
        let a = &AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(0));
        let b = &AtomicUsize::new(0);
        thread::scope(|s| unsafe {
            s.spawn(|_| {
                for i in 0..n {
                    b.store(i, Ordering::Relaxed);
                    a.$write(MaybeUninit::new(i as $ty), Ordering::$store_order);
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
    (should_pass, $ty:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            #[test]
            // Currently, to make this test work well enough outside of Miri, tens of thousands
            // of iterations are needed, but this test is very slow in some environments because
            // it creates two threads for each iteration.
            // So, ignore on QEMU by default.
            #[cfg_attr(any(debug_assertions, qemu), ignore = "slow in some environments")] // debug mode is slow.
            fn [<load_ $load_order:lower _ $write _ $store_order:lower>]() {
                __stress_test_seqcst!(
                    $ty, $write, $load_order, $store_order);
            }
        }
    };
    (can_panic, $ty:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            #[test]
            // Currently, to make this test work well enough outside of Miri, tens of thousands
            // of iterations are needed, but this test is very slow in some environments because
            // it creates two threads for each iteration.
            // So, ignore by default. See also catch_unwind_on_non_seqcst_arch.
            #[ignore = "slow in some environments"]
            fn [<load_ $load_order:lower _ $write _ $store_order:lower>]() {
                can_panic("c=2", || __stress_test_seqcst!(
                    $ty, $write, $load_order, $store_order));
            }
        }
    };
    ($ty:ident, $write:ident, $load_order:ident, $store_order:ident) => {{
        use std::{
            mem::MaybeUninit,
            sync::atomic::{AtomicUsize, Ordering},
        };

        use crossbeam_utils::thread;

        use crate::AtomicMaybeUninit;

        const N: usize = if cfg!(valgrind) { 50 } else { 50_000 };
        let a = &AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(0));
        let b = &AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(0));
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
#[allow(dead_code)]
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
#[allow(dead_code)]
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
    ($ty:ident) => {
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_acquire_release_load_store_ $ty>] {
                use crate::tests::helper::catch_unwind_on_weak_memory_arch as can_panic;
                __stress_test_acquire_release!(can_panic, $ty, store, Relaxed, Relaxed);
                __stress_test_acquire_release!(can_panic, $ty, store, Relaxed, Release);
                __stress_test_acquire_release!(can_panic, $ty, store, Relaxed, SeqCst);
                __stress_test_acquire_release!(can_panic, $ty, store, Acquire, Relaxed);
                __stress_test_acquire_release!(should_pass, $ty, store, Acquire, Release);
                __stress_test_acquire_release!(should_pass, $ty, store, Acquire, SeqCst);
                __stress_test_acquire_release!(can_panic, $ty, store, SeqCst, Relaxed);
                __stress_test_acquire_release!(should_pass, $ty, store, SeqCst, Release);
                __stress_test_acquire_release!(should_pass, $ty, store, SeqCst, SeqCst);
            }
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_seqcst_load_store_ $ty>] {
                use crate::tests::helper::catch_unwind_on_non_seqcst_arch as can_panic;
                __stress_test_seqcst!(can_panic, $ty, store, Relaxed, Relaxed);
                __stress_test_seqcst!(can_panic, $ty, store, Relaxed, Release);
                __stress_test_seqcst!(can_panic, $ty, store, Relaxed, SeqCst);
                __stress_test_seqcst!(can_panic, $ty, store, Acquire, Relaxed);
                __stress_test_seqcst!(can_panic, $ty, store, Acquire, Release);
                __stress_test_seqcst!(can_panic, $ty, store, Acquire, SeqCst);
                __stress_test_seqcst!(can_panic, $ty, store, SeqCst, Relaxed);
                __stress_test_seqcst!(can_panic, $ty, store, SeqCst, Release);
                __stress_test_seqcst!(should_pass, $ty, store, SeqCst, SeqCst);
            }
        }
    };
}
macro_rules! stress_test {
    ($ty:ident) => {
        stress_test_load_store!($ty);
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_acquire_release_load_swap_ $ty>] {
                use crate::tests::helper::catch_unwind_on_weak_memory_arch as can_panic;
                __stress_test_acquire_release!(can_panic, $ty, swap, Relaxed, Relaxed);
                __stress_test_acquire_release!(can_panic, $ty, swap, Relaxed, Acquire);
                __stress_test_acquire_release!(can_panic, $ty, swap, Relaxed, Release);
                __stress_test_acquire_release!(can_panic, $ty, swap, Relaxed, AcqRel);
                __stress_test_acquire_release!(can_panic, $ty, swap, Relaxed, SeqCst);
                __stress_test_acquire_release!(can_panic, $ty, swap, Acquire, Relaxed);
                __stress_test_acquire_release!(can_panic, $ty, swap, Acquire, Acquire);
                __stress_test_acquire_release!(should_pass, $ty, swap, Acquire, Release);
                __stress_test_acquire_release!(should_pass, $ty, swap, Acquire, AcqRel);
                __stress_test_acquire_release!(should_pass, $ty, swap, Acquire, SeqCst);
                __stress_test_acquire_release!(can_panic, $ty, swap, SeqCst, Relaxed);
                __stress_test_acquire_release!(can_panic, $ty, swap, SeqCst, Acquire);
                __stress_test_acquire_release!(should_pass, $ty, swap, SeqCst, Release);
                __stress_test_acquire_release!(should_pass, $ty, swap, SeqCst, AcqRel);
                __stress_test_acquire_release!(should_pass, $ty, swap, SeqCst, SeqCst);
            }
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_seqcst_load_swap_ $ty>] {
                use crate::tests::helper::catch_unwind_on_non_seqcst_arch as can_panic;
                __stress_test_seqcst!(can_panic, $ty, swap, Relaxed, Relaxed);
                __stress_test_seqcst!(can_panic, $ty, swap, Relaxed, Acquire);
                __stress_test_seqcst!(can_panic, $ty, swap, Relaxed, Release);
                __stress_test_seqcst!(can_panic, $ty, swap, Relaxed, AcqRel);
                __stress_test_seqcst!(can_panic, $ty, swap, Relaxed, SeqCst);
                __stress_test_seqcst!(can_panic, $ty, swap, Acquire, Relaxed);
                __stress_test_seqcst!(can_panic, $ty, swap, Acquire, Acquire);
                __stress_test_seqcst!(can_panic, $ty, swap, Acquire, Release);
                __stress_test_seqcst!(can_panic, $ty, swap, Acquire, AcqRel);
                __stress_test_seqcst!(can_panic, $ty, swap, Acquire, SeqCst);
                __stress_test_seqcst!(can_panic, $ty, swap, SeqCst, Relaxed);
                __stress_test_seqcst!(can_panic, $ty, swap, SeqCst, Acquire);
                __stress_test_seqcst!(can_panic, $ty, swap, SeqCst, Release);
                __stress_test_seqcst!(can_panic, $ty, swap, SeqCst, AcqRel);
                __stress_test_seqcst!(should_pass, $ty, swap, SeqCst, SeqCst);
            }
        }
    };
}
