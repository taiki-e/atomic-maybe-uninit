// SPDX-License-Identifier: Apache-2.0 OR MIT

macro_rules! __test_atomic {
    ($ty:ident) => {
        load_store();
        fn load_store() {
            static VAR: AtomicMaybeUninit<$ty> =
                AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(10));
            for (load_order, store_order) in LOAD_ORDERINGS.into_iter().zip(STORE_ORDERINGS) {
                unsafe {
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
        cfg_has_atomic_cas! {
        swap();
        fn swap() {
            for order in SWAP_ORDERINGS {
                unsafe {
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                    assert_eq!(a.swap(MaybeUninit::new($ty::MIN), order).assume_init(), 5);
                    assert_eq!(a.swap(MaybeUninit::new($ty::MAX), order).assume_init(), $ty::MIN);
                    assert_eq!(a.swap(MaybeUninit::new(10), order).assume_init(), $ty::MAX);
                    assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                    let _v = a.swap(MaybeUninit::new(15), order);
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::uninit());
                    let _v = a.swap(MaybeUninit::new(10), order);
                    assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                }
            }
        }
        compare_exchange();
        fn compare_exchange() {
            for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                unsafe {
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
                }
            }
        }
        compare_exchange_weak();
        fn compare_exchange_weak() {
            for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                unsafe {
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
        fetch_update();
        fn fetch_update() {
            for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                unsafe {
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
        }
        memcpy();
        fn memcpy() {
            unsafe {
                // TODO
                if !(cfg!(target_arch = "m68k") && core::mem::size_of::<$ty>() == 8) {
                    let x = PerByteAtomicMaybeUninit::<$ty>::from(0);
                    assert_eq!(x.load(Ordering::Relaxed).assume_init(), 0);
                    x.store(MaybeUninit::new(!0), Ordering::Relaxed);
                    assert_eq!(x.load(Ordering::Relaxed).assume_init(), !0);
                    let x = PerByteAtomicMaybeUninit::<[$ty; 1]>::from([0]);
                    assert_eq!(x.load(Ordering::Relaxed).assume_init(), [0]);
                    x.store(MaybeUninit::new([!0]), Ordering::Relaxed);
                    assert_eq!(x.load(Ordering::Relaxed).assume_init(), [!0]);
                }
                // TODO
                if !cfg!(target_arch = "m68k") {
                    let x = PerByteAtomicMaybeUninit::<[$ty; 2]>::from([0; 2]);
                    assert_eq!(x.load(Ordering::Relaxed).assume_init(), [0; 2]);
                    x.store(MaybeUninit::new([!0; 2]), Ordering::Relaxed);
                    assert_eq!(x.load(Ordering::Relaxed).assume_init(), [!0; 2]);
                    let x = PerByteAtomicMaybeUninit::<[$ty; 200]>::from([0; 200]);
                    assert_eq!(x.load(Ordering::Relaxed).assume_init()[..], [0; 200][..]);
                    x.store(MaybeUninit::new([!0; 200]), Ordering::Relaxed);
                    assert_eq!(x.load(Ordering::Relaxed).assume_init()[..], [!0; 200][..]);
                }
            }
        }
    };
}

const LOAD_ORDERINGS: [Ordering; 3] = [Ordering::Relaxed, Ordering::Acquire, Ordering::SeqCst];
const STORE_ORDERINGS: [Ordering; 3] = [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst];
cfg_has_atomic_cas! {
const SWAP_ORDERINGS: [Ordering; 5] =
    [Ordering::Relaxed, Ordering::Release, Ordering::Acquire, Ordering::AcqRel, Ordering::SeqCst];
const COMPARE_EXCHANGE_ORDERINGS: [(Ordering, Ordering); 15] = [
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
}
