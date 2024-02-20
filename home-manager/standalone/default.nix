# specific configuration for standalone home-manager
{ lib, unstablePkgs, config, ... }:
lib.mkIfStandalone config
{
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = unstablePkgs.nix;
    # Allows me to use nix flakes
    extraOptions = "experimental-features = nix-command flakes";
  };
  home.packages = [ unstablePkgs.nix ];

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;
}
