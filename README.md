# r8q-debian

debian arm64 de verdade no s20 fe 5g (r8q), via uefi. sem android no caminho.

kernel: vanadium `not_samsung.sm8250-7.2.0` branch `r8q/debian/WIP`
bring-up baseado no r8q-arch do sitsirk, portado pra debian aqui.

## oq tu precisa baixar

- os artifacts do ultimo run verde aqui do actions:
  - `esp-r8q.zip`
  - `debian-r8q-rootfs.ext4`
- a imagem uefi `Mu-r8q-0.img` la do project-silicium (a gente nao builda ela aqui)
- `heimdall` instalado no pc
- backup das tuas coisas, pq o userdata vai ser apagado. sem choro depois

## passo a passo

### 1. uefi no boot

1. desliga o celular
2. segura volup+voldown e pluga o usb (download mode)
3. roda `./scripts/flash.sh Mu-r8q-0.img`
4. isso so mexe no BOOT, da pra voltar flashando o stock depois

### 2. esp no cache

1. entra no mass-storage do mu-silicium
2. formata o `cache` como vfat com label `R8QESP`
3. descompacta o `esp-r8q.zip` la dentro (vai o kernel como `EFI/BOOT/BOOTAA64.EFI` + dtb + cmdline)

### 3. rootfs no userdata

1. grava o `debian-r8q-rootfs.ext4` na particao **userdata**:
   `heimdall flash --USERDATA debian-r8q-rootfs.ext4`
2. isso apaga tudo do userdata, avisei la em cima
3. reboota e olha a tela: log do kernel -> initramfs -> systemd

### 4. primeiro acesso

```sh
ssh root@172.16.42.1
# senha: r8q  (troca na hora, pfv)
```

### 5. gpu (pra acelerar de verdade)

sem isso boota normal, so anda em cpu:

1. pega o `a650_zap.mbn` assinado pela samsung do teu firmware stock (`scripts/extract-firmware.sh` ajuda a achar)
2. copia pra `/lib/firmware/qcom/sm8250/` no celular
3. reboota. o `a650_sqe.fw` e `a650_gmu.bin` ja vem no `firmware-qcom-soc` da imagem

## se der ruim

- olha a tela: o initramfs mostra onde travou
- conecta na ESP e le `logs/switchroot-fail.txt`
- se nem o rootfs subir, o initramfs abre telnet de emergencia no mesmo `172.16.42.1`
- wifi: `nmtui`, usb0 nao mexe (e o ssh)
- sem suspend, sem bluetooth, sem audio por enquanto. carga lenta no usb do pc, normal
