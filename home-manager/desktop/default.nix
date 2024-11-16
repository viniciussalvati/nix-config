# This file is incluced by lib/flake-helpers.nix
{
  imports = [
    ./gnome
    ./hyprland
    ./kitty.nix
    ../services/flameshot.nix
  ];
}
