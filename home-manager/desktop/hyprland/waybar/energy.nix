{
  styles = builtins.readFile ./energy.css;
  settings = {
    "group/energy" = {
      orientation = "inherit";
      modules = [
        "battery"
        "custom/reboot"
        "custom/power"
        "custom/quit"
        "custom/suspend"
        "custom/lock"
        "power-profiles-daemon"
      ];
      drawer = {
        transition-left-to-right = false;
        click-to-reveal = true;
      };
    };

    power-profiles-daemon = {
      format = "{icon}";
      tooltip-format = "Power profile: {profile}\nDriver: {driver}";
      tooltip = true;
      format-icons = {
        default = "";
        performance = "";
        balanced = "";
        power-saver = "";
      };
    };

    battery = {
      format = "{capacity}% {icon} ";
      "format-icons" = [
        ""
        ""
        ""
        ""
        ""
      ];
      states = {
        critical = 15;
        warning = 30;
      };
    };
    "custom/quit" = {
      format = "󰗼";
      tooltip = true;
      tooltip-format = "logout";
      on-click = "hyprctl dispatch exit";
    };
    "custom/lock" = {
      format = "󰍁";
      tooltip = true;
      tooltip-format = "lock";
      on-click = "hyprlock --immediate";
    };
    "custom/reboot" = {
      format = "󰜉";
      tooltip = true;
      tooltip-format = "reboot";
      on-click = "reboot";
    };
    "custom/suspend" = {
      format = "󰒲";
      tooltip = true;
      tooltip-format = "suspend";
      on-click = "systemctl suspend";
    };
    "custom/power" = {
      format = "";
      tooltip = true;
      tooltip-format = "shutdown";
      on-click = "shutdown now";
    };
  };
}
