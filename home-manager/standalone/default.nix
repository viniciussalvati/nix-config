# specific configuration for standalone home-manager
{ lib, pkgs, config, ... }:
lib.mkIfStandalone config
{
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nix;
    # Allows me to use nix flakes
    extraOptions = "experimental-features = nix-command flakes";
  };
  home.packages = [ pkgs.nix ];

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;
}
