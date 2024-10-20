{ inputs, ... }:
{
  nix = {
    # Allows me to use nix flakes
    extraOptions = "experimental-features = nix-command flakes";

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };
  };
}
