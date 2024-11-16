# This file is incluced by lib/flake-helpers.nix
{
  imports = [
    ./gnome
    ./kitty.nix
    ../services/flameshot.nix
  ];
}
