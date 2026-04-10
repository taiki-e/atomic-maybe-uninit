// SPDX-License-Identifier: Apache-2.0 OR MIT

#![allow(dead_code, unused_macros)]

pub(crate) use std::sync::atomic::Ordering;
use std::{
    boxed::Box,
    eprintln,
    sync::atomic::{AtomicIsize, AtomicUsize},
    thread,
};

#[cfg(valgrind)]
use crabgrind::memcheck;

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
                        assert_eq!(INTO_INNER.assume_init(), 10);
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
                #[cfg(not(any(
                    all(target_arch = "csky", atomic_maybe_uninit_no_ldex_stex),
                    all(target_arch = "mips64", atomic_maybe_uninit_no_ll_sc),
                )))]
                __test_atomic!(swap, $ty);
                #[cfg(not(any(
                    all(target_arch = "csky", atomic_maybe_uninit_no_ldex_stex),
                    all(target_arch = "mips64", atomic_maybe_uninit_no_ll_sc),
                    all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg),
                )))]
                __test_atomic!(cas, $ty);
            }
        }
    };
}

macro_rules! __test_atomic {
    (load_store, $ty:ident) => {
        use std::{
            collections::BTreeSet,
            eprintln,
            mem::{self, MaybeUninit},
            thread,
            time::Instant,
            vec,
            vec::Vec,
        };

        use crate::{AtomicMaybeUninit, tests::helper::*, utils::RegSize};

        #[test]
        fn load_store() {
            static VAR_RO: Align16<$ty> = Align16(10);
            static VAR: AtomicMaybeUninit<$ty> = AtomicMaybeUninit::new(MaybeUninit::new(10));
            #[allow(deprecated)]
            static _VAR: AtomicMaybeUninit<$ty> =
                AtomicMaybeUninit::<$ty>::const_new(MaybeUninit::new(10));
            let var = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(10));
            unsafe {
                assert_eq!(
                    VAR.load(Ordering::Relaxed).assume_init(),
                    var.load(Ordering::Relaxed).assume_init()
                );
                #[allow(clippy::ptr_as_ptr)]
                if mem::size_of::<$ty>() <= mem::size_of::<RegSize>()
                    || cfg!(all(
                        any(target_arch = "aarch64", target_arch = "arm64ec"),
                        any(target_feature = "lse2", atomic_maybe_uninit_target_feature = "lse2"),
                    ))
                    || cfg!(target_arch = "powerpc64")
                    || cfg!(target_arch = "s390x")
                    || cfg!(all(
                        target_arch = "x86",
                        any(
                            all(
                                target_feature = "sse",
                                not(atomic_maybe_uninit_test_prefer_x87_over_sse),
                            ),
                            all(
                                any(
                                    target_feature = "x87",
                                    atomic_maybe_uninit_target_feature = "x87"
                                ),
                                not(atomic_maybe_uninit_test_prefer_cmpxchg8b_over_x87),
                            ),
                        ),
                    ))
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
            test_load_ordering(&|order| { VAR.load(order); });
            test_store_ordering(&|order| VAR.store(MaybeUninit::new(10), order));
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
                    let v = MaybeUninit::uninit();
                    #[cfg(valgrind)]
                    if IMP_ARM_LINUX && mem::size_of::<$ty>() == 8 {
                        mark_defined(&v);
                    }
                    let a = AtomicMaybeUninit::<$ty>::new(v);
                    let _v = a.load(load_order);
                    a.store(MaybeUninit::new(2), store_order);
                    assert_eq!(a.load(load_order).assume_init(), 2);
                    let v = MaybeUninit::uninit();
                    #[cfg(valgrind)]
                    if IMP_ARM_LINUX && mem::size_of::<$ty>() == 8 {
                        mark_defined(&v);
                    }
                    a.store(v, store_order);
                    let _v = a.load(load_order);
                }
            }
        }
        ::quickcheck::quickcheck! {
            fn quickcheck_load_store(x: $ty, y: $ty) -> bool {
                let mut rng = fastrand::Rng::new();
                for base in [0, !0] {
                    let mut arr = Array::new(base, &mut rng);
                    for (load_order, store_order) in
                        LOAD_ORDERINGS.into_iter().zip(STORE_ORDERINGS)
                    {
                        unsafe {
                            arr.set(x);
                            let a = arr.get();
                            assert_eq!(a.load(load_order).assume_init(), x);
                            a.store(MaybeUninit::new(y), store_order);
                            assert_eq!(a.load(load_order).assume_init(), y);
                            a.store(MaybeUninit::new(x), store_order);
                            assert_eq!(a.load(load_order).assume_init(), x);
                            let v = MaybeUninit::uninit();
                            #[cfg(valgrind)]
                            if IMP_ARM_LINUX && mem::size_of::<$ty>() == 8 {
                                mark_defined(&v);
                            }
                            a.store(v, store_order);
                            let _v = a.load(load_order);
                            arr.assert();
                        }
                    }
                }
                true
            }
        }
        #[test]
        // TODO(csky): hang or glibc/pthread assertion fail. likely due to broken libatomic: https://github.com/rust-lang/rust/issues/117306
        #[cfg_attr(target_arch = "csky", ignore = "upstream bug")]
        fn stress_load_store() {
            let mut rng = fastrand::Rng::new();
            let (iterations, threads) = stress_test_config(&mut rng);
            let data1 = (0..iterations).map(|_| rng.$ty(..)).collect::<Vec<_>>();
            let set = data1.iter().copied().collect::<BTreeSet<_>>();
            let a = AtomicMaybeUninit::<$ty>::from(data1[rng.usize(0..iterations)]);
            let now = &Instant::now();
            thread::scope(|s| {
                for _ in 0..threads {
                    s.spawn(|| {
                        let mut rng = fastrand::Rng::new();
                        let now = *now;
                        for i in 0..iterations {
                            a.store(MaybeUninit::new(data1[i]), rand_store_ordering(&mut rng));
                        }
                        eprintln!("store end={:?}", now.elapsed());
                    });
                    s.spawn(|| {
                        let mut rng = fastrand::Rng::new();
                        let now = *now;
                        let mut v = vec![0; iterations];
                        for i in 0..iterations {
                            unsafe {
                                v[i] = a.load(rand_load_ordering(&mut rng)).assume_init();
                            }
                        }
                        eprintln!("load end={:?}", now.elapsed());
                        for v in v {
                            assert!(set.contains(&v), "load unexpected={}", v);
                        }
                    });
                }
            });
        }
    };
    (swap, $ty:ident) => {
        #[test]
        fn swap() {
            // TODO(riscv): wrong result (as of Valgrind 3.26)
            #[cfg(valgrind)]
            if cfg!(target_arch = "arm") && mem::size_of::<$ty>() == 8 && !IMP_ARM_LINUX
                || cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2
            {
                return;
            }
            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
            #[cfg(valgrind)]
            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                mark_aligned_defined(&a);
            }
            test_swap_ordering(&|order| { a.swap(MaybeUninit::new(5), order); });
            for order in SWAP_ORDERINGS {
                unsafe {
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                    #[cfg(valgrind)]
                    if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                        mark_aligned_defined(&a);
                    }
                    assert_eq!(a.swap(MaybeUninit::new($ty::MIN), order).assume_init(), 5);
                    assert_eq!(a.swap(MaybeUninit::new($ty::MAX), order).assume_init(), $ty::MIN);
                    assert_eq!(a.swap(MaybeUninit::new(10), order).assume_init(), $ty::MAX);
                    let v = MaybeUninit::uninit();
                    #[cfg(valgrind)]
                    if cfg!(target_arch = "aarch64")
                        && (cfg!(not(target_feature = "lse"))
                            || cfg!(not(target_feature = "lse128")) && mem::size_of::<$ty>() == 16)
                        || cfg!(target_arch = "arm")
                        || cfg!(target_arch = "s390x") && mem::size_of::<$ty>() == 16
                    {
                        mark_defined(&v);
                    }
                    assert_eq!(a.swap(v, order).assume_init(), 10);
                    let _v = a.swap(MaybeUninit::new(15), order);
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::uninit());
                    #[cfg(valgrind)]
                    if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                        mark_aligned_defined(&a);
                    }
                    #[cfg(valgrind)]
                    if cfg!(target_arch = "arm") && IMP_ARM_LINUX
                        || cfg!(target_arch = "s390x") && mem::size_of::<$ty>() == 16
                    {
                        mark_defined(&a);
                    }
                    let _v = a.swap(MaybeUninit::new(10), order);
                    let v = MaybeUninit::uninit();
                    #[cfg(valgrind)]
                    if cfg!(target_arch = "aarch64")
                        && (cfg!(not(target_feature = "lse"))
                            || cfg!(not(target_feature = "lse128")) && mem::size_of::<$ty>() == 16)
                        || cfg!(target_arch = "arm")
                        || cfg!(target_arch = "s390x") && mem::size_of::<$ty>() == 16
                    {
                        mark_defined(&v);
                    }
                    assert_eq!(a.swap(v, order).assume_init(), 10);
                }
            }
        }
        ::quickcheck::quickcheck! {
            fn quickcheck_swap(x: $ty, y: $ty) -> bool {
                // TODO(riscv): wrong result (as of Valgrind 3.26)
                #[cfg(valgrind)]
                if cfg!(target_arch = "arm") && mem::size_of::<$ty>() == 8 && !IMP_ARM_LINUX
                    || cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2
                {
                    return true;
                }
                let mut rng = fastrand::Rng::new();
                for base in [0, !0] {
                    let mut arr = Array::new(base, &mut rng);
                    for order in SWAP_ORDERINGS {
                        unsafe {
                            arr.set(x);
                            let a = arr.get();
                            assert_eq!(a.swap(MaybeUninit::new(y), order).assume_init(), x);
                            assert_eq!(a.swap(MaybeUninit::new(x), order).assume_init(), y);
                            let v = MaybeUninit::uninit();
                            #[cfg(valgrind)]
                            if cfg!(target_arch = "aarch64")
                                && (cfg!(not(target_feature = "lse"))
                                    || cfg!(not(target_feature = "lse128")) && mem::size_of::<$ty>() == 16)
                                || cfg!(target_arch = "arm")
                                || cfg!(target_arch = "s390x") && mem::size_of::<$ty>() == 16
                            {
                                mark_defined(&v);
                            }
                            assert_eq!(a.swap(v, order).assume_init(), x);
                            arr.assert();
                        }
                    }
                }
                true
            }
        }
        #[test]
        // TODO(csky): hang or glibc/pthread assertion fail. likely due to broken libatomic: https://github.com/rust-lang/rust/issues/117306
        #[cfg_attr(target_arch = "csky", ignore = "upstream bug")]
        fn stress_swap() {
            // TODO(riscv): wrong result (as of Valgrind 3.26)
            #[cfg(valgrind)]
            if cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2 {
                return;
            }
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
            #[cfg(valgrind)]
            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                mark_aligned_defined(a);
            }
            let now = &Instant::now();
            thread::scope(|s| {
                for thread in 0..threads {
                    if thread % 2 == 0 {
                        s.spawn(move || {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            for i in 0..iterations {
                                a.store(
                                    MaybeUninit::new(data1[thread][i]),
                                    rand_store_ordering(&mut rng),
                                );
                            }
                            eprintln!("store end={:?}", now.elapsed());
                        });
                    } else {
                        s.spawn(|| {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            let mut v = vec![0; iterations];
                            for i in 0..iterations {
                                unsafe {
                                    v[i] = a.load(rand_load_ordering(&mut rng)).assume_init();
                                }
                            }
                            eprintln!("load end={:?}", now.elapsed());
                            for v in v {
                                assert!(set.contains(&v), "load unexpected={}", v);
                            }
                        });
                    }
                    s.spawn(move || {
                        let mut rng = fastrand::Rng::new();
                        let now = *now;
                        let mut v = vec![0; iterations];
                        for i in 0..iterations {
                            unsafe {
                                v[i] = a
                                    .swap(
                                        MaybeUninit::new(data2[thread][i]),
                                        rand_swap_ordering(&mut rng),
                                    )
                                    .assume_init();
                            }
                        }
                        eprintln!("swap end={:?}", now.elapsed());
                        for v in v {
                            assert!(set.contains(&v), "swap unexpected={}", v);
                        }
                    });
                }
            });
        }
    };
    (cas, $ty:ident) => {
        #[test]
        fn compare_exchange() {
            // TODO(riscv): wrong result (as of Valgrind 3.26)
            #[cfg(valgrind)]
            if cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2 {
                return;
            }
            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
            #[cfg(valgrind)]
            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                mark_aligned_defined(&a);
            }
            test_compare_exchange_ordering(&|success, failure| {
                let _ = a.compare_exchange(
                    MaybeUninit::new(5),
                    MaybeUninit::new(5),
                    success,
                    failure,
                );
            });
            for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                unsafe {
                    for (x, y) in [(5, 10), ($ty::MAX, $ty::MIN), ($ty::MIN, $ty::MAX)] {
                        let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(x));
                        #[cfg(valgrind)]
                        if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                            mark_aligned_defined(&a);
                        }
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

                    for base in [0, !0] {
                        for bit in 0..$ty::BITS {
                            let flipped = base ^ (1 << bit);
                            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(base));
                            #[cfg(valgrind)]
                            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                                mark_aligned_defined(&a);
                            }
                            assert_eq!(
                                a.compare_exchange(
                                    MaybeUninit::new(flipped),
                                    MaybeUninit::new(flipped),
                                    success,
                                    failure
                                )
                                .unwrap_err()
                                .assume_init(),
                                base,
                                "flipped bit: {bit}"
                            );
                            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(flipped));
                            #[cfg(valgrind)]
                            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                                mark_aligned_defined(&a);
                            }
                            assert_eq!(
                                a.compare_exchange(
                                    MaybeUninit::new(base),
                                    MaybeUninit::new(base),
                                    success,
                                    failure
                                )
                                .unwrap_err()
                                .assume_init(),
                                flipped,
                                "flipped bit: {bit}"
                            );
                        }
                    }

                    let mut u = MaybeUninit::uninit();
                    #[cfg(valgrind)]
                    mark_defined(&u);
                    let a = AtomicMaybeUninit::<$ty>::new(u);
                    #[cfg(valgrind)]
                    if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                        mark_aligned_defined(&a);
                    }
                    while let Err(e) = a.compare_exchange(u, MaybeUninit::new(10), success, failure)
                    {
                        u = e;
                    }
                    assert_eq!(a.load(Ordering::Relaxed).assume_init(), 10);
                    let v = MaybeUninit::uninit();
                    #[cfg(valgrind)]
                    if cfg!(target_arch = "arm") && mem::size_of::<$ty>() == 8
                        || cfg!(target_arch = "aarch64") && cfg!(not(target_feature = "lse"))
                    {
                        mark_defined(&v);
                    }
                    assert_eq!(
                        a.compare_exchange(MaybeUninit::new(10), v, success, failure)
                            .unwrap()
                            .assume_init(),
                        10
                    );
                    let _v = a.load(Ordering::Relaxed);
                }
            }
        }
        #[test]
        fn compare_exchange_weak() {
            // TODO(riscv): wrong result (as of Valgrind 3.26)
            #[cfg(valgrind)]
            if cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2 {
                return;
            }
            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
            #[cfg(valgrind)]
            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                mark_aligned_defined(&a);
            }
            test_compare_exchange_ordering(&|success, failure| {
                let _ = a.compare_exchange_weak(
                    MaybeUninit::new(5),
                    MaybeUninit::new(5),
                    success,
                    failure,
                );
            });
            for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                unsafe {
                    for x in [4, $ty::MAX, $ty::MIN] {
                        let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(x));
                        #[cfg(valgrind)]
                        if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                            mark_aligned_defined(&a);
                        }
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

                    for base in [0, !0] {
                        for bit in 0..$ty::BITS {
                            let flipped = base ^ (1 << bit);
                            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(base));
                            #[cfg(valgrind)]
                            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                                mark_aligned_defined(&a);
                            }
                            assert_eq!(
                                a.compare_exchange_weak(
                                    MaybeUninit::new(flipped),
                                    MaybeUninit::new(flipped),
                                    success,
                                    failure
                                )
                                .unwrap_err()
                                .assume_init(),
                                base,
                                "flipped bit: {bit}"
                            );
                            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(flipped));
                            #[cfg(valgrind)]
                            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                                mark_aligned_defined(&a);
                            }
                            assert_eq!(
                                a.compare_exchange_weak(
                                    MaybeUninit::new(base),
                                    MaybeUninit::new(base),
                                    success,
                                    failure
                                )
                                .unwrap_err()
                                .assume_init(),
                                flipped,
                                "flipped bit: {bit}"
                            );
                        }
                    }
                }
            }
        }
        #[test]
        fn fetch_update() {
            // TODO(riscv): wrong result (as of Valgrind 3.26)
            #[cfg(valgrind)]
            if cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2 {
                return;
            }
            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(7));
            #[cfg(valgrind)]
            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                mark_aligned_defined(&a);
            }
            test_compare_exchange_ordering(&|set, fetch| {
                let _ = a.fetch_update(set, fetch, |x| Some(x));
            });
            for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                unsafe {
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(7));
                    #[cfg(valgrind)]
                    if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                        mark_aligned_defined(&a);
                    }
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
                // TODO(riscv): wrong result (as of Valgrind 3.26)
                #[cfg(valgrind)]
                if cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2 {
                    return true;
                }
                let mut rng = fastrand::Rng::new();
                let z = loop {
                    let z = rng.$ty(..);
                    if z != y {
                        break z;
                    }
                };
                for base in [0, !0] {
                    let mut arr = Array::new(base, &mut rng);
                    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                        unsafe {
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
                            let v = MaybeUninit::uninit();
                            #[cfg(valgrind)]
                            if cfg!(target_arch = "arm") && mem::size_of::<$ty>() == 8
                                || cfg!(target_arch = "aarch64") && cfg!(not(target_feature = "lse"))
                            {
                                mark_defined(&v);
                            }
                            assert_eq!(
                                a.compare_exchange(
                                    MaybeUninit::new(y),
                                    v,
                                    success,
                                    failure
                                )
                                .unwrap()
                                .assume_init(),
                                y
                            );
                            let _v = a.load(Ordering::Relaxed);
                            arr.assert();
                        }
                    }
                }
                true
            }
            fn quickcheck_fetch_update(x: $ty, y: $ty) -> bool {
                // TODO(riscv): wrong result (as of Valgrind 3.26)
                #[cfg(valgrind)]
                if cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2 {
                    return true;
                }
                let mut rng = fastrand::Rng::new();
                let z = loop {
                    let z = rng.$ty(..);
                    if z != y {
                        break z;
                    }
                };
                for base in [0, !0] {
                    let mut arr = Array::new(base, &mut rng);
                    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                        unsafe {
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
        // TODO(csky): hang or glibc/pthread assertion fail. likely due to broken libatomic: https://github.com/rust-lang/rust/issues/117306
        #[cfg_attr(target_arch = "csky", ignore = "upstream bug")]
        fn stress_compare_exchange() {
            // TODO(riscv): wrong result (as of Valgrind 3.26)
            #[cfg(valgrind)]
            if cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2 {
                return;
            }
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
            #[cfg(valgrind)]
            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                mark_aligned_defined(a);
            }
            let now = &Instant::now();
            thread::scope(|s| {
                for thread in 0..threads {
                    if thread % 2 == 0 {
                        s.spawn(move || {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            for i in 0..iterations {
                                a.store(
                                    MaybeUninit::new(data1[thread][i]),
                                    rand_store_ordering(&mut rng),
                                );
                            }
                            eprintln!("store end={:?}", now.elapsed());
                        });
                    } else {
                        s.spawn(|| {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            let mut v = vec![0; iterations];
                            for i in 0..iterations {
                                unsafe {
                                    v[i] = a.load(rand_load_ordering(&mut rng)).assume_init();
                                }
                            }
                            eprintln!("load end={:?}", now.elapsed());
                            for v in v {
                                assert!(set.contains(&v), "load unexpected={}", v);
                            }
                        });
                    }
                    s.spawn(move || {
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
                            unsafe {
                                match a.compare_exchange(old, new, o.0, o.1) {
                                    Ok(r) => assert_eq!(old.assume_init(), r.assume_init()),
                                    Err(r) => v[i] = r.assume_init(),
                                }
                            }
                        }
                        eprintln!("compare_exchange end={:?}", now.elapsed());
                        for v in v {
                            assert!(set.contains(&v), "cas unexpected={}", v);
                        }
                    });
                }
            });
        }
        #[test]
        // TODO(csky): hang or glibc/pthread assertion fail. likely due to broken libatomic: https://github.com/rust-lang/rust/issues/117306
        #[cfg_attr(target_arch = "csky", ignore = "upstream bug")]
        fn stress_fetch_update() {
            // TODO(riscv): wrong result (as of Valgrind 3.26)
            #[cfg(valgrind)]
            if cfg!(target_arch = "riscv64") && mem::size_of::<$ty>() <= 2 {
                return;
            }
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
            #[cfg(valgrind)]
            if IMP_EMU_SUB_WORD_CAS && mem::size_of::<$ty>() <= 2 {
                mark_aligned_defined(a);
            }
            let now = &Instant::now();
            thread::scope(|s| {
                for thread in 0..threads {
                    if thread % 2 == 0 {
                        s.spawn(move || {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            for i in 0..iterations {
                                a.store(
                                    MaybeUninit::new(data1[thread][i]),
                                    rand_store_ordering(&mut rng),
                                );
                            }
                            eprintln!("store end={:?}", now.elapsed());
                        });
                    } else {
                        s.spawn(|| {
                            let mut rng = fastrand::Rng::new();
                            let now = *now;
                            let mut v = vec![0; iterations];
                            for i in 0..iterations {
                                unsafe {
                                    v[i] = a.load(rand_load_ordering(&mut rng)).assume_init();
                                }
                            }
                            eprintln!("load end={:?}", now.elapsed());
                            for v in v {
                                assert!(set.contains(&v), "load unexpected={}", v);
                            }
                        });
                    }
                    s.spawn(move || {
                        let mut rng = fastrand::Rng::new();
                        let now = *now;
                        let mut v = vec![0; iterations];
                        for i in 0..iterations {
                            unsafe {
                                v[i] = a
                                    .fetch_update(
                                        rand_swap_ordering(&mut rng),
                                        rand_load_ordering(&mut rng),
                                        |_| Some(MaybeUninit::new(data2[thread][i])),
                                    )
                                    .unwrap()
                                    .assume_init();
                            }
                        }
                        eprintln!("fetch_update end={:?}", now.elapsed());
                        for v in v {
                            assert!(set.contains(&v), "fetch_update unexpected={}", v);
                        }
                    });
                }
            });
        }
    };
}

