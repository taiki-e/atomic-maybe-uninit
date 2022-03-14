// Refs:
// - inline assembly reference: https://doc.rust-lang.org/nightly/reference/inline-assembly.html
// - inline assembly rust by example: https://doc.rust-lang.org/nightly/rust-by-example/unsafe/asm.html
// - feature(asm_experimental_arch): https://doc.rust-lang.org/nightly/unstable-book/language-features/asm-experimental-arch.html
//
// template for "generated asm" link: https://godbolt.org/z/PG9jrT58x

#[cfg(not(any(
    target_arch = "x86",
    target_arch = "x86_64",
    all(
        target_arch = "arm",
        any(target_feature = "v7", atomic_maybe_uninit_target_feature_v7),
        any(
            target_feature = "aclass",
            atomic_maybe_uninit_target_feature_aclass,
            target_feature = "rclass",
            atomic_maybe_uninit_target_feature_rclass,
        )
    ),
    target_arch = "aarch64",
    target_arch = "riscv32",
    target_arch = "riscv64"
)))]
compile_error!("this target is not supported yet");

#[cfg(target_arch = "aarch64")]
mod aarch64;
#[cfg(all(
    target_arch = "arm",
    any(target_feature = "v7", atomic_maybe_uninit_target_feature_v7),
    any(
        target_feature = "aclass",
        atomic_maybe_uninit_target_feature_aclass,
        target_feature = "rclass",
        atomic_maybe_uninit_target_feature_rclass,
    )
))]
mod arm;
#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
mod riscv;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod x86;
