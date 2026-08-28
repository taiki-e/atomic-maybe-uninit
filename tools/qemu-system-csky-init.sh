#!/bin/sh
# SPDX-License-Identifier: Apache-2.0 OR MIT

busybox=/bin/busybox

"${busybox}" mount -t proc proc /proc

# Keep the test environment used by the host-side GitHub Actions job.
export ATOMIC_MAYBE_UNINIT_DENY_WARNINGS=1
export CI=true
export GITHUB_ACTIONS=true
export RUST_BACKTRACE=1
export RUST_TEST_THREADS=1

status=1
if "${busybox}" mount -t 9p -o trans=virtio,version=9p2000.L,msize=1048576 hostshare /mnt/host; then
  if "${busybox}" xargs -0 /mnt/host/test </mnt/host/args; then
    status=0
  else
    status=$?
  fi
fi

if [ "${status}" -eq 0 ]; then
  printf 'C-SKY tests finished successfully\n'
else
  printf 'C-SKY tests failed with status %s\n' "${status}"
fi

while true; do
  "${busybox}" sleep 1
done
