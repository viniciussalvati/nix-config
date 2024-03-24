{ lib, config, osConfig, ... }:
lib.mkIfNixos config
  (
    {
      programs.navi.settings.cheats.paths = [
        ./cheats/nixos.cheat
      ] ++ (if (osConfig.virtualisation.waydroid.enable) then [ ./cheats/waydroid.cheat ] else [ ]);
    }
  )
