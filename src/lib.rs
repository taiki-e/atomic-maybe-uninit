/*!
Atomic operations on potentially uninitialized integers.

## Motivation

Copying types containing uninitialized bytes (e.g., padding), via the standard library's atomic types is [undefined behavior because the copy goes through integers][undefined-behavior].

This crate provides a way to soundly perform such operations.

## Platform Support

Currently, x86, x86_64, ARM (v6-m, v7+), AArch64, RISC-V, MIPS32r2, MIPS64r2, PowerPC, and s390x are supported.

| target_arch                       | primitives                                          | load/store | RMW   |
| --------------------------------- | --------------------------------------------------- |:----------:|:-----:|
| x86                               | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓     |
| x86_64                            | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓     |
| x86_64 (+cmpxchg16b)              | i128,u128                                           | ✓          | ✓     |
| arm (v6-m, v7+)                   | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1] |
| arm (v7-a)                        | i64,u64                                             | ✓          | ✓     |
| aarch64 \[2]                      | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓     |
| riscv32                           | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1] |
| riscv64                           | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓\[1] |
| mips \[3]                         | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓     |
| mips64 \[3]                       | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓     |
| powerpc \[3]                      | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓     |
| powerpc64 \[3]                    | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓     |
| powerpc64 (le or pwr8+) \[3] \[4] | i128,u128                                           | ✓          | ✓     |
| s390x \[3]                        | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓     |

\[1] ARM's atomic RMW operations are not available on v6-m (thumbv6m). RISC-V's atomic RMW operations are not available on targets without the A (or G) extension such as riscv32i, riscv32imc, etc.<br>
\[2] If target features such as `lse` and `lse2` are enabled at compile-time, more efficient instructions are used.<br>
\[3] Requires nightly due to `#![feature(asm_experimental_arch)]`.<br>
\[4] target-cpu `pwr8`, `pwr9`, or `pwr10`.<br>

Feel free to submit an issue if your target is not supported yet.

## Related Projects

- [portable-atomic]: Portable atomic types including support for 128-bit atomics, atomic float, etc.
- [atomic-memcpy]: Byte-wise atomic memcpy.

[atomic-memcpy]: https://github.com/taiki-e/atomic-memcpy
[portable-atomic]: https://github.com/taiki-e/portable-atomic
[undefined-behavior]: https://doc.rust-lang.org/reference/behavior-considered-undefined.html
*/

#![no_std]
#![doc(test(
    no_crate_inject,
    attr(
        deny(warnings, rust_2018_idioms, single_use_lifetimes),
        allow(dead_code, unused_variables)
    )
))]
#![warn(
    missing_debug_implementations,
    missing_docs,
    rust_2018_idioms,
    single_use_lifetimes,
    unreachable_pub,
    unsafe_op_in_unsafe_fn
)]
#![warn(
    clippy::default_union_representation,
    clippy::exhaustive_enums,
    clippy::exhaustive_structs,
    clippy::inline_asm_x86_att_syntax,
    clippy::missing_inline_in_public_items,
    clippy::pedantic,
    clippy::transmute_undefined_repr,
    clippy::undocumented_unsafe_blocks
)]
#![allow(
    clippy::doc_markdown,
    clippy::missing_errors_doc,
    clippy::module_inception,
    clippy::too_many_lines,
    clippy::type_complexity
)]
#![cfg_attr(
    not(any(
        target_arch = "x86",
        target_arch = "x86_64",
        target_arch = "arm",
        target_arch = "aarch64",
        target_arch = "riscv32",
        target_arch = "riscv64",
    )),
    feature(asm_experimental_arch)
)]

#[cfg(test)]
extern crate std;

#[macro_use]
mod utils;

#[cfg(test)]
#[macro_use]
mod tests;

mod arch;

pub mod raw;

#[cfg(doc)]
use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
use core::{
    cell::UnsafeCell,
    fmt,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap, Primitive};

/// A potentially uninitialized integer type which can be safely shared between threads.
///
/// This type has the same in-memory representation as the underlying
/// integer type, `MaybeUninit<T>`.
#[repr(C)]
pub struct AtomicMaybeUninit<T: Primitive> {
    v: UnsafeCell<MaybeUninit<T>>,
    /// `[T::Align; 0]` ensures alignment is at least that of `T::Align`.
    ///
    /// This is needed because x86's u64 is 4-byte aligned and x86_64's u128 is
    /// 8-byte aligned and atomic operations normally require alignment greater
    /// than or equal to the size.
    _align: [T::Align; 0],
}

