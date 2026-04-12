#!/usr/bin/env bash
set -CeEuo pipefail
IFS=$'\n\t'
cd -- "$(dirname -- "$0")"

cd lib
tar xf ./libLLVM.tar.xz
tar xf ./librustc_driver.tar.xz

cd rustlib/x86_64-unknown-linux-gnu/lib
tar xf ./libLLVM.tar.xz
