// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]

include!("../../include/basic.rs");

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;
use msp430f5529 as _;

macro_rules! print_str {
    ($($tt:tt)*) => {{
        simio::write_str($($tt)*);
    }};
}

#[msp430_rt::entry]
fn main() -> ! {
    test_atomic_all!();

    print_str!("Tests finished successfully\n");

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
    use core::fmt;

    pub fn write_str(s: &str) {
        // https://github.com/dlbeer/mspdebug/blob/v0.26/simio/simio_console.c#L188
        let addr = 0x00FF_usize as *mut u8;
        for &b in s.as_bytes() {
            unsafe { addr.write_volatile(b) }
        }
    }
    pub struct Console;
    impl fmt::Write for Console {
        fn write_str(&mut self, s: &str) -> fmt::Result {
            write_str(s);
            Ok(())
        }
    }
}
