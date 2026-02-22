// SPDX-License-Identifier: Apache-2.0 OR MIT

//! Low level API.

#[cfg(doc)]
use core::{
    cell::UnsafeCell,
    sync::atomic::{
        Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst},
        fence,
    },
};
use core::{mem::MaybeUninit, sync::atomic::Ordering};

// TODO(semver): merge AtomicLoad and AtomicStore and rename to AtomicLoadStore?

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
    /// - `src` must be valid for reads.
    /// - `src` must be properly aligned **to the size of `Self`**.
    ///   (For example, if `Self` is `u128`, `src` must be aligned to 16-byte even if the alignment of `u128` is 8-byte.)
    /// - `order` must be [`SeqCst`], [`Acquire`], or [`Relaxed`].
    ///
    /// The rules for the validity of the pointer follow [the rules applied to
    /// functions exposed by the standard library's `ptr` module][validity],
    /// except that concurrent atomic operations on `src` are allowed if the
    /// pointer go through [`UnsafeCell::get`].
    ///
    /// See the ["Atomic accesses to read-only memory" section in the `core::sync::atomic` docs][read-only-memory]
    /// for compatibility with read-only memory.
    ///
    /// [read-only-memory]: core::sync::atomic#atomic-accesses-to-read-only-memory
    /// [validity]: core::ptr#safety
    unsafe fn atomic_load(src: *const MaybeUninit<Self>, order: Ordering) -> MaybeUninit<Self>;
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
    /// - `dst` must be valid for writes
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
    unsafe fn atomic_store(dst: *mut MaybeUninit<Self>, val: MaybeUninit<Self>, order: Ordering);
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

crate::cfg_has_atomic_memcpy! {
#[cfg(not(doc))]
#[cfg(not(target_arch = "avr"))]
use core::cell::UnsafeCell;
use core::{mem, num::NonZeroUsize};

#[cfg(doc)]
use crate::PerByteAtomicMaybeUninit;
#[cfg(not(target_arch = "avr"))]
use crate::{private::PrimitivePriv, utils::RegSize};

pub(crate) trait AtomicMemcpy: Primitive {
    unsafe fn atomic_load_memcpy<const DST_ALIGNED: bool>(
        dst: *mut MaybeUninit<Self>,
        src: *const MaybeUninit<Self>,
        count: NonZeroUsize,
    );
    unsafe fn atomic_store_memcpy<const SRC_ALIGNED: bool>(
        dst: *mut MaybeUninit<Self>,
        src: *const MaybeUninit<Self>,
        count: NonZeroUsize,
    );
}

#[cfg_attr(target_arch = "avr", allow(clippy::extra_unused_type_parameters))]
#[inline]
unsafe fn atomic_memcpy_aligned<const IS_LOAD: bool, T>(
    dst: *mut MaybeUninit<u8>,
    src: *const MaybeUninit<u8>,
    count_in_byte: NonZeroUsize,
) {
    const ALIGNED: bool = true;

    #[cfg(any(
        target_arch = "aarch64",
        target_arch = "amdgpu",
        target_arch = "arm64ec",
        target_arch = "bpf",
        target_arch = "loongarch64",
        target_arch = "mips64",
        target_arch = "mips64r6",
        target_arch = "nvptx64",
        target_arch = "powerpc64",
        target_arch = "riscv64",
        target_arch = "s390x",
        target_arch = "sparc64",
        target_arch = "wasm64",
        target_arch = "x86_64",
    ))] // NB: Sync with gen/utils.rs
    if const_eval!(T => bool { mem::align_of::<T>() >= 8 }) {
        #[allow(clippy::cast_ptr_alignment)] // we've checked the alignment
        let dst = dst.cast::<MaybeUninit<u64>>();
        #[allow(clippy::cast_ptr_alignment)] // we've checked the alignment
        let src = src.cast::<MaybeUninit<u64>>();
        let count = unsafe { NonZeroUsize::new_unchecked(count_in_byte.get() >> 3) };
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            if IS_LOAD {
                u64::atomic_load_memcpy::<ALIGNED>(dst, src, count);
            } else {
                u64::atomic_store_memcpy::<ALIGNED>(dst, src, count);
            }
        }
        return;
    }

    #[cfg(not(any(target_arch = "avr", target_arch = "msp430")))]
    if const_eval!(T => bool { mem::align_of::<T>() >= 4 }) {
        #[allow(clippy::cast_ptr_alignment)] // we've checked the alignment
        let dst = dst.cast::<MaybeUninit<u32>>();
        #[allow(clippy::cast_ptr_alignment)] // we've checked the alignment
        let src = src.cast::<MaybeUninit<u32>>();
        let count = unsafe { NonZeroUsize::new_unchecked(count_in_byte.get() >> 2) };
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            if IS_LOAD {
                u32::atomic_load_memcpy::<ALIGNED>(dst, src, count);
            } else {
                u32::atomic_store_memcpy::<ALIGNED>(dst, src, count);
            }
        }
        return;
    }

    #[cfg(not(target_arch = "avr"))] // AVR's actual register size is 8-bit.
    if const_eval!(T => bool { mem::align_of::<T>() >= 2 }) {
        #[allow(clippy::cast_ptr_alignment)] // we've checked the alignment
        let dst = dst.cast::<MaybeUninit<u16>>();
        #[allow(clippy::cast_ptr_alignment)] // we've checked the alignment
        let src = src.cast::<MaybeUninit<u16>>();
        let count = unsafe { NonZeroUsize::new_unchecked(count_in_byte.get() >> 1) };
        // SAFETY: the caller must uphold the safety contract.
        unsafe {
            if IS_LOAD {
                u16::atomic_load_memcpy::<ALIGNED>(dst, src, count);
            } else {
                u16::atomic_store_memcpy::<ALIGNED>(dst, src, count);
            }
        }
        return;
    }

    let count = count_in_byte;
    // SAFETY: the caller must uphold the safety contract.
    unsafe {
        if IS_LOAD {
            u8::atomic_load_memcpy::<ALIGNED>(dst, src, count);
        } else {
            u8::atomic_store_memcpy::<ALIGNED>(dst, src, count);
        }
    }
}

