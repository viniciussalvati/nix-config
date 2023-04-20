{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Cli utils
    bat
    exa
    fd
    htop
    jq
    ripgrep
    sd
  ];
}