#[allow(unused_unsafe)] // for old rustc
fn assert_panic(f: &dyn Fn()) -> std::string::String {
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
pub(crate) fn test_load_ordering(f: &dyn Fn(Ordering)) {
    for order in LOAD_ORDERINGS {
        f(order);
    }
    if !skip_should_panic_test() {
        assert_eq!(
            assert_panic(&|| f(Ordering::Release)),
            "there is no such thing as a release load"
        );
        assert_eq!(
            assert_panic(&|| f(Ordering::AcqRel)),
            "there is no such thing as an acquire-release load"
        );
    }
}
pub(crate) const STORE_ORDERINGS: [Ordering; 3] =
    [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst];
pub(crate) fn rand_store_ordering(rng: &mut fastrand::Rng) -> Ordering {
    STORE_ORDERINGS[rng.usize(0..STORE_ORDERINGS.len())]
}
pub(crate) fn test_store_ordering(f: &dyn Fn(Ordering)) {
    for order in STORE_ORDERINGS {
        f(order);
    }
    if !skip_should_panic_test() {
        assert_eq!(
            assert_panic(&|| f(Ordering::Acquire)),
            "there is no such thing as an acquire store"
        );
        assert_eq!(
            assert_panic(&|| f(Ordering::AcqRel)),
            "there is no such thing as an acquire-release store"
        );
    }
}
pub(crate) const SWAP_ORDERINGS: [Ordering; 5] =
    [Ordering::Relaxed, Ordering::Release, Ordering::Acquire, Ordering::AcqRel, Ordering::SeqCst];
pub(crate) fn rand_swap_ordering(rng: &mut fastrand::Rng) -> Ordering {
    SWAP_ORDERINGS[rng.usize(0..SWAP_ORDERINGS.len())]
}
pub(crate) fn test_swap_ordering(f: &dyn Fn(Ordering)) {
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
pub(crate) fn test_compare_exchange_ordering(f: &dyn Fn(Ordering, Ordering)) {
    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
        f(success, failure);
    }
    if !skip_should_panic_test() {
        for order in SWAP_ORDERINGS {
            let msg = assert_panic(&|| f(order, Ordering::AcqRel));
            assert!(
                msg == "there is no such thing as an acquire-release failure ordering"
                    || msg == "there is no such thing as an acquire-release load",
                "{}",
                msg
            );
            let msg = assert_panic(&|| f(order, Ordering::Release));
            assert!(
                msg == "there is no such thing as a release failure ordering"
                    || msg == "there is no such thing as a release load",
                "{}",
                msg
            );
        }
    }
}

// Used in stress tests to find atomicity bug generated by __test_atomic macro.
pub(crate) fn stress_test_config(rng: &mut fastrand::Rng) -> (usize, usize) {
    let iterations = if cfg!(any(debug_assertions, qemu, valgrind)) { 5_000 } else { 25_000 };
    let threads = if cfg!(debug_assertions) { 2 } else { rng.usize(2..=8) };
    eprintln!("threads={threads}");
    (iterations, threads)
}

// true if the current implementation is arch/arm_linux.rs.
pub(crate) const IMP_ARM_LINUX: bool = cfg!(all(
    target_arch = "arm",
    any(target_os = "linux", target_os = "android"),
    any(
        not(any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6")),
        atomic_maybe_uninit_test_prefer_kuser_cmpxchg,
    ),
    not(any(
        target_feature = "v8",
        atomic_maybe_uninit_target_feature = "v8",
        target_feature = "v8m",
        atomic_maybe_uninit_target_feature = "v8m",
    )),
));
// true if the current implementation implements sub-word atomics using word-size CAS.
#[cfg(valgrind)]
pub(crate) const IMP_EMU_SUB_WORD_CAS: bool = cfg!(target_arch = "s390x") || IMP_ARM_LINUX;

#[cfg(valgrind)]
#[inline(always)]
pub(crate) fn mark_no_access<T: ?Sized>(a: &T) {
    memcheck::mark_memory(
        a as *const T as *mut core::ffi::c_void,
        size_of_val(a),
        memcheck::MemState::NoAccess,
    )
    .unwrap();
}
#[cfg(valgrind)]
#[inline(always)]
pub(crate) fn mark_defined<T: ?Sized>(a: &T) {
    memcheck::mark_memory(
        a as *const T as *mut core::ffi::c_void,
        size_of_val(a),
        memcheck::MemState::Defined,
    )
    .unwrap();
}
#[cfg(valgrind)]
#[inline(always)]
pub(crate) fn mark_aligned_defined<T: ?Sized>(a: &T) {
    assert!(size_of_val(a) <= 2);
    memcheck::mark_memory(
        (a as *const T as *mut core::ffi::c_void).map_addr(|a| a & !3),
        4,
        memcheck::MemState::Defined,
    )
    .unwrap();
}
#[cfg(valgrind)]
#[inline(always)]
pub(crate) fn mark_aligned_undefined<T: ?Sized>(a: &T) {
    assert!(size_of_val(a) <= 2);
    memcheck::mark_memory(
        (a as *const T as *mut core::ffi::c_void).map_addr(|a| a & !3),
        4,
        memcheck::MemState::Undefined,
    )
    .unwrap();
}

fn skip_should_panic_test() -> bool {
    // Valgrind false positive on s390x
    is_panic_abort() || cfg!(all(valgrind, target_arch = "s390x"))
}

// For -C panic=abort -Z panic_abort_tests: https://github.com/rust-lang/rust/issues/67650
fn is_panic_abort() -> bool {
    !cfg!(panic = "unwind")
}

#[repr(C, align(16))]
pub(crate) struct Align16<T>(pub(crate) T);

pub(crate) struct Array<T: Primitive> {
    arr: Box<Align16<[AtomicMaybeUninit<T>; 10]>>,
    base: T,
    idx: usize,
}
impl<T: raw::AtomicLoad + PartialEq + core::fmt::Debug> Array<T> {
    pub(crate) fn new(base: T, rng: &mut fastrand::Rng) -> Self {
        Self {
            arr: Box::new(Align16([
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
            ])),
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
        #[cfg(valgrind)]
        {
            mark_no_access(&self.arr.0);
            if size_of::<T>() <= 2 {
                if IMP_ARM_LINUX || cfg!(target_arch = "s390x") {
                    mark_aligned_defined(&self.arr.0[self.idx]);
                } else if cfg!(all(
                    target_arch = "powerpc64",
                    not(any(
                        target_feature = "partword-atomics",
                        atomic_maybe_uninit_target_feature = "partword-atomics",
                    )),
                )) {
                    mark_aligned_undefined(&self.arr.0[self.idx]);
                }
            }
            mark_defined(&self.arr.0[self.idx]);
        }
    }
    #[track_caller]
    pub(crate) unsafe fn assert(&self) {
        #[cfg(valgrind)]
        mark_defined(&self.arr.0);
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

// Stress tests to find memory ordering bug.
// Note that this is not exhaustive and only tests a few cases.
macro_rules! __stress_acquire_release {
    (should_pass, $ty:ident, $read:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            #[test]
            #[cfg_attr(debug_assertions, ignore = "slow in some environments")] // debug mode is slow.
            #[allow(
                clippy::cast_possible_wrap,
                clippy::cast_sign_loss,
                clippy::cast_possible_truncation,
            )]
            fn [<acquire_release1 _ $read _ $load_order:lower _ $write _ $store_order:lower>]() {
                __call_stress_test_fn!(
                    acquire_release1, $ty, $read, $write, $load_order, $store_order);
            }
        }
    };
    (can_panic, $ty:ident, $read:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        // Currently, to make this test work well enough outside of Miri, tens of thousands
        // of iterations are needed, but this test is slow in some environments.
        // So, ignore by default. See also catch_unwind_on_weak_memory_arch.
        // paste::paste! {
        //     #[test]
        //     #[ignore = "slow in some environments"]
        //     #[allow(
        //         clippy::cast_possible_wrap,
        //         clippy::cast_sign_loss,
        //         clippy::cast_possible_truncation,
        //     )]
        //     fn [<acquire_release1 _ $read _ $load_order:lower _ $write _ $store_order:lower>]() {
        //         use crate::tests::helper::catch_unwind_on_weak_memory_arch as can_panic;
        //         can_panic("a=", test_helper::function_name!(), || __call_stress_test_fn!(
        //             acquire_release1, $ty, $read, $write, $load_order, $store_order));
        //     }
        // }
    };
}
macro_rules! __stress_seqcst {
    (should_pass, $ty:ident, $read:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        paste::paste! {
            #[test]
            #[cfg_attr(debug_assertions, ignore = "slow in some environments")] // debug mode is slow.
            #[allow(
                clippy::cast_possible_wrap,
                clippy::cast_sign_loss,
                clippy::cast_possible_truncation,
            )]
            fn [<seqcst1 _ $read _ $load_order:lower _ $write _ $store_order:lower>]() {
                if cfg!(all(
                    qemu,
                    any(target_arch = "aarch64", target_arch = "arm", target_arch = "arm64ec"),
                )) {
                    return; // TODO(arm,aarch64): QEMU bug as of QEMU 10.2
                }
                __call_stress_test_fn!(
                    seqcst1, $ty, $read, $write, $load_order, $store_order);
            }
        }
    };
    (can_panic, $ty:ident, $read:ident, $write:ident, $load_order:ident, $store_order:ident) => {
        // Currently, to make this test work well enough outside of Miri, tens of thousands
        // of iterations are needed, but this test is slow in some environments.
        // So, ignore by default. See also catch_unwind_on_non_seqcst_arch.
        // paste::paste! {
        //     #[test]
        //     #[ignore = "slow in some environments"]
        //     #[allow(
        //         clippy::cast_possible_wrap,
        //         clippy::cast_sign_loss,
        //         clippy::cast_possible_truncation,
        //     )]
        //     fn [<seqcst1 _ $read _ $load_order:lower _ $write _ $store_order:lower>]() {
        //         if cfg!(all(
        //             qemu,
        //             any(target_arch = "aarch64", target_arch = "arm", target_arch = "arm64ec"),
        //         )) {
        //             return; // TODO(arm,aarch64): QEMU bug as of QEMU 10.2
        //         }
        //         use crate::tests::helper::catch_unwind_on_non_seqcst_arch as can_panic;
        //         can_panic("c=2", test_helper::function_name!(), || __call_stress_test_fn!(
        //             seqcst1, $ty, $read, $write, $load_order, $store_order));
        //     }
        // }
    };
}
// To test this working correctly:
// - Uncomment can_panic case in __stress_seqcst,
//   and run test with `--release -- acquire_release1 --ignored`.
//   At least on AArch64 machine, some "panicked as expected" will be shown.
pub(crate) fn acquire_release1<T: Send + Sync>(
    min: isize,
    max: isize,
    new: impl Fn(isize) -> T,
    load: impl Fn(&T) -> isize + Send + Sync,
    store: impl Fn(&T, isize) + Send + Sync,
    #[allow(unused_variables)] do_rmw: bool,
) {
    let n: usize = if cfg!(any(qemu, valgrind)) { 5_000 } else { 50_000 };

    // TODO(riscv): wrong result (as of Valgrind 3.26)
    #[cfg(valgrind)]
    if cfg!(target_arch = "riscv64") && max <= u16::MAX as isize && do_rmw {
        return;
    }
    let mut start: isize = 0;
    #[allow(clippy::cast_possible_wrap)]
    let mut end: isize = n as isize;
    // This test is relatively fast because it spawns only one thread, but
    // the iterations are limited to a maximum value of integers.
    if max < end {
        start = min;
        end = max;
    }
    assert!((start..end).len() <= n, "{}", (start..end).len());
    let a = &new(start);
    #[cfg(valgrind)]
    if IMP_EMU_SUB_WORD_CAS && max <= u16::MAX as isize && do_rmw {
        mark_aligned_defined(a);
    }
    let b = &AtomicIsize::new(start);
    let a_ready = &AtomicUsize::new(0);
    let b_ready = &AtomicUsize::new(0);
    thread::scope(|s| {
        s.spawn(|| {
            while a_ready.load(Ordering::Relaxed) == 0 {}
            b_ready.store(1, Ordering::Relaxed);
            for i in start..end {
                b.store(i, Ordering::Relaxed);
                store(a, i);
            }
        });
        let end = end - 1;
        a_ready.store(1, Ordering::Relaxed);
        while b_ready.load(Ordering::Relaxed) == 0 {}
        loop {
            let a = load(a);
            let b = b.load(Ordering::Relaxed);
            assert!(a <= b, "a={a},b={b}");
            if a == end && b == end {
                break;
            }
        }
    });
}
// To test this working correctly:
// - Uncomment can_panic case in __stress_seqcst,
//   and run test with `--release -- seqcst1 --ignored`.
//   At least on AArch64 machine, some "panicked as expected" will be shown.
// - Change aarch64.rs's 128-bit seqcst load from `ldar; ldp; dmb ishld` to `ldp; dmb ish`
//   and run test with `--release -- seqcst1` on AArch64 macOS or other AArch64 which supports FEAT_LSE2
//   with `RUSTFLAGS=-C target-feature=+lse2`.
//   tests::stress_swap_u128::seqcst1_load_seqcst_swap_seqcst should fail within a few repetitions.
pub(crate) fn seqcst1<T: Send + Sync>(
    _min: isize,
    #[allow(unused_variables)] max: isize,
    new: impl Fn(isize) -> T,
    load: impl Fn(&T) -> isize + Send + Sync,
    store: impl Fn(&T, isize) + Send + Sync,
    #[allow(unused_variables)] do_rmw: bool,
) {
    let n: usize = if cfg!(valgrind) {
        50
    } else if cfg!(qemu) {
        5_000
    } else {
        50_000
    };

    // TODO(riscv): wrong result (as of Valgrind 3.26)
    #[cfg(valgrind)]
    if cfg!(target_arch = "riscv64") && max <= u16::MAX as isize && do_rmw {
        return;
    }
    let a = &new(0);
    #[cfg(valgrind)]
    if IMP_EMU_SUB_WORD_CAS && max <= u16::MAX as isize && do_rmw {
        mark_aligned_defined(a);
    }
    let b = &new(0);
    #[cfg(valgrind)]
    if IMP_EMU_SUB_WORD_CAS && max <= u16::MAX as isize && do_rmw {
        mark_aligned_defined(b);
    }
    let c = &AtomicUsize::new(0);
    let a_done = &AtomicUsize::new(0);
    let a_ready = &AtomicUsize::new(0);
    let b_ready = &AtomicUsize::new(0);
    let panicked = &AtomicUsize::new(0);
    thread::scope(|s| {
        s.spawn(|| {
            for n in 1..n {
                // Acquire to make initialization of a/b/c visible.
                while a_ready.load(Ordering::Acquire) != n {
                    if panicked.load(Ordering::Relaxed) != 0 {
                        return;
                    }
                }
                b_ready.store(n, Ordering::Relaxed);
                store(a, 1);
                if load(b) == 0 {
                    c.fetch_add(1, Ordering::Relaxed);
                }
                // Release to make update of c visible.
                a_done.store(n, Ordering::Release);
            }
        });
        for n in 1..n {
            store(a, 0);
            store(b, 0);
            c.store(0, Ordering::Relaxed);
            // Release to make initialization of a/b/c visible.
            a_ready.store(n, Ordering::Release);
            while b_ready.load(Ordering::Relaxed) != n {}
            store(b, 1);
            if load(a) == 0 {
                c.fetch_add(1, Ordering::Relaxed);
            }
            // Acquire to make update of c visible.
            while a_done.load(Ordering::Acquire) != n {}
            let c = c.load(Ordering::Relaxed);
            let ok = matches!(c, 0 | 1);
            if !ok {
                panicked.store(1, Ordering::Relaxed);
                panic!("c={c},n={n}");
            }
        }
    });
}
// Catches unwinding panic on architectures with weak memory models.
pub(crate) fn catch_unwind_on_weak_memory_arch(pat: &str, function_name: &str, f: impl Fn()) {
    // With x86 TSO, RISC-V TSO (optional), SPARC TSO (optional, default?),
    // and IBM-370 memory models should never be a panic here.
    if cfg!(any(
        target_arch = "x86",
        target_arch = "x86_64",
        target_arch = "s390x",
        target_arch = "sparc",
        target_arch = "sparc64",
        all(any(target_arch = "riscv32", target_arch = "riscv64"), target_feature = "ztso"),
    )) {
        f();
    } else if !is_panic_abort() {
        // This could be Err on architectures with weak memory models.
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
                test_helper::eprintln_nocapture!("  {function_name} panicked as expected");
            }
        }
    }
}
// Catches unwinding panic on architectures with non-sequentially consistent memory models.
pub(crate) fn catch_unwind_on_non_seqcst_arch(pat: &str, function_name: &str, f: impl Fn()) {
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
                test_helper::eprintln_nocapture!("  {function_name} panicked as expected");
            }
        }
    }
}
macro_rules! __call_stress_test_fn {
    ($name:ident, $ty:ident, load, cas, $load_order:ident, $store_order:ident) => {
        $name(
            $ty::MIN.try_into().unwrap_or(isize::MIN),
            $ty::MAX.try_into().unwrap_or(isize::MAX),
            |v| AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(v as $ty)),
            |a| unsafe { a.load(Ordering::$load_order).assume_init() as isize },
            |a, v| {
                a.fetch_update(Ordering::$store_order, Ordering::Relaxed, |_| {
                    Some(MaybeUninit::new(v as $ty))
                })
                .unwrap();
            },
            true, // do_rmw
        )
    };
    ($name:ident, $ty:ident, load, $write:ident, $load_order:ident, $store_order:ident) => {
        $name(
            $ty::MIN.try_into().unwrap_or(isize::MIN),
            $ty::MAX.try_into().unwrap_or(isize::MAX),
            |v| AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(v as $ty)),
            |a| unsafe { a.load(Ordering::$load_order).assume_init() as isize },
            |a, v| {
                a.$write(MaybeUninit::new(v as $ty), Ordering::$store_order);
            },
            stringify!($write) == "swap", // do_rmw
        )
    };
    ($name:ident, $ty:ident, cas, $write:ident, $load_order:ident, $store_order:ident) => {
        $name(
            $ty::MIN.try_into().unwrap_or(isize::MIN),
            $ty::MAX.try_into().unwrap_or(isize::MAX),
            |v| AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(v as $ty)),
            |a| unsafe {
                a.compare_exchange(
                    MaybeUninit::new(0),
                    MaybeUninit::new(0),
                    Ordering::$load_order,
                    match Ordering::$load_order {
                        Ordering::Release => Ordering::Relaxed,
                        Ordering::AcqRel => Ordering::Acquire,
                        _ => Ordering::$load_order,
                    },
                )
                .unwrap_or_else(|x| x)
                .assume_init() as isize
            },
            |a, v| {
                a.$write(MaybeUninit::new(v as $ty), Ordering::$store_order);
            },
            true, // do_rmw
        )
    };
    ($name:ident, $ty:ident, cas_weak, $write:ident, $load_order:ident, $store_order:ident) => {
        $name(
            $ty::MIN.try_into().unwrap_or(isize::MIN),
            $ty::MAX.try_into().unwrap_or(isize::MAX),
            |v| AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(v as $ty)),
            |a| unsafe {
                a.compare_exchange_weak(
                    MaybeUninit::new(0),
                    MaybeUninit::new(0),
                    Ordering::$load_order,
                    match Ordering::$load_order {
                        Ordering::Release => Ordering::Relaxed,
                        Ordering::AcqRel => Ordering::Acquire,
                        _ => Ordering::$load_order,
                    },
                )
                .unwrap_or_else(|x| x)
                .assume_init() as isize
            },
            |a, v| {
                a.$write(MaybeUninit::new(v as $ty), Ordering::$store_order);
            },
            true, // do_rmw
        )
    };
}
#[rustfmt::skip]
macro_rules! stress_test {
    ($ty:ident) => {
        #[cfg(not(target_arch = "csky"))] // TODO(csky): hang or glibc/pthread assertion fail. likely due to broken libatomic: https://github.com/rust-lang/rust/issues/117306
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_load_store_ $ty>] {
                use std::{mem::MaybeUninit, sync::atomic::Ordering};

                use crate::{AtomicMaybeUninit, tests::helper::*};

                __stress_acquire_release!(can_panic, $ty, load, store, Relaxed, Relaxed);
                __stress_acquire_release!(can_panic, $ty, load, store, Relaxed, Release);
                __stress_acquire_release!(can_panic, $ty, load, store, Relaxed, SeqCst);
                __stress_acquire_release!(can_panic, $ty, load, store, Acquire, Relaxed);
                __stress_acquire_release!(should_pass, $ty, load, store, Acquire, Release);
                __stress_acquire_release!(should_pass, $ty, load, store, Acquire, SeqCst);
                __stress_acquire_release!(can_panic, $ty, load, store, SeqCst, Relaxed);
                __stress_acquire_release!(should_pass, $ty, load, store, SeqCst, Release);
                __stress_acquire_release!(should_pass, $ty, load, store, SeqCst, SeqCst);

                __stress_seqcst!(can_panic, $ty, load, store, Relaxed, Relaxed);
                __stress_seqcst!(can_panic, $ty, load, store, Relaxed, Release);
                __stress_seqcst!(can_panic, $ty, load, store, Relaxed, SeqCst);
                __stress_seqcst!(can_panic, $ty, load, store, Acquire, Relaxed);
                __stress_seqcst!(can_panic, $ty, load, store, Acquire, Release);
                __stress_seqcst!(can_panic, $ty, load, store, Acquire, SeqCst);
                __stress_seqcst!(can_panic, $ty, load, store, SeqCst, Relaxed);
                __stress_seqcst!(can_panic, $ty, load, store, SeqCst, Release);
                __stress_seqcst!(should_pass, $ty, load, store, SeqCst, SeqCst);
            }
        }
        #[cfg(not(target_arch = "csky"))] // TODO(csky): hang or glibc/pthread assertion fail. likely due to broken libatomic: https://github.com/rust-lang/rust/issues/117306
        #[cfg(not(any(
            all(target_arch = "csky", atomic_maybe_uninit_no_ldex_stex),
            all(target_arch = "mips64", atomic_maybe_uninit_no_ll_sc),
        )))]
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_swap_ $ty>] {
                use std::{mem::MaybeUninit, sync::atomic::Ordering};

                use crate::{AtomicMaybeUninit, tests::helper::*};

                __stress_acquire_release!(can_panic, $ty, load, swap, Relaxed, Relaxed);
                __stress_acquire_release!(can_panic, $ty, load, swap, Relaxed, Acquire);
                __stress_acquire_release!(can_panic, $ty, load, swap, Relaxed, Release);
                __stress_acquire_release!(can_panic, $ty, load, swap, Relaxed, AcqRel);
                __stress_acquire_release!(can_panic, $ty, load, swap, Relaxed, SeqCst);
                __stress_acquire_release!(can_panic, $ty, load, swap, Acquire, Relaxed);
                __stress_acquire_release!(can_panic, $ty, load, swap, Acquire, Acquire);
                __stress_acquire_release!(should_pass, $ty, load, swap, Acquire, Release);
                __stress_acquire_release!(should_pass, $ty, load, swap, Acquire, AcqRel);
                __stress_acquire_release!(should_pass, $ty, load, swap, Acquire, SeqCst);
                __stress_acquire_release!(can_panic, $ty, load, swap, SeqCst, Relaxed);
                __stress_acquire_release!(can_panic, $ty, load, swap, SeqCst, Acquire);
                __stress_acquire_release!(should_pass, $ty, load, swap, SeqCst, Release);
                __stress_acquire_release!(should_pass, $ty, load, swap, SeqCst, AcqRel);
                __stress_acquire_release!(should_pass, $ty, load, swap, SeqCst, SeqCst);

                __stress_seqcst!(can_panic, $ty, load, swap, Relaxed, Relaxed);
                __stress_seqcst!(can_panic, $ty, load, swap, Relaxed, Acquire);
                __stress_seqcst!(can_panic, $ty, load, swap, Relaxed, Release);
                __stress_seqcst!(can_panic, $ty, load, swap, Relaxed, AcqRel);
                __stress_seqcst!(can_panic, $ty, load, swap, Relaxed, SeqCst);
                __stress_seqcst!(can_panic, $ty, load, swap, Acquire, Relaxed);
                __stress_seqcst!(can_panic, $ty, load, swap, Acquire, Acquire);
                __stress_seqcst!(can_panic, $ty, load, swap, Acquire, Release);
                __stress_seqcst!(can_panic, $ty, load, swap, Acquire, AcqRel);
                __stress_seqcst!(can_panic, $ty, load, swap, Acquire, SeqCst);
                __stress_seqcst!(can_panic, $ty, load, swap, SeqCst, Relaxed);
                __stress_seqcst!(can_panic, $ty, load, swap, SeqCst, Acquire);
                __stress_seqcst!(can_panic, $ty, load, swap, SeqCst, Release);
                __stress_seqcst!(can_panic, $ty, load, swap, SeqCst, AcqRel);
                __stress_seqcst!(should_pass, $ty, load, swap, SeqCst, SeqCst);
            }
        }
        #[cfg(not(target_arch = "csky"))] // TODO(csky): hang or glibc/pthread assertion fail. likely due to broken libatomic: https://github.com/rust-lang/rust/issues/117306
        #[cfg(not(any(
            all(target_arch = "csky", atomic_maybe_uninit_no_ldex_stex),
            all(target_arch = "mips64", atomic_maybe_uninit_no_ll_sc),
            all(target_arch = "x86", atomic_maybe_uninit_no_cmpxchg),
        )))]
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::arithmetic_side_effects,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks
            )]
            mod [<stress_ $ty>] {
                use std::{mem::MaybeUninit, sync::atomic::Ordering};

                use crate::{AtomicMaybeUninit, tests::helper::*};

                __stress_acquire_release!(can_panic, $ty, cas, store, Relaxed, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas, store, Relaxed, Release);
                __stress_acquire_release!(can_panic, $ty, cas, store, Relaxed, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas, store, Acquire, Relaxed);
                __stress_acquire_release!(should_pass, $ty, cas, store, Acquire, Release);
                __stress_acquire_release!(should_pass, $ty, cas, store, Acquire, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas, store, Release, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas, store, Release, Release);
                __stress_acquire_release!(can_panic, $ty, cas, store, Release, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas, store, AcqRel, Relaxed);
                __stress_acquire_release!(should_pass, $ty, cas, store, AcqRel, Release);
                __stress_acquire_release!(should_pass, $ty, cas, store, AcqRel, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas, store, SeqCst, Relaxed);
                __stress_acquire_release!(should_pass, $ty, cas, store, SeqCst, Release);
                __stress_acquire_release!(should_pass, $ty, cas, store, SeqCst, SeqCst);

                __stress_acquire_release!(can_panic, $ty, cas_weak, store, Relaxed, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas_weak, store, Relaxed, Release);
                __stress_acquire_release!(can_panic, $ty, cas_weak, store, Relaxed, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas_weak, store, Acquire, Relaxed);
                __stress_acquire_release!(should_pass, $ty, cas_weak, store, Acquire, Release);
                __stress_acquire_release!(should_pass, $ty, cas_weak, store, Acquire, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas_weak, store, Release, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas_weak, store, Release, Release);
                __stress_acquire_release!(can_panic, $ty, cas_weak, store, Release, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas_weak, store, AcqRel, Relaxed);
                __stress_acquire_release!(should_pass, $ty, cas_weak, store, AcqRel, Release);
                __stress_acquire_release!(should_pass, $ty, cas_weak, store, AcqRel, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas_weak, store, SeqCst, Relaxed);
                __stress_acquire_release!(should_pass, $ty, cas_weak, store, SeqCst, Release);
                __stress_acquire_release!(should_pass, $ty, cas_weak, store, SeqCst, SeqCst);

                __stress_acquire_release!(can_panic, $ty, cas, swap, Relaxed, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Relaxed, Acquire);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Relaxed, Release);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Relaxed, AcqRel);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Relaxed, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Acquire, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Acquire, Acquire);
                __stress_acquire_release!(should_pass, $ty, cas, swap, Acquire, Release);
                __stress_acquire_release!(should_pass, $ty, cas, swap, Acquire, AcqRel);
                __stress_acquire_release!(should_pass, $ty, cas, swap, Acquire, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Release, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Release, Acquire);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Release, Release);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Release, AcqRel);
                __stress_acquire_release!(can_panic, $ty, cas, swap, Release, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas, swap, AcqRel, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas, swap, AcqRel, Acquire);
                __stress_acquire_release!(should_pass, $ty, cas, swap, AcqRel, Release);
                __stress_acquire_release!(should_pass, $ty, cas, swap, AcqRel, AcqRel);
                __stress_acquire_release!(should_pass, $ty, cas, swap, AcqRel, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas, swap, SeqCst, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas, swap, SeqCst, Acquire);
                __stress_acquire_release!(should_pass, $ty, cas, swap, SeqCst, Release);
                __stress_acquire_release!(should_pass, $ty, cas, swap, SeqCst, AcqRel);
                __stress_acquire_release!(should_pass, $ty, cas, swap, SeqCst, SeqCst);

                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Relaxed, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Relaxed, Acquire);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Relaxed, Release);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Relaxed, AcqRel);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Relaxed, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Acquire, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Acquire, Acquire);
                __stress_acquire_release!(should_pass, $ty, cas_weak, swap, Acquire, Release);
                __stress_acquire_release!(should_pass, $ty, cas_weak, swap, Acquire, AcqRel);
                __stress_acquire_release!(should_pass, $ty, cas_weak, swap, Acquire, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Release, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Release, Acquire);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Release, Release);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Release, AcqRel);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, Release, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, AcqRel, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, AcqRel, Acquire);
                __stress_acquire_release!(should_pass, $ty, cas_weak, swap, AcqRel, Release);
                __stress_acquire_release!(should_pass, $ty, cas_weak, swap, AcqRel, AcqRel);
                __stress_acquire_release!(should_pass, $ty, cas_weak, swap, AcqRel, SeqCst);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, SeqCst, Relaxed);
                __stress_acquire_release!(can_panic, $ty, cas_weak, swap, SeqCst, Acquire);
                __stress_acquire_release!(should_pass, $ty, cas_weak, swap, SeqCst, Release);
                __stress_acquire_release!(should_pass, $ty, cas_weak, swap, SeqCst, AcqRel);
                __stress_acquire_release!(should_pass, $ty, cas_weak, swap, SeqCst, SeqCst);

                __stress_acquire_release!(can_panic, $ty, load, cas, Relaxed, Relaxed);
                __stress_acquire_release!(can_panic, $ty, load, cas, Relaxed, Acquire);
                __stress_acquire_release!(can_panic, $ty, load, cas, Relaxed, Release);
                __stress_acquire_release!(can_panic, $ty, load, cas, Relaxed, AcqRel);
                __stress_acquire_release!(can_panic, $ty, load, cas, Relaxed, SeqCst);
                __stress_acquire_release!(can_panic, $ty, load, cas, Acquire, Relaxed);
                __stress_acquire_release!(can_panic, $ty, load, cas, Acquire, Acquire);
                __stress_acquire_release!(should_pass, $ty, load, cas, Acquire, Release);
                __stress_acquire_release!(should_pass, $ty, load, cas, Acquire, AcqRel);
                __stress_acquire_release!(should_pass, $ty, load, cas, Acquire, SeqCst);
                __stress_acquire_release!(can_panic, $ty, load, cas, SeqCst, Relaxed);
                __stress_acquire_release!(can_panic, $ty, load, cas, SeqCst, Acquire);
                __stress_acquire_release!(should_pass, $ty, load, cas, SeqCst, Release);
                __stress_acquire_release!(should_pass, $ty, load, cas, SeqCst, AcqRel);
                __stress_acquire_release!(should_pass, $ty, load, cas, SeqCst, SeqCst);

                __stress_seqcst!(can_panic, $ty, cas, store, Relaxed, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, store, Relaxed, Release);
                __stress_seqcst!(can_panic, $ty, cas, store, Relaxed, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas, store, Acquire, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, store, Acquire, Release);
                __stress_seqcst!(can_panic, $ty, cas, store, Acquire, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas, store, Release, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, store, Release, Release);
                __stress_seqcst!(can_panic, $ty, cas, store, Release, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas, store, AcqRel, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, store, AcqRel, Release);
                __stress_seqcst!(can_panic, $ty, cas, store, AcqRel, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas, store, SeqCst, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, store, SeqCst, Release);
                __stress_seqcst!(should_pass, $ty, cas, store, SeqCst, SeqCst);

                __stress_seqcst!(can_panic, $ty, cas_weak, store, Relaxed, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, Relaxed, Release);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, Relaxed, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, Acquire, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, Acquire, Release);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, Acquire, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, Release, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, Release, Release);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, Release, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, AcqRel, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, AcqRel, Release);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, AcqRel, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, SeqCst, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, store, SeqCst, Release);
                __stress_seqcst!(should_pass, $ty, cas_weak, store, SeqCst, SeqCst);

                __stress_seqcst!(can_panic, $ty, cas, swap, Relaxed, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, swap, Relaxed, Acquire);
                __stress_seqcst!(can_panic, $ty, cas, swap, Relaxed, Release);
                __stress_seqcst!(can_panic, $ty, cas, swap, Relaxed, AcqRel);
                __stress_seqcst!(can_panic, $ty, cas, swap, Relaxed, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas, swap, Acquire, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, swap, Acquire, Acquire);
                __stress_seqcst!(can_panic, $ty, cas, swap, Acquire, Release);
                __stress_seqcst!(can_panic, $ty, cas, swap, Acquire, AcqRel);
                __stress_seqcst!(can_panic, $ty, cas, swap, Acquire, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas, swap, Release, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, swap, Release, Acquire);
                __stress_seqcst!(can_panic, $ty, cas, swap, Release, Release);
                __stress_seqcst!(can_panic, $ty, cas, swap, Release, AcqRel);
                __stress_seqcst!(can_panic, $ty, cas, swap, Release, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas, swap, AcqRel, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, swap, AcqRel, Acquire);
                __stress_seqcst!(can_panic, $ty, cas, swap, AcqRel, Release);
                __stress_seqcst!(can_panic, $ty, cas, swap, AcqRel, AcqRel);
                __stress_seqcst!(can_panic, $ty, cas, swap, AcqRel, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas, swap, SeqCst, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas, swap, SeqCst, Acquire);
                __stress_seqcst!(can_panic, $ty, cas, swap, SeqCst, Release);
                __stress_seqcst!(can_panic, $ty, cas, swap, SeqCst, AcqRel);
                __stress_seqcst!(should_pass, $ty, cas, swap, SeqCst, SeqCst);

                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Relaxed, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Relaxed, Acquire);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Relaxed, Release);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Relaxed, AcqRel);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Relaxed, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Acquire, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Acquire, Acquire);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Acquire, Release);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Acquire, AcqRel);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Acquire, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Release, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Release, Acquire);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Release, Release);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Release, AcqRel);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, Release, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, AcqRel, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, AcqRel, Acquire);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, AcqRel, Release);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, AcqRel, AcqRel);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, AcqRel, SeqCst);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, SeqCst, Relaxed);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, SeqCst, Acquire);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, SeqCst, Release);
                __stress_seqcst!(can_panic, $ty, cas_weak, swap, SeqCst, AcqRel);
                __stress_seqcst!(should_pass, $ty, cas_weak, swap, SeqCst, SeqCst);

                __stress_seqcst!(can_panic, $ty, load, cas, Relaxed, Relaxed);
                __stress_seqcst!(can_panic, $ty, load, cas, Relaxed, Acquire);
                __stress_seqcst!(can_panic, $ty, load, cas, Relaxed, Release);
                __stress_seqcst!(can_panic, $ty, load, cas, Relaxed, AcqRel);
                __stress_seqcst!(can_panic, $ty, load, cas, Relaxed, SeqCst);
                __stress_seqcst!(can_panic, $ty, load, cas, Acquire, Relaxed);
                __stress_seqcst!(can_panic, $ty, load, cas, Acquire, Acquire);
                __stress_seqcst!(can_panic, $ty, load, cas, Acquire, Release);
                __stress_seqcst!(can_panic, $ty, load, cas, Acquire, AcqRel);
                __stress_seqcst!(can_panic, $ty, load, cas, Acquire, SeqCst);
                __stress_seqcst!(can_panic, $ty, load, cas, SeqCst, Relaxed);
                __stress_seqcst!(can_panic, $ty, load, cas, SeqCst, Acquire);
                __stress_seqcst!(can_panic, $ty, load, cas, SeqCst, Release);
                __stress_seqcst!(can_panic, $ty, load, cas, SeqCst, AcqRel);
                __stress_seqcst!(should_pass, $ty, load, cas, SeqCst, SeqCst);
            }
        }
    };
}