/// Loads `count * size_of::<T>()` bytes from `src` into `dst`.
///
/// The memory ordering of this operation is always [`Relaxed`].
/// If [`Acquire`] memory ordering is needed, emit the [`fence(Acquire)`](fence)
/// *after* this operation.
///
/// **Note:** There is *no* guarantee that all elements have been copied at
/// the same time, so if `src` is updated by a concurrent write operation,
/// the elements at `dst` may be a mix of elements before and after the update.
///
/// # Safety
///
/// Behavior is undefined if any of the following conditions are violated:
///
/// - `src` must be valid for reads.
/// - `src` must go through [`UnsafeCell::get`].
/// - `dst` must be valid for writes.
/// - Both `src` and `dst` must be properly aligned.
/// - The region of memory beginning at `src` with a size of `count *
///   size_of::<T>()` bytes must *not* overlap with the region of memory
///   beginning at `dst` with the same size.
/// - `count * size_of::<T>()` must not overflow.
/// - There are no concurrent non-atomic write operations.
/// - There are no concurrent atomic write operations of different
///   granularity. The granularity of atomic operations is an implementation
///   detail and may changed in the future, so the concurrent write operation
///   that can always safely be used together with this function is only
///   [`PerByteAtomicMaybeUninit`] and [`atomic_store_memcpy`].
///
/// The rules for the validity of pointer follow [the rules applied to
/// functions exposed by the standard library's `ptr` module][validity],
/// except that concurrent atomic operations of the same granularity on `src`
/// are allowed.
///
/// [validity]: core::ptr#safety
#[allow(clippy::missing_panics_doc)] // see the comment on unwrap
#[inline]
pub unsafe fn atomic_load_memcpy<T>(
    dst: *mut MaybeUninit<T>,
    src: *const MaybeUninit<T>,
    count: usize,
) {
    const IS_LOAD: bool = true;

    // Handle zero-sized cases.
    let Some(size) =
        const_eval!(T => Option<NonZeroUsize> { NonZeroUsize::new(mem::size_of::<T>()) })
    else {
        return;
    };
    let Some(count) = NonZeroUsize::new(count) else { return };

    // SAFETY: the caller must guarantee that `count * size_of::<T>()` doesn't overflow.
    let count = unsafe { count.checked_mul(size).unwrap_unchecked() };

    #[cfg_attr(target_arch = "avr", allow(unused_mut))]
    let mut dst = dst.cast::<MaybeUninit<u8>>();
    let src = src.cast::<MaybeUninit<u8>>();

    // Handle cases where the alignment is smaller than the register size.
    #[cfg(not(target_arch = "avr"))] // AVR's actual register size is 8-bit.
    if const_eval!(T => bool { mem::align_of::<T>() < mem::size_of::<RegSize>() })
        && (
            // If RegSize is 32-bit:
            //    0 1 2 3 4 5 6
            // 0  ^ ^ ^ ^
            // 1    ^ ^ ^ ^
            // 2      ^ ^ ^ ^
            // 3        ^ ^ ^ ^
            const_eval!(T => bool { mem::size_of::<T>() >= mem::size_of::<RegSize>() << 1 })
                || count.get() >= const_eval!(=> usize { mem::size_of::<RegSize>() << 1 })
        )
    {
        // TODO: avoid conversion to slice
        let src = unsafe {
            core::slice::from_raw_parts(src.cast::<UnsafeCell<MaybeUninit<u8>>>(), count.get())
        };
        let (first, mid, last) =
            unsafe { src.align_to::<UnsafeCell<MaybeUninit<<RegSize as PrimitivePriv>::Align>>>() };
        if let Some(count) = NonZeroUsize::new(first.len()) {
            let src = first.as_ptr().cast::<MaybeUninit<u8>>();
            unsafe {
                atomic_memcpy_aligned::<IS_LOAD, T>(dst, src, count);
                dst = dst.add(count.get());
            }
        }
        {
            // unwrap is okay because the length check above.
            let count = NonZeroUsize::new(mid.len()).unwrap();
            let src = mid.as_ptr().cast::<MaybeUninit<RegSize>>();
            #[allow(clippy::cast_ptr_alignment)] // unaligned dst is okay since DST_ALIGNED is false
            unsafe {
                RegSize::atomic_load_memcpy::</* DST_ALIGNED */ false>(
                    dst.cast::<MaybeUninit<RegSize>>(),
                    src,
                    count,
                );
                dst = dst.add(
                    count.get().wrapping_mul(mem::size_of::<RegSize>()) /* can use unchecked_mul */
                );
            }
        }
        if let Some(count) = NonZeroUsize::new(last.len()) {
            let src = last.as_ptr().cast::<MaybeUninit<u8>>();
            unsafe { atomic_memcpy_aligned::<IS_LOAD, T>(dst, src, count) }
        }
        return;
    }

    // SAFETY: the caller must uphold the safety contract.
    unsafe { atomic_memcpy_aligned::<IS_LOAD, T>(dst, src, count) }
}

