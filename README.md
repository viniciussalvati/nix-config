# nixos-config
My nixos configuration files

This readme file is a work in progress

## Install

First, close the default installer, then open gparted and configure it like so

In GParted, Create `gpt` partition table in this format
name  | file system | label | flags    | size
----- | ----------- | ----- | -------- | ----
boot  | fat32       | BOOT  | boot esp | 512MiB
swap  | linux-swap  | swap  | swap     | Check https://help.ubuntu.com/community/SwapFaq for the size
nixos | btrfs       | nixos |          | whatever is remaining

```bash
# mount disks
mount /dev/disk/by-label/nixos /mnt # mount the root
mkdir -p /mnt/boot/efi # create boot and efi mount point
mount /dev/disk/by-label/BOOT /mnt/boot/efi # mount efi partition

# install nixos pointing to the flake
# new root password will be asked in the end
nixos-install --flake github:viniciussalvati/nixos-config\#{host}

# sets the user password, so we don't have to after the boot
nixos-enter --command 'passwd vinicius'

reboot
```
