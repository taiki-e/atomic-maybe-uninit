#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0 OR MIT
set -CeEuo pipefail
IFS=$'\n\t'
trap -- 's=$?; printf >&2 "%s\n" "${0##*/}:${LINENO}: \`${BASH_COMMAND}\` exit with ${s}"; exit ${s}' ERR

: "${CSKY_QEMU_SYSTEM:?}"
: "${CSKY_KERNEL:?}"
: "${CSKY_ROOTFS:?}"
: "${CSKY_QEMU_CPU:?}"
: "${CSKY_QEMU_SMP:?}"

binary=$1
shift

tmp=$(mktemp -d)
qemu_pid=''
cleanup() {
  if [[ -n "${qemu_pid}" ]]; then
    kill "${qemu_pid}" 2>/dev/null || true
    wait "${qemu_pid}" 2>/dev/null || true
  fi
  rm -rf -- "${tmp:?}"
}
trap cleanup EXIT
shared="${tmp}/shared"
mkdir -- "${shared}"
install -m 0755 -- "${binary}" "${shared}/test"
if [[ $# -gt 0 ]]; then
  printf '%s\0' "$@" >"${shared}/args"
else
  : >"${shared}/args"
fi

log="${tmp}/qemu.log"
TMPDIR="${tmp}" "${CSKY_QEMU_SYSTEM}" \
  -M virt \
  -cpu "${CSKY_QEMU_CPU}" \
  -smp "${CSKY_QEMU_SMP}" \
  -m 1G \
  -display none \
  -monitor none \
  -serial stdio \
  -no-user-config \
  -nic none \
  -kernel "${CSKY_KERNEL}" \
  -append 'console=ttyS0,115200 rootwait root=/dev/vda rw init=/init panic=-1 quiet' \
  -drive "file=${CSKY_ROOTFS},format=raw,id=hd0,snapshot=on" \
  -device virtio-blk-device,drive=hd0 \
  -fsdev "local,id=fsdev0,path=${shared},security_model=none" \
  -device virtio-9p-device,id=fs0,fsdev=fsdev0,mount_tag=hostshare \
  -no-reboot \
  >"${log}" 2>&1 &
qemu_pid=$!
for _ in {1..360}; do
  if grep -Eq 'C-SKY tests (finished successfully|failed with status)' "${log}"; then
    break
  fi
  if ! kill -0 "${qemu_pid}" 2>/dev/null; then
    break
  fi
  sleep 1
done
kill "${qemu_pid}" 2>/dev/null || true
wait "${qemu_pid}" 2>/dev/null || true
qemu_pid=''
cat -- "${log}"
grep -Fq 'C-SKY tests finished successfully' "${log}"
