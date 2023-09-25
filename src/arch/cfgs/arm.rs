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
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass"))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
)))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    any(target_feature = "v7", atomic_maybe_uninit_target_feature = "v7"),
    not(any(target_feature = "mclass", atomic_maybe_uninit_target_feature = "mclass")),
)))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
