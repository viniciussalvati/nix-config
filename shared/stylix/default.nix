{ pkgs, ... }:
{
  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  stylix.image = ./wallpaper.jpeg;

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 35;
  };
}
