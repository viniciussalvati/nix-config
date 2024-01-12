# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Uses grub2 boot, because it supports EFI boot and can probe for Windows in other partitions
    ../../modules/boot/grub2.nix
    ../../modules/boot/plymouth.nix
    ./grub-entries.nix

    # enable waydroid
    ../../modules/android/emulators/waydroid.nix

    ../../modules/games/steam.nix

    ../../modules/hardware/logitech/solaar.nix
  ];

  services.xserver.layout = "br";
  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;
}
