{
  lib,
  config,
  unstablePkgs,
  ...
}:
lib.mkIf (config.settings.enableGaming) {
  programs.mangohud = {
    enable = true;
    package = unstablePkgs.mangohud;
    settings = {
      gpu_temp = true;
      gpu_name = true;
      cpu_temp = true;
      fan = true;
      frame_timing = 0;
      gamemode = true;
    };
  };
}
