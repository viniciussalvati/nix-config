{ unstablePkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      shell = "${unstablePkgs.nushell}/bin/nu";
      editor = "nvim";
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
    };
  };
}
