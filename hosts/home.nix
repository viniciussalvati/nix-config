{ user, pkgs, ... }:
{
  imports = [
    ../modules/shell/home
    ../modules/desktop/home/gnome.nix
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
