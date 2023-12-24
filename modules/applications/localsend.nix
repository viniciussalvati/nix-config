{ unstablePkgs, ... }:
{
  environment.systemPackages = [ unstablePkgs.localsend ];
}
