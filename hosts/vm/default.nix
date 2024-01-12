# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Includes systemd-boot configuration
    ../../nixos/boot/systemd-boot.nix
  ];

  networking.hostName = "nixos-vm"; # Define your hostname.

  services.xserver.layout = "br";
  # Configure console keymap
  console.keyMap = "br-abnt2";

  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];
}
