// SPDX-License-Identifier: Apache-2.0 OR MIT

#![allow(dead_code, clippy::undocumented_unsafe_blocks)]

use std::{
    cell::UnsafeCell,
    hint::black_box,
    mem::{self, MaybeUninit},
    sync::{Barrier, atomic::Ordering},
    thread,
};

use atomic_maybe_uninit::PerByteAtomicMaybeUninit;
use criterion::{Criterion, criterion_group, criterion_main};

const WRITER_THREADS: usize = 1;
const READER_THREADS: usize = 2;
const LOAD_ORDERING: Ordering = Ordering::Acquire;
const STORE_ORDERING: Ordering = Ordering::Release;
const N: u32 = 5000;

#[repr(transparent)]
struct SendSync<T>(UnsafeCell<T>);
unsafe impl<T: Send> Send for SendSync<T> {}
unsafe impl<T: Sync> Sync for SendSync<T> {}

fn bench_load_atomic_maybe_uninit<T: Copy + Send + Sync>(v: &SendSync<T>, _val: T) {
    unsafe {
        let a = &*(v.0.get() as *const PerByteAtomicMaybeUninit<T>);
        black_box(a.load(LOAD_ORDERING).assume_init());
    }
}
fn bench_store_atomic_maybe_uninit<T: Copy + Send + Sync>(v: &SendSync<T>, val: T) {
    let a = unsafe { &*(v.0.get() as *const PerByteAtomicMaybeUninit<T>) };
    a.store(MaybeUninit::new(val), STORE_ORDERING);
}
fn bench_concurrent_load_store_atomic_maybe_uninit<T: Copy + Send + Sync>(v: &SendSync<T>, val: T) {
    let a = unsafe { &*(v.0.get() as *const PerByteAtomicMaybeUninit<T>) };
    let barrier = Barrier::new(WRITER_THREADS + READER_THREADS);
    thread::scope(|s| {
        for _ in 0..READER_THREADS {
            s.spawn(|| {
                barrier.wait();
                for _ in 0..N {
                    unsafe {
                        black_box(a.load(LOAD_ORDERING).assume_init());
                    }
                }
            });
        }
        for _ in 0..WRITER_THREADS {
            s.spawn(|| {
                barrier.wait();
                for _ in 0..N {
                    a.store(MaybeUninit::new(val), STORE_ORDERING);
                }
            });
        }
    });
}

fn bench_load_atomic_memcpy<T: Copy + Send + Sync>(v: &SendSync<T>, _val: T) {
    unsafe {
        black_box(atomic_memcpy::atomic_load(v.0.get(), LOAD_ORDERING).assume_init());
    }
}
fn bench_store_atomic_memcpy<T: Copy + Send + Sync>(v: &SendSync<T>, val: T) {
    unsafe {
        atomic_memcpy::atomic_store(v.0.get(), val, STORE_ORDERING);
    }
}
fn bench_concurrent_load_store_atomic_memcpy<T: Copy + Send + Sync>(v: &SendSync<T>, val: T) {
    let barrier = Barrier::new(WRITER_THREADS + READER_THREADS);
    thread::scope(|s| {
        for _ in 0..READER_THREADS {
            s.spawn(|| {
                barrier.wait();
                for _ in 0..N {
                    unsafe {
                        black_box(
                            atomic_memcpy::atomic_load(v.0.get(), LOAD_ORDERING).assume_init(),
                        );
                    }
                }
            });
        }
        for _ in 0..WRITER_THREADS {
            s.spawn(|| {
                barrier.wait();
                for _ in 0..N {
                    unsafe {
                        atomic_memcpy::atomic_store(v.0.get(), val, STORE_ORDERING);
                    }
                }
            });
        }
    });
}

#[derive(Clone, Copy, Default)]
#[repr(C, align(1))]
struct Align1<T>(T);
#[derive(Clone, Copy, Default)]
#[repr(C, align(2))]
struct Align2<T>(T);
#[derive(Clone, Copy, Default)]
#[repr(C, align(4))]
struct Align4<T>(T);
#[derive(Clone, Copy, Default)]
#[repr(C, align(8))]
struct Align8<T>(T);
#[derive(Clone, Copy, Default)]
#[repr(C, align(16))]
struct Align16<T>(T);

