#!/usr/bin/env bash
# Flash the Mu-Silicium UEFI image to the BOOT partition.
# Phone must be in DOWNLOAD mode (power off; hold VolUp+VolDown; plug USB).
set -euo pipefail
IMG="${1:?usage: flash.sh path/to/Mu-r8q-0.img}"
heimdall detect
heimdall flash --BOOT "$IMG"   # heimdall reboots the phone

# then, from download mode or recovery shell:
# - format cache as vfat (label R8QESP), copy the esp bundle (EFI/BOOT/BOOTAA64.EFI)
# - write debian-r8q-rootfs.ext4 to userdata (this wipes userdata)
