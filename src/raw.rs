//! Low level API.

#[cfg(doc)]
use core::{
    cell::UnsafeCell,
    sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst},
};
use core::{mem::MaybeUninit, sync::atomic::Ordering};

/// Primitive types that may support atomic operations.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
pub trait Primitive: crate::private::PrimitivePriv {}

/// Atomic load.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
pub trait AtomicLoad: Primitive {
    /// Loads a value from `src` into `out`.
    ///
    /// `atomic_load` takes an [`Ordering`] argument which describes the memory ordering of this operation.
    /// Possible values are [`SeqCst`], [`Acquire`] and [`Relaxed`].
    ///
    /// # Safety
    ///
    /// Behavior is undefined if any of the following conditions are violated:
    ///
    /// - If `Self` is greater than the pointer width, `src` must be valid for both reads and writes.
    ///   Otherwise, `src` must be valid for reads.
    /// - `src` must be properly aligned **to the size of `Self`**.
    ///   (For example, if `Self` is `u128`, `src` must be aligned to 16-byte even if the alignment of `u128` is 8-byte.)
    /// - `src` must go through [`UnsafeCell::get`].
    /// - `src` must *not* overlap with `out`.
    /// - `out` must be valid for writes.
    /// - `out` must be properly aligned.
    /// - `order` must be [`SeqCst`], [`Acquire`], or [`Relaxed`].
    ///
    /// The rules for the validity of pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `src` are allowed.
    ///
    /// [validity]: core::ptr#safety
    unsafe fn atomic_load(
        src: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        order: Ordering,
    );
}

/// Atomic store.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
pub trait AtomicStore: Primitive {
    /// Stores a value from `val` into `dst`.
    ///
    /// `atomic_store` takes an [`Ordering`] argument which describes the memory ordering of this operation.
    ///  Possible values are [`SeqCst`], [`Release`] and [`Relaxed`].
    ///
    /// # Safety
    ///
    /// Behavior is undefined if any of the following conditions are violated:
    ///
    /// - If `Self` is greater than the pointer width, `dst` must be valid for both reads and writes.
    ///   Otherwise, `dst` must be valid for writes.
    /// - `dst` must be properly aligned **to the size of `Self`**.
    ///   (For example, if `Self` is `u128`, `dst` must be aligned to 16-byte even if the alignment of `u128` is 8-byte.)
    /// - `dst` must go through [`UnsafeCell::get`].
    /// - `dst` must *not* overlap with `val`.
    /// - `val` must be valid for reads.
    /// - `val` must be properly aligned.
    /// - `order` must be [`SeqCst`], [`Release`], or [`Relaxed`].
    ///
    /// The rules for the validity of pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `dst` are allowed.
    ///
    /// [validity]: core::ptr#safety
    unsafe fn atomic_store(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        order: Ordering,
    );
}

/// Atomic swap.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
pub trait AtomicSwap: AtomicLoad + AtomicStore {
    /// Stores a value from `val` into `dst`, writes the previous value to `out`.
    ///
    /// `atomic_swap` takes an [`Ordering`] argument which describes the memory ordering
    /// of this operation. All ordering modes are possible. Note that using
    /// [`Acquire`] makes the store part of this operation [`Relaxed`], and
    /// using [`Release`] makes the load part [`Relaxed`].
    ///
    /// # Safety
    ///
    /// Behavior is undefined if any of the following conditions are violated:
    ///
    /// - `dst` must be valid for both reads and writes.
    /// - `dst` must be properly aligned **to the size of `Self`**.
    ///   (For example, if `Self` is `u128`, `dst` must be aligned to 16-byte even if the alignment of `u128` is 8-byte.)
    /// - `dst` must go through [`UnsafeCell::get`].
    /// - `dst` must *not* overlap with `val` or `out`.
    /// - `val` must be valid for reads.
    /// - `val` must be properly aligned.
    /// - `out` must be valid for writes.
    /// - `out` must be properly aligned.
    /// - `order` must be [`SeqCst`], [`AcqRel`], [`Acquire`], [`Release`], or [`Relaxed`].
    ///
    /// The rules for the validity of pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `dst` are allowed.
    ///
    /// [validity]: core::ptr#safety
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        order: Ordering,
    );
}
