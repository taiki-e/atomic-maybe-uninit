// # TODO
// #[cfg(target_arch = "aarch64")]
// mod aarch64;
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
mod riscv;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod x86;

#[cfg(not(any(
    target_arch = "x86",
    target_arch = "x86_64",
    target_arch = "riscv32",
    target_arch = "riscv64"
)))]
compile_error!("this target is not supported yet");

#[cfg(all(any(target_arch = "x86_64", target_arch = "aarch64"), target_pointer_width = "32"))]
compile_error!("x32 ABI is not supported yet");
