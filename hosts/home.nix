{ user, pkgs, ... }:
{
  imports = [
    ../home/desktop/gnome.nix
    ../home/shell
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
