{
  lib,
  config,
  unstablePkgs,
  ...
}:
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

  home.shellAliases = (
    lib.mkIfDesktop config {
      "rm!" = "command rm";
      rm = "echo 'Use trash command or rm! if you really want to remove the file'";
      trash = "gio trash";
    }
  );

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

  programs.fd = {
    enable = true;
    package = unstablePkgs.fd;
  };

  programs.jq = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
    package = unstablePkgs.ripgrep;
  };
}
