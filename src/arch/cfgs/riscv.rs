// SPDX-License-Identifier: Apache-2.0 OR MIT

#![allow(missing_docs)]

#[macro_export]
macro_rules! cfg_has_atomic_8 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_8 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_16 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_16 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_32 {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_32 {
    ($($tt:tt)*) => {};
}
#[cfg(target_arch = "riscv32")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(target_arch = "riscv32")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(target_arch = "riscv64", target_arch = "riscv128"))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(target_arch = "riscv64", target_arch = "riscv128"))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "riscv128")]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "riscv128")]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a"))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a")))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(target_feature = "a", atomic_maybe_uninit_target_feature = "a")))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
