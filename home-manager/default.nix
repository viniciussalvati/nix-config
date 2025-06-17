{
  localPkgs,
  pkgs,
  unstablePkgs,
  ...
}:
{
  imports = [
    ../home-manager/shell
    ./gaming
    ./stylix

    ./nixos # only use if in nixos installation of home-manager
    ./standalone # only used if in standalone installation of home-manager
    ./wsl # only used if in standalone installation of home-manager inside wsl

    ./config/packages.nix # Installs packages from shared settings.packages when in standalone home-manager installation
  ];

  # Used to make home-manager generate the .profile file
  programs.bash.enable = true;

  home = {
    packages =
      (with localPkgs; [ nixvim ])
      ++ (with pkgs; [
        neofetch
        wl-clipboard
        nix-index # tool to index and find references in the nix store. Use nix-locate
        nil
        nixfmt-rfc-style

      ])
      ++ (with unstablePkgs; [ devenv ]);

    sessionVariables = {
      EDITOR = "code --wait";
      # Enables Console Do Not Track https://consoledonottrack.com/
      DO_NOT_TRACK = 1;
    };
  };
}
