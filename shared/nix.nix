{
  inputs,
  unstablePkgs,
  lib,
  ...
}:
{
  nix = {
    # Uses lix
    # mkForce is necessary
    package = lib.mkForce unstablePkgs.lix;

    # Allows me to use nix flakes and the pipeline operator
    extraOptions = "experimental-features = nix-command flakes pipe-operator";
    # checkConfig = true; # This is temporary, as it seems home-manager can't build without it for now

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };
  };
}
