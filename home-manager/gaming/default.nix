{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf (config.settings.enableGaming) {
  programs.mangohud = {
    enable = true;
    package = pkgs.mangohud;
    settings = {
      gpu_temp = true;
      gpu_name = true;
      cpu_temp = true;
      fan = true;
      frame_timing = 0;
      gamemode = true;
      font_size = lib.mkForce 18;
      font_size_text = lib.mkForce 18;
    };
  };
}
