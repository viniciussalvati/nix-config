{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Cli utils
    bat
    eza
    fd
    htop
    jq
    ripgrep
    sd
  ];
}
