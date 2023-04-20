{ user, pkgs, ... }:
{
  imports = [
    ../modules/shell/home
    ../modules/editors/home
  ];

  home = {
    stateVersion = "23.05";

    username = "${user}";
    homeDirectory = "/home/${user}";

    sessionVariables = {
      EDITOR = "code --wait";
    };
  };

  # Used to make home-manager generate the .profile file
  programs.bash.enable = true;
}
