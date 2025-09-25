// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Arm (AArch32)

This file is included from other arm*.rs files.
*/

pub(crate) use core::sync::atomic::fence;

const OPT_FOR_SIZE: bool = false; // Currently only for bench

#[rustfmt::skip]
macro_rules! atomic_memcpy {
    ($ty:ident, $size:literal, $suffix:tt) => {
        impl AtomicMemcpy for $ty {
            #[inline]
            unsafe fn atomic_load_memcpy<const DST_ALIGNED: bool>(
                mut dst: *mut MaybeUninit<Self>,
                mut src: *const MaybeUninit<Self>,
                mut count: NonZeroUsize,
            ) {
                if OPT_FOR_SIZE {
                    let mut tmp;
                    // SAFETY: the caller must uphold the safety contract.
                    unsafe {
                        loop {
                            asm!(
                                concat!("ldr", $suffix, " {tmp}, [{src}], #", $size), // atomic { tmp = *src }; src = src.byte_add($size)
                                src = inout(reg) src,
                                tmp = out(reg) tmp,
                                options(nostack, preserves_flags),
                            );
                            if DST_ALIGNED {
                                dst.write(tmp);
                            } else {
                                dst.write_unaligned(tmp);
                            }
                            dst = dst.add(1);
                            match NonZeroUsize::new(count.get() - 1) {
                                Some(v) => count = v,
                                None => return,
                            }
                        }
                    }
                } else {
                    let mut tmp0;
                    let mut tmp1;
                    // SAFETY: the caller must uphold the safety contract.
                    unsafe {
                        if count.get() & 0x1 == 1 {
                            asm!(
                                concat!("ldr", $suffix, " {tmp0}, [{src}], #", $size), // atomic { tmp0 = *src }; src = src.byte_add($size)
                                src = inout(reg) src,
                                tmp0 = out(reg) tmp0,
                                options(nostack, preserves_flags),
                            );
                            if DST_ALIGNED {
                                dst.write(tmp0);
                            } else {
                                dst.write_unaligned(tmp0);
                            }
                            dst = dst.add(1);
                            match NonZeroUsize::new(count.get() - 1) {
                                Some(v) => count = v,
                                None => return,
                            }
                        }
                        loop {
                            asm!(
                                concat!("ldr", $suffix, " {tmp1}, [{src}, #", $size, "]"), // atomic { tmp1 = *src.byte_add($size) }
                                concat!("ldr", $suffix, " {tmp0}, [{src}], #2*", $size),   // atomic { tmp0 = *src }; src = src.byte_add(2*$size)
                                src = inout(reg) src,
                                tmp0 = out(reg) tmp0,
                                tmp1 = out(reg) tmp1,
                                options(nostack, preserves_flags),
                            );
                            if DST_ALIGNED {
                                dst.add(1).write(tmp1);
                                dst.write(tmp0);
                            } else {
                                dst.add(1).write_unaligned(tmp1);
                                dst.write_unaligned(tmp0);
                            }
                            dst = dst.add(2);
                            match NonZeroUsize::new(count.get() - 2) {
                                Some(v) => count = v,
                                None => return,
                            }
                        }
                    }
                }
            }
            #[inline]
            unsafe fn atomic_store_memcpy<const SRC_ALIGNED: bool>(
                mut dst: *mut MaybeUninit<Self>,
                mut src: *const MaybeUninit<Self>,
                mut count: NonZeroUsize,
            ) {
                if OPT_FOR_SIZE {
                    let mut tmp;
                    // SAFETY: the caller must uphold the safety contract.
                    unsafe {
                        loop {
                            if SRC_ALIGNED {
                                tmp = src.read();
                            } else {
                                tmp = src.read_unaligned();
                            }
                            src = src.add(1);
                            asm!(
                                concat!("str", $suffix, " {tmp}, [{dst}], #", $size), // atomic { *dst = tmp }; dst = dst.byte_add($size)
                                dst = inout(reg) dst,
                                tmp = in(reg) tmp,
                                options(nostack, preserves_flags),
                            );
                            match NonZeroUsize::new(count.get() - 1) {
                                Some(v) => count = v,
                                None => return,
                            }
                        }
                    }
                } else {
                    let mut tmp0;
                    let mut tmp1;
                    // SAFETY: the caller must uphold the safety contract.
                    unsafe {
                        if count.get() & 0x1 == 1 {
                            if SRC_ALIGNED {
                                tmp0 = src.read();
                            } else {
                                tmp0 = src.read_unaligned();
                            }
                            src = src.add(1);
                            asm!(
                                concat!("str", $suffix, " {tmp0}, [{dst}], #", $size), // atomic { *dst = tmp0 }; dst = dst.byte_add($size)
                                dst = inout(reg) dst,
                                tmp0 = in(reg) tmp0,
                                options(nostack, preserves_flags),
                            );
                            match NonZeroUsize::new(count.get() - 1) {
                                Some(v) => count = v,
                                None => return,
                            }
                        }
                        loop {
                            if SRC_ALIGNED {
                                tmp1 = src.add(1).read();
                                tmp0 = src.read();
                            } else {
                                tmp1 = src.add(1).read_unaligned();
                                tmp0 = src.read_unaligned();
                            }
                            src = src.add(2);
                            asm!(
                                concat!("str", $suffix, " {tmp1}, [{dst}, #", $size, "]"), // atomic { *dst.byte_add($size) = tmp1 }
                                concat!("str", $suffix, " {tmp0}, [{dst}], #2*", $size),   // atomic { *dst = tmp0 }; dst = dst.byte_add(2*$size)
                                dst = inout(reg) dst,
                                tmp0 = in(reg) tmp0,
                                tmp1 = in(reg) tmp1,
                                options(nostack, preserves_flags),
                            );
                            match NonZeroUsize::new(count.get() - 2) {
                                Some(v) => count = v,
                                None => return,
                            }
                        }
                    }
                }
            }
        }
    };
}

atomic_memcpy!(u8, "1", "b");
atomic_memcpy!(u16, "2", "h");
atomic_memcpy!(u32, "4", "");
