// SPDX-License-Identifier: Apache-2.0 OR MIT

use aya_build::Toolchain;

fn main() -> anyhow::Result<()> {
    let no_default_features = !cfg!(feature = "default");
    let features = match (
        cfg!(feature = "isize"),
        cfg!(feature = "usize"),
        cfg!(feature = "i32"),
        cfg!(feature = "u32"),
        cfg!(feature = "i64"),
        cfg!(feature = "u64"),
    ) {
        (true, false, false, false, true, false) => &["isize", "i64"][..],
        (false, true, false, false, false, true) => &["usize", "u64"],
        (false, false, true, false, false, false) => &["i32"],
        (false, false, false, true, false, false) => &["u32"],
        _ => unreachable!(),
    };
    let ebpf_package = aya_build::Package {
        name: "bpf-test-ebpf",
        root_dir: std::path::Path::new(env!("CARGO_MANIFEST_PATH"))
            .parent()
            .unwrap()
            .to_str()
            .unwrap(),
        no_default_features,
        features,
    };
    aya_build::build_ebpf([ebpf_package], Toolchain::default())
}
