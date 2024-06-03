{ localPkgs, unstablePkgs, ... }:
{
  imports = [
    ../home-manager/shell
    ./nixos # only use if in nixos installation of home-manager
    ./standalone # only used if in standalone installation of home-manager
    ./wsl # only used if in standalone installation of home-manager inside wsl
  ];

  # Used to make home-manager generate the .profile file
  programs.bash.enable = true;

  home = {
    packages =
      (with localPkgs; [ nixvim ])
      ++ (with unstablePkgs; [
        neofetch
        wl-clipboard
        nix-index # tool to index and find references in the nix store. Use nix-locate
        nil
        # todo: Checkout nixfmt-rfc-style instead of nixfmt-classic
        # nixfmt-classic
        nixfmt-rfc-style
      ]);

    sessionVariables = {
      EDITOR = "code --wait";
    };
  };
}
