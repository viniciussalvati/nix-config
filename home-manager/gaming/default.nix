{
  lib,
  osConfig,
  unstablePkgs,
  ...
}:
lib.mkIf osConfig.programs.steam.enable {
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
