// SPDX-License-Identifier: Apache-2.0 OR MIT

#![no_main]
#![no_std]
#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]

include!("../../include/basic.rs");

use core::{mem::MaybeUninit, sync::atomic::Ordering};

use arduino_hal::avr_device;
use atomic_maybe_uninit::*;

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

    test_atomic!(isize);
    test_atomic!(usize);
    test_atomic!(i8);
    test_atomic!(u8);
    test_atomic!(i16);
    test_atomic!(u16);

    println!("Tests finished successfully");

    sim::exit(0)
}

#[inline(never)]
#[panic_handler]
fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
    avr_device::interrupt::disable();

    let dp = unsafe { arduino_hal::Peripherals::steal() };
    let pins = arduino_hal::pins!(dp);
    let mut serial = sim::Usart(arduino_hal::default_serial!(dp, pins, 57600));

    macro_rules! println {
        ($($tt:tt)*) => {{
            use core::fmt::Write as _;
            let _ = writeln!(serial, $($tt)*);
        }};
    }

    println!("{info}");
    sim::exit(1)
}

mod sim {
    use core::fmt;

    use arduino_hal::avr_device;

    pub fn exit(_code: u32) -> ! {
        // Note that there is no way to exit simavr with a non-zero exit code.
        // https://github.com/buserror/simavr/issues/362
        avr_device::interrupt::disable();
        avr_device::asm::sleep();
        #[allow(clippy::empty_loop)] // this test crate is #![no_std]
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
