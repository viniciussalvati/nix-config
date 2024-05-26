{ lib, ... }: {
  options = {
    hostname = lib.mkOption {
      description =
        "The hostname set in flake for the current nixos system or standalone home-manager installation";
      type = lib.types.str;
      readOnly = true;
    };
    username = lib.mkOption {
      description = "The name of the default user";
      type = lib.types.str;
      readOnly = true;
    };
    homeDirectory = lib.mkOption {
      description = "The path of the home directory";
      type = lib.types.str;
      readOnly = true;
    };
  };
}
