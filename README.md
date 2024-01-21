# nix-config

My nixos and home-manager configuration files

This readme file is a work in progress

## Install Nixos

First, close the default installer, then open gparted and configure it like so

In GParted, Create `gpt` partition table in this format

| name  | file system | label | flags    | size                                                           |
| ----- | ----------- | ----- | -------- | -------------------------------------------------------------- |
| boot  | fat32       | BOOT  | boot esp | 512MiB                                                         |
| swap  | linux-swap  | swap  | swap     | Check <https://help.ubuntu.com/community/SwapFaq> for the size |
| nixos | btrfs/ext4  | nixos |          | whatever is remaining                                          |

Note: Sometimes `btrfs` won't work after installed (or a rebuild will fail). In that case, reinstall with ext4

```bash
# mount disks
mount /dev/disk/by-label/nixos /mnt # mount the root
mkdir -p /mnt/boot/efi # create boot and efi mount point
mount /dev/disk/by-label/BOOT /mnt/boot/efi # mount efi partition

# install nixos pointing to the flake
# new root password will be asked in the end
nixos-install --flake github:viniciussalvati/nix-config\#{host}

# sets the user password, so we don't have to after the boot
nixos-enter --command 'passwd vinicius'

reboot
```

## Available Machines

### vm

This is a config for a vm created in Boxes (probably qemu). It works with the default config. Swap size depends on the allocated memory to the VM.

### nixos-acer

This is my Acer machine. And there are some quirks to it:

- The machine came with an `ESP` partition for Windows, but it's too small, so I decided to create a `BOOT` EFI partition and installed the boot loader there
- I used `grub` version 2 for it, because I needed it to find the Windows bootable binary in the `ESP` binary.
- I had to use `ext4`, because some nixos commands were failing after install if I used `btrfs`
- I used 20GB for the swap
