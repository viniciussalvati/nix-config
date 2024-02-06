{ localPkgs, ... }: {
  imports = [
    ../home-manager/shell
    ./standalone # only used if in standalone installation of home-manager
    ./wsl # only used if in standalone installation of home-manager inside wsl
  ];

  # Used to make home-manager generate the .profile file
  programs.bash.enable = true;

  home = {
    packages = with localPkgs; [ nixvim ];
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
