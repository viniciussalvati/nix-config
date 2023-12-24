{ pkgs, ... }:
let
  # Extensions to be used in gnome
  extensions = with pkgs; [
    # Allows using tray icons
    # This is not a perfect solution, but it will do until I replace gnome
    gnomeExtensions.tray-icons-reloaded
  ];
  # Maps the enabled extensions to their ids so they can be enabled
  extensionNames = (builtins.map (e: e.extensionUuid) extensions);
in
{
  home.packages = extensions;

  dconf.settings."org/gnome/shell" = {
    disable-user-extensions = false; # enables extensions

    # `gnome-extensions list` for a list
    enabled-extensions = extensionNames;
  };
}
