{ lib }:
{
  mkIfNixos = config: value: lib.mkIf (config.home-manager.type == "nixos") value;
  mkIfStandalone =
    config: value:
    lib.mkIf (config.home-manager.type == "standalone" || config.home-manager.type == "wsl") value;
  mkIfWsl = config: value: lib.mkIf (config.home-manager.type == "wsl") value;
  mkIfDesktop = config: value: lib.mkIf (config.home-manager.type != "wsl") value;
}
