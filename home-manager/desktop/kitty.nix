{ unstablePkgs, lib, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = lib.mkForce "FiraCode Nerd Font";
    settings = {
      show_hyperlink_targets = "yes";

      shell = "${unstablePkgs.nushell}/bin/nu";
      editor = "nvim";
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
    };
  };
}
