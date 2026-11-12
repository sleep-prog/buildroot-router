#!/bin/bash
set -euo pipefail

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="2025.02.19"
SOURCE_DIR="$PROJECT_DIR/buildroot-$VERSION"
ARCHIVE="$PROJECT_DIR/buildroot-$VERSION.tar.xz"
OUTPUT_DIR="$SOURCE_DIR/output"
DEFCONFIG="$PROJECT_DIR/configs/buildroot-router_defconfig"
URL="https://buildroot.org/downloads/buildroot-$VERSION.tar.xz"

if [[ ! -d "$SOURCE_DIR" ]]; then
    if [[ ! -f "$ARCHIVE" ]]; then
        echo "downloading buildroot $VERSION..."
        wget -O "$ARCHIVE" "$URL"
    fi

    echo "extracting Buildroot..."
    tar -C "$PROJECT_DIR" -xf "$ARCHIVE"
fi

if [[ ! -f "$DEFCONFIG" ]]; then
    echo "saved configuration not found: $DEFCONFIG" >&2
    exit 1
fi

echo "loading the saved configuration..."
make -C "$SOURCE_DIR" \
    O="$OUTPUT_DIR" \
    BR2_DEFCONFIG="$DEFCONFIG" \
    defconfig

echo "building with $(nproc) jobs..."
make -C "$SOURCE_DIR" \
    O="$OUTPUT_DIR" \
    -j"$(nproc)"

echo "build is done good sir"
echo "Images: $OUTPUT_DIR/images"
