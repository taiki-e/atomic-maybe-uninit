#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0 OR MIT
set -CeEuo pipefail
IFS=$'\n\t'

bin="$1"
stdout='.tsim-leon3.stdout'

rm -f -- ./"${stdout}"
touch -- ./"${stdout}"

tail -s0 -f "${stdout}" &
tail_pid=$!

# There is no way to exit tsim-leon3 with non-zero when failed.
tsim-leon3 -c tsim-commands.txt "${bin}" &>>"${stdout}" &
tsim_pid=$!

# shellcheck disable=2317 # used in trap
cleanup() {
    kill "${tsim_pid}"
    kill "${tail_pid}"
    rm -- "${stdout}"
    exit "${code}"
}

code=1
trap -- 'printf >&2 "%s\n" "${0##*/}: trapped SIGINT"; cleanup' SIGINT

wait "${tsim_pid}"

if grep -Fq 'panicked' "${stdout}"; then
    code=101
else
    code=0
fi

rm -- "${stdout}"
exit "${code}"
