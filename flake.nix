{
  description = "Configurations for my nixos machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11"; # for nixos stable
      # url = "github:nix-community/home-manager"; # for nixos unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      # url = "github:danth/stylix/release-24.05";
      inputs.home-manager.follows = "home-manager";
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

    browser-stack-local-flake = {
      url = "github:viniciussalvati/browser-stack-local-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (import ./lib inputs) deepMerge;
      inherit (import ./lib/flake-helpers.nix inputs) mkNixosConfigs mkHomeConfigs local-packages;
    in
    deepMerge [
      {
        nixosConfigurations = mkNixosConfigs [
          {
            hostname = "nixos-acer";
            stateVersion = "24.05";
          }
          {
            hostname = "vm";
            stateVersion = "23.11";
          }
        ];

        homeConfigurations = mkHomeConfigs [
          {
            hostname = "wsl-work";
            type = "wsl";
            stateVersion = "23.11";
          }
        ];

        # Templates
        templates = import ./templates;
      }
      local-packages
    ];
}
