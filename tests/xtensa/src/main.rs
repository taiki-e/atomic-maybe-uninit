// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]

include!("../../include/basic.rs");

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;
use esp_println::{print, println};

#[esp_hal::main]
fn main() -> ! {
    macro_rules! test_atomic {
        ($ty:ident) => {
            paste::paste! {
                fn [<test_atomic_ $ty>]() {
                    __test_atomic!($ty);
                }
                print!("{}", concat!("test test_atomic_", stringify!($ty), " ... "));
                [<test_atomic_ $ty>]();
                println!("ok");
            }
        };
    }

    cfg_has_atomic_cas! {
        println!("target_has_cas: true");
    }
    cfg_no_atomic_cas! {
        println!("target_has_cas: false");
    }
    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);
    test_atomic!(i32);
    test_atomic!(u32);

    println!("Tests finished successfully");

    #[allow(clippy::empty_loop)] // this test crate is #![no_std]
    loop {}
}

#[inline(never)]
#[panic_handler]
fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
    println!("{info}");
    #[allow(clippy::empty_loop)] // this test crate is #![no_std]
    loop {}
}
