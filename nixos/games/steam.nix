{
  pkgs,
  unstablePkgs,
  config,
  homeDirectory,
  lib,
  ...
}:
lib.mkIf config.settings.enableGaming {
  # Enables support for the steam controller
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    # Allows starting games with a micro-compositor to improve games and fix issues
    gamescopeSession.enable = true;
  };

  environment.systemPackages =
    (with pkgs; [
      # Program to monitor systems status (CPU and GPU load and temp, RAM, FPS, etc)
      mangohud

      (import ./nix-game-launcher.nix pkgs)
    ])
    ++ (with unstablePkgs; [
      protonup-ng
      wine
    ]);

  # Improves game performance by temporarily applying optimizations to the OS and game process
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    # Path where protonup will install proton
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${homeDirectory}/.steam/root/compatibilitytools.d";
  };
}
