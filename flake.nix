{
  description = "Configurations for my nixos machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05"; # for nixos stable
      # url = "github:nix-community/home-manager"; # for nixos unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      # url = "github:danth/stylix";
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
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
