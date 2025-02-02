{ config, lib, ... }:
lib.mkIfStandalone config {
  home.packages = config.settings.packages;
}
