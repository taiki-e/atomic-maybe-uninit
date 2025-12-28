// SPDX-License-Identifier: Apache-2.0 OR MIT

use anyhow::{Context as _, anyhow};
use aya_build::{Toolchain, cargo_metadata};

fn main() -> anyhow::Result<()> {
    let cargo_metadata::Metadata { packages, .. } =
        cargo_metadata::MetadataCommand::new().no_deps().exec().context("MetadataCommand::exec")?;
    let ebpf_package = packages
        .into_iter()
        .find(|cargo_metadata::Package { name, .. }| name.as_str() == "bpf-test-ebpf")
        .ok_or_else(|| anyhow!("bpf-test-ebpf package not found"))?;
    let no_default_features = !cfg!(feature = "default");
    let features = match (cfg!(feature = "i32"), cfg!(feature = "u32")) {
        (true, false) => &["i32"][..],
        (false, true) => &["u32"],
        (false, false) => &[],
        _ => unreachable!(),
    };
    aya_build::build_ebpf([ebpf_package], Toolchain::default(), features, no_default_features)
}
