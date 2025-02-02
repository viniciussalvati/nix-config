{ lib, ... }:
{

  options.settings.packages = lib.mkOption {
    description = "list of packages to be added to either NixOS or home-manager";
    type = lib.types.listOf lib.types.package;
    default = [ ];
  };
}
