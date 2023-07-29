// Helper for implementing sub-word atomic operations using word-sized LL/SC loop or CAS loop.

use core::mem;

use super::XSize;

type MinWord = u32;

// Refs: https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/llvm/lib/CodeGen/AtomicExpandPass.cpp#L699
// (aligned_ptr, shift, mask)
#[inline]
pub(crate) fn create_mask_values<T>(ptr: *mut T) -> (*mut MinWord, XSize, XSize) {
    let ptr_mask = mem::size_of::<MinWord>() - 1;
    let aligned_ptr = strict::with_addr(ptr, ptr as usize & !ptr_mask).cast::<MinWord>();
    let ptr_lsb = if cfg!(any(
        target_arch = "riscv32",
        target_arch = "riscv64",
        target_arch = "loongarch64",
        target_arch = "s390x",
    )) {
        // We use 32-bit wrapping shift instructions on these platforms.
        ptr as usize
    } else {
        ptr as usize & ptr_mask
    };
    let shift = if cfg!(any(target_endian = "little", target_arch = "s390x")) {
        ptr_lsb.wrapping_mul(8)
    } else {
        (ptr_lsb ^ (mem::size_of::<MinWord>() - mem::size_of::<T>())).wrapping_mul(8)
    };
    let mask = (1 << (mem::size_of::<T>() * 8)) - 1; // !0_T as XSize
    (aligned_ptr, shift as XSize, mask)
}

#[allow(
    clippy::cast_possible_wrap,
    clippy::transmutes_expressible_as_ptr_casts,
    clippy::useless_transmute
)]
mod strict {
    use core::mem;

    #[inline]
    #[must_use]
    pub(crate) fn addr<T>(ptr: *mut T) -> usize {
        // SAFETY: Every sized pointer is a valid integer for the time being.
        unsafe { mem::transmute(ptr) }
    }

    #[inline]
    #[must_use]
    pub(crate) fn with_addr<T>(ptr: *mut T, addr: usize) -> *mut T {
        // FIXME(strict_provenance_magic): I am magic and should be a compiler intrinsic.
        //
        // In the mean-time, this operation is defined to be "as if" it was
        // a wrapping_offset, so we can emulate it as such. This should properly
        // restore pointer provenance even under today's compiler.
        let self_addr = self::addr(ptr) as isize;
        let dest_addr = addr as isize;
        let offset = dest_addr.wrapping_sub(self_addr);

        // This is the canonical desugaring of this operation.
        ptr.cast::<u8>().wrapping_offset(offset).cast::<T>()
    }
}