impl<T: Primitive> From<MaybeUninit<T>> for AtomicMaybeUninit<T> {
    /// Creates a new atomic value from a potentially uninitialized integer.
    #[inline]
    fn from(v: MaybeUninit<T>) -> Self {
        Self::new(v)
    }
}

impl<T: Primitive> From<T> for AtomicMaybeUninit<T> {
    /// Creates a new atomic value from an initialized integer.
    #[inline]
    fn from(v: T) -> Self {
        Self::new(MaybeUninit::new(v))
    }
}

impl<T: Primitive> fmt::Debug for AtomicMaybeUninit<T> {
    #[allow(clippy::missing_inline_in_public_items)] // fmt is not hot path
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.pad(core::any::type_name::<Self>())
    }
}

// Send is implicitly implemented.
// SAFETY: `T` is `Sync` and any data races are prevented by atomic intrinsics.
unsafe impl<T: Primitive> Sync for AtomicMaybeUninit<T> {}

// UnwindSafe is implicitly implemented.
impl<T: Primitive> core::panic::RefUnwindSafe for AtomicMaybeUninit<T> {}

impl<T: Primitive> AtomicMaybeUninit<T> {
    /// Creates a new atomic value from a potentially uninitialized integer.
    ///
    /// This is `const fn` on Rust 1.61+. See also `const_new` function.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::mem::MaybeUninit;
    ///
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// let v = AtomicMaybeUninit::new(MaybeUninit::new(5_i32));
    ///
    /// // Equivalent to:
    /// let v = AtomicMaybeUninit::from(5_i32);
    /// ```
    #[cfg(not(atomic_maybe_uninit_no_const_fn_trait_bound))]
    #[inline]
    #[must_use]
    pub const fn new(v: MaybeUninit<T>) -> Self {
        Self { v: UnsafeCell::new(v), _align: [] }
    }

    /// Creates a new atomic value from a potentially uninitialized integer.
    ///
    /// This is `const fn` on Rust 1.61+. See also `const_new` function.
    #[cfg(atomic_maybe_uninit_no_const_fn_trait_bound)]
    #[inline]
    #[must_use]
    pub fn new(v: MaybeUninit<T>) -> Self {
        Self { v: UnsafeCell::new(v), _align: [] }
    }

    /// Returns a mutable reference to the underlying integer.
    ///
    /// This is safe because the mutable reference guarantees that no other threads are
    /// concurrently accessing the atomic data.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::mem::MaybeUninit;
    ///
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// let mut v = AtomicMaybeUninit::from(5_i32);
    /// unsafe { assert_eq!((*v.get_mut()).assume_init(), 5) }
    /// *v.get_mut() = MaybeUninit::new(10);
    /// unsafe { assert_eq!((*v.get_mut()).assume_init(), 10) }
    /// ```
    #[inline]
    pub fn get_mut(&mut self) -> &mut MaybeUninit<T> {
        self.v.get_mut()
    }

    /// Consumes the atomic and returns the contained value.
    ///
    /// This is safe because passing `self` by value guarantees that no other threads are
    /// concurrently accessing the atomic data.
    ///
    /// # Examples
    ///
    /// ```
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// let v = AtomicMaybeUninit::from(5_i32);
    /// unsafe { assert_eq!(v.into_inner().assume_init(), 5) }
    /// ```
    #[inline]
    pub fn into_inner(self) -> MaybeUninit<T> {
        self.v.into_inner()
    }

    /// Loads a value from the atomic integer.
    ///
    /// `load` takes an [`Ordering`] argument which describes the memory ordering of this operation.
    /// Possible values are [`SeqCst`], [`Acquire`] and [`Relaxed`].
    ///
    /// # Panics
    ///
    /// Panics if `order` is [`Release`] or [`AcqRel`].
    ///
    /// # Examples
    ///
    /// ```
    /// use std::sync::atomic::Ordering;
    ///
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// let v = AtomicMaybeUninit::from(5_i32);
    /// unsafe { assert_eq!(v.load(Ordering::Relaxed).assume_init(), 5) }
    /// ```
    #[inline]
    pub fn load(&self, order: Ordering) -> MaybeUninit<T>
    where
        T: AtomicLoad,
    {
        utils::assert_load_ordering(order);
        let mut out = MaybeUninit::<T>::uninit();
        // SAFETY: any data races are prevented by atomic intrinsics, the raw
        // pointer passed in is valid because we got it from a reference,
        // and we've checked the order is valid.
        unsafe { T::atomic_load(self.v.get(), &mut out, order) }
        out
    }

