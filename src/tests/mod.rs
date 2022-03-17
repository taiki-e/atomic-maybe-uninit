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
                        let _f = std::format!("{:?}", a);
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

use core::{mem::MaybeUninit, sync::atomic::AtomicUsize};
use std::{sync::atomic::Ordering, vec::Vec};

use crossbeam_utils::thread;

use crate::AtomicMaybeUninit;

const N: usize = if cfg!(debug_assertions) { 500_000 } else { 2_000_000 };

macro_rules! stress_test {
    ($write:ident, $load_order:ident, $store_order:ident) => {
        unsafe {
            let v = &(0..N).map(|_| AtomicUsize::new(0)).collect::<Vec<_>>();
            let a = &AtomicMaybeUninit::from(0_usize);
            thread::scope(|s| {
                s.spawn(|_| {
                    for i in 0..N {
                        if let Some(b) = (a.load(Ordering::$load_order).assume_init()
                            as *const AtomicUsize)
                            .as_ref()
                        {
                            assert_eq!(b.load(Ordering::Relaxed), 1, "i={i}");
                        }
                    }
                });
                for b in v {
                    b.store(1, Ordering::Relaxed);
                    a.$write(MaybeUninit::new(b as *const _ as usize), Ordering::$store_order);
                }
            })
            .unwrap();
        }
    };
}

// This test should panic on architectures with weak memory models.
#[test]
// This should be `any(target_arch = ...)`, but qemu-user running on x86_64 does
// not seem to support weak memory emulation.
// Therefore, explicitly enable should_panic only on actual aarch64 hardware.
#[cfg_attr(weak_memory, should_panic)]
fn stress_load_relaxed_store_relaxed() {
    stress_test!(store, Relaxed, Relaxed);
}
#[test]
// `asm!` implies a compiler fence, so it seems the relaxed load written in
// `asm!` behaves like a consume load on architectures with weak memory models.
// #[cfg_attr(weak_memory, should_panic)]
fn stress_load_relaxed_store_release() {
    stress_test!(store, Relaxed, Release);
}
// This test should panic on architectures with weak memory models.
#[test]
#[cfg_attr(weak_memory, should_panic)]
fn stress_load_acquire_store_relaxed() {
    stress_test!(store, Acquire, Relaxed);
}
#[test]
fn stress_load_acquire_store_release() {
    stress_test!(store, Acquire, Release);
}
#[test]
fn stress_load_seqcst_store_seqcst() {
    stress_test!(store, SeqCst, SeqCst);
}

// This test should panic on architectures with weak memory models.
#[test]
#[cfg_attr(weak_memory, should_panic)]
fn stress_load_relaxed_swap_relaxed() {
    stress_test!(swap, Relaxed, Relaxed);
}
#[test]
// `asm!` implies a compiler fence, so it seems the relaxed load written in
// `asm!` behaves like a consume load on architectures with weak memory models.
// #[cfg_attr(weak_memory, should_panic)]
fn stress_load_relaxed_swap_release() {
    stress_test!(swap, Relaxed, Release);
}
// This test should panic on architectures with weak memory models.
#[test]
#[cfg_attr(weak_memory, should_panic)]
fn stress_load_acquire_swap_relaxed() {
    stress_test!(swap, Acquire, Relaxed);
}
#[test]
fn stress_load_acquire_swap_release() {
    stress_test!(swap, Acquire, Release);
}
#[test]
fn stress_load_acquire_swap_acqrel() {
    stress_test!(swap, Acquire, AcqRel);
}
#[test]
fn stress_load_seqcst_swap_seqcst() {
    stress_test!(swap, SeqCst, SeqCst);
}
