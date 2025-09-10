{ unstablePkgs, ... }:
{
  imports = [
    ./git.nix
    ./navi
    ./tealdeer.nix
    ./starship.nix
    ./zsh
    ./nushell
    ./fzf.nix
  ];

  home.packages = with unstablePkgs; [
    sd
  ];

  programs.btop = {
    enable = true;
    package = unstablePkgs.btop;
    settings = {
      show_io_stat = true;
      proc_tree = true;
    };
  };

  programs.htop = {
    enable = true;
    package = unstablePkgs.htop;
  };

  programs.eza = {
    enable = true;
    package = unstablePkgs.eza;
    icons = "always";
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

  programs.fd = {
    enable = true;
    package = unstablePkgs.fd;
  };

  programs.jq.enable = true;

  programs.ripgrep = {
    enable = true;
    package = unstablePkgs.ripgrep;
  };

  programs.zoxide.enable = true;
  programs.carapace = {
    enable = true;
    # Needed to fix an error on init on nushell. May be removed when the version in stable is 1.3.3 or older
    package = unstablePkgs.carapace;
  };
}
