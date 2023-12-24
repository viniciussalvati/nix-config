{ unstablePkgs, ... }:
{
  services.flameshot = {
    enable = true;
    package = unstablePkgs.flameshot;
    settings = {
      General = {
        checkForUpdates = false;
        saveLastRegion = true;
      };
    };
  };
}
