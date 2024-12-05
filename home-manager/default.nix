{ localPkgs, pkgs, ... }:
{
  imports = [
    ../home-manager/shell
    ./gaming
    ./stylix

    ./nixos # only use if in nixos installation of home-manager
    ./standalone # only used if in standalone installation of home-manager
    ./wsl # only used if in standalone installation of home-manager inside wsl
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
      ]);

    sessionVariables = {
      EDITOR = "code --wait";
    };
  };
}
