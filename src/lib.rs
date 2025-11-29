// SPDX-License-Identifier: Apache-2.0 OR MIT

/*!
<!-- Note: Document from sync-markdown-to-rustdoc:start through sync-markdown-to-rustdoc:end
     is synchronized from README.md. Any changes to that range are not preserved. -->
<!-- tidy:sync-markdown-to-rustdoc:start -->

Atomic operations on potentially uninitialized integers.

## Motivation

Copying types containing uninitialized bytes (e.g., padding), via the standard library's atomic types
is [undefined behavior because the copy goes through integers][undefined-behavior].

This crate provides a way to soundly perform such operations.

## Platform Support

Currently, x86, x86_64, Arm, AArch64, RISC-V, LoongArch, Arm64EC, s390x, MIPS, PowerPC, MSP430, AVR, SPARC, Hexagon, M68k, C-SKY, and Xtensa are supported.
(You can use `cfg_{has,no}_*` macros to write code based on whether or not which size of primitives is available.)

| target_arch                                 | primitives                                          | load/store | swap/CAS |
| ------------------------------------------- | --------------------------------------------------- |:----------:|:--------:|
| x86                                         | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| x86_64                                      | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| x86_64 (+cmpxchg16b) \[2]                   | i128,u128                                           | ✓          | ✓        |
| arm (v6+ or Linux/Android)                  | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |
| arm (except for M-profile) \[3]             | i64,u64                                             | ✓          | ✓        |
| aarch64                                     | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓        |
| riscv32                                     | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |
| riscv32 (+zacas) \[4]                       | i64,u64                                             | ✓          | ✓        |
| riscv64                                     | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓\[1]    |
| riscv64 (+zacas) \[4]                       | i128,u128                                           | ✓          | ✓        |
| loongarch64                                 | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| loongarch32 \[8] (experimental)             | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓        |
| arm64ec \[7]                                | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓        |
| s390x \[7]                                  | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓          | ✓        |
| mips / mips32r6 \[9]                        | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓        |
| mips64 / mips64r6 \[9]                      | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| powerpc \[9]                                | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓        |
| powerpc64 \[9]                              | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| powerpc64 (+quadword-atomics) \[5] \[9]     | i128,u128                                           | ✓          | ✓        |
| msp430 \[9] (experimental)                  | isize,usize,i8,u8,i16,u16                           | ✓          | ✓        |
| avr \[9] (experimental)                     | isize,usize,i8,u8,i16,u16                           | ✓          | ✓        |
| sparc \[6] \[9] (experimental)              | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓        |
| sparc64 \[9] (experimental)                 | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| hexagon \[9] (experimental)                 | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓          | ✓        |
| m68k \[9] (experimental)                    | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |
| m68k (+isa-68020) \[9] \[10] (experimental) | i64,u64                                             | ✓          | ✓        |
| csky \[9] (experimental)                    | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |
| xtensa \[9] (experimental)                  | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓          | ✓\[1]    |

\[1] Arm's atomic RMW operations are not available on Armv6-M (thumbv6m). RISC-V's atomic RMW operations are not available on targets without the A (or G which means IMAFD) or Zalrsc or Zacas extension, such as riscv32i, riscv32imc, etc. M68k's atomic RMW operations requires target-cpu M68020+ (enabled by default on Linux). C-SKY's atomic RMW operations requires target-cpu ck860\* or c860\* (enabled by default on the hard-float target). Xtensa's atomic RMW operations are not available on esp32s2.<br>
\[2] Requires `cmpxchg16b` target feature (enabled by default on Apple, Windows (except Windows 7), and Fuchsia targets).<br>
\[3] Armv6+ or Linux/Android, except for M-profile architecture such as thumbv6m, thumbv7m, etc.<br>
\[4] Requires `zacas` target feature.<br>
\[5] Requires `quadword-atomics` target feature (enabled by default on powerpc64le).<br>
\[6] Requires `v9` or `leoncasa` target feature (enabled by default on Linux).<br>
\[7] Requires Rust 1.84+.<br>
\[8] Requires Rust 1.91+.<br>
\[9] Requires nightly due to `#![feature(asm_experimental_arch)]`.<br>
\[10] Requires target-cpu M68020+ (enabled by default on Linux).<br>

See also [Atomic operation overview by architecture](https://github.com/taiki-e/atomic-maybe-uninit/blob/HEAD/src/arch/README.md)
for more information about atomic operations in these architectures.

Feel free to submit an issue if your target is not supported yet.

## Related Projects

- [portable-atomic]: Portable atomic types including support for 128-bit atomics, atomic float, etc.
- [atomic-memcpy]: Byte-wise atomic memcpy.

[atomic-memcpy]: https://github.com/taiki-e/atomic-memcpy
[portable-atomic]: https://github.com/taiki-e/portable-atomic
[undefined-behavior]: https://doc.rust-lang.org/reference/behavior-considered-undefined.html

<!-- tidy:sync-markdown-to-rustdoc:end -->
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
    // Lints that may help when writing public library.
    missing_debug_implementations,
    missing_docs,
    clippy::alloc_instead_of_core,
    clippy::exhaustive_enums,
    clippy::exhaustive_structs,
    clippy::impl_trait_in_params,
    clippy::missing_inline_in_public_items,
    clippy::std_instead_of_alloc,
    clippy::std_instead_of_core,
    // Code outside of cfg(test) shouldn't use float.
    clippy::float_arithmetic,
    // Code outside of cfg(test) shouldn't use code that can panic except for assertions. (overflow also cause panic if overflow check is enabled)
    clippy::arithmetic_side_effects,
)]
#![cfg_attr(atomic_maybe_uninit_no_strict_provenance, allow(unstable_name_collisions))]
#![allow(clippy::inline_always)]
#![cfg_attr(atomic_maybe_uninit_unstable_asm_experimental_arch, feature(asm_experimental_arch))]

// There are currently no 128-bit or higher builtin targets.
// (Although some of our generic code is written with the future
// addition of 128-bit targets in mind.)
// Note that Rust (and C99) pointers must be at least 16-bit (i.e., 8-bit targets are impossible): https://github.com/rust-lang/rust/pull/49305
#[cfg(not(any(
    target_pointer_width = "16",
    target_pointer_width = "32",
    target_pointer_width = "64",
)))]
compile_error!(
    "atomic-maybe-uninit currently only supports targets with {16,32,64}-bit pointer width; \
     if you need support for others, \
     please submit an issue at <https://github.com/taiki-e/atomic-maybe-uninit>"
);

#[cfg(test)]
extern crate std;

#[macro_use]
mod utils;

#[cfg(test)]
#[macro_use]
mod tests;

pub mod raw;

#[cfg(doc)]
use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
use core::{
    cell::UnsafeCell,
    fmt,
    mem::{self, MaybeUninit},
    sync::atomic::Ordering,
};

use self::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap, Primitive};

// -----------------------------------------------------------------------------
// AtomicMaybeUninit

/// A potentially uninitialized integer type which can be safely shared between threads.
///
/// This type has the same in-memory representation as the underlying
/// value type, `MaybeUninit<T>`.
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
    /// Creates a new atomic value from a potentially uninitialized value.
    #[inline]
    fn from(v: MaybeUninit<T>) -> Self {
        Self::new(v)
    }
}

impl<T: Primitive> From<T> for AtomicMaybeUninit<T> {
    /// Creates a new atomic value from an initialized value.
    #[inline]
    fn from(v: T) -> Self {
        Self::new(MaybeUninit::new(v))
    }
}

impl<T: Primitive> fmt::Debug for AtomicMaybeUninit<T> {
    #[inline] // fmt is not hot path, but #[inline] on fmt seems to still be useful: https://github.com/rust-lang/rust/pull/117727
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(core::any::type_name::<Self>())
    }
}

// Send is implicitly implemented.
// SAFETY: `T` is `Send` and any data races are prevented by atomic intrinsics.
unsafe impl<T: Primitive> Sync for AtomicMaybeUninit<T> {}

// UnwindSafe is implicitly implemented.
impl<T: Primitive> core::panic::RefUnwindSafe for AtomicMaybeUninit<T> {}

impl<T: Primitive> AtomicMaybeUninit<T> {
    /// Creates a new atomic value from a potentially uninitialized value.
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
    #[inline]
    #[must_use]
    pub const fn new(v: MaybeUninit<T>) -> Self {
        Self { v: UnsafeCell::new(v), _align: [] }
    }

    // TODO: update docs based on https://github.com/rust-lang/rust/pull/116762
    const_fn! {
        const_if: #[cfg(not(atomic_maybe_uninit_no_const_mut_refs))];
        /// Creates a new reference to an atomic value from a pointer.
        ///
        /// This is `const fn` on Rust 1.83+.
        ///
        /// # Safety
        ///
        /// * `ptr` must be aligned to `align_of::<AtomicMaybeUninit<T>>()` (note that on some platforms this
        ///   can be bigger than `align_of::<MaybeUninit<T>>()`).
        /// * `ptr` must be [valid] for both reads and writes for the whole lifetime `'a`.
        /// * Non-atomic accesses to the value behind `ptr` must have a happens-before
        ///   relationship with atomic accesses via the returned value (or vice-versa).
        ///   * In other words, time periods where the value is accessed atomically may not
        ///     overlap with periods where the value is accessed non-atomically.
        ///   * This requirement is trivially satisfied if `ptr` is never used non-atomically
        ///     for the duration of lifetime `'a`. Most use cases should be able to follow
        ///     this guideline.
        ///   * This requirement is also trivially satisfied if all accesses (atomic or not) are
        ///     done from the same thread.
        /// * This method must not be used to create overlapping or mixed-size atomic
        ///   accesses, as these are not supported by the memory model.
        ///
        /// [valid]: core::ptr#safety
        #[inline]
        #[must_use]
        pub const unsafe fn from_ptr<'a>(ptr: *mut MaybeUninit<T>) -> &'a Self {
            // SAFETY: guaranteed by the caller
            unsafe { &*ptr.cast::<Self>() }
        }
    }

    const_fn! {
        const_if: #[cfg(not(atomic_maybe_uninit_no_const_mut_refs))];
        /// Returns a mutable reference to the underlying value.
        ///
        /// This is safe because the mutable reference guarantees that no other threads are
        /// concurrently accessing the atomic data.
        ///
        /// This is `const fn` on Rust 1.83+.
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
        pub const fn get_mut(&mut self) -> &mut MaybeUninit<T> {
            // SAFETY: the mutable reference guarantees unique ownership.
            // (core::cell::UnsafeCell::get_mut requires newer nightly)
            unsafe { &mut *self.as_ptr() }
        }
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
    pub const fn into_inner(self) -> MaybeUninit<T> {
        // SAFETY: AtomicMaybeUninit<T> and MaybeUninit<T> have the same size
        // and in-memory representations, so they can be safely transmuted.
        // (Equivalent to UnsafeCell::into_inner which is unstable in const context.)
        unsafe { utils::transmute_copy_by_val::<Self, MaybeUninit<T>>(self) }
    }

    /// Loads a value from the atomic value.
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
    #[cfg_attr(debug_assertions, track_caller)]
    pub fn load(&self, order: Ordering) -> MaybeUninit<T>
    where
        T: AtomicLoad,
    {
        utils::assert_load_ordering(order);
        // SAFETY: any data races are prevented by atomic intrinsics, the raw
        // pointer passed in is valid because we got it from a reference,
        // and we've checked the order is valid. Alignment is upheld because
        // `PrimitivePriv`'s safety requirement ensures sufficient alignment
        // of `T::Align`, and we got our `_align` field.
        unsafe { T::atomic_load(self.v.get(), order) }
    }

    /// Stores a value into the atomic value.
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
    #[cfg_attr(debug_assertions, track_caller)]
    pub fn store(&self, val: MaybeUninit<T>, order: Ordering)
    where
        T: AtomicStore,
    {
        utils::assert_store_ordering(order);
        // Workaround LLVM pre-20 bug: https://github.com/rust-lang/rust/issues/129585#issuecomment-2360273081
        #[cfg(atomic_maybe_uninit_pre_llvm_20)]
        let val = core::hint::black_box(val);
        // SAFETY: any data races are prevented by atomic intrinsics, the raw
        // pointer passed in is valid because we got it from a reference,
        // and we've checked the order is valid. Alignment is upheld because
        // `PrimitivePriv`'s safety requirement ensures sufficient alignment
        // of `T::Align`, and we got our `_align` field.
        unsafe { T::atomic_store(self.v.get(), val, order) }
    }

    /// Stores a value into the atomic value, returning the previous value.
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
        // Workaround LLVM pre-20 bug: https://github.com/rust-lang/rust/issues/129585#issuecomment-2360273081
        #[cfg(atomic_maybe_uninit_pre_llvm_20)]
        let val = core::hint::black_box(val);
        // SAFETY: any data races are prevented by atomic intrinsics and the raw
        // pointer passed in is valid because we got it from a reference.
        // Alignment is upheld because `PrimitivePriv`'s safety requirement
        // ensures sufficient alignment of `T::Align`, and we got our `_align`
        // field.
        unsafe { T::atomic_swap(self.v.get(), val, order) }
    }

    /// Stores a value into the atomic value if the current value is the same as
    /// the `current` value. Here, "the same" is determined using byte-wise
    /// equality, not `PartialEq`.
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
    /// they are equivalent as Rust's type, because values can be byte-wise
    /// inequal even when they are equal as Rust values.
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
    ///     let x = mem::transmute::<Test, MaybeUninit<u32>>(Test(0, 0));
    ///     let v = AtomicMaybeUninit::new(x);
    ///     while v
    ///         .compare_exchange(
    ///             mem::transmute::<Test, MaybeUninit<u32>>(Test(0, 0)),
    ///             mem::transmute::<Test, MaybeUninit<u32>>(Test(1, 0)),
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
    ///     let mut current_raw = mem::transmute::<Test, MaybeUninit<u32>>(current);
    ///     let new_raw = mem::transmute::<Test, MaybeUninit<u32>>(new);
    ///     loop {
    ///         match v.compare_exchange_weak(current_raw, new_raw, Ordering::AcqRel, Ordering::Acquire)
    ///         {
    ///             Ok(_) => {
    ///                 // The values are byte-wise equal; for `Test` we know this implies they are `PartialEq`-equal.
    ///                 break Ok(current);
    ///             }
    ///             Err(previous_raw) => {
    ///                 let previous = mem::transmute::<MaybeUninit<u32>, Test>(previous_raw);
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
    ///     let x = mem::transmute::<Test, MaybeUninit<u32>>(Test(0, 0));
    ///     let v = AtomicMaybeUninit::new(x);
    ///     while atomic_compare_exchange(&v, Test(0, 0), Test(1, 0)).is_err() {}
    /// }
    /// ```
    ///
    /// Also, Valgrind reports "Conditional jump or move depends on uninitialized value(s)"
    /// error if there is such a comparison -- which is correct, that's exactly
    /// what the implementation does, but we are doing this inside inline
    /// assembly so it should be fine. (Effectively we are adding partial
    /// `freeze` capabilities to Rust via inline assembly. This pattern has not
    /// been blessed by the language team, but is also not known to cause any
    /// problems.)
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
    #[doc(alias = "compare_and_swap")]
    #[inline]
    #[cfg_attr(debug_assertions, track_caller)]
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
        // Workaround LLVM pre-20 bug: https://github.com/rust-lang/rust/issues/129585#issuecomment-2360273081
        #[cfg(atomic_maybe_uninit_pre_llvm_20)]
        let current = core::hint::black_box(current);
        #[cfg(atomic_maybe_uninit_pre_llvm_20)]
        let new = core::hint::black_box(new);
        // SAFETY: any data races are prevented by atomic intrinsics and the raw
        // pointer passed in is valid because we got it from a reference.
        // Alignment is upheld because `PrimitivePriv`'s safety requirement
        // ensures sufficient alignment of `T::Align`, and we got our `_align`
        // field.
        let (out, ok) =
            unsafe { T::atomic_compare_exchange(self.v.get(), current, new, success, failure) };
        if ok { Ok(out) } else { Err(out) }
    }

    /// Stores a value into the atomic value if the current value is the same as
    /// the `current` value. Here, "the same" is determined using byte-wise
    /// equality, not `PartialEq`.
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
    /// they are equivalent as Rust's type, because values can be byte-wise
    /// inequal even when they are equal as Rust values.
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
    #[doc(alias = "compare_and_swap")]
    #[inline]
    #[cfg_attr(debug_assertions, track_caller)]
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
        // Workaround LLVM pre-20 bug: https://github.com/rust-lang/rust/issues/129585#issuecomment-2360273081
        #[cfg(atomic_maybe_uninit_pre_llvm_20)]
        let current = core::hint::black_box(current);
        #[cfg(atomic_maybe_uninit_pre_llvm_20)]
        let new = core::hint::black_box(new);
        // SAFETY: any data races are prevented by atomic intrinsics and the raw
        // pointer passed in is valid because we got it from a reference.
        // Alignment is upheld because `PrimitivePriv`'s safety requirement
        // ensures sufficient alignment of `T::Align`, and we got our `_align`
        // field.
        let (out, ok) = unsafe {
            T::atomic_compare_exchange_weak(self.v.get(), current, new, success, failure)
        };
        if ok { Ok(out) } else { Err(out) }
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
    /// # Considerations
    ///
    /// This method is not magic; it is not provided by the hardware.
    /// It is implemented in terms of [`compare_exchange_weak`](Self::compare_exchange_weak),
    /// and suffers from the same drawbacks.
    /// In particular, this method will not circumvent the [ABA Problem].
    ///
    /// [ABA Problem]: https://en.wikipedia.org/wiki/ABA_problem
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
    #[cfg_attr(debug_assertions, track_caller)]
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

    /// Returns a mutable pointer to the underlying value.
    ///
    /// Returning an `*mut` pointer from a shared reference to this atomic is safe because the
    /// atomic types work with interior mutability. All modifications of an atomic change the value
    /// through a shared reference, and can do so safely as long as they use atomic operations. Any
    /// use of the returned raw pointer requires an `unsafe` block and still has to uphold the same
    /// restriction: operations on it must be atomic.
    #[inline]
    pub const fn as_ptr(&self) -> *mut MaybeUninit<T> {
        self.v.get()
    }
}

macro_rules! int {
    ($ty:ident, $align:ident) => {
        impl raw::Primitive for $ty {}
        const _: () = {
            assert!(mem::size_of::<AtomicMaybeUninit<$ty>>() == mem::size_of::<$ty>());
            assert!(mem::align_of::<AtomicMaybeUninit<$ty>>() == mem::size_of::<$ty>());
        };
        // SAFETY: the static assertion above ensures safety requirement.
        unsafe impl private::PrimitivePriv for $ty {
            type Align = private::$align;
        }
        impl AtomicMaybeUninit<$ty> {
            /// Creates a new atomic value from a potentially uninitialized value.
            #[inline]
            #[must_use]
            // TODO: remove in the next breaking release.
            #[deprecated(
                since = "0.3.10",
                note = "use `new` instead because it is now always `const fn`"
            )]
            pub const fn const_new(v: MaybeUninit<$ty>) -> Self {
                Self { v: UnsafeCell::new(v), _align: [] }
            }
        }
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

#[cfg(target_pointer_width = "16")]
pub use {cfg_has_atomic_16 as cfg_has_atomic_ptr, cfg_no_atomic_16 as cfg_no_atomic_ptr};
#[cfg(target_pointer_width = "32")]
pub use {cfg_has_atomic_32 as cfg_has_atomic_ptr, cfg_no_atomic_32 as cfg_no_atomic_ptr};
#[cfg(target_pointer_width = "64")]
pub use {cfg_has_atomic_64 as cfg_has_atomic_ptr, cfg_no_atomic_64 as cfg_no_atomic_ptr};
#[cfg(target_pointer_width = "128")]
pub use {cfg_has_atomic_128 as cfg_has_atomic_ptr, cfg_no_atomic_128 as cfg_no_atomic_ptr};

// -----------------------------------------------------------------------------
// Internals

#[cfg_attr(
    any(target_arch = "aarch64", all(target_arch = "arm64ec", not(atomic_maybe_uninit_no_asm))),
    path = "arch/aarch64.rs"
)]
#[cfg_attr(
    all(
        target_arch = "arm",
        any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6"),
        not(any(
            target_feature = "v8",
            atomic_maybe_uninit_target_feature = "v8",
            target_feature = "v8m",
            atomic_maybe_uninit_target_feature = "v8m",
            atomic_maybe_uninit_test_prefer_kuser_cmpxchg,
        )),
    ),
    path = "arch/arm.rs"
)]
#[cfg_attr(
    all(
        target_arch = "arm",
        any(target_os = "linux", target_os = "android"),
        any(
            not(any(target_feature = "v6", atomic_maybe_uninit_target_feature = "v6")),
            atomic_maybe_uninit_test_prefer_kuser_cmpxchg,
        ),
        not(any(
            target_feature = "v8",
            atomic_maybe_uninit_target_feature = "v8",
            target_feature = "v8m",
            atomic_maybe_uninit_target_feature = "v8m",
        )),
    ),
    path = "arch/arm_linux.rs"
)]
#[cfg_attr(
    all(
        target_arch = "arm",
        any(
            target_feature = "v8",
            atomic_maybe_uninit_target_feature = "v8",
            target_feature = "v8m",
            atomic_maybe_uninit_target_feature = "v8m",
        ),
    ),
    path = "arch/armv8.rs"
)]
#[cfg_attr(
    all(target_arch = "avr", atomic_maybe_uninit_unstable_asm_experimental_arch),
    path = "arch/avr.rs"
)]
#[cfg_attr(
    all(target_arch = "csky", atomic_maybe_uninit_unstable_asm_experimental_arch),
    path = "arch/csky.rs"
)]
#[cfg_attr(
    all(target_arch = "hexagon", atomic_maybe_uninit_unstable_asm_experimental_arch),
    path = "arch/hexagon.rs"
)]
#[cfg_attr(
    any(
        all(target_arch = "loongarch32", not(atomic_maybe_uninit_no_asm)),
        target_arch = "loongarch64",
    ),
    path = "arch/loongarch.rs"
)]
#[cfg_attr(
    all(target_arch = "m68k", atomic_maybe_uninit_unstable_asm_experimental_arch),
    path = "arch/m68k.rs"
)]
#[cfg_attr(
    all(
        any(
            all(target_arch = "mips", not(atomic_maybe_uninit_no_sync)),
            target_arch = "mips32r6",
            target_arch = "mips64",
            target_arch = "mips64r6",
        ),
        atomic_maybe_uninit_unstable_asm_experimental_arch,
    ),
    path = "arch/mips.rs"
)]
#[cfg_attr(
    all(target_arch = "msp430", atomic_maybe_uninit_unstable_asm_experimental_arch),
    path = "arch/msp430.rs"
)]
#[cfg_attr(
    all(
        any(target_arch = "powerpc", target_arch = "powerpc64"),
        atomic_maybe_uninit_unstable_asm_experimental_arch,
    ),
    path = "arch/powerpc.rs"
)]
#[cfg_attr(any(target_arch = "riscv32", target_arch = "riscv64"), path = "arch/riscv.rs")]
#[cfg_attr(all(target_arch = "s390x", not(atomic_maybe_uninit_no_asm)), path = "arch/s390x.rs")]
#[cfg_attr(
    all(
        any(
            all(
                target_arch = "sparc",
                any(
                    target_feature = "leoncasa",
                    atomic_maybe_uninit_target_feature = "leoncasa",
                    target_feature = "v9",
                    atomic_maybe_uninit_target_feature = "v9",
                ),
            ),
            target_arch = "sparc64",
        ),
        atomic_maybe_uninit_unstable_asm_experimental_arch,
    ),
    path = "arch/sparc.rs"
)]
#[cfg_attr(any(target_arch = "x86", target_arch = "x86_64"), path = "arch/x86.rs")]
#[cfg_attr(
    all(target_arch = "xtensa", atomic_maybe_uninit_unstable_asm_experimental_arch),
    path = "arch/xtensa.rs"
)]
#[allow(missing_docs)] // For cfg_* macros.
mod arch;

mod private {
    #![allow(missing_debug_implementations)]

    use core::panic::{RefUnwindSafe, UnwindSafe};

    /// This trait is private and cannot be implemented for types outside of `atomic-maybe-uninit`.
    ///
    /// # Safety
    ///
    /// The implementer must guarantee that `align_of::<Self::Align>() == size_of::<Self>()`.
    // Auto traits are needed to better docs.
    #[allow(unknown_lints, unnameable_types)] // Not public API. unnameable_types is available on Rust 1.79+
    pub unsafe trait PrimitivePriv:
        Copy + Send + Sync + Unpin + UnwindSafe + RefUnwindSafe
    {
        // See _align field of AtomicMaybeUninit.
        type Align: Send + Sync + Unpin + UnwindSafe + RefUnwindSafe;
    }

    #[repr(align(1))]
    #[allow(unknown_lints, unnameable_types)] // Not public API. unnameable_types is available on Rust 1.79+
    pub struct Align1(#[allow(dead_code)] u8);
    #[repr(align(2))]
    #[allow(unknown_lints, unnameable_types)] // Not public API. unnameable_types is available on Rust 1.79+
    pub struct Align2(#[allow(dead_code)] u16);
    #[repr(align(4))]
    #[allow(unknown_lints, unnameable_types)] // Not public API. unnameable_types is available on Rust 1.79+
    pub struct Align4(#[allow(dead_code)] u32);
    #[repr(align(8))]
    #[allow(unknown_lints, unnameable_types)] // Not public API. unnameable_types is available on Rust 1.79+
    pub struct Align8(#[allow(dead_code)] u64);
    #[repr(align(16))]
    #[allow(unknown_lints, unnameable_types)] // Not public API. unnameable_types is available on Rust 1.79+
    pub struct Align16(#[allow(dead_code)] u128);
    #[cfg(target_pointer_width = "16")]
    pub(crate) type AlignPtr = Align2;
    #[cfg(target_pointer_width = "32")]
    pub(crate) type AlignPtr = Align4;
    #[cfg(target_pointer_width = "64")]
    pub(crate) type AlignPtr = Align8;
    #[cfg(target_pointer_width = "128")]
    pub(crate) type AlignPtr = Align16;

    // Check that all cfg_ macros work.
    #[allow(unused_imports)]
    use crate::{
        AtomicMaybeUninit, cfg_has_atomic_8, cfg_has_atomic_16, cfg_has_atomic_32,
        cfg_has_atomic_64, cfg_has_atomic_128, cfg_has_atomic_cas, cfg_has_atomic_ptr,
        cfg_no_atomic_8, cfg_no_atomic_16, cfg_no_atomic_32, cfg_no_atomic_64, cfg_no_atomic_128,
        cfg_no_atomic_cas, cfg_no_atomic_ptr,
    };
    // TODO: make these type aliases public?
    cfg_has_atomic_8! {
        type _AtomicMaybeUninitI8 = AtomicMaybeUninit<i8>;
        type _AtomicMaybeUninitU8 = AtomicMaybeUninit<u8>;
    }
    cfg_no_atomic_8! {
        type _AtomicMaybeUninitI8 = AtomicMaybeUninit<i8>;
        type _AtomicMaybeUninitU8 = AtomicMaybeUninit<u8>;
    }
    cfg_has_atomic_16! {
        type _AtomicMaybeUninitI16 = AtomicMaybeUninit<i16>;
        type _AtomicMaybeUninitU16 = AtomicMaybeUninit<u16>;
    }
    cfg_no_atomic_16! {
        type _AtomicMaybeUninitI16 = AtomicMaybeUninit<i16>;
        type _AtomicMaybeUninitU16 = AtomicMaybeUninit<u16>;
    }
    cfg_has_atomic_32! {
        type _AtomicMaybeUninitI32 = AtomicMaybeUninit<i32>;
        type _AtomicMaybeUninitU32 = AtomicMaybeUninit<u32>;
    }
    cfg_no_atomic_32! {
        type _AtomicMaybeUninitI32 = AtomicMaybeUninit<i32>;
        type _AtomicMaybeUninitU32 = AtomicMaybeUninit<u32>;
    }
    cfg_has_atomic_64! {
        type _AtomicMaybeUninitI64 = AtomicMaybeUninit<i64>;
        type _AtomicMaybeUninitU64 = AtomicMaybeUninit<u64>;
    }
    cfg_no_atomic_64! {
        type _AtomicMaybeUninitI64 = AtomicMaybeUninit<i64>;
        type _AtomicMaybeUninitU64 = AtomicMaybeUninit<u64>;
    }
    cfg_has_atomic_128! {
        type _AtomicMaybeUninitI128 = AtomicMaybeUninit<i128>;
        type _AtomicMaybeUninitU128 = AtomicMaybeUninit<u128>;
    }
    cfg_no_atomic_128! {
        type _AtomicMaybeUninitI128 = AtomicMaybeUninit<i128>;
        type _AtomicMaybeUninitU128 = AtomicMaybeUninit<u128>;
    }
    cfg_has_atomic_ptr! {
        type _AtomicMaybeUninitIsize = AtomicMaybeUninit<isize>;
        type _AtomicMaybeUninitUsize = AtomicMaybeUninit<usize>;
    }
    cfg_no_atomic_ptr! {
        type _AtomicMaybeUninitIsize = AtomicMaybeUninit<isize>;
        type _AtomicMaybeUninitUsize = AtomicMaybeUninit<usize>;
    }
    cfg_has_atomic_cas! {
        type __AtomicMaybeUninitIsize = AtomicMaybeUninit<isize>;
        type __AtomicMaybeUninitUsize = AtomicMaybeUninit<usize>;
    }
    cfg_no_atomic_cas! {
        type __AtomicMaybeUninitIsize = AtomicMaybeUninit<isize>;
        type __AtomicMaybeUninitUsize = AtomicMaybeUninit<usize>;
    }
}