macro_rules! b {
    ($b:ident, $bench_fn:ident, $v:expr) => {
        let val1 = black_box($v);
        let val2 = black_box($v);
        $b.iter(|| {
            let v = SendSync(UnsafeCell::new(val1));
            $bench_fn(&v, val2);
            v
        });
    };
}
macro_rules! bg {
    ($c:ident, $group_name:expr, $bench_fn:ident, $v:expr) => {{
        let mut g = $c.benchmark_group($group_name);
        g.bench_function("align1", |b| {
            b!(b, $bench_fn, Align1($v));
        });
        g.bench_function("align2", |b| {
            b!(b, $bench_fn, Align2($v));
        });
        g.bench_function("align4", |b| {
            b!(b, $bench_fn, Align4($v));
        });
        g.bench_function("align8", |b| {
            b!(b, $bench_fn, Align8($v));
        });
    }};
}

fn bench_atomic_maybe_uninit(c: &mut Criterion) {
    assert_eq!(mem::align_of::<Align1<[u8; 2048]>>(), 1);
    assert_eq!(mem::align_of::<Align2<[u8; 2048]>>(), 2);
    assert_eq!(mem::align_of::<Align4<[u8; 2048]>>(), 4);
    assert_eq!(mem::align_of::<Align8<[u8; 2048]>>(), 8);
    assert_eq!(mem::align_of::<Align16<[u8; 2048]>>(), 16);

    bg!(c, "atomic_maybe_uninit/load_u8x8", bench_load_atomic_maybe_uninit, [0u8; 8]);
    bg!(c, "atomic_maybe_uninit/load_u8x16", bench_load_atomic_maybe_uninit, [0u8; 16]);
    bg!(c, "atomic_maybe_uninit/load_u8x32", bench_load_atomic_maybe_uninit, [0u8; 32]);
    bg!(c, "atomic_maybe_uninit/load_u8x64", bench_load_atomic_maybe_uninit, [0u8; 64]);
    bg!(c, "atomic_maybe_uninit/load_u8x256", bench_load_atomic_maybe_uninit, [0u8; 256]);

    bg!(c, "atomic_maybe_uninit/store_u8x16", bench_store_atomic_maybe_uninit, [0u8; 16]);
    bg!(c, "atomic_maybe_uninit/store_u8x32", bench_store_atomic_maybe_uninit, [0u8; 32]);
    bg!(c, "atomic_maybe_uninit/store_u8x64", bench_store_atomic_maybe_uninit, [0u8; 64]);
    bg!(c, "atomic_maybe_uninit/store_u8x256", bench_store_atomic_maybe_uninit, [0u8; 256]);

    bg!(
        c,
        "atomic_maybe_uninit/concurrent_load_store_u8x16",
        bench_concurrent_load_store_atomic_maybe_uninit,
        [0u8; 16]
    );
    bg!(
        c,
        "atomic_maybe_uninit/concurrent_load_store_u8x32",
        bench_concurrent_load_store_atomic_maybe_uninit,
        [0u8; 32]
    );
    bg!(
        c,
        "atomic_maybe_uninit/concurrent_load_store_u8x64",
        bench_concurrent_load_store_atomic_maybe_uninit,
        [0u8; 64]
    );
    bg!(
        c,
        "atomic_maybe_uninit/concurrent_load_store_u8x128",
        bench_concurrent_load_store_atomic_maybe_uninit,
        [0u8; 128]
    );
    bg!(
        c,
        "atomic_maybe_uninit/concurrent_load_store_u8x256",
        bench_concurrent_load_store_atomic_maybe_uninit,
        [0u8; 256]
    );
    bg!(
        c,
        "atomic_maybe_uninit/concurrent_load_store_u8x512",
        bench_concurrent_load_store_atomic_maybe_uninit,
        [0u8; 512]
    );
    bg!(
        c,
        "atomic_maybe_uninit/concurrent_load_store_u8x1024",
        bench_concurrent_load_store_atomic_maybe_uninit,
        [0u8; 1024]
    );
    bg!(
        c,
        "atomic_maybe_uninit/concurrent_load_store_u8x2048",
        bench_concurrent_load_store_atomic_maybe_uninit,
        [0u8; 2048]
    );
    bg!(
        c,
        "atomic_maybe_uninit/concurrent_load_store_u8x4096",
        bench_concurrent_load_store_atomic_maybe_uninit,
        [0u8; 4096]
    );
}

