// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]

include!("../../include/basic.rs");

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;

macro_rules! print_str {
    ($($tt:tt)*) => {{
        let s = concat!($($tt)*, "\0");
        unsafe {
            libc::puts(s as *const str as *const i8);
        }
    }};
}

#[no_mangle]
extern "C" fn main() {
    test_atomic_all!();

    unsafe { libc::exit(0) }
}

#[inline(never)]
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo<'_>) -> ! {
    // macro_rules! println {
    //     ($($tt:tt)*) => {
    //         use core::fmt::Write as _;
    //         let _ = writeln!(simio::Console, $($tt)*);
    //     };
    // }

    // println!("{info}");
    unsafe {
        libc::puts("panicked\0" as *const str as *const i8);
        libc::abort()
    }
}

mod libc {
    #[link(name = "c")]
    extern "C" {
        pub fn abort() -> !;
        pub fn exit(status: i32) -> !;
        pub fn puts(s: *const i8) -> i32;
    }
}
