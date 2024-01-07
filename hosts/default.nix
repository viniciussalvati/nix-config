{ nixpkgs, nixpkgs-unstable, user, home-manager, nixvim, solaar, ... }:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  unstablePkgs = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
  mkHost = { hostModule, homeManagerImports ? [ ] }: lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit user system unstablePkgs;
    };
    modules = [
      solaar.nixosModules.default

      ./configuration.nix
      hostModule
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit user unstablePkgs;
          };
          users.${user} = {
            imports = [
              nixvim.homeManagerModules.nixvim
              ./home.nix
            ] ++ homeManagerImports;
          };
          # gdm is gnome's login screen's user
          users.gdm = {
            home.stateVersion = "23.11";
            imports = [ ../home/desktop/gdm.nix ];
          };
        };
      }
    ];
  };
in
{
  vm = mkHost { hostModule = ./vm/configuration.nix; };
  acer = mkHost { hostModule = ./acer/configuration.nix; };
}
