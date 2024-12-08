{ unstablePkgs, lib, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = lib.mkForce "FiraCode Nerd Font";
    settings = {
      shell = "${unstablePkgs.nushell}/bin/nu";
      editor = "nvim";

      copy_on_select = true;
      show_hyperlink_targets = "yes";
      strip_trailing_spaces = "smart";
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
    };
    extraConfig = ''
      mouse_map right press grabbed,ungrabbed no-op
      mouse_map right click grabbed,ungrabbed paste_from_clipboard
    '';
  };
}
