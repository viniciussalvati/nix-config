{ user, pkgs, ... }:
{
  imports = [
    ../home/desktop/gnome
    ../home/services/flameshot.nix
    ../home/shell
    ../home/editors/neovim
  ];

  home = {
    stateVersion = "23.11";

    username = "${user}";
    homeDirectory = "/home/${user}";

    sessionVariables = {
      EDITOR = "code --wait";
    };
  };

  # Used to make home-manager generate the .profile file
  programs.bash.enable = true;
}
