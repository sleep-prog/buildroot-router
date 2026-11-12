#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="$PROJECT_DIR/buildroot-2025.02.19/output"
QEMU="$OUTPUT_DIR/host/bin/qemu-system-aarch64"
KERNEL="$OUTPUT_DIR/images/Image"
ROOTFS="$OUTPUT_DIR/images/rootfs.ext4"

for file in "$QEMU" "$KERNEL" "$ROOTFS"; do
    if [[ ! -e "$file" ]]; then
        echo "required build output not found: $file" >&2
        echo "run ./scripts/build.sh first" >&2
        exit 1
    fi
done

exec "$QEMU" \
    -M virt \
    -cpu cortex-a53 \
    -nographic \
    -smp 1 \
    -kernel "$KERNEL" \
    -append "rootwait root=/dev/vda console=ttyAMA0" \
    -netdev user,id=eth0 \
    -device virtio-net-device,netdev=eth0 \
    -drive "file=$ROOTFS,if=none,format=raw,id=hd0" \
    -device virtio-blk-device,drive=hd0
