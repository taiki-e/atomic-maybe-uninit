// SPDX-License-Identifier: Apache-2.0 OR MIT

// https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0750r1.html
// https://github.com/jfbastien/stdconsume
// https://github.com/WebKit/WebKit/blob/5b3a80e263160410767442939b0b7b498fc36b45/Source/WTF/wtf/Atomics.h#L365
// https://stackoverflow.com/questions/55741148/memory-order-consume-usage-in-c11
// https://preshing.com/20140709/the-purpose-of-memory_order_consume-in-cpp11/
// https://preshing.com/20141124/fixing-gccs-implementation-of-memory_order_consume/
// https://github.com/ARM-software/progress64/blob/12230fa3a19db365a9f2e2820bf58ff571348dbf/src/arch/aarch64.h#L16

// Arm: https://developer.arm.com/documentation/ddi0406/cb/Appendixes/Barrier-Litmus-Tests/Simple-ordering-and-barrier-cases/Address-dependency-with-object-construction
//      https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Application-Level-Memory-Model/Memory-access-order/Ordering-requirements-for-memory-accesses
// RISC-V: https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-2336fdc-2025-03-19/src/mm-eplan.adoc#syntactic-dependencies-rules-9-11
// Arm, PowerPC: https://stackoverflow.com/questions/37222999/convert-c-to-assembly-with-predicated-instruction/37224546#comment61984046_37224546
// - PowerPC: Section 1.7.1 "Storage Access Ordering" of Power ISA 3.1C Book II
// SPARCV9: Section D.3.3 "Dependence Order" of of the SPARC Architecture Manual, Version 9
// MIPS, LoongArch, C-SKY, Xtensa: TODO: not 100% sure this is guaranteed: https://stackoverflow.com/questions/4023026/mips-curiosity-faster-way-of-clearing-a-register#comment67702346_4032346

// TODO:
// - docs
// - adjust dependent API to prevent misuse
// - move litmus tests to src/tests as stress_tests_consume

use core::{fmt, mem::MaybeUninit, ops, ptr::NonNull};

use crate::{cfg_has_fast_consume, cfg_no_fast_consume};

mod sealed {
    #[allow(unknown_lints, unnameable_types)] // Not public API. unnameable_types is available on Rust 1.79+
    pub trait Sealed {}
}

#[derive(Clone, Copy)]
#[non_exhaustive]
#[repr(C)]
pub struct Dependent<T> {
    pub val: T,
    pub dep: Dependency,
}

impl<T> Dependent<T> {
    #[inline(always)]
    pub const fn new_no_dep(val: T) -> Self {
        Self { val, dep: Dependency::NO_DEP }
    }
    #[inline(always)]
    pub fn map_val<U, F: FnOnce(T) -> U>(self, f: F) -> Dependent<U> {
        Dependent { val: f(self.val), dep: self.dep }
    }
}
impl<T> Dependent<MaybeUninit<T>> {
    #[inline(always)]
    pub const unsafe fn assume_init(self) -> Dependent<T> {
        // SAFETY: the caller must uphold the safety contract.
        Dependent { val: unsafe { self.val.assume_init() }, dep: self.dep }
    }
}
impl<T> Dependent<*const T> {
    #[inline(always)]
    pub fn cast<U>(self) -> Dependent<*const U> {
        Dependent { val: self.val.cast::<U>(), dep: self.dep }
    }
}
impl<T> Dependent<*mut T> {
    #[inline(always)]
    pub fn cast<U>(self) -> Dependent<*mut U> {
        Dependent { val: self.val.cast::<U>(), dep: self.dep }
    }
}
impl<T> Dependent<NonNull<T>> {
    #[inline(always)]
    pub fn cast<U>(self) -> Dependent<NonNull<U>> {
        Dependent { val: self.val.cast::<U>(), dep: self.dep }
    }
}
impl<T: fmt::Debug> fmt::Debug for Dependent<T> {
    #[inline] // fmt is not hot path, but #[inline] on fmt seems to still be useful: https://github.com/rust-lang/rust/pull/117727
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        fmt::Debug::fmt(&self.val, f)
    }
}
impl<T: fmt::Display> fmt::Display for Dependent<T> {
    #[inline] // fmt is not hot path, but #[inline] on fmt seems to still be useful: https://github.com/rust-lang/rust/pull/117727
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        fmt::Display::fmt(&self.val, f)
    }
}
impl<T: fmt::Pointer> fmt::Pointer for Dependent<T> {
    #[inline] // fmt is not hot path, but #[inline] on fmt seems to still be useful: https://github.com/rust-lang/rust/pull/117727
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        fmt::Pointer::fmt(&self.val, f)
    }
}