/// Stores `count * size_of::<T>()` bytes from `src` into `dst`.
///
/// The memory ordering of this operation is always [`Relaxed`].
/// If [`Release`] memory ordering is needed, emit the [`fence(Release)`](fence)
/// *before* this operation.
///
/// **Note:** There is *no* guarantee that all elements have been copied at
/// the same time, so if `dst` is updated by a concurrent write operation,
/// the elements at `dst` may be a mix of elements before and after the update.
///
/// # Safety
///
/// Behavior is undefined if any of the following conditions are violated:
///
/// - `dst` must be valid for writes.
/// - `dst` must go through [`UnsafeCell::get`].
/// - `src` must be valid for reads.
/// - Both `src` and `dst` must be properly aligned.
/// - The region of memory beginning at `src` with a size of `count *
///   size_of::<T>()` bytes must *not* overlap with the region of memory
///   beginning at `dst` with the same size.
/// - `count * size_of::<T>()` must not overflow.
/// - There are no concurrent non-atomic operations.
/// - There are no concurrent atomic operations of different
///   granularity. The granularity of atomic operations is an implementation
///   detail and may changed in the future, so the concurrent operation
///   that can always safely be used together with this function is only
///   [`PerByteAtomicMaybeUninit`] and [`atomic_load_memcpy`].
///
/// The rules for the validity of pointer follow [the rules applied to
/// functions exposed by the standard library's `ptr` module][validity],
/// except that concurrent atomic operations of the same granularity on `dst`
/// are allowed.
///
/// [validity]: core::ptr#safety
#[allow(clippy::missing_panics_doc)] // see the comment on unwrap
#[inline]
pub unsafe fn atomic_store_memcpy<T>(
    dst: *mut MaybeUninit<T>,
    src: *const MaybeUninit<T>,
    count: usize,
) {
    const IS_LOAD: bool = false;

    // Handle zero-sized cases.
    let Some(size) =
        const_eval!(T => Option<NonZeroUsize> { NonZeroUsize::new(mem::size_of::<T>()) })
    else {
        return;
    };
    let Some(count) = NonZeroUsize::new(count) else { return };

    // SAFETY: the caller must guarantee that `count * size_of::<T>()` doesn't overflow.
    let count = unsafe { count.checked_mul(size).unwrap_unchecked() };

    let dst = dst.cast::<MaybeUninit<u8>>();
    #[cfg_attr(target_arch = "avr", allow(unused_mut))]
    let mut src = src.cast::<MaybeUninit<u8>>();

    // Handle cases where the alignment is smaller than the register size.
    #[cfg(not(target_arch = "avr"))] // AVR's actual register size is 8-bit.
    if const_eval!(T => bool { mem::align_of::<T>() < mem::size_of::<RegSize>() })
        && (
            // If RegSize is 32-bit:
            //    0 1 2 3 4 5 6
            // 0  ^ ^ ^ ^
            // 1    ^ ^ ^ ^
            // 2      ^ ^ ^ ^
            // 3        ^ ^ ^ ^
            const_eval!(T => bool { mem::size_of::<T>() >= mem::size_of::<RegSize>() << 1 })
                || count.get() >= const_eval!(=> usize { mem::size_of::<RegSize>() << 1 })
        )
    {
        // TODO: avoid conversion to slice
        let dst = unsafe {
            core::slice::from_raw_parts(dst.cast::<UnsafeCell<MaybeUninit<u8>>>(), count.get())
        };
        let (first, mid, last) =
            unsafe { dst.align_to::<UnsafeCell<MaybeUninit<<RegSize as PrimitivePriv>::Align>>>() };
        if let Some(count) = NonZeroUsize::new(first.len()) {
            let dst = UnsafeCell::raw_get(first.as_ptr());
            unsafe {
                atomic_memcpy_aligned::<IS_LOAD, T>(dst, src, count);
                src = src.add(count.get());
            }
        }
        {
            // unwrap is okay because the length check above.
            let count = NonZeroUsize::new(mid.len()).unwrap();
            let dst = UnsafeCell::raw_get(mid.as_ptr()).cast::<MaybeUninit<RegSize>>();
            #[allow(clippy::cast_ptr_alignment)] // unaligned src is okay since SRC_ALIGNED is false
            unsafe {
                RegSize::atomic_store_memcpy::</* SRC_ALIGNED */ false>(
                    dst,
                    src.cast::<MaybeUninit<RegSize>>(),
                    count,
                );
                src = src.add(
                    count.get().wrapping_mul(mem::size_of::<RegSize>()) /* can use unchecked_mul */
                );
            }
        }
        if let Some(count) = NonZeroUsize::new(last.len()) {
            let dst = UnsafeCell::raw_get(last.as_ptr());
            unsafe { atomic_memcpy_aligned::<IS_LOAD, T>(dst, src, count) }
        }
        return;
    }

    // SAFETY: the caller must uphold the safety contract.
    unsafe { atomic_memcpy_aligned::<IS_LOAD, T>(dst, src, count) }
}
}
