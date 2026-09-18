# r8q-debian

debian arm64 native on samsung galaxy s20 fe 5g (r8q, sm8250) via mu-silicium uefi (wip)

kernel: `vanadium-oss/samsung-sm8250/mainline/not_samsung.sm8250-7.2.0` branch `r8q/debian/WIP`
device bring-up based on sitsirK/r8q-arch (arch), ported to debian here.

## artifacts (actions)

- `Image` (efi stub, initramfs embedded) -> esp as `EFI/BOOT/BOOTAA64.EFI`
- `sm8250-samsung-r8q.dtb` (also embedded into the uefi image at uefi build time)
- `debian-r8q-rootfs.ext4` (label `debian-root`) -> userdata partition
- `cmdline.txt`, `initramfs.cpio`

## flash

1. download mode, `scripts/flash.sh` with a mu-silicium r8q uefi image -> BOOT
2. cache partition as vfat `R8QESP` with the esp bundle
3. userdata as ext4 with the rootfs
4. ssh `root@172.16.42.1` over usb (ncm), password `r8q`, change it

## firmware (not shipped)

- adreno: `firmware-qcom-soc` (a650 sqe/gmu) + samsung-signed `a650_zap.mbn`
  from stock firmware, see `scripts/extract-firmware.sh`
- wifi: `firmware-atheros` (qca6390 ath11k)
