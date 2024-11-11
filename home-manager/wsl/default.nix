# Specific configuration when running inside wsl
{
  lib,
  config,
  pkgs,
  ...
}:
let
  scripts = import ./scripts.nix { inherit pkgs; };
in
lib.mkIfWsl config {
  stylix.targets = {
    gnome.enable = false;
    gtk.enable = false;
    firefox.enable = false;
  };

  programs.home-manager.enable = true;

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;
  programs.nushell.extraConfig = builtins.readFile ./config.nu;

  programs.keychain = {
    enable = true;
    keys = [ ]; # load no key
    agents = [ "ssh" ]; # start ssh agent
  };

  home.packages =
    with pkgs;
    [
      xdg-utils
      wsl-open
    ]
    ++ scripts;
}
