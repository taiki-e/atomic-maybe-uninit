//! Low level API.

#[cfg(doc)]
use core::{
    cell::UnsafeCell,
    sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst},
};
use core::{mem::MaybeUninit, sync::atomic::Ordering};

// TODO: merge traits and rename to AtomicLoadStore and AtomicRMW?

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

/// Atomic compare and exchange.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
pub trait AtomicCompareExchange: AtomicLoad + AtomicStore {
    /// Stores a value from `new` into `dst` if the current value is the same as
    /// the value at `current`, writes the previous value to `out`.
    ///
    /// The return value is a result indicating whether the new value was written and
    /// containing the previous value. On success the value at `out` is guaranteed to be equal to
    /// the value at `current`.
    ///
    /// `atomic_compare_exchange` takes two [`Ordering`] arguments to describe the memory
    /// ordering of this operation. `success` describes the required ordering for the
    /// read-modify-write operation that takes place if the comparison with `current` succeeds.
    /// `failure` describes the required ordering for the load operation that takes place when
    /// the comparison fails. Using [`Acquire`] as success ordering makes the store part
    /// of this operation [`Relaxed`], and using [`Release`] makes the successful load
    /// [`Relaxed`]. The failure ordering can only be [`SeqCst`], [`Acquire`] or [`Relaxed`].
    ///
    /// # Safety
    ///
    /// Behavior is undefined if any of the following conditions are violated:
    ///
    /// - `dst` must be valid for both reads and writes.
    /// - `dst` must be properly aligned **to the size of `Self`**.
    ///   (For example, if `Self` is `u128`, `dst` must be aligned to 16-byte even if the alignment of `u128` is 8-byte.)
    /// - `dst` must go through [`UnsafeCell::get`].
    /// - `dst` must *not* overlap with `current`, `new`, or `out`.
    /// - `current` must be valid for reads.
    /// - `current` must be properly aligned.
    /// - `new` must be valid for reads.
    /// - `new` must be properly aligned.
    /// - `out` must be valid for writes.
    /// - `out` must be properly aligned.
    /// - `success` must be [`SeqCst`], [`AcqRel`], [`Acquire`], [`Release`], or [`Relaxed`].
    /// - `failure` must be [`SeqCst`], [`Acquire`], or [`Relaxed`].
    ///
    /// The rules for the validity of pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `dst` are allowed.
    ///
    /// [validity]: core::ptr#safety
    ///
    /// # Notes
    ///
    /// Comparison of two values containing uninitialized bytes may fail even if
    /// they are equivalent as Rust's type, because their contents are not frozen
    /// until a pointer to the value containing uninitialized bytes is passed to `asm!`.
    ///
    /// See [`AtomicMaybeUninit::compare_exchange`](crate::AtomicMaybeUninit::compare_exchange) for details.
    unsafe fn atomic_compare_exchange(
        dst: *mut MaybeUninit<Self>,
        current: *const MaybeUninit<Self>,
        new: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        success: Ordering,
        failure: Ordering,
    ) -> bool;

    /// Stores a value from `new` into `dst` if the current value is the same as
    /// the value at `current`, writes the previous value to `out`.
    ///
    /// This function is allowed to spuriously fail even when the comparison succeeds,
    /// which can result in more efficient code on some platforms. The return value
    /// is a result indicating whether the new value was written and containing
    /// the previous value.
    ///
    /// `atomic_compare_exchange_weak` takes two [`Ordering`] arguments to describe the memory
    /// ordering of this operation. `success` describes the required ordering for the
    /// read-modify-write operation that takes place if the comparison with `current` succeeds.
    /// `failure` describes the required ordering for the load operation that takes place when
    /// the comparison fails. Using [`Acquire`] as success ordering makes the store part
    /// of this operation [`Relaxed`], and using [`Release`] makes the successful load
    /// [`Relaxed`]. The failure ordering can only be [`SeqCst`], [`Acquire`] or [`Relaxed`].
    ///
    /// # Safety
    ///
    /// Behavior is undefined if any of the following conditions are violated:
    ///
    /// - `dst` must be valid for both reads and writes.
    /// - `dst` must be properly aligned **to the size of `Self`**.
    ///   (For example, if `Self` is `u128`, `dst` must be aligned to 16-byte even if the alignment of `u128` is 8-byte.)
    /// - `dst` must go through [`UnsafeCell::get`].
    /// - `dst` must *not* overlap with `current`, `new`, or `out`.
    /// - `current` must be valid for reads.
    /// - `current` must be properly aligned.
    /// - `new` must be valid for reads.
    /// - `new` must be properly aligned.
    /// - `out` must be valid for writes.
    /// - `out` must be properly aligned.
    /// - `success` must be [`SeqCst`], [`AcqRel`], [`Acquire`], [`Release`], or [`Relaxed`].
    /// - `failure` must be [`SeqCst`], [`Acquire`], or [`Relaxed`].
    ///
    /// The rules for the validity of pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `dst` are allowed.
    ///
    /// [validity]: core::ptr#safety
    ///
    /// # Notes
    ///
    /// Comparison of two values containing uninitialized bytes may fail even if
    /// they are equivalent as Rust's type, because their contents are not frozen
    /// until a pointer to the value containing uninitialized bytes is passed to `asm!`.
    ///
    /// See [`AtomicMaybeUninit::compare_exchange`](crate::AtomicMaybeUninit::compare_exchange) for details.
    #[inline]
    unsafe fn atomic_compare_exchange_weak(
        dst: *mut MaybeUninit<Self>,
        current: *const MaybeUninit<Self>,
        new: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        success: Ordering,
        failure: Ordering,
    ) -> bool {
        // SAFETY: the caller must uphold the safety contract for `atomic_compare_exchange_weak`.
        unsafe { Self::atomic_compare_exchange(dst, current, new, out, success, failure) }
    }
}
