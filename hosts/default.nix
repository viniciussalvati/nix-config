{ nixpkgs, nixpkgs-unstable, username, home-manager, nixvim, solaar, ... }:
let
  system = "x86_64-linux";
  unstablePkgs = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
  mkHost = { hostModule, homeManagerImports ? [ ] }: lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit username system unstablePkgs;
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
            inherit username unstablePkgs;
          };
          users.${username} = {
            imports = [
              {
                home = {
                  stateVersion = "23.11";
                  username = "${username}";
                  homeDirectory = "/home/${username}";
                };
              }
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
  vm = mkHost { hostModule = ./vm; };
  acer = mkHost { hostModule = ./acer; };
}
