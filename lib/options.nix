{ lib }: {
  mkIfStandalone = config: value:
    lib.mkIf
      (
        config.home-manager.type == "standalone" ||
        config.home-manager.type == "wsl"
      )
      value;
  mkIfWsl = config: value:
    lib.mkIf
      (config.home-manager.type == "wsl")
      value;
}
