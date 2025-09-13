#![no_std]
#![no_main]
#![warn(unsafe_op_in_unsafe_fn)]

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;
use aya_ebpf::{bindings::xdp_action, macros::xdp, programs::XdpContext};
use aya_log_ebpf::info;

#[xdp]
pub fn bpf_test(ctx: XdpContext) -> u32 {
    macro_rules! print {
        ($($tt:tt)*) => {{
            info!(&ctx, $($tt)*);
        }};
    }
    macro_rules! println {
        ($($tt:tt)*) => {{
            info!(&ctx, $($tt)*);
        }};
    }
    macro_rules! assert_eq {
        ($a:expr, $b:expr $(,)?) => {{
            let a = $a;
            let b = $b;
            if a != b {
                info!(&ctx, "assertion failed: left={},right={}", a, b);
                return xdp_action::XDP_ABORTED;
            }
        }};
    }

    macro_rules! __test_atomic_load_store {
        ($ty:ident) => {
            // load_store();
            // fn load_store()
            {
                unsafe {
                    // static VAR: AtomicMaybeUninit<$ty> =
                    //     AtomicMaybeUninit::<$ty>::const_new(MaybeUninit::new(10));
                    for (load_order, store_order) in LOAD_ORDERINGS.into_iter().zip(STORE_ORDERINGS)
                    {
                        // assert_eq!(VAR.load(load_order).assume_init(), 10);
                        // VAR.store(MaybeUninit::new(5), store_order);
                        // assert_eq!(VAR.load(load_order).assume_init(), 5);
                        // VAR.store(MaybeUninit::uninit(), store_order);
                        // let _v = VAR.load(load_order);
                        // VAR.store(MaybeUninit::new(10), store_order);

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
        };
    }
    macro_rules! __test_atomic {
        ($ty:ident) => {
            __test_atomic_load_store!($ty);
            /* TODO: should separately tested with CAS/load/store tests
            // swap();
            // fn swap()
            {
                unsafe {
                    let order = SWAP_ORDERINGS[4];
                    // for order in SWAP_ORDERINGS {
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                    assert_eq!(a.swap(MaybeUninit::new($ty::MIN), order).assume_init(), 5);
                    // assert_eq!(
                    //     a.swap(MaybeUninit::new($ty::MAX), order).assume_init(),
                    //     $ty::MIN
                    // );
                    // assert_eq!(a.swap(MaybeUninit::new(10), order).assume_init(), $ty::MAX);
                    // assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                    // let _v = a.swap(MaybeUninit::new(15), order);
                    // let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::uninit());
                    // let _v = a.swap(MaybeUninit::new(10), order);
                    // assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                    // }
                }
            }
            */
            // compare_exchange();
            // fn compare_exchange()
            {
                unsafe {
                    let (success, failure) = COMPARE_EXCHANGE_ORDERINGS[14];
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                    assert_eq!(
                        a.compare_exchange(
                            MaybeUninit::new(5),
                            MaybeUninit::new(10),
                            success,
                            failure
                        )
                        .unwrap_unchecked()
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
                        .unwrap_err_unchecked()
                        .assume_init(),
                        10
                    );
                    assert_eq!(a.load(Ordering::Relaxed).assume_init(), 10);
                    // }
                }
            }
            /*
            // compare_exchange_weak();
            // fn compare_exchange_weak()
            {
                unsafe {
                    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                        let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(4));
                        assert_eq!(
                            a.compare_exchange_weak(
                                MaybeUninit::new(6),
                                MaybeUninit::new(8),
                                success,
                                failure
                            )
                            .unwrap_err_unchecked()
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
            // fetch_update();
            // fn fetch_update()
            {
                unsafe {
                    for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                        let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(7));
                        assert_eq!(
                            a.fetch_update(success, failure, |_| None)
                                .unwrap_err_unchecked()
                                .assume_init(),
                            7
                        );
                        assert_eq!(
                            a.fetch_update(success, failure, |x| Some(MaybeUninit::new(
                                x.assume_init() + 1
                            )))
                            .unwrap_unchecked()
                            .assume_init(),
                            7
                        );
                        assert_eq!(
                            a.fetch_update(success, failure, |x| Some(MaybeUninit::new(
                                x.assume_init() + 1
                            )))
                            .unwrap_unchecked()
                            .assume_init(),
                            8
                        );
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), 9);
                    }
                }
            }
            */
        };
    }

    macro_rules! test_atomic_load_store {
        ($ty:ident) => {
            paste::paste! {
                // fn [<test_atomic_ $ty>]() {
                //     __test_atomic_load_store!($ty);
                // }
                print!("test test_atomic_{} ... ", stringify!($ty));
                // [<test_atomic_ $ty>]();
                {
                    __test_atomic_load_store!($ty);
                }
                println!("ok");
            }
        };
    }
    macro_rules! test_atomic {
        ($ty:ident) => {
            paste::paste! {
                // fn [<test_atomic_ $ty>]() {
                //     __test_atomic!($ty);
                // }
                print!("test test_atomic_{} ... ", stringify!($ty));
                // [<test_atomic_ $ty>]();
                {
                    __test_atomic!($ty);
                }
                println!("ok");
            }
        };
    }

    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic_load_store!(i8);
    test_atomic_load_store!(u8);
    test_atomic_load_store!(i16);
    test_atomic_load_store!(u16);
    test_atomic_load_store!(i32);
    test_atomic_load_store!(u32);
    test_atomic!(i64);
    test_atomic!(u64);

    info!(&ctx, "Tests finished successfully");
    xdp_action::XDP_PASS
}

const LOAD_ORDERINGS: [Ordering; 3] = [Ordering::Relaxed, Ordering::Acquire, Ordering::SeqCst];
const STORE_ORDERINGS: [Ordering; 3] = [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst];
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

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}
