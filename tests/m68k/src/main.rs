// SPDX-License-Identifier: Apache-2.0 OR MIT

#![allow(internal_features)] // for prelude_import
#![feature(asm_experimental_arch, no_core, prelude_import)]
#![no_main]
#![no_core]
#![warn(unsafe_op_in_unsafe_fn)]
#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]
#![cfg_attr(atomic_maybe_uninit_no_strict_provenance, allow(unstable_name_collisions))]

#[macro_use]
extern crate core;

#[prelude_import]
#[allow(unused_imports)]
use core::prelude::v1::*;

#[allow(unused_macros)]
#[macro_use]
#[path = "../../../src/utils.rs"]
mod utils;

#[cfg(target_arch = "m68k")]
#[path = "../../../src/arch/m68k.rs"]
mod m68k;

#[path = "../../../src/raw.rs"]
mod raw;

use core::{cell::UnsafeCell, fmt, mem::MaybeUninit, sync::atomic::Ordering};

use crate::raw::{AtomicCompareExchange, AtomicLoad, AtomicStore, AtomicSwap, Primitive};

macro_rules! __test_atomic {
    ($ty:ident) => {
        load_store();
        fn load_store() {
            unsafe {
                static VAR: AtomicMaybeUninit<$ty> =
                    AtomicMaybeUninit::<$ty>::const_new(MaybeUninit::new(10));
                for (load_order, store_order) in LOAD_ORDERINGS.into_iter().zip(STORE_ORDERINGS) {
                    assert_eq!(VAR.load(load_order).assume_init(), 10);
                    VAR.store(MaybeUninit::new(5), store_order);
                    assert_eq!(VAR.load(load_order).assume_init(), 5);
                    VAR.store(MaybeUninit::uninit(), store_order);
                    let _v = VAR.load(load_order);
                    VAR.store(MaybeUninit::new(10), store_order);

                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(1));
                    assert_eq!(a.load(load_order).assume_init(), 1);
                    a.store(MaybeUninit::new($ty::MIN), store_order);
                    assert_eq!(a.load(load_order).assume_init(), $ty::MIN);
                    a.store(MaybeUninit::new($ty::MAX), store_order);
                    assert_eq!(a.load(load_order).assume_init(), $ty::MAX);
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::uninit());
                    let _v = a.load(load_order);
                    a.store(MaybeUninit::new(2), store_order);
                    assert_eq!(a.load(load_order).assume_init(), 2);
                    a.store(MaybeUninit::uninit(), store_order);
                    let _v = a.load(load_order);
                }
            }
        }
        cfg_has_atomic_cas! {
        swap();
        fn swap() {
            unsafe {
                for order in SWAP_ORDERINGS {
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(5));
                    assert_eq!(a.swap(MaybeUninit::new($ty::MIN), order).assume_init(), 5);
                    assert_eq!(
                        a.swap(MaybeUninit::new($ty::MAX), order).assume_init(),
                        $ty::MIN
                    );
                    assert_eq!(a.swap(MaybeUninit::new(10), order).assume_init(), $ty::MAX);
                    assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                    let _v = a.swap(MaybeUninit::new(15), order);
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::uninit());
                    let _v = a.swap(MaybeUninit::new(10), order);
                    assert_eq!(a.swap(MaybeUninit::uninit(), order).assume_init(), 10);
                }
            }
        }
        compare_exchange();
        fn compare_exchange() {
            unsafe {
                for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                    for (x, y) in [(5, 10), ($ty::MAX, $ty::MIN), ($ty::MIN, $ty::MAX)] {
                        let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(x));
                        assert_eq!(
                            a.compare_exchange(
                                MaybeUninit::new(x),
                                MaybeUninit::new(y),
                                success,
                                failure
                            )
                            .unwrap()
                            .assume_init(),
                            x
                        );
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), y);
                        assert_eq!(
                            a.compare_exchange(
                                MaybeUninit::new(6),
                                MaybeUninit::new(12),
                                success,
                                failure
                            )
                            .unwrap_err()
                            .assume_init(),
                            y
                        );
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), y);
                    }
                }
            }
        }
        compare_exchange_weak();
        fn compare_exchange_weak() {
            unsafe {
                for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                    for x in [4, $ty::MAX, $ty::MIN] {
                        let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(x));
                        assert_eq!(
                            a.compare_exchange_weak(
                                MaybeUninit::new(6),
                                MaybeUninit::new(8),
                                success,
                                failure
                            )
                            .unwrap_err()
                            .assume_init(),
                            x
                        );
                        let mut old = a.load(Ordering::Relaxed);
                        loop {
                            let new = MaybeUninit::new(old.assume_init().wrapping_add(2));
                            match a.compare_exchange_weak(old, new, success, failure) {
                                Ok(_) => break,
                                Err(x) => old = x,
                            }
                        }
                        assert_eq!(a.load(Ordering::Relaxed).assume_init(), x.wrapping_add(2));
                    }
                }
            }
        }
        fetch_update();
        fn fetch_update() {
            unsafe {
                for (success, failure) in COMPARE_EXCHANGE_ORDERINGS {
                    let a = AtomicMaybeUninit::<$ty>::new(MaybeUninit::new(7));
                    assert_eq!(
                        a.fetch_update(success, failure, |_| None).unwrap_err().assume_init(),
                        7
                    );
                    assert_eq!(
                        a.fetch_update(success, failure, |x| Some(MaybeUninit::new(
                            x.assume_init() + 1
                        )))
                        .unwrap()
                        .assume_init(),
                        7
                    );
                    assert_eq!(
                        a.fetch_update(success, failure, |x| Some(MaybeUninit::new(
                            x.assume_init() + 1
                        )))
                        .unwrap()
                        .assume_init(),
                        8
                    );
                    assert_eq!(a.load(Ordering::Relaxed).assume_init(), 9);
                }
            }
        }
        }
    };
}

