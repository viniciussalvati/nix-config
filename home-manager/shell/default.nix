{ unstablePkgs, ... }:
{
  imports = [
    ./git.nix
    ./navi
    ./tealdeer.nix
    ./starship.nix
    ./zsh
    ./fzf.nix
  ];

  home.packages = with unstablePkgs; [
    fd
    sd
    htop
    btop
    jq
    ripgrep
  ];

  home.shellAliases = {
    ta = "tig --all";
  };

  programs.btop = {
    enable = true;
    package = unstablePkgs.btop;
    settings = {
      show_io_stat = true;
      proc_tree = true;
    };
  };

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

  programs.bat = {
    enable = true;
    package = unstablePkgs.bat;
  };

  programs.direnv = {
    enable = true;
    package = unstablePkgs.direnv;
    nix-direnv.enable = true;
  };
}
