#![allow(clippy::undocumented_unsafe_blocks, clippy::wildcard_imports)]

#[macro_use]
pub(crate) mod helper;

macro_rules! test_common {
    ($int_type:ident) => {
        paste::paste! {
            #[allow(clippy::undocumented_unsafe_blocks)]
            mod [<test_common_ $int_type>] {
                use std::mem::MaybeUninit;

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
                    unsafe {
                        let mut a = AtomicMaybeUninit::<$int_type>::new(MaybeUninit::new(10));
                        assert_eq!(*a.get_mut().as_mut_ptr(), 10);
                        *a.get_mut() = MaybeUninit::new(5);
                        assert_eq!(a.into_inner().assume_init(), 5);
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
test_common!(i8);
test_common!(u8);
test_common!(i16);
test_common!(u16);
test_common!(i32);
test_common!(u32);
test_common!(i64);
test_common!(u64);
test_common!(i128);
test_common!(u128);
