{ config, unstablePkgs, ... }:
let
  cleanType = if config.home-manager.type == "nixos" then "all" else "user";
  nixCheats = unstablePkgs.writeTextDir "nix.cheat" ''
    % nix

    # Collect garbage
    nh clean ${cleanType} --keep 3 --keep-since 15d --ask
  '';
in
{
  programs.navi = {
    enable = true;
    package = unstablePkgs.navi;
    settings.cheats.paths = [
      ./cheats
      nixCheats
    ];
  };
}
