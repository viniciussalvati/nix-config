{ unstablePkgs, ... }:
{
  imports = [
    ./git.nix
    ./navi
    ./tealdeer.nix
    ./starship.nix
    ./zsh
  ];

  home.packages = with unstablePkgs; [
    fd
    sd
    bat
    htop
    jq
    ripgrep
  ];

  programs.eza = {
    enable = true;
    package = unstablePkgs.eza;
    icons = true;
    extraOptions = [
      "-F"
      "--group-directories-first"
      "--color-scale"
    ];
  };

  programs.direnv = {
    enable = true;
    package = unstablePkgs.direnv;
    nix-direnv.enable = true;
  };
}
