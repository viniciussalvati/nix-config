# specific configuration for standalone home-manager
{
  lib,
  unstablePkgs,
  config,
  homeDirectory,
  ...
}:
{
  imports = [ ../../shared/nix.nix ];
}
// (lib.mkIfStandalone config {
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = unstablePkgs.nixVersions.git;
    # Allows me to use nix flakes
    extraOptions = "experimental-features = nix-command flakes";
    checkConfig = false; # This is temporary, as it seems home-manager can't build without it for now
  };

  home.packages = with unstablePkgs; [
    nh
    nix-output-monitor
    nvd
  ];

  home.sessionVariables = {
    FLAKE = "${homeDirectory}/nix-config?submodules=1";
  };

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;

  programs.navi.settings.cheats.paths = [ ./cheats/home-manager.cheat ];
})
