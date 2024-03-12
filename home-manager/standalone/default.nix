# specific configuration for standalone home-manager
{ lib, unstablePkgs, config, ... }:
lib.mkIfStandalone config
{
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = unstablePkgs.nixVersions.unstable;
    # Allows me to use nix flakes
    extraOptions = "experimental-features = nix-command flakes";
    checkConfig = false; # This is temporary, as it seems home-manager can't build without it for now
  };
  # home.packages = [ unstablePkgs.nixVersions.unstable ];

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;
}
