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

## Install home-manager

- Install nix according to your system. See the [website](https://nixos.org/download.html) for instructions.
- Enter a shell with git, if necessary, with: `nix-shell -p git`.
- Enter this repository and run

```bash
  nix run --experimental-features 'nix-command flakes' '.#homeConfigurations.{profile}.activationPackage'

```

- Run the following method, if the profile you picked needs it.

```bash
    nix run '.?submodules=1#homeConfigurations.wsl-work.activationPackage'
```

## Private

There are some configurations that I want to keep private, for example, work related stuff (nothing like api keys, passwords, etc.) that I don't know if I want to be in a public repo.

Because of that, I have created a private repo in github, and added it as a submodule in this repo.

## Available Machines

### vm

This is a config for a vm created in Boxes (probably qemu). It works with the default config. Swap size depends on the allocated memory to the VM.

### nixos-acer

This is my Acer machine. And there are some quirks to it:

- The machine came with an `ESP` partition for Windows, but it's too small, so I decided to create a `BOOT` EFI partition and installed the boot loader there
- I used `grub` version 2 for it, because I needed it to find the Windows bootable binary in the `ESP` binary.
- I had to use `ext4`, because some nixos commands were failing after install if I used `btrfs`
- I used 20GB for the swap

## Profiles

Profiles are meant for machines with other distros that use standalone home-manager

### wsl-work

The configuration I use for work. This one includes the private configurations.

## Specific instructions

- [Graphics cards](./docs/graphics-cards.md)
- [Gaming](./docs/gaming.md)
