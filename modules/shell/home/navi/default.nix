{ unstablePkgs, ... }:
{
  programs.navi = {
    enable = true;
    package = unstablePkgs.navi;
    enableZshIntegration = true;
    settings.cheats.paths = [
      ./cheats
    ];
  };
}
