#!/usr/bin/env bash
# Pull the Samsung-signed Adreno zap shader out of stock firmware.
# Samsung TZ only accepts Samsung's signature: the linux-firmware
# generic zap leaves the gpu locked in secure mode (silent render drops).
# Usage: extract-firmware.sh SM-G780G_*.zip <outdir>
set -euo pipefail
ZIP="${1:?usage: extract-firmware.sh stock.zip outdir}"
OUT="${2:?usage: extract-firmware.sh stock.zip outdir}"
mkdir -p "$OUT"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
unzip -p "$ZIP" "*.tar.md5" > "$tmp/ap.tar" 2>/dev/null || unzip -p "$ZIP" "AP_*.tar*" > "$tmp/ap.tar"
tar -xf "$tmp/ap.tar" -C "$tmp"
img="$(ls "$tmp"/dtbo.img "$tmp"/super.img 2>/dev/null; ls "$tmp"/*.img | head -n 20)"
echo "images:"; echo "$img"
echo "copy the a650_zap.mbn matching your revision to $OUT/qcom/sm8250/a650_zap.mbn"
echo "(also grab adsp.mbn/cdsp.mbn/slpi.mbn under $OUT/qcom/sm8250/Samsung/r8q/)"
