{
  lib,
  config,
  osConfig,
  ...
}:
lib.mkIfNixos config {
  # Passes the config settings defined in the NixOS config to home-manager settings
  settings = osConfig.settings;

  programs.navi.settings.cheats.paths = [
    ./cheats/nixos.cheat
  ] ++ (if (osConfig.virtualisation.waydroid.enable) then [ ./cheats/waydroid.cheat ] else [ ]);
}
