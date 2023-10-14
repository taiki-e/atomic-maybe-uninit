// SPDX-License-Identifier: Apache-2.0 OR MIT

#![allow(
    clippy::alloc_instead_of_core,
    clippy::std_instead_of_alloc,
    clippy::std_instead_of_core,
    clippy::undocumented_unsafe_blocks,
    clippy::wildcard_imports
)]

#[macro_use]
pub(crate) mod helper;

use crate::*;

macro_rules! test_common {
    ($int_type:ident) => {
        paste::paste! {
            #[allow(
                clippy::alloc_instead_of_core,
                clippy::std_instead_of_alloc,
                clippy::std_instead_of_core,
                clippy::undocumented_unsafe_blocks,
            )]
            mod [<test_common_ $int_type>] {
                use std::{
                    boxed::Box,
                    mem::{self, MaybeUninit},
                };

                use crate::AtomicMaybeUninit;

                #[test]
                fn assert_auto_traits() {
                    fn _assert<
                        T: Send + Sync + Unpin + std::panic::UnwindSafe + std::panic::RefUnwindSafe,
                    >() {
                    }
                    _assert::<AtomicMaybeUninit<$int_type>>();
                }
                #[test]
                fn accessor() {
                    #[repr(C, align(16))]
                    struct Align16<T>(T);
                    #[allow(clippy::ptr_as_ptr)]
                    unsafe {
                        let mut a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(10));
                        assert_eq!(*a.get_mut().as_mut_ptr(), 10);
                        assert_eq!(a.as_ptr() as *const (), &a as *const _ as *const ());
                        *a.get_mut() = MaybeUninit::new(5);
                        assert_eq!(a.into_inner().assume_init(), 5);

                        let ptr: *mut Align16<MaybeUninit<$int_type>>
                            = Box::into_raw(Box::new(Align16(MaybeUninit::new(0))));
                        assert!(
                            ptr as usize % mem::align_of::<AtomicMaybeUninit<$int_type>>() == 0
                        );
                        {
                            let a = AtomicMaybeUninit::<$int_type>::from_ptr(
                                ptr.cast::<MaybeUninit<$int_type>>()
                            );
                            *a.as_ptr() = MaybeUninit::new(1);
                        }
                        assert_eq!((*ptr).0.assume_init(), 1);
                        drop(Box::from_raw(ptr));
                    }
                }
                #[test]
                fn impls() {
                    unsafe {
                        let a = AtomicMaybeUninit::<$int_type>::from(MaybeUninit::new(0));
                        let b = AtomicMaybeUninit::<$int_type>::from(0);
                        assert_eq!(
                            std::format!("{:?}", a),
                            concat!("atomic_maybe_uninit::AtomicMaybeUninit<", stringify!($int_type), ">"),
                        );
                        assert_eq!(a.into_inner().assume_init(), b.into_inner().assume_init());
                    }
                }
            }
        }
    };
}

test_common!(isize);
test_common!(usize);
cfg_has_atomic_ptr! {
    test_atomic!(isize);
    test_atomic!(usize);
}
test_common!(i8);
test_common!(u8);
cfg_has_atomic_8! {
    test_atomic!(i8);
    test_atomic!(u8);
    // load/store/swap implementation is not affected by signedness, so it is
    // enough to test only unsigned types.
    stress_test!(u8);
}
test_common!(i16);
test_common!(u16);
cfg_has_atomic_16! {
    test_atomic!(i16);
    test_atomic!(u16);
    stress_test!(u16);
}
test_common!(i32);
test_common!(u32);
cfg_has_atomic_32! {
    test_atomic!(i32);
    test_atomic!(u32);
    stress_test!(u32);
}
test_common!(i64);
test_common!(u64);
cfg_has_atomic_64! {
    test_atomic!(i64);
    test_atomic!(u64);
    stress_test!(u64);
}
test_common!(i128);
test_common!(u128);
cfg_has_atomic_128! {
    test_atomic!(i128);
    test_atomic!(u128);
    stress_test!(u128);
}
