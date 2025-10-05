// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]

include!("../../include/basic.rs");

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;

macro_rules! print {
    ($($tt:tt)*) => {{
        use core::fmt::Write as _;
        let _ = write!(sim::Console, $($tt)*);
    }};
}
macro_rules! println {
    ($($tt:tt)*) => {{
        use core::fmt::Write as _;
        let _ = writeln!(sim::Console, $($tt)*);
    }};
}

#[no_mangle]
extern "C" fn main() -> i32 {
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

    0
}

#[inline(never)]
#[panic_handler]
fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
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

    pub struct Console;
    impl fmt::Write for Console {
        fn write_str(&mut self, s: &str) -> fmt::Result {
            for &b in s.as_bytes() {
                unsafe { putchar(b as i32) }
            }
            Ok(())
        }
    }
}
