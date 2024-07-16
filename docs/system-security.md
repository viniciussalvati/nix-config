## System Security

To fully secure the system, the system needs both full-disk encryption and secure boot enabled.

The disk encryption will ensure that the contents of the hard drive can't be accessed, and secure boot will ensure that the boot loader can't be tampered with, since the boot partition can't be encrypted.

### Full disk encryption

To encrypt the disk, when partitioning, use gnome-disks, and ensure the data (`nixos`) and `swap` partitions are encrypted with LUKS. Also, additional configuration needs to be added to the `hardware-configuration.nix` file.

```nix
  # The values may need to be updated depending on your config

  # This device points to nixos parent LUKS partition
  boot.initrd.luks.devices."luks-nixos".device = "/dev/sda3";
  # This device points to swap parent LUKS partition
  boot.initrd.luks.devices."luks-swap".device = "/dev/sda2";
```

### Secure boot

To enable secure boot, I have used `lanzaboote` to encrypt and use the bootloader is signed.

To generate the keys use:

```sh
sudo nix run nixpkgs#sbctl create-keys
```

After this is done, enable lanzaboote in the configurations by including the file `nixos/boot/secure-boot.nix` from your host configuration.nix file.

To do it while installing, run the following before the `nixos-install` step.

**WARNING: THIS NEEDS TO BE TESTED**

```sh
# Run as root
# Both database-path and export are the default values, prefixed with /mnt to point to the mount point
nix run nixpkgs#sbctl create-keys -- --database-path /mnt/etc/secureboot --export /mnt/etc/secureboot/keys
```
