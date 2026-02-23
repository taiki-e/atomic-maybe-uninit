# Run-time CPU feature detection

This module has run-time CPU feature detection implementations.

Most part of implementations are adapted from [portable-atomic](https://github.com/taiki-e/portable-atomic/tree/HEAD/src/imp/detect).

Here is the table of targets that support run-time CPU feature detection and the instruction or API used:

| target_arch | target_os/target_env | instruction/API | features | note |
| ----------- | -------------------- | --------------- | -------- | ---- |
| x86_64 | all (except for sgx) | cpuid | all | Enabled by default |

Run-time detection is enabled by default on most targets and can be disabled with `--cfg atomic_maybe_uninit_no_outline_atomics`.
