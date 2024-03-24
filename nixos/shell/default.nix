{ unstablePkgs, ... }:
{
  environment.systemPackages = with unstablePkgs; [
    # Cli utils
    bat
    eza
    fd
    htop
    jq
    ripgrep
    sd

    # Terminal
    tilix
    terminator
  ];
}
