#![no_main]
#![no_std]
#![warn(rust_2018_idioms, unsafe_op_in_unsafe_fn)]
#![feature(panic_info_message)]

use core::{fmt::Write, mem::MaybeUninit, panic::PanicInfo, sync::atomic::Ordering};

use atomic_maybe_uninit::*;
use cortex_m::asm;
use cortex_m_rt::entry;
use cortex_m_semihosting as semihosting;

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
    };
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

#[entry]
fn main() -> ! {
    asm::nop();

    let mut hstdout = semihosting::hio::hstdout().unwrap();

    macro_rules! test_atomic {
        ($int_type:ident) => {
            paste::paste! {
                fn [<test_atomic_ $int_type>]() {
                    __test_atomic!($int_type);
                }
                let _ = write!(hstdout, "test test_atomic_{} ...", stringify!($int_type));
                [<test_atomic_ $int_type>]();
                let _ = write!(hstdout, " ok\n");
            }
        };
    }

    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);
    test_atomic!(i32);
    test_atomic!(u32);

    loop {
        semihosting::debug::exit(semihosting::debug::EXIT_SUCCESS);
    }
}

#[inline(never)]
#[panic_handler]
fn panic(info: &PanicInfo<'_>) -> ! {
    if let Ok(mut hstdout) = semihosting::hio::hstdout() {
        if let Some(s) = info.message() {
            if let Some(l) = info.location() {
                let _ = writeln!(hstdout, "panicked at '{:?}', {}", s, l);
            } else {
                let _ = writeln!(hstdout, "panicked at '{:?}' (no location info)", s);
            }
        } else {
            let _ = writeln!(hstdout, "panic occurred (no message)");
        }
    }

    loop {
        semihosting::debug::exit(semihosting::debug::EXIT_FAILURE);
    }
}