    /// Stores a value into the atomic integer.
    ///
    /// `store` takes an [`Ordering`] argument which describes the memory ordering of this operation.
    ///  Possible values are [`SeqCst`], [`Release`] and [`Relaxed`].
    ///
    /// # Panics
    ///
    /// Panics if `order` is [`Acquire`] or [`AcqRel`].
    ///
    /// # Examples
    ///
    /// ```
    /// use std::{mem::MaybeUninit, sync::atomic::Ordering};
    ///
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// let v = AtomicMaybeUninit::from(5_i32);
    /// v.store(MaybeUninit::new(10), Ordering::Relaxed);
    /// unsafe { assert_eq!(v.load(Ordering::Relaxed).assume_init(), 10) }
    /// ```
    #[inline]
    pub fn store(&self, val: MaybeUninit<T>, order: Ordering)
    where
        T: AtomicStore,
    {
        utils::assert_store_ordering(order);
        // SAFETY: any data races are prevented by atomic intrinsics, the raw
        // pointer passed in is valid because we got it from a reference,
        // and we've checked the order is valid.
        unsafe { T::atomic_store(self.v.get(), &val, order) }
    }

    /// Stores a value into the atomic integer, returning the previous value.
    ///
    /// `swap` takes an [`Ordering`] argument which describes the memory ordering
    /// of this operation. All ordering modes are possible. Note that using
    /// [`Acquire`] makes the store part of this operation [`Relaxed`], and
    /// using [`Release`] makes the load part [`Relaxed`].
    ///
    /// # Examples
    ///
    /// ```
    /// use std::{mem::MaybeUninit, sync::atomic::Ordering};
    ///
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// let v = AtomicMaybeUninit::from(5_i32);
    /// unsafe {
    ///     assert_eq!(v.swap(MaybeUninit::new(10), Ordering::Relaxed).assume_init(), 5);
    ///     assert_eq!(v.load(Ordering::Relaxed).assume_init(), 10);
    /// }
    /// ```
    #[inline]
    pub fn swap(&self, val: MaybeUninit<T>, order: Ordering) -> MaybeUninit<T>
    where
        T: AtomicSwap,
    {
        utils::assert_swap_ordering(order);
        let mut out = MaybeUninit::<T>::uninit();
        // SAFETY: any data races are prevented by atomic intrinsics and the raw
        // pointer passed in is valid because we got it from a reference.
        unsafe { T::atomic_swap(self.v.get(), &val, &mut out, order) }
        out
    }

