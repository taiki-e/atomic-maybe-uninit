// SPDX-License-Identifier: Apache-2.0 OR MIT

#![allow(
    clippy::alloc_instead_of_core,
    clippy::std_instead_of_alloc,
    clippy::std_instead_of_core,
    clippy::undocumented_unsafe_blocks,
    clippy::wildcard_imports
)]

#[macro_use]
pub(crate) mod helper;

use crate::*;

test_common!(isize);
test_common!(usize);
cfg_has_atomic_ptr! {
    test_atomic!(isize);
    test_atomic!(usize);
}
test_common!(i8);
test_common!(u8);
cfg_has_atomic_8! {
    test_atomic!(i8);
    test_atomic!(u8);
    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
}
test_common!(i16);
test_common!(u16);
cfg_has_atomic_16! {
    test_atomic!(i16);
    test_atomic!(u16);
    stress_test!(u16);
}
test_common!(i32);
test_common!(u32);
cfg_has_atomic_32! {
    test_atomic!(i32);
    test_atomic!(u32);
    stress_test!(u32);
}
test_common!(i64);
test_common!(u64);
cfg_has_atomic_64! {
    test_atomic!(i64);
    test_atomic!(u64);
    stress_test!(u64);
}
test_common!(i128);
test_common!(u128);
cfg_has_atomic_128! {
    test_atomic!(i128);
    test_atomic!(u128);
    stress_test!(u128);
}