#[no_mangle]
extern "C" fn main() {
    macro_rules! test_atomic {
        ($ty:ident) => {
            paste::paste! {
                fn [<test_atomic_ $ty>]() {
                    __test_atomic!($ty);
                }
                unsafe {
                    libc::puts(concat!("test test_atomic_", stringify!($ty), " ... \0") as *const str as *const i8);
                }
                [<test_atomic_ $ty>]();
                unsafe {
                    libc::puts("ok\0" as *const str as *const i8);
                }
            }
        };
    }

    cfg_has_atomic_cas! {
        unsafe {
            libc::puts("target_has_cas: true\0" as *const str as *const i8);
        }
    }
    cfg_no_atomic_cas! {
        unsafe {
            libc::puts("target_has_cas: false\0" as *const str as *const i8);
        }
    }
    #[cfg(feature = "isize")]
    test_atomic!(isize);
    #[cfg(feature = "usize")]
    test_atomic!(usize);
    #[cfg(feature = "i8")]
    test_atomic!(i8);
    #[cfg(feature = "u8")]
    test_atomic!(u8);
    #[cfg(feature = "i16")]
    test_atomic!(i16);
    #[cfg(feature = "u16")]
    test_atomic!(u16);
    #[cfg(feature = "i32")]
    test_atomic!(i32);
    #[cfg(feature = "u32")]
    test_atomic!(u32);
    cfg_has_atomic_64! {
        #[cfg(feature = "i64")]
        test_atomic!(i64);
        #[cfg(feature = "u64")]
        test_atomic!(u64);
    }

    unsafe { libc::exit(0) }
}

const LOAD_ORDERINGS: [Ordering; 3] = [Ordering::Relaxed, Ordering::Acquire, Ordering::SeqCst];
const STORE_ORDERINGS: [Ordering; 3] = [Ordering::Relaxed, Ordering::Release, Ordering::SeqCst];
cfg_has_atomic_cas! {
const SWAP_ORDERINGS: [Ordering; 5] =
    [Ordering::Relaxed, Ordering::Release, Ordering::Acquire, Ordering::AcqRel, Ordering::SeqCst];
const COMPARE_EXCHANGE_ORDERINGS: [(Ordering, Ordering); 15] = [
    (Ordering::Relaxed, Ordering::Relaxed),
    (Ordering::Relaxed, Ordering::Acquire),
    (Ordering::Relaxed, Ordering::SeqCst),
    (Ordering::Acquire, Ordering::Relaxed),
    (Ordering::Acquire, Ordering::Acquire),
    (Ordering::Acquire, Ordering::SeqCst),
    (Ordering::Release, Ordering::Relaxed),
    (Ordering::Release, Ordering::Acquire),
    (Ordering::Release, Ordering::SeqCst),
    (Ordering::AcqRel, Ordering::Relaxed),
    (Ordering::AcqRel, Ordering::Acquire),
    (Ordering::AcqRel, Ordering::SeqCst),
    (Ordering::SeqCst, Ordering::Relaxed),
    (Ordering::SeqCst, Ordering::Acquire),
    (Ordering::SeqCst, Ordering::SeqCst),
];
}

