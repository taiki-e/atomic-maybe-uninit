// SPDX-License-Identifier: Apache-2.0 OR MIT

// Adapted from https://github.com/taiki-e/atomic-memcpy

#![allow(clippy::cast_possible_truncation)]

use std::{
    boxed::Box,
    cell::UnsafeCell,
    mem::{self, MaybeUninit},
    ptr,
    sync::atomic::{AtomicUsize, Ordering},
    vec::Vec,
};

use super::helper::{assert_panic, skip_should_panic_test};
#[cfg(atomic_maybe_uninit_no_strict_provenance)]
use crate::utils::ptr::MutPtrExt as _;
use crate::{PerByteAtomicMaybeUninit, raw};

macro_rules! test_int {
    ($test_name:ident, $ty:ident) => {
        #[test]
        fn $test_name() {
            unsafe {
                let x = PerByteAtomicMaybeUninit::<$ty>::from(0);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), 0);
                x.store(MaybeUninit::new(!0), Ordering::Relaxed);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), !0);
                let x = PerByteAtomicMaybeUninit::<[$ty; 1]>::from([0]);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [0]);
                x.store(MaybeUninit::new([!0]), Ordering::Relaxed);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [!0]);
                let x = PerByteAtomicMaybeUninit::<[$ty; 2]>::from([0; 2]);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [0; 2]);
                x.store(MaybeUninit::new([!0; 2]), Ordering::Relaxed);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [!0; 2]);
                let x = PerByteAtomicMaybeUninit::<[$ty; 3]>::from([0; 3]);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [0; 3]);
                x.store(MaybeUninit::new([!0; 3]), Ordering::Relaxed);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [!0; 3]);
                let x = PerByteAtomicMaybeUninit::<[$ty; 4]>::from([0; 4]);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [0; 4]);
                x.store(MaybeUninit::new([!0; 4]), Ordering::Relaxed);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [!0; 4]);
                let x = PerByteAtomicMaybeUninit::<[$ty; 5]>::from([0; 5]);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [0; 5]);
                x.store(MaybeUninit::new([!0; 5]), Ordering::Relaxed);
                assert_eq!(x.load(Ordering::Relaxed).assume_init(), [!0; 5]);
                let x = PerByteAtomicMaybeUninit::<[$ty; 200]>::from([0; 200]);
                assert_eq!(x.load(Ordering::Relaxed).assume_init()[..], [0; 200][..]);
                x.store(MaybeUninit::new([!0; 200]), Ordering::Relaxed);
                assert_eq!(x.load(Ordering::Relaxed).assume_init()[..], [!0; 200][..]);
            }
        }
    };
}

test_int!(basic_u8, u8);
test_int!(basic_u16, u16);
test_int!(basic_u32, u32);
test_int!(basic_u64, u64);
test_int!(basic_u128, u128);

#[test]
fn basic_unit() {
    unsafe {
        let x = PerByteAtomicMaybeUninit::<()>::from(());
        x.load(Ordering::Relaxed).assume_init();
        x.store(MaybeUninit::new(()), Ordering::Relaxed);
        x.load(Ordering::Relaxed).assume_init();
    }
}

#[test]
fn basic_ptr() {
    unsafe {
        let a = &0u8;
        let x = PerByteAtomicMaybeUninit::<*const u8>::from(a as *const u8);
        assert_eq!(0, *x.load(Ordering::Relaxed).assume_init());
        x.store(MaybeUninit::new(ptr::null_mut()), Ordering::Relaxed);
        assert!(x.load(Ordering::Relaxed).assume_init().is_null());
    }
}

const LOAD_ORDERINGS: [Ordering; 2] = [Ordering::Relaxed, Ordering::Acquire];
const STORE_ORDERINGS: [Ordering; 2] = [Ordering::Relaxed, Ordering::Release];

#[test]
fn ordering() {
    let x = PerByteAtomicMaybeUninit::from(0u8);
    for order in LOAD_ORDERINGS {
        x.load(order);
    }
    for order in STORE_ORDERINGS {
        x.store(MaybeUninit::new(1), order);
    }

    if !skip_should_panic_test() {
        assert_eq!(
            assert_panic(|| {
                let x = PerByteAtomicMaybeUninit::from(0u8);
                x.load(Ordering::Release)
            }),
            "there is no such thing as a release load"
        );
        assert_eq!(
            assert_panic(|| {
                let x = PerByteAtomicMaybeUninit::from(0u8);
                x.load(Ordering::AcqRel)
            }),
            "there is no such thing as an acquire-release load"
        );
        assert_eq!(
            assert_panic(|| {
                let x = PerByteAtomicMaybeUninit::from(0u8);
                x.load(Ordering::SeqCst)
            }),
            "there is no such thing as a seqcst per-byte load"
        );
        assert_eq!(
            assert_panic(|| {
                let x = PerByteAtomicMaybeUninit::from(0u8);
                x.store(MaybeUninit::new(1), Ordering::Acquire);
            }),
            "there is no such thing as an acquire store"
        );
        assert_eq!(
            assert_panic(|| {
                let x = PerByteAtomicMaybeUninit::from(0u8);
                x.store(MaybeUninit::new(1), Ordering::AcqRel);
            }),
            "there is no such thing as an acquire-release store"
        );
        assert_eq!(
            assert_panic(|| {
                let x = PerByteAtomicMaybeUninit::from(0u8);
                x.store(MaybeUninit::new(1), Ordering::SeqCst);
            }),
            "there is no such thing as a seqcst per-byte store"
        );
    }
}

