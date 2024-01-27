{
  imports = [
    ../home-manager/shell
    ../home-manager/editors/neovim
    ./standalone # only used if in standalone installation of home-manager
    ./wsl # only used if in standalone installation of home-manager inside wsl
  ];

  # Used to make home-manager generate the .profile file
  programs.bash.enable = true;

  home = {
    sessionVariables = {
      EDITOR = "code --wait";
    };
  };
}