#[repr(C)]
pub struct AtomicMaybeUninit<T: Primitive> {
    v: UnsafeCell<MaybeUninit<T>>,
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
    #[inline] // fmt is not hot path, but #[inline] on fmt seems to still be useful: https://github.com/rust-lang/rust/pull/117727
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(core::any::type_name::<Self>())
    }
}
unsafe impl<T: Primitive> Sync for AtomicMaybeUninit<T> {}
impl<T: Primitive> core::panic::RefUnwindSafe for AtomicMaybeUninit<T> {}
impl<T: Primitive> AtomicMaybeUninit<T> {
    #[inline]
    #[must_use]
    pub const fn new(v: MaybeUninit<T>) -> Self {
        Self { v: UnsafeCell::new(v), _align: [] }
    }
    #[inline]
    #[must_use]
    pub unsafe fn from_ptr<'a>(ptr: *mut MaybeUninit<T>) -> &'a Self {
        unsafe { &*(ptr as *mut Self) }
    }
    #[inline]
    pub fn get_mut(&mut self) -> &mut MaybeUninit<T> {
        unsafe { &mut *self.as_ptr() }
    }
    #[inline]
    pub const fn into_inner(self) -> MaybeUninit<T> {
        unsafe { utils::transmute_copy_by_val::<Self, MaybeUninit<T>>(self) }
    }
    #[inline]
    #[cfg_attr(debug_assertions, track_caller)]
    pub fn load(&self, order: Ordering) -> MaybeUninit<T>
    where
        T: AtomicLoad,
    {
        utils::assert_load_ordering(order);
        unsafe { T::atomic_load(self.v.get(), order) }
    }
    #[inline]
    pub fn store(&self, val: MaybeUninit<T>, order: Ordering)
    where
        T: AtomicStore,
    {
        utils::assert_store_ordering(order);
        // Workaround LLVM pre-20 bug: https://github.com/rust-lang/rust/issues/129585#issuecomment-2360273081
        let val = core::hint::black_box(val);
        unsafe { T::atomic_store(self.v.get(), val, order) }
    }
    #[inline]
    pub fn swap(&self, val: MaybeUninit<T>, order: Ordering) -> MaybeUninit<T>
    where
        T: AtomicSwap,
    {
        // Workaround LLVM pre-20 bug: https://github.com/rust-lang/rust/issues/129585#issuecomment-2360273081
        let val = core::hint::black_box(val);
        unsafe { T::atomic_swap(self.v.get(), val, order) }
    }
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
        // Workaround LLVM pre-20 bug: https://github.com/rust-lang/rust/issues/129585#issuecomment-2360273081
        let current = core::hint::black_box(current);
        let new = core::hint::black_box(new);
        let (out, ok) =
            unsafe { T::atomic_compare_exchange(self.v.get(), current, new, success, failure) };
        if ok {
            Ok(out)
        } else {
            Err(out)
        }
    }
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
        // Workaround LLVM pre-20 bug: https://github.com/rust-lang/rust/issues/129585#issuecomment-2360273081
        let current = core::hint::black_box(current);
        let new = core::hint::black_box(new);
        let (out, ok) = unsafe {
            T::atomic_compare_exchange_weak(self.v.get(), current, new, success, failure)
        };
        if ok {
            Ok(out)
        } else {
            Err(out)
        }
    }
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
    #[inline]
    pub const fn as_ptr(&self) -> *mut MaybeUninit<T> {
        self.v.get()
    }
}

macro_rules! int {
    ($ty:ident, $align:ident) => {
        impl crate::raw::Primitive for $ty {}
        static_assert!(
            core::mem::size_of::<AtomicMaybeUninit<$ty>>() == core::mem::size_of::<$ty>()
                && core::mem::align_of::<AtomicMaybeUninit<$ty>>() == core::mem::size_of::<$ty>()
        );
        unsafe impl crate::private::PrimitivePriv for $ty {
            type Align = crate::private::$align;
        }
        impl AtomicMaybeUninit<$ty> {
            #[inline]
            #[must_use]
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

mod private {
    #![allow(missing_debug_implementations)]

    use core::marker::Copy;

    pub unsafe trait PrimitivePriv: Copy {
        type Align;
    }

    #[repr(align(1))]
    pub struct Align1(#[allow(dead_code)] u8);
    #[repr(align(2))]
    pub struct Align2(#[allow(dead_code)] u16);
    #[repr(align(4))]
    pub struct Align4(#[allow(dead_code)] u32);
    #[repr(align(8))]
    pub struct Align8(#[allow(dead_code)] u64);
    #[repr(align(16))]
    pub struct Align16(#[allow(dead_code)] u128);
    #[cfg(target_pointer_width = "16")]
    pub(crate) type AlignPtr = Align2;
    #[cfg(target_pointer_width = "32")]
    pub(crate) type AlignPtr = Align4;
    #[cfg(target_pointer_width = "64")]
    pub(crate) type AlignPtr = Align8;

    // Check that all cfg_ macros work.
    #[allow(unused_imports)]
    use crate::{
        cfg_has_atomic_128, cfg_has_atomic_16, cfg_has_atomic_32, cfg_has_atomic_64,
        cfg_has_atomic_8, cfg_has_atomic_cas, cfg_has_atomic_ptr, cfg_no_atomic_128,
        cfg_no_atomic_16, cfg_no_atomic_32, cfg_no_atomic_64, cfg_no_atomic_8, cfg_no_atomic_cas,
        cfg_no_atomic_ptr, AtomicMaybeUninit,
    };
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

#[inline(never)]
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo<'_>) -> ! {
    // macro_rules! println {
    //     ($($tt:tt)*) => {
    //         use core::fmt::Write as _;
    //         let _ = writeln!(simio::Console, $($tt)*);
    //     };
    // }

    // println!("{info}");
    unsafe {
        libc::puts("panicked\0" as *const str as *const i8);
        libc::abort()
    }
}

mod libc {
    #[link(name = "c")]
    extern "C" {
        pub fn abort() -> !;
        pub fn exit(status: i32) -> !;
        pub fn puts(s: *const i8) -> i32;
    }
}
