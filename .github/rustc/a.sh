#!/usr/bin/env bash
set -CeEuo pipefail
IFS=$'\n\t'
cd -- "$(dirname -- "$0")"

cd lib
XZ_OPT='-T0 -9e' tar acf ./libLLVM.tar.xz libLLVM.so.*
XZ_OPT='-T0 -9e' tar acf ./librustc_driver.tar.xz librustc_driver-*.so

cd rustlib/x86_64-unknown-linux-gnu/lib
XZ_OPT='-T0 -9e' tar acf ./libLLVM.tar.xz libLLVM.so.*
