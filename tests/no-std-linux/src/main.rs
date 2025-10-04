// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]

include!("../../include/basic.rs");

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use atomic_maybe_uninit::*;

#[no_mangle]
extern "C" fn main() {
    macro_rules! test_atomic {
        ($ty:ident) => {
            paste::paste! {
                fn [<test_atomic_ $ty>]() {
                    __test_atomic!($ty);
                }
                unsafe {
                    libc::puts(concat!("test test_atomic_", stringify!($ty), " ... \0") as *const str as *const i8);
                }
                [<test_atomic_ $ty>]();
                unsafe {
                    libc::puts("ok\0" as *const str as *const i8);
                }
            }
        };
    }

    cfg_has_atomic_cas! {
        unsafe {
            libc::puts("target_has_cas: true\0" as *const str as *const i8);
        }
    }
    cfg_no_atomic_cas! {
        unsafe {
            libc::puts("target_has_cas: false\0" as *const str as *const i8);
        }
    }
    #[cfg(feature = "isize")]
    test_atomic!(isize);
    #[cfg(feature = "usize")]
    test_atomic!(usize);
    #[cfg(feature = "i8")]
    test_atomic!(i8);
    #[cfg(feature = "u8")]
    test_atomic!(u8);
    #[cfg(feature = "i16")]
    test_atomic!(i16);
    #[cfg(feature = "u16")]
    test_atomic!(u16);
    #[cfg(feature = "i32")]
    test_atomic!(i32);
    #[cfg(feature = "u32")]
    test_atomic!(u32);
    cfg_has_atomic_64! {
        #[cfg(feature = "i64")]
        test_atomic!(i64);
        #[cfg(feature = "u64")]
        test_atomic!(u64);
    }

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
