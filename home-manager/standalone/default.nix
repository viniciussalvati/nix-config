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
    NH_FLAKE = "${homeDirectory}/nix-config?${submodulesFragment}";
  };

  programs.zsh.initContent = lib.mkBefore (builtins.readFile ./zsh-init-content-first.zsh);

  programs.navi.settings.cheats.paths = [ ./cheats/home-manager.cheat ];
})