fn bench_atomic_memcpy(c: &mut Criterion) {
    assert_eq!(mem::align_of::<Align1<[u8; 2048]>>(), 1);
    assert_eq!(mem::align_of::<Align2<[u8; 2048]>>(), 2);
    assert_eq!(mem::align_of::<Align4<[u8; 2048]>>(), 4);
    assert_eq!(mem::align_of::<Align8<[u8; 2048]>>(), 8);
    assert_eq!(mem::align_of::<Align16<[u8; 2048]>>(), 16);

    bg!(c, "atomic_memcpy/load_u8x8", bench_load_atomic_memcpy, [0u8; 8]);
    bg!(c, "atomic_memcpy/load_u8x16", bench_load_atomic_memcpy, [0u8; 16]);
    bg!(c, "atomic_memcpy/load_u8x32", bench_load_atomic_memcpy, [0u8; 32]);
    bg!(c, "atomic_memcpy/load_u8x64", bench_load_atomic_memcpy, [0u8; 64]);
    bg!(c, "atomic_memcpy/load_u8x256", bench_load_atomic_memcpy, [0u8; 256]);

    bg!(c, "atomic_memcpy/store_u8x16", bench_store_atomic_memcpy, [0u8; 16]);
    bg!(c, "atomic_memcpy/store_u8x32", bench_store_atomic_memcpy, [0u8; 32]);
    bg!(c, "atomic_memcpy/store_u8x64", bench_store_atomic_memcpy, [0u8; 64]);
    bg!(c, "atomic_memcpy/store_u8x256", bench_store_atomic_memcpy, [0u8; 256]);

    bg!(
        c,
        "atomic_memcpy/concurrent_load_store_u8x16",
        bench_concurrent_load_store_atomic_memcpy,
        [0u8; 16]
    );
    bg!(
        c,
        "atomic_memcpy/concurrent_load_store_u8x32",
        bench_concurrent_load_store_atomic_memcpy,
        [0u8; 32]
    );
    bg!(
        c,
        "atomic_memcpy/concurrent_load_store_u8x64",
        bench_concurrent_load_store_atomic_memcpy,
        [0u8; 64]
    );
    bg!(
        c,
        "atomic_memcpy/concurrent_load_store_u8x128",
        bench_concurrent_load_store_atomic_memcpy,
        [0u8; 128]
    );
    bg!(
        c,
        "atomic_memcpy/concurrent_load_store_u8x256",
        bench_concurrent_load_store_atomic_memcpy,
        [0u8; 256]
    );
    bg!(
        c,
        "atomic_memcpy/concurrent_load_store_u8x512",
        bench_concurrent_load_store_atomic_memcpy,
        [0u8; 512]
    );
    bg!(
        c,
        "atomic_memcpy/concurrent_load_store_u8x1024",
        bench_concurrent_load_store_atomic_memcpy,
        [0u8; 1024]
    );
    bg!(
        c,
        "atomic_memcpy/concurrent_load_store_u8x2048",
        bench_concurrent_load_store_atomic_memcpy,
        [0u8; 2048]
    );
    bg!(
        c,
        "atomic_memcpy/concurrent_load_store_u8x4096",
        bench_concurrent_load_store_atomic_memcpy,
        [0u8; 4096]
    );
}

criterion_group!(
    benches,
    //
    bench_atomic_maybe_uninit,
    bench_atomic_memcpy,
);
criterion_main!(benches);
