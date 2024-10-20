// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![warn(unsafe_op_in_unsafe_fn)]

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;
use msp430f5529 as _;

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
        cfg_has_atomic_cas! {
        compare_exchange();
        fn compare_exchange() {
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
        }
    };
}

macro_rules! print {
    ($($tt:tt)*) => {
        let _ = ufmt::uwrite!(simio::Console, $($tt)*);
    };
}
macro_rules! println {
    ($($tt:tt)*) => {
        let _ = ufmt::uwriteln!(simio::Console, $($tt)*);
    };
}

#[msp430_rt::entry]
fn main() -> ! {
    macro_rules! test_atomic {
        ($int_type:ident) => {
            paste::paste! {
                fn [<test_atomic_ $int_type>]() {
                    __test_atomic!($int_type);
                }
                print!("{}", concat!("test test_atomic_", stringify!($int_type), " ... "));
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

    println!("Tests finished successfully");

    #[allow(clippy::empty_loop)] // this test crate is #![no_std]
    loop {}
}

fn load_orderings() -> [Ordering; 3] {
    [Ordering::Relaxed, Ordering::Acquire, Ordering::SeqCst]
}
fn store_orderings() -> [Ordering; 3] {
    [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst]
}
fn swap_orderings() -> [Ordering; 5] {
    [Ordering::Relaxed, Ordering::Release, Ordering::Acquire, Ordering::AcqRel, Ordering::SeqCst]
}
cfg_has_atomic_cas! {
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
}

#[inline(never)]
#[panic_handler]
fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
    macro_rules! println {
        ($($tt:tt)*) => {
            use core::fmt::Write as _;
            let _ = writeln!(simio::Console, $($tt)*);
        };
    }

    println!("{info}"); // this println takes a lot of spaces but better panic message is useful...
    #[allow(clippy::empty_loop)] // this test crate is #![no_std]
    loop {}
}

#[no_mangle]
extern "C" fn abort() -> ! {
    panic!()
}

mod simio {
    use core::{convert::Infallible, fmt};

    pub struct Console;
    impl Console {
        fn write_str(&mut self, s: &str) {
            // https://github.com/dlbeer/mspdebug/blob/v0.25/simio/simio_console.c#L130
            let addr = 0x00FF_usize as *mut u8;
            for &b in s.as_bytes() {
                unsafe { addr.write_volatile(b) }
            }
        }
    }
    impl ufmt::uWrite for Console {
        type Error = Infallible;
        fn write_str(&mut self, s: &str) -> Result<(), Self::Error> {
            self.write_str(s);
            Ok(())
        }
    }
    impl fmt::Write for Console {
        fn write_str(&mut self, s: &str) -> fmt::Result {
            self.write_str(s);
            Ok(())
        }
    }
}
