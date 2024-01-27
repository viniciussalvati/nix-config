{ nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
let
  inherit (import ./list.nix) includeIfExists;
  lib = nixpkgs.lib.extend (final: _prev:
    (import ./default.nix {
      lib = final;
    }) // home-manager.lib);
in
{
  mkNixosConfig =
    { hostname
    , username ? "vinicius"
    , homePath ? "/home"
    , homeDirectory ? "${homePath}/${username}"
    , system ? "x86_64-linux"
    , stateVersion ? "23.11"
    , nixpkgs ? inputs.nixpkgs
    , home-manager ? inputs.home-manager
    , nixvim ? inputs.nixvim
    , solaar ? inputs.solaar
    }:
    let
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      ${hostname} =
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit username system unstablePkgs lib;
          };
          modules = [
            solaar.nixosModules.default
            ../hosts/configuration.nix
            ../hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              networking.hostName = hostname;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit username unstablePkgs;
                };
                users.${username} = {
                  imports = [
                    ../options/home-manager.nix
                    nixvim.homeManagerModules.nixvim
                    {
                      home-manager.type = "nixos";
                      home = {
                        inherit stateVersion username homeDirectory;
                      };
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
  mkHomeConfig =
    { hostname
    , username ? "vinicius"
    , homePath ? "/home"
    , homeDirectory ? "${homePath}/${username}"
    , system ? "x86_64-linux"
    , stateVersion ? "23.11"
    , type ? "standalone"
    , nixpkgs ? inputs.nixpkgs
    , home-manager ? inputs.home-manager
    , nixvim ? inputs.nixvim
    }:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      ${hostname} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit username unstablePkgs lib;
          };

          modules = [
            ../options/home-manager.nix
            nixvim.homeManagerModules.nixvim
            {
              home-manager.type = type;
              home = {
                inherit stateVersion username homeDirectory;
              };
            }
          ] ++
          (includeIfExists ../private/profiles/${hostname}) ++
          [
            ../home-manager
            ../home-manager/standalone
            ../profiles/${hostname}
          ];
        };
    };
}
