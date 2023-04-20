{ ... }:
{
  imports = [
    ./git.nix
    ./navi
    ./tealdeer.nix
    ./starship.nix
    ./zsh
  ];

  home = {
    shellAliases = {
      # Map ls commands to exa
      ls = "exa --icons -F --group-directories-first --color-scale";
      la = "exa --icons -F --group-directories-first --color-scale --all";
      ll = "exa --icons -F --group-directories-first --color-scale -l --all";
      l = "ls";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
