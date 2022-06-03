/*!
Atomic operations on potentially uninitialized integers.

## Motivation

Copying types containing uninitialized bytes (e.g., padding), via the standard library's atomic types is [undefined behavior because the copy goes through integers][undefined-behavior].

This crate provides a way to soundly perform such operations.

## Platform Support

Currently, x86, x86_64, ARM (v6-m, v7+), AArch64, RISC-V, MIPS32r2, MIPS64r2, and PowerPC are supported.

| target_arch                     | primitives                                          | [load]/[store] | [swap] |
| ------------------------------- | --------------------------------------------------- |:--------------:|:------:|
| x86                             | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓              | ✓      |
| x86_64                          | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓              | ✓      |
| arm (v6-m, v7+)                 | isize,usize,i8,u8,i16,u16,i32,u32                   | ✓              | ✓\[1]  |
| arm (v7-a)                      | i64,u64                                             | ✓              | ✓      |
| aarch64 \[2]                    | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64,i128,u128 | ✓              | ✓      |
| riscv32                         | isize,usize,i32,u32                                 | ✓              | ✓\[1]  |
| riscv32                         | i8,u8,i16,u16                                       | ✓              |        |
| riscv64                         | isize,usize,i32,u32,i64,u64                         | ✓              | ✓\[1]  |
| riscv64                         | i8,u8,i16,u16                                       | ✓              |        |
| mips \[3]                       | isize,usize,i32,u32                                 | ✓              | ✓      |
| mips \[3]                       | i8,u8,i16,u16                                       | ✓              |        |
| mips64 \[3]                     | isize,usize,i32,u32,i64,u64                         | ✓              | ✓      |
| mips64 \[3]                     | i8,u8,i16,u16                                       | ✓              |        |
| powerpc \[3]                    | isize,usize,i32,u32                                 | ✓              | ✓      |
| powerpc \[3]                    | i8,u8,i16,u16                                       | ✓              |        |
| powerpc64 \[3]                  | isize,usize,i32,u32,i64,u64                         | ✓              | ✓      |
| powerpc64 \[3]                  | i8,u8,i16,u16                                       | ✓              |        |
| powerpc64 (le) \[3]             | isize,usize,i8,u8,i16,u16,i32,u32,i64,u64           | ✓              | ✓      |
| powerpc64 (le, pwr8+) \[3] \[4] | i128,u128                                           | ✓              | ✓      |

\[1] ARM's atomic swap is not available on v6-m (thumbv6m). RISC-V's atomic swap is not available on targets without the A (or G) extension such as riscv32i-unknown-none-elf, riscv32imc-unknown-none-elf, etc.<br>
\[2] If target features such as `lse` and `lse2` are enabled at compile-time, more efficient instructions are used.<br>
\[3] Requires nightly due to `#![feature(asm_experimental_arch)]`.<br>

Feel free to submit an issue if your target is not supported yet.

## Related Projects

- [portable-atomic]: Portable atomic types including support for 128-bit atomics, atomic float, etc.
- [atomic-memcpy]: Byte-wise atomic memcpy.

[load]: https://docs.rs/atomic-maybe-uninit/latest/atomic_maybe_uninit/struct.AtomicMaybeUninit.html#method.load
[store]: https://docs.rs/atomic-maybe-uninit/latest/atomic_maybe_uninit/struct.AtomicMaybeUninit.html#method.store
[swap]: https://docs.rs/atomic-maybe-uninit/latest/atomic_maybe_uninit/struct.AtomicMaybeUninit.html#method.swap
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
#![allow(clippy::doc_markdown, clippy::module_inception, clippy::type_complexity)]
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

use crate::raw::{AtomicLoad, AtomicStore, AtomicSwap, Primitive};

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
    #[inline]
    fn from(v: MaybeUninit<T>) -> Self {
        Self::new(v)
    }
}

impl<T: Primitive> From<T> for AtomicMaybeUninit<T> {
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
    /// Creates a new atomic integer.
    ///
    /// This is `const fn` on Rust 1.61+. See also `const_new` function.
    #[cfg(not(atomic_maybe_uninit_no_const_fn_trait_bound))]
    #[inline]
    #[must_use]
    pub const fn new(v: MaybeUninit<T>) -> Self {
        Self { v: UnsafeCell::new(v), _align: [] }
    }

    /// Creates a new atomic integer.
    ///
    /// This is `const fn` on Rust 1.61+.
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
    #[inline]
    pub fn get_mut(&mut self) -> &mut MaybeUninit<T> {
        self.v.get_mut()
    }

    /// Consumes the atomic and returns the contained value.
    ///
    /// This is safe because passing `self` by value guarantees that no other threads are
    /// concurrently accessing the atomic data.
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
}

macro_rules! int {
    ($ty:ident, $align:ident) => {
        impl crate::raw::Primitive for $ty {}
        impl crate::private::PrimitivePriv for $ty {
            type Align = crate::private::$align;
        }
        impl AtomicMaybeUninit<$ty> {
            /// Creates a new atomic integer. Unlike [`new`](Self::new), this is always `const fn`.
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
