// SPDX-License-Identifier: Apache-2.0 OR MIT

#![allow(dead_code, clippy::undocumented_unsafe_blocks)]

use std::{
    cell::UnsafeCell,
    hint::black_box,
    mem::{self, MaybeUninit},
    sync::{
        Barrier,
        atomic::{AtomicBool, Ordering},
    },
    thread,
};

use atomic_maybe_uninit::PerByteAtomicMaybeUninit;
use criterion::{Bencher, Criterion, Throughput, criterion_group, criterion_main};
use test_helper::function_name;

const LOAD_ORDERING: Ordering = Ordering::Acquire;
const STORE_ORDERING: Ordering = Ordering::Release;
const N: u32 = 5000;

#[repr(transparent)]
struct SendSync<T>(UnsafeCell<T>);
unsafe impl<T: Send> Send for SendSync<T> {}
unsafe impl<T: Sync> Sync for SendSync<T> {}

fn bench_local<T: Copy + Send + Sync + 'static>(
    b: &mut Bencher<'_>,
    val: T,
    load: impl Fn(&SendSync<MaybeUninit<T>>, &mut MaybeUninit<T>) + Copy + Send + Sync + 'static,
    store: impl Fn(&SendSync<MaybeUninit<T>>, &MaybeUninit<T>) + Copy + Send + Sync + 'static,
    bench_load: bool,
) {
    let v = SendSync(UnsafeCell::new(black_box(MaybeUninit::new(val))));
    if bench_load {
        let mut out = black_box(MaybeUninit::uninit());
        b.iter(|| {
            load(black_box(&v), black_box(&mut out));
        });
    } else {
        let val = black_box(MaybeUninit::new(val));
        b.iter(|| {
            store(black_box(&v), black_box(&val));
        });
    }
}
fn bench_concurrent_contended<T: Copy + Send + Sync + 'static>(
    b: &mut Bencher<'_>,
    val: T,
    load: impl Fn(&SendSync<MaybeUninit<T>>, &mut MaybeUninit<T>) + Copy + Send + Sync + 'static,
    store: impl Fn(&SendSync<MaybeUninit<T>>, &MaybeUninit<T>) + Copy + Send + Sync + 'static,
    bench_load: bool,
) {
    let barrier = Barrier::new(2);
    let v = SendSync(UnsafeCell::new(black_box(MaybeUninit::new(val))));
    let finished = AtomicBool::new(false);
    thread::scope(|s| {
        if bench_load {
            s.spawn(|| {
                let val = black_box(MaybeUninit::new(val));
                barrier.wait();
                while !finished.load(Ordering::Relaxed) {
                    for _ in 0..N * 2 {
                        store(black_box(&v), black_box(&val));
                    }
                }
            });
            let mut out = black_box(MaybeUninit::uninit());
            barrier.wait();
            b.iter(|| {
                for _ in 0..N {
                    load(black_box(&v), black_box(&mut out));
                }
            });
        } else {
            s.spawn(|| {
                let mut out = black_box(MaybeUninit::uninit());
                barrier.wait();
                while !finished.load(Ordering::Relaxed) {
                    for _ in 0..N * 2 {
                        load(black_box(&v), black_box(&mut out));
                    }
                }
            });
            let val = black_box(MaybeUninit::new(val));
            barrier.wait();
            b.iter(|| {
                for _ in 0..N {
                    store(black_box(&v), black_box(&val));
                }
            });
        }
        finished.store(true, Ordering::Relaxed);
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
#[derive(Clone, Copy, Default)]
#[repr(C, align(32))]
struct Align32<T>(T);
#[derive(Clone, Copy, Default)]
#[repr(C, align(64))]
struct Align64<T>(T);

macro_rules! bench {
    ($c:ident) => {{
        bench!(@1; $c, 8);
        bench!(@1; $c, 16);
        bench!(@1; $c, 32);
        bench!(@1; $c, 64);
        bench!(@1; $c, 128);
        bench!(@1; $c, 256);
        bench!(@1; $c, 512);
        bench!(@1; $c, 4096);
    }};
    (@1; $c:ident, $len:expr) => {{
        bench!(@0; $c, concat!(stringify!($len), "/align1"), Align1([0u8; $len]));
        // if $len >= 2 {
        //     bench!(@0; $c, concat!(stringify!($len), "/align2"), Align2([0u8; $len]));
        // }
        // if $len >= 4 {
        //     bench!(@0; $c, concat!(stringify!($len), "/align4"), Align4([0u8; $len]));
        // }
        // if $len >= 8 {
        //     bench!(@0; $c, concat!(stringify!($len), "/align8"), Align8([0u8; $len]));
        // }
        // if $len >= 16 {
        //     bench!(@0; $c, concat!(stringify!($len), "/align16"), Align16([0u8; $len]));
        // }
        // if $len >= 32 {
        //     bench!(@0; $c, concat!(stringify!($len), "/align32"), Align32([0u8; $len]));
        // }
        // if $len >= 64 {
        //     bench!(@0; $c, concat!(stringify!($len), "/align64"), Align64([0u8; $len]));
        // }
    }};
    (@0; $c:ident, $group_name:expr, $v:expr) => {{
        let mut g = $c.benchmark_group(
            format!("{}/{}", function_name!().strip_prefix("bench_").unwrap(), $group_name)
        );
        g.throughput(Throughput::Bytes(mem::size_of_val(&$v) as u64));
        g.bench_function("load", |b| {
            bench_local(b, $v, load, store, true);
        });
        g.bench_function("store", |b| {
            bench_local(b, $v, load, store, false);
        });
        g.throughput(Throughput::Bytes(mem::size_of_val(&$v) as u64 * N as u64));
        g.bench_function("load_contended", |b| {
            bench_concurrent_contended(b, $v, load, store, true);
        });
        g.bench_function("store_contended", |b| {
            bench_concurrent_contended(b, $v, load, store, false);
        });
    }};
}

fn bench_atomic_maybe_uninit(c: &mut Criterion) {
    fn load<T: Copy + Send + Sync>(v: &SendSync<MaybeUninit<T>>, out: &mut MaybeUninit<T>) {
        unsafe {
            let a = &*(v.0.get() as *const PerByteAtomicMaybeUninit<T>);
            a.load_to(out, LOAD_ORDERING);
        }
    }
    fn store<T: Copy + Send + Sync>(v: &SendSync<MaybeUninit<T>>, val: &MaybeUninit<T>) {
        let a = unsafe { &*(v.0.get() as *const PerByteAtomicMaybeUninit<T>) };
        a.store_from(val, STORE_ORDERING);
    }
    bench!(c);
}

// Note: this is UB for contended cases
fn bench_libc_memcpy_ub(c: &mut Criterion) {
    fn load<T: Copy + Send + Sync>(v: &SendSync<MaybeUninit<T>>, out: &mut MaybeUninit<T>) {
        unsafe {
            libc::memcpy(
                out.as_mut_ptr().cast::<libc::c_void>(),
                v.0.get().cast::<libc::c_void>(),
                mem::size_of::<T>(),
            );
        }
        match LOAD_ORDERING {
            Ordering::Relaxed => { /* no-op */ }
            order => core::sync::atomic::fence(order),
        }
    }
    fn store<T: Copy + Send + Sync>(v: &SendSync<MaybeUninit<T>>, val: &MaybeUninit<T>) {
        match STORE_ORDERING {
            Ordering::Relaxed => { /* no-op */ }
            order => core::sync::atomic::fence(order),
        }
        unsafe {
            libc::memcpy(
                v.0.get().cast::<libc::c_void>(),
                val.as_ptr().cast::<libc::c_void>(),
                mem::size_of::<T>(),
            );
        }
    }
    bench!(c);
}

// Note: this is UB for contended cases
fn bench_ptr_volatile_ub(c: &mut Criterion) {
    fn load<T: Copy + Send + Sync>(v: &SendSync<MaybeUninit<T>>, out: &mut MaybeUninit<T>) {
        unsafe {
            *out = v.0.get().read_volatile();
        }
        match LOAD_ORDERING {
            Ordering::Relaxed => { /* no-op */ }
            order => core::sync::atomic::fence(order),
        }
    }
    fn store<T: Copy + Send + Sync>(v: &SendSync<MaybeUninit<T>>, val: &MaybeUninit<T>) {
        match STORE_ORDERING {
            Ordering::Relaxed => { /* no-op */ }
            order => core::sync::atomic::fence(order),
        }
        unsafe {
            v.0.get().write_volatile(*val);
        }
    }
    bench!(c);
}

fn bench_atomic_memcpy(c: &mut Criterion) {
    fn load<T: Copy + Send + Sync>(v: &SendSync<MaybeUninit<T>>, out: &mut MaybeUninit<T>) {
        unsafe {
            *out = atomic_memcpy::atomic_load(v.0.get().cast::<T>(), LOAD_ORDERING);
        }
    }
    fn store<T: Copy + Send + Sync>(v: &SendSync<MaybeUninit<T>>, val: &MaybeUninit<T>) {
        unsafe {
            atomic_memcpy::atomic_store(v.0.get(), *val, STORE_ORDERING);
        }
    }
    bench!(c);
}

criterion_group!(
    benches,
    //
    bench_atomic_maybe_uninit,
    bench_libc_memcpy_ub,
    // bench_ptr_volatile_ub,
    // bench_atomic_memcpy,
);
criterion_main!(benches);
