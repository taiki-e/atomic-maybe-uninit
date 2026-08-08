// SPDX-License-Identifier: Apache-2.0 OR MIT

use anyhow::Context as _;
use aya::{
    TestRunOptions,
    programs::{TestRun as _, Xdp},
};
use log::{debug, warn};

const XDP_PASS: u32 = 2;

fn main() -> anyhow::Result<()> {
    env_logger::builder().filter(Some("bpf_test"), log::LevelFilter::Info).init();

    // Bump the memlock rlimit. This is needed for older kernels that don't use the
    // new memcg based accounting, see https://lwn.net/Articles/837122/
    let rlim = libc::rlimit { rlim_cur: libc::RLIM_INFINITY, rlim_max: libc::RLIM_INFINITY };
    let ret = unsafe { libc::setrlimit(libc::RLIMIT_MEMLOCK, &rlim) };
    if ret != 0 {
        debug!("remove limit on locked memory failed, ret is: {ret}");
    }

    // This will include your eBPF object file as raw bytes at compile-time and load it at
    // runtime. This approach is recommended for most real-world use cases. If you would
    // like to specify the eBPF program at runtime rather than at compile-time, you can
    // reach for `Bpf::load_file` instead.
    let mut ebpf =
        aya::Ebpf::load(aya::include_bytes_aligned!(concat!(env!("OUT_DIR"), "/bpf-test")))?;
    let mut logger = match aya_log::EbpfLogger::init(&mut ebpf) {
        Err(e) => {
            // This can happen if you remove all log statements from your eBPF program.
            warn!("failed to initialize eBPF logger: {e}");
            None
        }
        Ok(logger) => Some(logger),
    };
    let program: &mut Xdp = ebpf.program_mut("bpf_test").unwrap().try_into()?;
    program.load()?;

    let packet = [0_u8; 64];
    let result = program.test_run(TestRunOptions {
        data_in: Some(&packet),
        repeat: 1,
        ..TestRunOptions::default()
    });

    if let Some(logger) = &mut logger {
        logger.flush();
    }
    let result = result.context("failed to execute the XDP program")?;
    anyhow::ensure!(
        result.return_value == XDP_PASS,
        "BPF tests failed: XDP program returned {}",
        result.return_value,
    );
    println!("Tests finished successfully");

    Ok(())
}
