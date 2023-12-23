{ unstablePkgs, ... }:
{
  environment.systemPackages = with unstablePkgs; [
    vscode
  ];
}
