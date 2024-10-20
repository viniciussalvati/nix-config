{ unstablePkgs, ... }:
{
  programs.nushell = {
    enable = true;
    package = unstablePkgs.nushell;
  };
}
