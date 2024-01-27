{
  description = "Configurations for my nixos machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11"; # for nixos stable
      # url = "github:nix-community/home-manager"; # for nixos unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    solaar = {
      url = "github:Svenum/Solaar-Flake/latest"; # For latest stable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs:
    let
      inherit (import ./lib/flake-helpers.nix inputs) mkNixosConfig mkHomeConfig;
    in
    {
      nixosConfigurations =
        (mkNixosConfig { hostname = "nixos-acer"; }) //
        (mkNixosConfig { hostname = "vm"; });

      homeConfigurations =
        (mkHomeConfig { hostname = "wsl-work"; });

      # Templates
      templates = (import ./templates);
    };
}
