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
#[cfg(any(
    all(
        target_arch = "riscv32",
        any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
    ),
    target_arch = "riscv64",
))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    all(
        target_arch = "riscv32",
        any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
    ),
    target_arch = "riscv64",
))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    all(
        target_arch = "riscv32",
        any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
    ),
    target_arch = "riscv64",
)))]
#[macro_export]
macro_rules! cfg_has_atomic_64 {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    all(
        target_arch = "riscv32",
        any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
    ),
    target_arch = "riscv64",
)))]
#[macro_export]
macro_rules! cfg_no_atomic_64 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "riscv64",
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(all(
    target_arch = "riscv64",
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    target_arch = "riscv64",
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
#[macro_export]
macro_rules! cfg_has_atomic_128 {
    ($($tt:tt)*) => {};
}
#[cfg(not(all(
    target_arch = "riscv64",
    any(target_feature = "zacas", atomic_maybe_uninit_target_feature = "zacas"),
)))]
#[macro_export]
macro_rules! cfg_no_atomic_128 {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
#[cfg(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
)))]
#[macro_export]
macro_rules! cfg_has_atomic_cas {
    ($($tt:tt)*) => {};
}
#[cfg(not(any(
    target_feature = "a",
    atomic_maybe_uninit_target_feature = "a",
    target_feature = "zalrsc",
    atomic_maybe_uninit_target_feature = "zalrsc",
)))]
#[macro_export]
macro_rules! cfg_no_atomic_cas {
    ($($tt:tt)*) => { $($tt)* };
}
