{
  description = "Configurations for my nixos machines";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    utils.url = "github:numtide/flake-utils";

    home-manager = {
      # url = "github:nix-community/home-manager/release-23.05"; # for nixos stable
      url = "github:nix-community/home-manager"; # for nixos unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, utils, ... }:
    let
      user = "vinicius";
    in
    {
      nixosConfigurations = (import ./hosts { inherit nixpkgs user home-manager; });
      templates = (import ./templates);
    } // utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            unzip # required for scripts/update-vscode-extensions
          ];
          NIXPKGS_ROOT = nixpkgs;
        };
      });
}
