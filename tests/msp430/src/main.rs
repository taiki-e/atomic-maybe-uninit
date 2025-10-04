// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]

include!("../../include/basic.rs");

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;
use msp430f5529 as _;

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
    fn write_str(s: &str) {
        // https://github.com/dlbeer/mspdebug/blob/v0.25/simio/simio_console.c#L130
        let addr = 0x00FF_usize as *mut u8;
        for &b in s.as_bytes() {
            unsafe { addr.write_volatile(b) }
        }
    }
    impl ufmt::uWrite for Console {
        type Error = Infallible;
        fn write_str(&mut self, s: &str) -> Result<(), Self::Error> {
            write_str(s);
            Ok(())
        }
    }
    impl fmt::Write for Console {
        fn write_str(&mut self, s: &str) -> fmt::Result {
            write_str(s);
            Ok(())
        }
    }
}
