# specific configuration for standalone home-manager
{ lib, unstablePkgs, config, ... }:
lib.mkIfStandalone config
  (
    let
      standaloneCheats = unstablePkgs.writeTextDir "home-manager.cheat" ''
        % home-manager

        # home-manager switch for '${config.common.hostname}' --- you MUST be in the nix-config directory
        nix run '.?submodules=1#homeConfigurations.${config.common.hostname}.activationPackage'
      '';
    in
    {
      nixpkgs.config.allowUnfree = true;
      nix = {
        package = unstablePkgs.nixVersions.unstable;
        # Allows me to use nix flakes
        extraOptions = "experimental-features = nix-command flakes";
        checkConfig = false; # This is temporary, as it seems home-manager can't build without it for now
      };
      # home.packages = [ unstablePkgs.nixVersions.unstable ];

      programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;

      programs.navi.settings.cheats.paths = [
        standaloneCheats
      ];
    }
  )
