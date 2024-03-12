{ lib, ... }:
{
  options.common = {
    hostname = lib.mkOption
      {
        description = "The hostname set in flake for the current nixos system or standalone home-manager installation";
        type = lib.types.str;
        readOnly = true;
      };
  };
}
