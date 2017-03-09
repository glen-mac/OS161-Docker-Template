#!/bin/bash

# fail if any command returns a non-zero code
set -e

base=${1:-'/home'}
src_base="${base}/${2:-os161-src}"

cd "${src_base}"
./configure --ostree="${base}/root"
# configure ASST0
cd "${src_base}/kern/conf"
./config ASST0
# make and install the kernel
cd "${src_base}/kern/compile/ASST0"
bmake depend
bmake
bmake install
# make source code
cd "${src_base}"
bmake
cd "${base}"