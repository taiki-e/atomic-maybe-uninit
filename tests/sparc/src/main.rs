// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]

include!("../../include/basic.rs");

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;

macro_rules! print_str {
    ($($tt:tt)*) => {{
        sim::write_str($($tt)*);
    }};
}

#[no_mangle]
extern "C" fn main() -> i32 {
    test_atomic_all!();

    print_str!("Tests finished successfully\n");

    0
}

#[inline(never)]
#[panic_handler]
fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
    macro_rules! println {
        ($($tt:tt)*) => {{
            use core::fmt::Write as _;
            let _ = writeln!(sim::Console, $($tt)*);
        }};
    }

    println!("{info}");
    // Note that this doesn't make tsim-leon3 to be exit with non-zero exit code.
    unsafe { sim::_exit(1) }
}

mod sim {
    // Refs: https://github.com/rust-lang/rust/blob/1.90.0/src/doc/rustc/src/platform-support/sparc-unknown-none-elf.md

    use core::fmt;

    extern "C" {
        fn putchar(ch: i32);
        pub fn _exit(code: i32) -> !;
    }

    pub fn write_str(s: &str) {
        for &b in s.as_bytes() {
            unsafe { putchar(b as i32) }
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
