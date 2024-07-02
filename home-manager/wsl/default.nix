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
  stylix.autoEnable = false;
  stylix.targets.bat.enable = true;
  stylix.targets.fzf.enable = true;
  stylix.targets.gitui.enable = true;
  stylix.targets.lazygit.enable = true;
  stylix.targets.btop.enable = true;

  programs.home-manager.enable = true;

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;

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
