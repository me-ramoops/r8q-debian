#!/usr/bin/env bash
# Pull the Samsung-signed Adreno zap shader out of stock firmware.
# Samsung's TrustZone only accepts Samsung's signature: the generic zap
# from linux-firmware is rejected and the gpu stays locked in secure mode.
# The zap is SPLIT in 4 files inside the vendor image (/vendor/firmware/):
#   a650_zap.mdt + a650_zap.b00/.b01/.b02
# Usage: extract-firmware.sh super.img outdir
#   (lpunpack from android-sdk first if super.img is a dynamic-partition image)
set -euo pipefail
SUPER="${1:?usage: extract-firmware.sh super.img outdir}"
OUT="${2:?usage: extract-firmware.sh super.img outdir}"
mkdir -p "$OUT/qcom/sm8250/Samsung/r8q"
echo "mount the vendor image from $SUPER and copy:"
echo "  /vendor/firmware/a650_zap.mdt  -> $OUT/qcom/sm8250/Samsung/r8q/a650_zap.mbn"
echo "  /vendor/firmware/a650_zap.b00 \
/vendor/firmware/a650_zap.b01 \
/vendor/firmware/a650_zap.b02 -> $OUT/qcom/sm8250/Samsung/r8q/"
echo "also grab adsp.mbn/cdsp.mbn/slpi.mbn into $OUT/qcom/sm8250/Samsung/r8q/"
