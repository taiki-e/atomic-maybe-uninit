// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![warn(unsafe_op_in_unsafe_fn)]

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use arduino_hal::avr_device;
use atomic_maybe_uninit::*;

macro_rules! __test_atomic {
    ($ty:ident) => {
        load_store();
        fn load_store() {
            unsafe {
                static VAR: AtomicMaybeUninit<$ty> =
                    AtomicMaybeUninit::<$ty>::const_new(MaybeUninit::new(10));
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
        swap();
        fn swap() {
            unsafe {
                for order in SWAP_ORDERINGS {
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
            unsafe {
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
                }
            }
        }
        compare_exchange_weak();
        fn compare_exchange_weak() {
            unsafe {
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
        fetch_update();
        fn fetch_update() {
            unsafe {
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
    };
}

#[avr_device::entry]
fn main() -> ! {
    let dp = arduino_hal::Peripherals::take().unwrap();
    let pins = arduino_hal::pins!(dp);
    let mut serial = arduino_hal::default_serial!(dp, pins, 57600);

    macro_rules! print {
        ($($tt:tt)*) => {{
            let _ = ufmt::uwrite!(serial, $($tt)*);
        }};
    }
    macro_rules! println {
        ($($tt:tt)*) => {{
            let _ = ufmt::uwriteln!(serial, $($tt)*);
        }};
    }

    macro_rules! test_atomic {
        ($ty:ident) => {
            paste::paste! {
                fn [<test_atomic_ $ty>]() {
                    __test_atomic!($ty);
                }
                print!("test test_atomic_{} ... ", stringify!($ty));
                [<test_atomic_ $ty>]();
                println!("ok");
            }
        };
    }

    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);

    println!("Tests finished successfully");

    sim::exit(0)
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

#[inline(never)]
#[panic_handler]
fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
    avr_device::interrupt::disable();

    let dp = unsafe { arduino_hal::Peripherals::steal() };
    let pins = arduino_hal::pins!(dp);
    let mut serial = sim::Usart(arduino_hal::default_serial!(dp, pins, 57600));

    macro_rules! println {
        ($($tt:tt)*) => {{
            use core::fmt::Write as _;
            let _ = writeln!(serial, $($tt)*);
        }};
    }

    println!("{info}");
    sim::exit(1)
}

mod sim {
    use core::fmt;

    use arduino_hal::avr_device;

    pub fn exit(_code: u32) -> ! {
        // Note that there is no way to exit simavr with a non-zero exit code.
        // https://github.com/buserror/simavr/issues/362
        avr_device::interrupt::disable();
        avr_device::asm::sleep();
        #[allow(clippy::empty_loop)] // this test crate is #![no_std]
        loop {}
    }

    pub struct Usart<USART, RX, TX>(pub arduino_hal::usart::Usart<USART, RX, TX>)
    where
        USART: arduino_hal::usart::UsartOps<arduino_hal::hal::Atmega, RX, TX>;
    impl<USART, RX, TX> fmt::Write for Usart<USART, RX, TX>
    where
        USART: arduino_hal::usart::UsartOps<arduino_hal::hal::Atmega, RX, TX>,
    {
        fn write_str(&mut self, s: &str) -> fmt::Result {
            for b in s.bytes() {
                self.0.write_byte(b);
            }
            Ok(())
        }
    }
}
