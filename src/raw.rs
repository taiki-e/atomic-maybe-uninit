// SPDX-License-Identifier: Apache-2.0 OR MIT

//! Low level API.

#[cfg(doc)]
use core::{
    cell::UnsafeCell,
    sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst},
};
use core::{mem::MaybeUninit, sync::atomic::Ordering};

// TODO: merge AtomicLoad and AtomicStore and rename to AtomicLoadStore?

/// Primitive types that may support atomic operations.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
///
/// Currently this is implemented only for integer types.
pub trait Primitive: crate::private::PrimitivePriv {}

/// Atomic load.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
#[cfg_attr(
    not(atomic_maybe_uninit_no_diagnostic_namespace),
    diagnostic::on_unimplemented(
        message = "atomic load of `{Self}` is not available on this target",
        label = "this associated function is not available on this target",
        note = "see <https://docs.rs/atomic-maybe-uninit/latest/atomic_maybe_uninit/#platform-support> for more."
    )
)]
pub trait AtomicLoad: Primitive {
    /// Loads a value from `src`.
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
    /// - `order` must be [`SeqCst`], [`Acquire`], or [`Relaxed`].
    ///
    /// The rules for the validity of the pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `src` are allowed if the
    /// pointer go through [`UnsafeCell::get`].
    ///
    /// [validity]: core::ptr#safety
    unsafe fn atomic_load<const OFFSET: usize>(
        src: *const MaybeUninit<Self>,
        order: Ordering,
    ) -> MaybeUninit<Self>;
}

/// Atomic store.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
#[cfg_attr(
    not(atomic_maybe_uninit_no_diagnostic_namespace),
    diagnostic::on_unimplemented(
        message = "atomic store of `{Self}` is not available on this target",
        label = "this associated function is not available on this target",
        note = "see <https://docs.rs/atomic-maybe-uninit/latest/atomic_maybe_uninit/#platform-support> for more."
    )
)]
pub trait AtomicStore: Primitive {
    /// Stores a value into `dst`.
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
    /// - `order` must be [`SeqCst`], [`Release`], or [`Relaxed`].
    ///
    /// The rules for the validity of the pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `dst` are allowed if the
    /// pointer go through [`UnsafeCell::get`].
    ///
    /// [validity]: core::ptr#safety
    unsafe fn atomic_store<const OFFSET: usize>(
        dst: *mut MaybeUninit<Self>,
        val: MaybeUninit<Self>,
        order: Ordering,
    );
}

/// Atomic swap.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
#[cfg_attr(
    not(atomic_maybe_uninit_no_diagnostic_namespace),
    diagnostic::on_unimplemented(
        message = "atomic swap of `{Self}` is not available on this target",
        label = "this associated function is not available on this target",
        note = "see <https://docs.rs/atomic-maybe-uninit/latest/atomic_maybe_uninit/#platform-support> for more."
    )
)]
pub trait AtomicSwap: AtomicLoad + AtomicStore {
    /// Stores a value into `dst`, returning the previous value.
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
    /// - `order` must be [`SeqCst`], [`AcqRel`], [`Acquire`], [`Release`], or [`Relaxed`].
    ///
    /// The rules for the validity of the pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `dst` are allowed if the
    /// pointer go through [`UnsafeCell::get`].
    ///
    /// [validity]: core::ptr#safety
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: MaybeUninit<Self>,
        order: Ordering,
    ) -> MaybeUninit<Self>;
}

/// Atomic compare and exchange.
///
/// This trait is sealed and cannot be implemented for types outside of `atomic-maybe-uninit`.
#[cfg_attr(
    not(atomic_maybe_uninit_no_diagnostic_namespace),
    diagnostic::on_unimplemented(
        message = "atomic compare and exchange of `{Self}` is not available on this target",
        label = "this associated function is not available on this target",
        note = "see <https://docs.rs/atomic-maybe-uninit/latest/atomic_maybe_uninit/#platform-support> for more."
    )
)]
pub trait AtomicCompareExchange: AtomicLoad + AtomicStore {
    /// Stores a value into `dst` if the current value is the same as
    /// the `current` value. Here, "the same" is determined using byte-wise
    /// equality, not `PartialEq`.
    ///
    /// The return value is a tuple of the previous value and the result indicating whether the new
    /// value was written and containing the previous value. On success, the returned value is
    /// guaranteed to be equal to the value at `current`.
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
    /// - `success` must be [`SeqCst`], [`AcqRel`], [`Acquire`], [`Release`], or [`Relaxed`].
    /// - `failure` must be [`SeqCst`], [`Acquire`], or [`Relaxed`].
    ///
    /// The rules for the validity of the pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `dst` are allowed if the
    /// pointer go through [`UnsafeCell::get`].
    ///
    /// [validity]: core::ptr#safety
    ///
    /// # Notes
    ///
    /// Comparison of two values containing uninitialized bytes may fail even if
    /// they are equivalent as Rust's type, because values can be byte-wise
    /// inequal even when they are equal as Rust values.
    ///
    /// See [`AtomicMaybeUninit::compare_exchange`](crate::AtomicMaybeUninit::compare_exchange) for details.
    unsafe fn atomic_compare_exchange(
        dst: *mut MaybeUninit<Self>,
        current: MaybeUninit<Self>,
        new: MaybeUninit<Self>,
        success: Ordering,
        failure: Ordering,
    ) -> (MaybeUninit<Self>, bool);

    /// Stores a value into `dst` if the current value is the same as
    /// the `current` value. Here, "the same" is determined using byte-wise
    /// equality, not `PartialEq`.
    ///
    /// This function is allowed to spuriously fail even when the comparison succeeds, which can
    /// result in more efficient code on some platforms. The return value is a tuple of the previous
    /// value and the result indicating whether the new value was written and containing the
    /// previous value.
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
    /// - `success` must be [`SeqCst`], [`AcqRel`], [`Acquire`], [`Release`], or [`Relaxed`].
    /// - `failure` must be [`SeqCst`], [`Acquire`], or [`Relaxed`].
    ///
    /// The rules for the validity of the pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `dst` are allowed if the
    /// pointer go through [`UnsafeCell::get`].
    ///
    /// [validity]: core::ptr#safety
    ///
    /// # Notes
    ///
    /// Comparison of two values containing uninitialized bytes may fail even if
    /// they are equivalent as Rust's type, because values can be byte-wise
    /// inequal even when they are equal as Rust values.
    ///
    /// See [`AtomicMaybeUninit::compare_exchange`](crate::AtomicMaybeUninit::compare_exchange) for details.
    #[inline]
    unsafe fn atomic_compare_exchange_weak(
        dst: *mut MaybeUninit<Self>,
        current: MaybeUninit<Self>,
        new: MaybeUninit<Self>,
        success: Ordering,
        failure: Ordering,
    ) -> (MaybeUninit<Self>, bool) {
        // SAFETY: the caller must uphold the safety contract.
        unsafe { Self::atomic_compare_exchange(dst, current, new, success, failure) }
    }
}
