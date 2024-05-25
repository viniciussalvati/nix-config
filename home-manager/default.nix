{ localPkgs, unstablePkgs, ... }: {
  imports = [
    ../home-manager/shell
    ./nixos # only use if in nixos installation of home-manager
    ./standalone # only used if in standalone installation of home-manager
    ./wsl # only used if in standalone installation of home-manager inside wsl
  ];

  # Used to make home-manager generate the .profile file
  programs.bash.enable = true;

  home = {
    packages = (with localPkgs; [ nixvim ])
      ++ (with unstablePkgs; [ neofetch wl-clipboard nil ]);

    sessionVariables = { EDITOR = "code --wait"; };
  };
}
