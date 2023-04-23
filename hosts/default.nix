{ nixpkgs, user, home-manager, ... }:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
in
{
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit user system;
    };
    modules = [
      ./configuration.nix
      ./vm/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit user;
          };
          users.${user} = {
            imports = [
              ./home.nix
            ];
          };
        };
      }
    ];
  };
  acer = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit user system;
    };
    modules = [
      ./configuration.nix
      ./acer/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit user;
          };
          users.${user} = {
            imports = [
              ./home.nix
            ];
          };
        };
      }
    ];
  };
}
