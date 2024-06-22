{ nixpkgs, ... }:
let
  lib = nixpkgs.lib;
in
(import ./list.nix)
// (import ./sets.nix { inherit lib; })
// (import ./options.nix { inherit lib; })
