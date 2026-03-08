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

    macro_rules! print_str {
        ($($tt:tt)*) => {{
            sim::write_str(&mut serial, $($tt)*);
        }};
    }

    test_atomic_all!();

    print_str!("Tests finished successfully\n");

    sim::exit(0)
}

#[inline(never)]
#[panic_handler]
fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
    avr_device::interrupt::disable();

    let dp = unsafe { arduino_hal::Peripherals::steal() };
    let pins = arduino_hal::pins!(dp);
    let mut serial = sim::Usart(arduino_hal::default_serial!(dp, pins, 57600));

    #[cfg(debug_assertions)]
    {
        let _ = info;
        sim::write_str(&mut serial.0, "panicked\n");
    }
    #[cfg(not(debug_assertions))]
    {
        macro_rules! println {
            ($($tt:tt)*) => {{
                use core::fmt::Write as _;
                let _ = writeln!(serial, $($tt)*);
            }};
        }
        println!("{info}");
    }
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

    pub fn write_str<USART, RX, TX>(usart: &mut arduino_hal::usart::Usart<USART, RX, TX>, s: &str)
    where
        USART: arduino_hal::usart::UsartOps<arduino_hal::hal::Atmega, RX, TX>,
    {
        for b in s.bytes() {
            usart.write_byte(b);
        }
    }
    #[repr(transparent)]
    pub struct Usart<USART, RX, TX>(pub arduino_hal::usart::Usart<USART, RX, TX>)
    where
        USART: arduino_hal::usart::UsartOps<arduino_hal::hal::Atmega, RX, TX>;
    impl<USART, RX, TX> fmt::Write for Usart<USART, RX, TX>
    where
        USART: arduino_hal::usart::UsartOps<arduino_hal::hal::Atmega, RX, TX>,
    {
        fn write_str(&mut self, s: &str) -> fmt::Result {
            write_str(&mut self.0, s);
            Ok(())
        }
    }
}
