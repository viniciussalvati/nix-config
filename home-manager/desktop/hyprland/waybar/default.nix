{ lib, ... }:
let
  workspaces = import ./workspaces.nix;
  clock = import ./clock.nix;
  energy = import ./energy.nix;
in
{
  programs.waybar.enable = true;
  # stylix.targets.waybar.enable = false;
  # stylix.targets.waybar.enableLeftBackColors = true;
  # stylix.targets.waybar.enableRightBackColors = true;

  programs.waybar.style = builtins.concatStringsSep "\n\n" [
    workspaces.styles
    energy.styles
    (builtins.readFile ./language.css)
    (builtins.readFile ./connections.css)
    (builtins.readFile ./tray.css)
  ];
  programs.waybar.settings = {
    mainBar = (
      lib.deepMerge [
        workspaces.settings
        clock.settings
        energy.settings
        {
          layer = "top";
          position = "top";
          height = 30;
          output = [
            "eDP-1"
            "HDMI-A-1"
          ];

          modules-left = [
            "hyprland/workspaces"
          ];

          modules-center = [
            "clock"
          ];

          modules-right = [
            "tray"
            "hyprland/language"
            "bluetooth"
            "network"
            "group/energy"
          ];

          tray = {
            show-passive-items = true;
            spacing = 10;
          };

          "hyprland/language" = {
            # format = "{}";
            format-pt = "🇧🇷";
          };

          bluetooth = {
            format = "";
            format-disabled = ""; # an empty format will hide the module
            format-connected = "";
            format-connected-battery = " {device_battery_percentage}%";
            # "format-device-preference": [ "device1" "device2" ], // preference list deciding the displayed device
            tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          };

          network = {
            format = "{ifname}";
            format-wifi = "";
            format-ethernet = "󰈀";
            format-disconnected = "󰲜"; # An empty format will hide the module
            tooltip-format = "{ifname} via {gwaddr} 󰊗 ";
            tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
            tooltip-format-ethernet = "{ifname} {ipaddr}/{cidr} 󰈀";
            tooltip-format-disconnected = "Disconnected";
          };
        }
      ]
    );
  };
}
