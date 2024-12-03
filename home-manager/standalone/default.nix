# specific configuration for standalone home-manager
{
  lib,
  unstablePkgs,
  config,
  homeDirectory,
  ...
}:
let
  submodulesFragment = if config.settings.includePrivate then "submodules=1" else "";
in
{
  imports = [ ../../shared/nix.nix ];
}
// (lib.mkIfStandalone config {
  nixpkgs.config.allowUnfree = true;

  nix.package = unstablePkgs.nixVersions.latest;

  home.packages = with unstablePkgs; [
    nh
    nix-output-monitor
    nvd
    config.nix.package # Uses the nix package defined in shared/nix.nix
  ];

  home.sessionVariables = {
    FLAKE = "${homeDirectory}/nix-config?${submodulesFragment}";
  };

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;

  programs.navi.settings.cheats.paths = [ ./cheats/home-manager.cheat ];
})
