// SPDX-License-Identifier: Apache-2.0 OR MIT

/*
Arm (AArch32)

This file is included from other arm*.rs files.
*/

#[rustfmt::skip]
macro_rules! atomic_memcpy {
    ($ty:ident, $size:literal, $suffix:tt) => {
        #[cfg(any(
            not(any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode")),
            any(target_feature = "thumb2", atomic_maybe_uninit_target_feature = "thumb2"),
        ))]
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("ldr", $suffix, " {tmp0}, [{src}], #", $size), // atomic { tmp0 = *src }; src = src.byte_add($size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("ldr", $suffix, " {tmp1}, [{src}, #", $size, "]"), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("ldr", $suffix, " {tmp0}, [{src}], #2*", $size),   // atomic { tmp0 = *src }; src = src.byte_add(2*$size)
                    src = inout(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("str", $suffix, " {tmp0}, [{dst}], #", $size), // atomic { *dst = tmp0 }; dst = dst.byte_add($size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("str", $suffix, " {tmp1}, [{dst}, #", $size, "]"), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("str", $suffix, " {tmp0}, [{dst}], #2*", $size),   // atomic { *dst = tmp0 }; dst = dst.byte_add(2*$size)
                    dst = inout(reg) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
        }
        // Thumb1 doesn't support post-increment syntax.
        // (increment is handled by {load,store}_memcpy!)
        #[cfg(not(any(
            not(any(target_feature = "thumb-mode", atomic_maybe_uninit_target_feature = "thumb-mode")),
            any(target_feature = "thumb2", atomic_maybe_uninit_target_feature = "thumb2"),
        )))]
        impl AtomicMemcpy for $ty {
            load_memcpy! { $ty, |src, tmp0, tmp1|
                asm!(
                    concat!("ldr", $suffix, " {tmp0}, [{src}]"), // atomic { tmp0 = *src }
                    src = in(reg) src,
                    tmp0 = out(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("ldr", $suffix, " {tmp1}, [{src}, #", $size, "]"), // atomic { tmp1 = *src.byte_add($size) }
                    concat!("ldr", $suffix, " {tmp0}, [{src}]"),               // atomic { tmp0 = *src }
                    src = in(reg) src,
                    tmp0 = out(reg) tmp0,
                    tmp1 = out(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
            store_memcpy! { $ty, |dst, tmp0, tmp1|
                asm!(
                    concat!("str", $suffix, " {tmp0}, [{dst}]"), // atomic { *dst = tmp0 }
                    dst = in(reg) dst,
                    tmp0 = in(reg) tmp0,
                    options(nostack, preserves_flags),
                ),
                asm!(
                    concat!("str", $suffix, " {tmp1}, [{dst}, #", $size, "]"), // atomic { *dst.byte_add($size) = tmp1 }
                    concat!("str", $suffix, " {tmp0}, [{dst}]"),               // atomic { *dst = tmp0 }
                    dst = in(reg) dst,
                    tmp0 = in(reg) tmp0,
                    tmp1 = in(reg) tmp1,
                    options(nostack, preserves_flags),
                ),
            }
        }
    };
}

atomic_memcpy!(u8, "1", "b");
atomic_memcpy!(u16, "2", "h");
atomic_memcpy!(u32, "4", "");
