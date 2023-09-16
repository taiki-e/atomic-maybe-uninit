// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![warn(rust_2018_idioms, single_use_lifetimes, unsafe_op_in_unsafe_fn)]
#![feature(panic_info_message)] // <PanicInfo as fmt::Display>::fmt increases binary size than manual printing
#![allow(clippy::empty_loop)] // this test crate is #![no_std]

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;

macro_rules! __test_atomic {
    ($int_type:ident) => {
        load_store();
        fn load_store() {
            unsafe {
                static VAR: AtomicMaybeUninit<$int_type> =
                    AtomicMaybeUninit::<$int_type>::const_new(MaybeUninit::new(10));
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
        swap();
        fn swap() {
            #[cfg(target_has_atomic = "ptr")]
            unsafe {
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
        compare_exchange();
        fn compare_exchange() {
            #[cfg(target_has_atomic = "ptr")]
            unsafe {
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
                }
            }
        }
        compare_exchange_weak();
        fn compare_exchange_weak() {
            #[cfg(target_has_atomic = "ptr")]
            unsafe {
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
        fetch_update();
        fn fetch_update() {
            #[cfg(target_has_atomic = "ptr")]
            unsafe {
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
        ($int_type:ident) => {
            paste::paste! {
                fn [<test_atomic_ $int_type>]() {
                    __test_atomic!($int_type);
                }
                print!("test test_atomic_{} ... ", stringify!($int_type));
                [<test_atomic_ $int_type>]();
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

    semihosting::exit(0)
}

fn load_orderings() -> [Ordering; 3] {
    [Ordering::Relaxed, Ordering::Acquire, Ordering::SeqCst]
}
fn store_orderings() -> [Ordering; 3] {
    [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst]
}
#[cfg(target_has_atomic = "ptr")]
fn swap_orderings() -> [Ordering; 5] {
    [Ordering::Relaxed, Ordering::Release, Ordering::Acquire, Ordering::AcqRel, Ordering::SeqCst]
}
#[cfg(target_has_atomic = "ptr")]
fn compare_exchange_orderings() -> [(Ordering, Ordering); 15] {
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

#[inline(never)]
#[panic_handler]
fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
    avr_device::interrupt::disable();

    let dp = unsafe { arduino_hal::Peripherals::steal() };
    let pins = arduino_hal::pins!(dp);
    let mut serial = semihosting::Usart(arduino_hal::default_serial!(dp, pins, 57600));

    macro_rules! print {
        ($($tt:tt)*) => {{
            use core::fmt::Write as _;
            let _ = write!(serial, $($tt)*);
        }};
    }
    macro_rules! println {
        ($($tt:tt)*) => {{
            use core::fmt::Write as _;
            let _ = writeln!(serial, $($tt)*);
        }};
    }

    if let Some(m) = info.message() {
        print!("panicked at '{m:?}'");
    } else {
        print!("panic occurred (no message)");
    }
    if let Some(l) = info.location() {
        println!(", {l}");
    } else {
        println!(" (no location info)");
    }

    semihosting::exit(1)
}

mod semihosting {
    use core::fmt;

    pub fn exit(code: u32) -> ! {
        // It seems there is no way to exit simavr with a non-zero exit code.
        // https://github.com/buserror/simavr/issues/362
        if code == 0 {
            avr_device::interrupt::disable();
            avr_device::asm::sleep();
        }
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