    /// Stores a value into the atomic integer if the current value is the same as
    /// the `current` value.
    ///
    /// The return value is a result indicating whether the new value was written and
    /// containing the previous value. On success this value is guaranteed to be equal to
    /// `current`.
    ///
    /// `compare_exchange` takes two [`Ordering`] arguments to describe the memory
    /// ordering of this operation. `success` describes the required ordering for the
    /// read-modify-write operation that takes place if the comparison with `current` succeeds.
    /// `failure` describes the required ordering for the load operation that takes place when
    /// the comparison fails. Using [`Acquire`] as success ordering makes the store part
    /// of this operation [`Relaxed`], and using [`Release`] makes the successful load
    /// [`Relaxed`]. The failure ordering can only be [`SeqCst`], [`Acquire`] or [`Relaxed`].
    ///
    /// # Panics
    ///
    /// Panics if `failure` is [`Release`], [`AcqRel`].
    ///
    /// # Notes
    ///
    /// Comparison of two values containing uninitialized bytes may fail even if
    /// they are equivalent as Rust's type, because their contents are not frozen
    /// until a pointer to the value containing uninitialized bytes is passed to `asm!`.
    ///
    /// For example, the following example could be an infinite loop:
    ///
    /// ```no_run
    /// use std::{
    ///     mem::{self, MaybeUninit},
    ///     sync::atomic::Ordering,
    /// };
    ///
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// #[derive(Clone, Copy, PartialEq, Eq)]
    /// #[repr(C, align(4))]
    /// struct Test(u8, u16);
    ///
    /// unsafe {
    ///     let x = mem::transmute::<_, MaybeUninit<u32>>(Test(0, 0));
    ///     let v = AtomicMaybeUninit::new(x);
    ///     while v
    ///         .compare_exchange(
    ///             mem::transmute::<_, MaybeUninit<u32>>(Test(0, 0)),
    ///             mem::transmute::<_, MaybeUninit<u32>>(Test(1, 0)),
    ///             Ordering::AcqRel,
    ///             Ordering::Acquire,
    ///         )
    ///         .is_err()
    ///     {}
    /// }
    /// ```
    ///
    /// To work around this problem, you need to use a helper like the following.
    ///
    /// ```
    /// # if cfg!(valgrind) { return; }
    /// # use std::{
    /// #     mem::{self, MaybeUninit},
    /// #     sync::atomic::Ordering,
    /// # };
    /// # use atomic_maybe_uninit::AtomicMaybeUninit;
    /// # #[derive(Clone, Copy, PartialEq, Eq)]
    /// # #[repr(C, align(4))]
    /// # struct Test(u8, u16);
    /// // Adapted from https://github.com/crossbeam-rs/crossbeam/blob/crossbeam-utils-0.8.10/crossbeam-utils/src/atomic/atomic_cell.rs#L1081-L1110
    /// unsafe fn atomic_compare_exchange(
    ///     v: &AtomicMaybeUninit<u32>,
    ///     mut current: Test,
    ///     new: Test,
    /// ) -> Result<Test, Test> {
    ///     let mut current_raw = mem::transmute::<_, MaybeUninit<u32>>(current);
    ///     let new_raw = mem::transmute::<_, MaybeUninit<u32>>(new);
    ///     loop {
    ///         match v.compare_exchange_weak(current_raw, new_raw, Ordering::AcqRel, Ordering::Acquire)
    ///         {
    ///             Ok(_) => break Ok(current),
    ///             Err(previous_raw) => {
    ///                 let previous = mem::transmute_copy(&previous_raw);
    ///
    ///                 if !Test::eq(&previous, &current) {
    ///                     break Err(previous);
    ///                 }
    ///
    ///                 // The compare-exchange operation has failed and didn't store `new`. The
    ///                 // failure is either spurious, or `previous` was semantically equal to
    ///                 // `current` but not byte-equal. Let's retry with `previous` as the new
    ///                 // `current`.
    ///                 current = previous;
    ///                 current_raw = previous_raw;
    ///             }
    ///         }
    ///     }
    /// }
    ///
    /// unsafe {
    ///     let x = mem::transmute::<_, MaybeUninit<u32>>(Test(0, 0));
    ///     let v = AtomicMaybeUninit::new(x);
    ///     while atomic_compare_exchange(&v, Test(0, 0), Test(1, 0)).is_err() {}
    /// }
    /// ```
    ///
    /// See [crossbeam-rs/crossbeam#315](https://github.com/crossbeam-rs/crossbeam/issues/315) for more details.
    ///
    /// Also, Valgrind reports "Conditional jump or move depends on uninitialized value(s)"
    /// error if there is such comparison.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::{mem::MaybeUninit, sync::atomic::Ordering};
    ///
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// unsafe {
    ///     let v = AtomicMaybeUninit::from(5_i32);
    ///
    ///     assert_eq!(
    ///         v.compare_exchange(
    ///             MaybeUninit::new(5),
    ///             MaybeUninit::new(10),
    ///             Ordering::Acquire,
    ///             Ordering::Relaxed
    ///         )
    ///         .unwrap()
    ///         .assume_init(),
    ///         5
    ///     );
    ///     assert_eq!(v.load(Ordering::Relaxed).assume_init(), 10);
    ///
    ///     assert_eq!(
    ///         v.compare_exchange(
    ///             MaybeUninit::new(6),
    ///             MaybeUninit::new(12),
    ///             Ordering::SeqCst,
    ///             Ordering::Acquire
    ///         )
    ///         .unwrap_err()
    ///         .assume_init(),
    ///         10
    ///     );
    ///     assert_eq!(v.load(Ordering::Relaxed).assume_init(), 10);
    /// }
    /// ```
    #[inline]
    pub fn compare_exchange(
        &self,
        current: MaybeUninit<T>,
        new: MaybeUninit<T>,
        success: Ordering,
        failure: Ordering,
    ) -> Result<MaybeUninit<T>, MaybeUninit<T>>
    where
        T: AtomicCompareExchange,
    {
        utils::assert_compare_exchange_ordering(success, failure);
        let mut out = MaybeUninit::<T>::uninit();
        // SAFETY: any data races are prevented by atomic intrinsics and the raw
        // pointer passed in is valid because we got it from a reference.
        let res = unsafe {
            T::atomic_compare_exchange(self.v.get(), &current, &new, &mut out, success, failure)
        };
        if res {
            Ok(out)
        } else {
            Err(out)
        }
    }

