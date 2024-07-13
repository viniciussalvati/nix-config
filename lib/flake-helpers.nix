{
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  stylix,
  ...
}@inputs:
let
  inherit (import ./list.nix) includeIfExists;
  lib = nixpkgs.lib.extend (_final: _prev: (import ./default.nix inputs) // home-manager.lib);
  local-packages = (import ../packages inputs);
  mkNixosConfig =
    {
      hostname,
      stateVersion,
      username ? "vinicius",
      homePath ? "/home",
      homeDirectory ? "${homePath}/${username}",
      system ? "x86_64-linux",
      nixpkgs ? inputs.nixpkgs,
      home-manager ? inputs.home-manager,
      solaar ? inputs.solaar,
    }:
    let
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      localPkgs = local-packages.packages.${system};
    in
    {
      ${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            hostname
            username
            homeDirectory
            system
            unstablePkgs
            localPkgs
            lib
            ;
        };
        modules = [
          stylix.nixosModules.stylix
          solaar.nixosModules.default
          ../options/common.nix
          ../hosts/configuration.nix
          ../hosts/${hostname}
          home-manager.nixosModules.home-manager
          {
            # This value determines the NixOS release from which the default
            # settings for stateful data, like file locations and database versions
            # on your system were taken. It‘s perfectly fine and recommended to leave
            # this value at the release version of the first install of this system.
            # Before changing this value read the documentation for this option
            # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
            system.stateVersion = stateVersion; # Did you read the comment?

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit
                  hostname
                  username
                  homeDirectory
                  unstablePkgs
                  localPkgs
                  ;
              };
              users.${username} = {
                imports = [
                  ../options/common.nix
                  ../options/home-manager.nix
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
                home = {
                  inherit stateVersion;
                };
                imports = [ ../home-manager/desktop/gdm.nix ];
              };
            };
          }
        ];
      };
    };
  mkHomeConfig =
    {
      hostname,
      stateVersion,
      username ? "vinicius",
      homePath ? "/home",
      homeDirectory ? "${homePath}/${username}",
      system ? "x86_64-linux",
      type ? "standalone",
      nixpkgs ? inputs.nixpkgs,
      home-manager ? inputs.home-manager,
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
      localPkgs = local-packages.packages.${system};
    in
    {
      "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit
            hostname
            username
            homeDirectory
            unstablePkgs
            lib
            localPkgs
            ;
          # This will ensure that the config can be used in non nixos machines
          osConfig = {
            settings = { };
          };
        };

        modules =
          [
            stylix.homeManagerModules.stylix
            ../options/common.nix
            ../options/home-manager.nix
            {
              home-manager.type = type;
              home = {
                inherit stateVersion username homeDirectory;
              };
            }
          ]
          ++ (includeIfExists ../private/profiles/${hostname})
          ++ [
            ../home-manager
            ../profiles/${hostname}
          ];
      };
    };
in
{
  inherit local-packages;
  mkNixosConfigs =
    configs:
    let
      foldFn = acc: config: acc // (mkNixosConfig config);
    in
    builtins.foldl' foldFn { } configs;
  mkHomeConfigs =
    configs:
    let
      foldFn = acc: config: acc // (mkHomeConfig config);
    in
    builtins.foldl' foldFn { } configs;
}
