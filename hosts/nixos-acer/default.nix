# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hardware-nvidia.nix

    ../../nixos/boot/systemd-boot.nix
    ../../nixos/boot/plymouth.nix

    ../../nixos/hardware/logitech/solaar.nix
  ];

  services.xserver.xkb.layout = "br";
  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;

  virtualisation.waydroid.enable = true;

  settings.enableGaming = true;

  programs.kdeconnect.enable = true;
}
