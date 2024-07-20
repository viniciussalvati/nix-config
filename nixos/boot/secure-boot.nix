{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [ sbctl ];

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  # Required to unlock the disk encryption with TPM2
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.enableTpm2 = true;
}
