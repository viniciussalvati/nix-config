{
  imports = [
    ../home-manager/shell
    ../home-manager/editors/neovim
  ];

  # Used to make home-manager generate the .profile file
  programs.bash.enable = true;

  home = {
    sessionVariables = {
      EDITOR = "code --wait";
    };
  };
}
