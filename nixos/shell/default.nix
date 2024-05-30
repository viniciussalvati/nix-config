{ config, unstablePkgs, ... }: {
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

  programs.nh = {
    enable = true;
    flake = "${config.homeDirectory}/nix-config?submodules=1";
  };
}
