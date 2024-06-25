{ lib, ... }:
{
  options.settings = {
    enableGaming = lib.mkOption {
      description = "Choose if gaming should be enabled";
      type = lib.types.bool;
      default = false;
    };
  };
}
