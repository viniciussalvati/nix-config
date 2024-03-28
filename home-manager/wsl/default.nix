# Specific configuration when running inside wsl
{ lib, config, pkgs, ... }:
let
  scripts = import ./scripts.nix { inherit pkgs; };
in
lib.mkIfWsl config
{
  programs.home-manager = {
    enable = true;
    # TODO: Get path of home-manager configuration, which should be this repo's root folder
  };

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;

  programs.keychain = {
    enable = true;
    keys = [ ]; # load no key
    agents = [ "ssh" ]; # start ssh agent
  };

  home.packages = with pkgs; [
    xdg-utils
    wsl-open
  ] ++ scripts;
}
