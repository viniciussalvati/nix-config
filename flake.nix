{
  description = "Configurations for my nixos machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11"; # for nixos stable
      # url = "github:nix-community/home-manager"; # for nixos unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-23.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    solaar = {
      url = "github:Svenum/Solaar-Flake/latest"; # For latest stable version
      #url = "https://github.com/Svenum/Solaar-Flake/release-1.1.10; # uncomment line for version 1.1.10
      #url = "https://github.com/Svenum/Solaar-Flake/main; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      inherit (import ./lib/flake-helpers.nix inputs) deepMerge mkNixosConfig mkHomeConfig;
    in
    deepMerge [
      # Nixos Configurations
      (mkNixosConfig { hostname = "nixos-acer"; })
      (mkNixosConfig { hostname = "vm"; })

      # Standalone home-manager profiles
      (mkHomeConfig { hostname = "wsl-work"; })

      # Templates
      { templates = (import ./templates); }
    ];
}
