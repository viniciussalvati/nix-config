{ unstablePkgs, ... }:
{
  services.flameshot = {
    enable = true;
    package = unstablePkgs.flameshot; # switch to stable on 24.11
    settings = {
      General = {
        saveLastRegion = true;
      };
    };
  };
}
