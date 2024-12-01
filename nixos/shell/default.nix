{
  homeDirectory,
  unstablePkgs,
  config,
  ...
}:
let
  submodulesFragment = if config.settings.includePrivate then "submodules=1" else "";
in
{
  environment.systemPackages = with unstablePkgs; [
    # Cli utils
    bat
    eza
    fd
    htop
    btop
    jq
    ripgrep
    sd
    fzf

    # Tools for nix (aka nh)
    nix-output-monitor
    nvd
  ];

  # See in https://github.com/viperML/nh
  programs.nh = {
    enable = true;
    package = unstablePkgs.nh;
    flake = "${homeDirectory}/nix-config?${submodulesFragment}";
  };
}
