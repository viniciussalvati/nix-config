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

    nh # todo: Move to programs.nh
    nix-output-monitor
    nvd
  ];

  environment.sessionVariables = {
    # todo: Move to programs.nh
    FLAKE = "${config.homeDirectory}/nix-config?submodules=1";
  };
}