// test for alignment smaller than usize
#[test]
fn small_alignment() {
    #[derive(Clone, Copy)]
    #[repr(C, align(8))]
    struct Align8<T>(T);

    macro_rules! test_small_alignment {
        ($ty:ident) => {
            unsafe {
                let x = Box::new(UnsafeCell::new(Align8::<[$ty; 1024]>([0; 1024])));
                assert_eq!(x.get().addr() % mem::align_of::<AtomicUsize>(), 0);
                let a = PerByteAtomicMaybeUninit::from_ptr(
                    x.get().cast::<$ty>().add(1).cast::<MaybeUninit<[$ty; 1000]>>(),
                );
                assert_ne!(a.as_ptr().addr() % mem::align_of::<AtomicUsize>(), 0);
                assert_eq!(a.load(Ordering::Relaxed).assume_init()[..], [0; 1000][..]);
                a.store(MaybeUninit::new([1; 1000]), Ordering::Relaxed);
                assert_eq!(a.load(Ordering::Relaxed).assume_init()[..], [1; 1000][..]);

                for i in 0..mem::size_of::<usize>() * 4 {
                    *x.get().cast::<$ty>().add(i) = i as $ty;
                }
                let mut ptr = x.get().cast::<$ty>();
                for i in 0..mem::size_of::<usize>() * 2 {
                    assert_eq!(
                        ptr.addr() % mem::align_of::<AtomicUsize>(),
                        i * mem::size_of::<$ty>() % mem::size_of::<usize>()
                    );
                    assert_eq!(ptr.align_offset(mem::align_of::<AtomicUsize>()), {
                        let v = i * mem::size_of::<$ty>() % mem::size_of::<usize>();
                        if v == 0 {
                            0
                        } else {
                            (mem::size_of::<usize>() - v) / mem::size_of::<$ty>()
                        }
                    });

                    let a = PerByteAtomicMaybeUninit::from_ptr(
                        ptr.cast::<MaybeUninit<[$ty; mem::size_of::<usize>() * 2]>>(),
                    );
                    let val = a.load(Ordering::Relaxed).assume_init();
                    a.store(MaybeUninit::new(val), Ordering::Relaxed);
                    assert_eq!(
                        val[..],
                        (i as $ty..).take(mem::size_of::<usize>() * 2).collect::<Vec<_>>()[..]
                    );

                    let a = PerByteAtomicMaybeUninit::from_ptr(
                        ptr.cast::<MaybeUninit<[$ty; mem::size_of::<usize>() * 2 - 1]>>(),
                    );
                    let val = a.load(Ordering::Relaxed).assume_init();
                    a.store(MaybeUninit::new(val), Ordering::Relaxed);
                    assert_eq!(
                        val[..],
                        (i as $ty..).take(mem::size_of::<usize>() * 2 - 1).collect::<Vec<_>>()[..]
                    );

                    let a = PerByteAtomicMaybeUninit::from_ptr(
                        ptr.cast::<MaybeUninit<[$ty; mem::size_of::<usize>() * 2 - 2]>>(),
                    );
                    let val = a.load(Ordering::Relaxed).assume_init();
                    a.store(MaybeUninit::new(val), Ordering::Relaxed);
                    assert_eq!(
                        val[..],
                        (i as $ty..).take(mem::size_of::<usize>() * 2 - 2).collect::<Vec<_>>()[..]
                    );

                    ptr = ptr.cast::<$ty>().add(1);
                }
            }
        };
    }
    test_small_alignment!(u8); // align 1
    test_small_alignment!(u16); // align 2
    #[cfg(target_pointer_width = "64")]
    test_small_alignment!(u32); // align 4
}

#[test]
fn drop() {
    #[repr(transparent)]
    struct PanicOnDrop<T>(T);
    impl<T> Drop for PanicOnDrop<T> {
        fn drop(&mut self) {
            panic!();
        }
    }

    // std write
    let mut a = PanicOnDrop(());
    let b = PanicOnDrop(());
    unsafe { ptr::write(&mut a, b) }
    mem::forget(a);
    let mut a = PanicOnDrop(0_u8);
    let b = PanicOnDrop(0_u8);
    unsafe { ptr::write(&mut a, b) }
    mem::forget(a);

    // atomic_store_memcpy
    let a = UnsafeCell::new(MaybeUninit::new(PanicOnDrop(())));
    let b = PanicOnDrop(());
    unsafe { raw::atomic_store_memcpy(a.get(), &MaybeUninit::new(b), 1) }
    let a = UnsafeCell::new(MaybeUninit::new(PanicOnDrop(0_u8)));
    let b = PanicOnDrop(0_u8);
    unsafe { raw::atomic_store_memcpy(a.get(), &MaybeUninit::new(b), 1) }

    // PerByteAtomicMaybeUninit
    let a = PerByteAtomicMaybeUninit::from(PanicOnDrop(()));
    let b = PanicOnDrop(());
    a.store(MaybeUninit::new(b), Ordering::Relaxed);
    let a = PerByteAtomicMaybeUninit::from(PanicOnDrop(0_u8));
    let b = PanicOnDrop(0_u8);
    a.store(MaybeUninit::new(b), Ordering::Relaxed);
}