    /// Stores a value into the atomic integer if the current value is the same as
    /// the `current` value.
    ///
    /// This function is allowed to spuriously fail even when the comparison succeeds,
    /// which can result in more efficient code on some platforms. The return value
    /// is a result indicating whether the new value was written and containing
    /// the previous value.
    ///
    /// `compare_exchange_weak` takes two [`Ordering`] arguments to describe the memory
    /// ordering of this operation. `success` describes the required ordering for the
    /// read-modify-write operation that takes place if the comparison with `current` succeeds.
    /// `failure` describes the required ordering for the load operation that takes place when
    /// the comparison fails. Using [`Acquire`] as success ordering makes the store part
    /// of this operation [`Relaxed`], and using [`Release`] makes the successful load
    /// [`Relaxed`]. The failure ordering can only be [`SeqCst`], [`Acquire`] or [`Relaxed`].
    ///
    /// # Panics
    ///
    /// Panics if `failure` is [`Release`], [`AcqRel`].
    ///
    /// # Notes
    ///
    /// Comparison of two values containing uninitialized bytes may fail even if
    /// they are equivalent as Rust's type, because their contents are not frozen
    /// until a pointer to the value containing uninitialized bytes is passed to `asm!`.
    ///
    /// See [`compare_exchange`](Self::compare_exchange) for details.
    ///
    /// # Examples
    ///
    /// ```
    /// use std::{mem::MaybeUninit, sync::atomic::Ordering};
    ///
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// let v = AtomicMaybeUninit::from(5_i32);
    ///
    /// unsafe {
    ///     let mut old = v.load(Ordering::Relaxed);
    ///     loop {
    ///         let new = old.assume_init() * 2;
    ///         match v.compare_exchange_weak(
    ///             old,
    ///             MaybeUninit::new(new),
    ///             Ordering::SeqCst,
    ///             Ordering::Relaxed,
    ///         ) {
    ///             Ok(_) => break,
    ///             Err(x) => old = x,
    ///         }
    ///     }
    /// }
    /// ```
    #[inline]
    pub fn compare_exchange_weak(
        &self,
        current: MaybeUninit<T>,
        new: MaybeUninit<T>,
        success: Ordering,
        failure: Ordering,
    ) -> Result<MaybeUninit<T>, MaybeUninit<T>>
    where
        T: AtomicCompareExchange,
    {
        utils::assert_compare_exchange_ordering(success, failure);
        let mut out = MaybeUninit::<T>::uninit();
        // SAFETY: any data races are prevented by atomic intrinsics and the raw
        // pointer passed in is valid because we got it from a reference.
        let res = unsafe {
            T::atomic_compare_exchange_weak(
                self.v.get(),
                &current,
                &new,
                &mut out,
                success,
                failure,
            )
        };
        if res {
            Ok(out)
        } else {
            Err(out)
        }
    }

