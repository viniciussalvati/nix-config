{ ... }:
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
    enableAliases = true;
    icons = true;
    extraOptions = [ "-F" "--group-directories-first" "--color-scale" ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
