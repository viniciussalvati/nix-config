{ lib, ... }:
{
  options.home-manager = {
    type = lib.mkOption {
      description = "The type of home-manager instalation";
      type = lib.types.enum [ "nixos" "standalone" "wsl" ];
    };
  };
}
