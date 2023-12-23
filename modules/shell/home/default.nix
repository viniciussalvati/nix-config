{ unstablePkgs, ... }:
{
  imports = [
    ./git.nix
    ./navi
    ./tealdeer.nix
    ./starship.nix
    ./zsh
  ];

  programs.eza = {
    enable = true;
    package = unstablePkgs.eza;
    enableAliases = true;
    icons = true;
    extraOptions = [ "-F" "--group-directories-first" "--color-scale" ];
  };

  programs.direnv = {
    enable = true;
    package = unstablePkgs.direnv;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