pub trait WithDependency: sealed::Sealed + Sized {
    #[must_use]
    fn with_dep(self, dep: Dependency) -> Self;
}
impl<T> sealed::Sealed for &T {}
impl<T> sealed::Sealed for &mut T {}
impl<T> sealed::Sealed for *const T {}
impl<T> sealed::Sealed for *mut T {}
impl<T> sealed::Sealed for NonNull<T> {}

cfg_has_fast_consume! {
    use crate::arch;
    #[cfg(atomic_maybe_uninit_no_strict_provenance)]
    use crate::utils::ptr::MutPtrExt as _;

    // The value of this type is always zero, but any non-Copy operation on
    // this type must be done in non-pure inline assembly.
    pub(crate) type DependencyType = MaybeUninit<usize>;
    impl<T> Dependent<T> {
        #[inline(always)]
        pub(crate) const fn from_parts(val: T, dep: DependencyType) -> Self {
            Self { val, dep: Dependency { dep } }
        }
    }
    #[allow(missing_debug_implementations)]
    #[derive(Clone, Copy)]
    #[repr(transparent)]
    pub struct Dependency {
        dep: DependencyType,
    }
    impl Dependency {
        const NO_DEP: Self = Self { dep: MaybeUninit::new(0) };
    }
    impl ops::BitOr for Dependency {
        type Output = Self;
        #[inline(always)]
        fn bitor(self, rhs: Self) -> Self::Output {
            Self { dep: arch::dep_with_dep(self.dep, rhs.dep) }
        }
    }
    impl ops::BitOrAssign for Dependency {
        #[inline(always)]
        fn bitor_assign(&mut self, rhs: Self) {
            *self = *self | rhs;
        }
    }
    impl<T> WithDependency for &T {
        #[inline(always)]
        fn with_dep(self, dep: Dependency) -> Self {
            // SAFETY: ptr_with_dep doesn't modify the actual address.
            unsafe {
                &*(arch::ptr_with_dep(self as *const T as *mut u8, dep.dep) as *const T)
            }
        }
    }
    impl<T> WithDependency for &mut T {
        #[inline(always)]
        fn with_dep(self, dep: Dependency) -> Self {
            // SAFETY: ptr_with_dep doesn't modify the actual address.
            unsafe {
                &mut *(arch::ptr_with_dep((self as *mut T).cast::<u8>(), dep.dep).cast::<T>())
            }
        }
    }
    impl<T> WithDependency for *const T {
        #[inline(always)]
        fn with_dep(self, dep: Dependency) -> Self {
            arch::ptr_with_dep(self as *mut u8, dep.dep) as *const T
        }
    }
    impl<T> WithDependency for *mut T {
        #[inline(always)]
        fn with_dep(self, dep: Dependency) -> Self {
            arch::ptr_with_dep(self.cast::<u8>(), dep.dep).cast::<T>()
        }
    }
    impl<T> WithDependency for NonNull<T> {
        #[inline(always)]
        fn with_dep(self, dep: Dependency) -> Self {
            // SAFETY: ptr_with_dep doesn't modify the actual address.
            unsafe {
                Self::new_unchecked(
                    arch::ptr_with_dep(self.as_ptr().cast::<u8>(), dep.dep).cast::<T>()
                )
            }
        }
    }
} // cfg_has_fast_consume!

