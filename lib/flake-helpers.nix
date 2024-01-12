{ nixpkgs-unstable, ... }@inputs:
let
  defaultUser = "vinicius";
  includeIfExists = path: if __pathExists path then [ path ] else [ ];
in
{
  mkNixosConfig =
    { hostname
    , username ? defaultUser
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
      nixosConfigurations.${hostname} =
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
              networking.hostName = hostname;

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
                    ../home/common.nix
                    ../home/desktop
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
      homeConfigurations.${hostname} =
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
            ../home/common.nix
            ../home/standalone
            ../profiles/${hostname}
          ];
        };
    };
}
