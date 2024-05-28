{ nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
let
  inherit (import ./list.nix) includeIfExists;
  lib = nixpkgs.lib.extend
    (_final: _prev: (import ./default.nix inputs) // home-manager.lib);
  local-packages = (import ../packages inputs);
in {
  mkNixosConfig = { hostname, username ? "vinicius", homePath ? "/home"
    , homeDirectory ? "${homePath}/${username}", system ? "x86_64-linux"
    , stateVersion ? "23.11", nixpkgs ? inputs.nixpkgs
    , home-manager ? inputs.home-manager, solaar ? inputs.solaar }:
    let
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      localPkgs = local-packages.packages.${system};
      config = { inherit hostname username homeDirectory; };
    in {
      ${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit username system unstablePkgs localPkgs lib; };
        modules = [
          solaar.nixosModules.default
          ../options/common.nix
          ../hosts/configuration.nix
          ../hosts/${hostname}
          home-manager.nixosModules.home-manager
          config
          {
            networking.hostName = hostname;

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit username unstablePkgs localPkgs; };
              users.${username} = {
                imports = [
                  ../options/common.nix
                  ../options/home-manager.nix
                  config
                  {
                    home-manager.type = "nixos";
                    home = { inherit stateVersion username homeDirectory; };
                  }
                  ../home-manager
                  ../home-manager/desktop
                ] ++ (includeIfExists ../hosts/${hostname}/home.nix);
              };
              # gdm is gnome's login screen's user
              users.gdm = {
                home = { inherit stateVersion; };
                imports = [ ../home-manager/desktop/gdm.nix ];
              };
            };
          }
        ];
      };
    };
  mkHomeConfig = { hostname, username ? "vinicius", homePath ? "/home"
    , homeDirectory ? "${homePath}/${username}", system ? "x86_64-linux"
    , stateVersion ? "23.11", type ? "standalone", nixpkgs ? inputs.nixpkgs
    , home-manager ? inputs.home-manager }:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      localPkgs = local-packages.packages.${system};
    in {
      ${hostname} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit username unstablePkgs lib localPkgs; };

        modules = [
          ../options/common.nix
          ../options/home-manager.nix
          {
            inherit hostname username homeDirectory;

            home-manager.type = type;
            home = { inherit stateVersion username homeDirectory; };
          }
        ] ++ (includeIfExists ../private/profiles/${hostname}) ++ [
          ../home-manager
          ../home-manager/standalone
          ../profiles/${hostname}
        ];
      };
    };
}
