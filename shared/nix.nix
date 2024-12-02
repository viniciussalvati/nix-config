{ unstablePkgs, inputs, ... }:
{
  nix = {
    package = unstablePkgs.nixVersions.latest;
    # Allows me to use nix flakes
    extraOptions = "experimental-features = nix-command flakes pipe-operators";
    # checkConfig = true; # This is temporary, as it seems home-manager can't build without it for now

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };
  };
}
