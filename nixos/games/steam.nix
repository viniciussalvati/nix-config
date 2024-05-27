{ pkgs, config, lib, ... }:
lib.mkIf config.programs.steam.enable {
  # Enables support for the steam controller
  hardware.steam-hardware.enable = true;
  programs.steam = {
    # Allows starting games with a micro-compositor to improve games and fix issues
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Program to monitor systems status (CPU and GPU load and temp, RAM, FPS, etc)
    mangohud
    protonup
  ];

  # Improves game performance by temporarily applying optimizations to the OS and game process
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    # Install proton with
    # protonup
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "${config.homeDirectory}/.steam/root/compatibilitytools.d";
  };
}
