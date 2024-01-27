{ pkgs, unstablePkgs, ... }:
let
  flameshot-gui = pkgs.writeShellScriptBin "flameshot-gui" "${unstablePkgs.flameshot}/bin/flameshot gui";

  mkBinding = name: binding: command: {
    inherit binding command name;
  };
  keybindings = [ (mkBinding "Flameshot" "Print" "${flameshot-gui}/bin/flameshot-gui") ];

  keybindingSet = builtins.listToAttrs (builtins.genList
    (index:
      let binding = (builtins.elemAt keybindings index); in
      {
        name = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${builtins.toString index}";
        value = binding;
      })
    (builtins.length keybindings));
  keybindingList = builtins.map (name: "/${name}/") (builtins.attrNames keybindingSet);
in
{
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      # Configure switching on alt-tab
      switch-applications = [ ]; # prevents behaviour of swithing whole applications
      switch-windows = [ "<Alt>Tab" ]; # configure alt-tab to switch between all open windows
      switch-windows-backward = [ "<Shift><Alt>Tab" ]; # configure alt-tab to switch between all open windows, backwards
    };
    # Disables the default screenshot interface
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ ];
    };
    # Sets the new keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = keybindingList;
    };
  } // keybindingSet;
}
