{ nixpkgs-unstable, nixvim, ... }@inputs:
let
  defaultUser = "vinicius";
  includeIfExists = path: if __pathExists path then [ path ] else [ ];
in
{
  mkNixOSConfig =
    { hostname
    , username ? defaultUser
    , homePath ? "/home"
    , homeDirectory ? "${homePath}/${username}"
    , system ? "x86_64-linux"
    , stateVersion ? "23.11"
    , nixpkgs ? inputs.nixpkgs
    , home-manager ? inputs.home-manager
    , solaar ? inputs.solaar
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
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit username system unstablePkgs;
      };
      modules = [
        solaar.nixosModules.default
        ../hosts/configuration.nix
        ../hosts/${hostname}
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
                nixvim.homeManagerModules.nixvim
                {
                  home = {
                    inherit stateVersion username homeDirectory;
                  };
                }
                ../hosts/home.nix
              ] ++ (includeIfExists ../hosts/${hostname}/home.nix);
            };
            # gdm is gnome's login screen's user
            users.gdm = {
              home = { inherit stateVersion; };
              imports = [ ../home/desktop/gdm.nix ];
            };
          };
        }
      ];
    };
  mkHomeConfig =
    { hostname
    , username ? defaultUser
    , homePath ? "/home"
    , homeDirectory ? "${homePath}/${username}"
    , system ? "x86_64-linux"
    , stateVersion ? "23.11"
    , nixpkgs ? inputs.nixpkgs
    , home-manager ? inputs.home-manager
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
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit username unstablePkgs;
      };

      modules = [
        nixvim.homeManagerModules.nixvim
        {
          home = {
            inherit stateVersion username homeDirectory;
          };
        }
        ../hosts/home.nix
        ../profiles/${hostname}
      ];
    };
}
