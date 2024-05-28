# specific configuration for standalone home-manager
{ lib, unstablePkgs, config, ... }:
lib.mkIfStandalone config (let
  standaloneCheats = unstablePkgs.writeTextDir "home-manager.cheat" ''
    % home-manager

    # Apply home-manager config for '${config.username}@${config.hostname}'
    nh home switch

    # Update flakes and apply home-manager config for '${config.username}@${config.hostname}'
    nh home switch --update
  '';
in {
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = unstablePkgs.nixVersions.git;
    # Allows me to use nix flakes
    extraOptions = "experimental-features = nix-command flakes";
    checkConfig =
      false; # This is temporary, as it seems home-manager can't build without it for now
  };

  home.packages = with unstablePkgs; [ nh nix-output-monitor nvd ];

  home.sessionVariables = {
    FLAKE = "${config.homeDirectory}/nix-config?submodules=1";
  };

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;

  programs.navi.settings.cheats.paths = [ standaloneCheats ];
})
