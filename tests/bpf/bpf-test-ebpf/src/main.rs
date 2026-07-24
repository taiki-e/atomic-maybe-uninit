// SPDX-License-Identifier: MIT

#![no_std]
#![no_main]

use aya_ebpf::{bindings::xdp_action, macros::xdp, programs::XdpContext};
use aya_log_ebpf::info;

#[xdp]
pub fn bpf_test(ctx: XdpContext) -> u32 {
    match run(ctx) {
        Ok(ret) => ret,
        Err(_) => xdp_action::XDP_ABORTED,
    }
}

#[cfg(not(test))]
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}

#[unsafe(link_section = "license")]
#[unsafe(no_mangle)]
static LICENSE: [u8; 4] = *b"MIT\0";

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;

fn run(ctx: XdpContext) -> Result<u32, u32> {
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
                return Err(xdp_action::XDP_ABORTED);
            }
        }};
    }

    macro_rules! __test_atomic {
        ($ty:ident) => {
            // load_store
            {
                static VAR: AtomicMaybeUninit<$ty> = AtomicMaybeUninit::new(MaybeUninit::new(10));
                macro_rules! __test_load_store {
                    ($load_order:expr, $store_order:expr) => {
                        unsafe {
                            assert_eq!(VAR.load($load_order).assume_init(), 10);
                            VAR.store(MaybeUninit::new(5), $store_order);
                            assert_eq!(VAR.load($load_order).assume_init(), 5);
                            VAR.store(MaybeUninit::uninit(), $store_order);
                            let _v = VAR.load($load_order);
                            VAR.store(MaybeUninit::new(10), $store_order);

                            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(1));
                            assert_eq!(a.load($load_order).assume_init(), 1);
                            a.store(MaybeUninit::new($ty::MIN), $store_order);
                            assert_eq!(a.load($load_order).assume_init(), $ty::MIN);
                            a.store(MaybeUninit::new($ty::MAX), $store_order);
                            assert_eq!(a.load($load_order).assume_init(), $ty::MAX);
                            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::uninit());
                            let _v = a.load($load_order);
                            a.store(MaybeUninit::new(2), $store_order);
                            assert_eq!(a.load($load_order).assume_init(), 2);
                            a.store(MaybeUninit::uninit(), $store_order);
                            let _v = a.load($load_order);
                        }
                    };
                }
                __test_load_store!(Ordering::Relaxed, Ordering::Relaxed);
                __test_load_store!(Ordering::Acquire, Ordering::Release);
                __test_load_store!(Ordering::SeqCst, Ordering::SeqCst);
            }
            // swap
            unsafe {
                // swap implementation is the same in all order.
                let order = Ordering::Relaxed;
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
            // compare_exchange
            {
                macro_rules! __test_compare_exchange {
                    ($success:expr, $failure:expr) => {
                        unsafe {
                            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                            assert_eq!(
                                a.compare_exchange(
                                    MaybeUninit::new(5),
                                    MaybeUninit::new(10),
                                    $success,
                                    $failure
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
                                    $success,
                                    $failure
                                )
                                .unwrap_err_unchecked()
                                .assume_init(),
                                10
                            );
                            assert_eq!(a.load(Ordering::Relaxed).assume_init(), 10);
                        }
                    };
                }
                // CAS implementation has two cases: failure is Relaxed or not
                __test_compare_exchange!(Ordering::Relaxed, Ordering::Relaxed);
                __test_compare_exchange!(Ordering::AcqRel, Ordering::Acquire);
            }
            // compare_exchange_weak
            {
                macro_rules! __test_compare_exchange_weak {
                    ($success:expr, $failure:expr) => {
                        unsafe {
                            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(4));
                            assert_eq!(
                                a.compare_exchange_weak(
                                    MaybeUninit::new(6),
                                    MaybeUninit::new(8),
                                    $success,
                                    $failure
                                )
                                .unwrap_err_unchecked()
                                .assume_init(),
                                4
                            );
                            let old = a.load(Ordering::Relaxed);
                            let new = MaybeUninit::new(old.assume_init() * 2);
                            assert_eq!(
                                a.compare_exchange_weak(old, new, $success, $failure)
                                    .unwrap_unchecked()
                                    .assume_init(),
                                4
                            );
                            assert_eq!(a.load(Ordering::Relaxed).assume_init(), 8);
                        }
                    };
                }
                // CAS implementation has two cases: failure is Relaxed or not
                __test_compare_exchange_weak!(Ordering::Relaxed, Ordering::Relaxed);
                __test_compare_exchange_weak!(Ordering::AcqRel, Ordering::Acquire);
            }
            // try_update
            {
                macro_rules! __test_try_update {
                    ($success:expr, $failure:expr) => {
                        unsafe {
                            let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(7));
                            assert_eq!(
                                a.try_update($success, $failure, |_| None)
                                    .unwrap_err_unchecked()
                                    .assume_init(),
                                7
                            );
                            assert_eq!(a.load(Ordering::Relaxed).assume_init(), 7);
                            // The verifier cannot recognize that the loop is actually finite.
                            // assert_eq!(
                            //     a.try_update($success, $failure, |x| Some(MaybeUninit::new(
                            //         x.assume_init() + 1
                            //     )))
                            //     .unwrap_unchecked()
                            //     .assume_init(),
                            //     7
                            // );
                            // assert_eq!(a.load(Ordering::Relaxed).assume_init(), 8);
                        }
                    };
                }
                // CAS implementation has two cases: failure is Relaxed or not
                // load implementation has three cases
                __test_try_update!(Ordering::Relaxed, Ordering::Relaxed);
                __test_try_update!(Ordering::AcqRel, Ordering::Acquire);
                __test_try_update!(Ordering::SeqCst, Ordering::SeqCst);
            }
            // update
            // The verifier cannot recognize that the loop is actually finite.
            // {
            //     macro_rules! __test_update {
            //         ($success:expr, $failure:expr) => {
            //             unsafe {
            //                 let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(7));
            //                 assert_eq!(
            //                     a.update($success, $failure, |x| MaybeUninit::new(
            //                         x.assume_init() + 1
            //                     ))
            //                     .assume_init(),
            //                     7
            //                 );
            //                 assert_eq!(a.load(Ordering::Relaxed).assume_init(), 8);
            //             }
            //         };
            //     }
            //     // CAS implementation has two cases: failure is Relaxed or not
            //     // load implementation has three cases
            //     __test_update!(Ordering::Relaxed, Ordering::Relaxed);
            //     __test_update!(Ordering::AcqRel, Ordering::Acquire);
            //     __test_update!(Ordering::SeqCst, Ordering::SeqCst);
            // }
        };
    }

    macro_rules! test_atomic {
        ($ty:ident) => {
            paste::paste! {
                print!("test test_atomic_{} ... ", stringify!($ty));
                {
                    __test_atomic!($ty);
                }
                println!("ok");
            }
        };
    }

    #[cfg(feature = "isize")]
    test_atomic!(isize);
    #[cfg(feature = "usize")]
    test_atomic!(usize);
    #[cfg(feature = "i32")]
    test_atomic!(i32);
    #[cfg(feature = "u32")]
    test_atomic!(u32);
    #[cfg(feature = "i64")]
    test_atomic!(i64);
    #[cfg(feature = "u64")]
    test_atomic!(u64);

    info!(&ctx, "Tests finished successfully");
    Ok(xdp_action::XDP_PASS)
}
