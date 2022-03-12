//! Low level API.

#[cfg(doc)]
use core::sync::atomic::Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst};
use core::{mem::MaybeUninit, sync::atomic::Ordering};

/// Primitive types that may support atomic operations.
pub trait Primitive: crate::private::PrimitivePriv {}

#[allow(clippy::missing_safety_doc)] // TODO
/// Atomic load.
pub trait AtomicLoad: Primitive {
    /// Loads a value from `src` into `out`.
    ///
    /// `atomic_load` takes an [`Ordering`] argument which describes the memory ordering of this operation.
    /// Possible values are [`SeqCst`], [`Acquire`] and [`Relaxed`].
    ///
    /// Behavior is undefined if `order` is [`Release`] or [`AcqRel`].
    unsafe fn atomic_load(
        src: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        order: Ordering,
    );
}

#[allow(clippy::missing_safety_doc)] // TODO
/// Atomic store.
pub trait AtomicStore: Primitive {
    /// Stores a value from `val` into `dst`.
    ///
    /// `atomic_store` takes an [`Ordering`] argument which describes the memory ordering of this operation.
    ///  Possible values are [`SeqCst`], [`Release`] and [`Relaxed`].
    ///
    /// Behavior is undefined if `order` is [`Acquire`] or [`AcqRel`].
    unsafe fn atomic_store(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        order: Ordering,
    );
}

#[allow(clippy::missing_safety_doc)] // TODO
/// Atomic swap.
pub trait AtomicSwap: Primitive {
    /// Stores a value from `val` into `dst`, writes the previous value to `out`.
    ///
    /// `atomic_swap` takes an [`Ordering`] argument which describes the memory ordering
    /// of this operation. All ordering modes are possible. Note that using
    /// [`Acquire`] makes the store part of this operation [`Relaxed`], and
    /// using [`Release`] makes the load part [`Relaxed`].
    unsafe fn atomic_swap(
        dst: *mut MaybeUninit<Self>,
        val: *const MaybeUninit<Self>,
        out: *mut MaybeUninit<Self>,
        order: Ordering,
    );
}
