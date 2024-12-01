{ lib, ... }:
{
  options.settings = {
    enableGaming = lib.mkOption {
      description = "Choose if gaming should be enabled";
      type = lib.types.bool;
      default = false;
    };
    includePrivate = lib.mkOption {
      description = "Choose if the private directory should be included when creating the FLAKE environment variable. This actually includes all the submodules";
      type = lib.types.bool;
      default = false;
    };
  };
}