cfg_no_fast_consume! {
    #[allow(missing_debug_implementations)]
    #[derive(Clone, Copy)]
    #[non_exhaustive]
    pub struct Dependency;
    impl Dependency {
        const NO_DEP: Self = Self;
    }
    impl ops::BitOr for Dependency {
        type Output = Self;
        #[inline(always)]
        fn bitor(self, _: Self) -> Self::Output {
            self
        }
    }
    impl ops::BitOrAssign for Dependency {
        #[inline(always)]
        fn bitor_assign(&mut self, _: Self) {}
    }
    impl<T> WithDependency for &T {
        #[inline(always)]
        fn with_dep(self, _: Dependency) -> Self {
            self
        }
    }
    impl<T> WithDependency for &mut T {
        #[inline(always)]
        fn with_dep(self, _: Dependency) -> Self {
            self
        }
    }
    impl<T> WithDependency for *const T {
        #[inline(always)]
        fn with_dep(self, _: Dependency) -> Self {
            self
        }
    }
    impl<T> WithDependency for *mut T {
        #[inline(always)]
        fn with_dep(self, _: Dependency) -> Self {
            self
        }
    }
    impl<T> WithDependency for NonNull<T> {
        #[inline(always)]
        fn with_dep(self, _: Dependency) -> Self {
            self
        }
    }
} // cfg_no_fast_consume!

#[cfg(test)]
#[allow(
    clippy::missing_transmute_annotations,
    clippy::std_instead_of_alloc,
    clippy::std_instead_of_core,
    clippy::undocumented_unsafe_blocks
)]
mod tests {
    use std::{
        mem::{self, MaybeUninit},
        sync::atomic::{AtomicUsize, Ordering},
        thread,
    };

    use super::*;
    use crate::AtomicMaybeUninit;

    #[test]
    fn litmus1() {
        let n: usize = if cfg!(valgrind) {
            50
        } else if option_env!("GITHUB_ACTIONS").is_some() && cfg!(not(target_os = "linux")) {
            // GitHub Actions' macOS and Windows runners are slow.
            5_000
        } else {
            50_000
        };
        let a = &AtomicUsize::new(0);
        let b = &AtomicMaybeUninit::<usize>::new(MaybeUninit::new(0));
        let ready = &AtomicUsize::new(0);
        thread::scope(|s| {
            for _ in 0..n {
                a.store(0, Ordering::Relaxed);
                b.store(MaybeUninit::new(0), Ordering::Relaxed);
                let h_a = s.spawn(|| {
                    while ready.load(Ordering::Relaxed) == 0 {}
                    a.store(1, Ordering::Relaxed);
                    b.store(unsafe { mem::transmute(a.as_ptr()) }, Ordering::Release);
                });
                let h_b = s.spawn(|| {
                    while ready.load(Ordering::Relaxed) == 0 {}
                    // let mut p = b.load(Ordering::Relaxed);
                    // let mut p = b.load(Ordering::Acquire);
                    let mut p = b.load_consume();
                    while unsafe { mem::transmute::<_, *mut usize>(p.val).is_null() } {
                        // p = b.load(Ordering::Relaxed);
                        // p = b.load(Ordering::Acquire);
                        p = b.load_consume();
                    }
                    // unsafe {
                    //     assert_eq!((*(p as *const AtomicUsize)).load(Ordering::Relaxed), 1);
                    // }
                    // unsafe {
                    //     // compiler can also use a instead of p.val.
                    //     if p.val == a as *const _ as *mut _ {
                    //         assert_eq!((*(p.val as *const AtomicUsize)).load(Ordering::Relaxed), 1);
                    //     } else {
                    //         unreachable!()
                    //     }
                    // }
                    // unsafe {
                    //     assert_eq!((*(a as *const AtomicUsize)).load(Ordering::Relaxed), 1);
                    // }
                    // assert_eq!(a.load(Ordering::Relaxed), 1);
                    let a = a.with_dep(p.dep).load(Ordering::Relaxed);
                    assert_eq!(a, 1, "a={a}");
                });
                ready.store(1, Ordering::Relaxed);
                h_a.join().unwrap();
                h_b.join().unwrap();
            }
        });
    }
}
