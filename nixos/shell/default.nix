{ homeDirectory, unstablePkgs, ... }:
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

    # Tools for nix (aka nh)
    nix-output-monitor
    nvd
  ];

  # See in https://github.com/viperML/nh
  programs.nh = {
    enable = true;
    flake = "${homeDirectory}/nix-config?submodules=1";
  };
}
