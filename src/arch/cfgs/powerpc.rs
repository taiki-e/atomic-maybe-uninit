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
#[cfg(target_arch = "powerpc")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(target_arch = "powerpc")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "powerpc64")]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(target_arch = "powerpc64")]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ),
)))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    target_arch = "powerpc64",
    any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ),
)))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "powerpc64",
    any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ),
))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "powerpc64",
    any(
        target_feature = "quadword-atomics",
        atomic_maybe_uninit_target_feature = "quadword-atomics",
    ),
))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => {};
}
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
