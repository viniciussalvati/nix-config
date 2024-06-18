{
  description = "Configurations for my nixos machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05"; # for nixos stable
      # url = "github:nix-community/home-manager"; # for nixos unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };

    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-fuzzy = {
      url = "github:bigH/git-fuzzy";
      flake = false;
    };
  };

  outputs =
    inputs:
    let
      inherit (import ./lib inputs) deepMerge;
      inherit (import ./lib/flake-helpers.nix inputs) mkNixosConfig mkHomeConfig;
      local-packages = import ./packages inputs;
    in
    deepMerge [
      {
        nixosConfigurations =
          (mkNixosConfig { hostname = "nixos-acer"; }) // (mkNixosConfig { hostname = "vm"; });

        homeConfigurations = mkHomeConfig {
          hostname = "wsl-work";
          type = "wsl";
        };

        # Templates
        templates = import ./templates;
      }
      local-packages
    ];
}