    /// Fetches the value, and applies a function to it that returns an optional
    /// new value. Returns a `Result` of `Ok(previous_value)` if the function returned `Some(_)`, else
    /// `Err(previous_value)`.
    ///
    /// Note: This may call the function multiple times if the value has been changed from other threads in
    /// the meantime, as long as the function returns `Some(_)`, but the function will have been applied
    /// only once to the stored value.
    ///
    /// `fetch_update` takes two [`Ordering`] arguments to describe the memory ordering of this operation.
    /// The first describes the required ordering for when the operation finally succeeds while the second
    /// describes the required ordering for loads. These correspond to the success and failure orderings of
    /// [`compare_exchange`](Self::compare_exchange) respectively.
    ///
    /// Using [`Acquire`] as success ordering makes the store part
    /// of this operation [`Relaxed`], and using [`Release`] makes the final successful load
    /// [`Relaxed`]. The (failed) load ordering can only be [`SeqCst`], [`Acquire`] or [`Relaxed`].
    ///
    /// # Panics
    ///
    /// Panics if `fetch_order` is [`Release`], [`AcqRel`].
    ///
    /// # Examples
    ///
    /// ```
    /// use std::{mem::MaybeUninit, sync::atomic::Ordering};
    ///
    /// use atomic_maybe_uninit::AtomicMaybeUninit;
    ///
    /// unsafe {
    ///     let v = AtomicMaybeUninit::from(5_i32);
    ///     assert_eq!(
    ///         v.fetch_update(Ordering::SeqCst, Ordering::SeqCst, |_| None).unwrap_err().assume_init(),
    ///         5
    ///     );
    ///     assert_eq!(
    ///         v.fetch_update(Ordering::SeqCst, Ordering::SeqCst, |x| Some(MaybeUninit::new(
    ///             x.assume_init() + 1
    ///         )))
    ///         .unwrap()
    ///         .assume_init(),
    ///         5
    ///     );
    ///     assert_eq!(v.load(Ordering::SeqCst).assume_init(), 6);
    /// }
    /// ```
    #[inline]
    pub fn fetch_update<F>(
        &self,
        set_order: Ordering,
        fetch_order: Ordering,
        mut f: F,
    ) -> Result<MaybeUninit<T>, MaybeUninit<T>>
    where
        F: FnMut(MaybeUninit<T>) -> Option<MaybeUninit<T>>,
        T: AtomicCompareExchange,
    {
        let mut prev = self.load(fetch_order);
        while let Some(next) = f(prev) {
            match self.compare_exchange_weak(prev, next, set_order, fetch_order) {
                x @ Ok(_) => return x,
                Err(next_prev) => prev = next_prev,
            }
        }
        Err(prev)
    }
}

macro_rules! int {
    ($ty:ident, $align:ident) => {
        impl crate::raw::Primitive for $ty {}
        impl crate::private::PrimitivePriv for $ty {
            type Align = crate::private::$align;
        }
        impl AtomicMaybeUninit<$ty> {
            /// Creates a new atomic value from a potentially uninitialized integer.
            /// Unlike [`new`](Self::new), this is always `const fn`.
            #[inline]
            #[must_use]
            pub const fn const_new(v: MaybeUninit<$ty>) -> Self {
                Self { v: UnsafeCell::new(v), _align: [] }
            }
        }
        static_assert!(mem::size_of::<AtomicMaybeUninit<$ty>>() == mem::size_of::<$ty>());
        static_assert!(mem::align_of::<AtomicMaybeUninit<$ty>>() == mem::size_of::<$ty>());
    };
}
int!(i8, Align1);
int!(u8, Align1);
int!(i16, Align2);
int!(u16, Align2);
int!(i32, Align4);
int!(u32, Align4);
int!(i64, Align8);
int!(u64, Align8);
int!(i128, Align16);
int!(u128, Align16);
int!(isize, AlignPtr);
int!(usize, AlignPtr);

mod private {
    use core::panic::{RefUnwindSafe, UnwindSafe};

    // Auto traits is needed to better docs.
    pub trait PrimitivePriv: Copy + Send + Sync + Unpin + UnwindSafe + RefUnwindSafe {
        // See _align field of AtomicMaybeUninit.
        type Align: Send + Sync + Unpin + UnwindSafe + RefUnwindSafe;
    }

    #[allow(missing_debug_implementations)]
    #[repr(align(1))]
    pub struct Align1(u8);
    #[allow(missing_debug_implementations)]
    #[repr(align(2))]
    pub struct Align2(u16);
    #[allow(missing_debug_implementations)]
    #[repr(align(4))]
    pub struct Align4(u32);
    #[allow(missing_debug_implementations)]
    #[repr(align(8))]
    pub struct Align8(u64);
    #[allow(missing_debug_implementations)]
    #[repr(align(16))]
    pub struct Align16(u128);
    #[cfg(target_pointer_width = "16")]
    pub(crate) type AlignPtr = Align2;
    #[cfg(target_pointer_width = "32")]
    pub(crate) type AlignPtr = Align4;
    #[cfg(target_pointer_width = "64")]
    pub(crate) type AlignPtr = Align8;
    #[cfg(target_pointer_width = "128")]
    pub(crate) type AlignPtr = Align16;
}
