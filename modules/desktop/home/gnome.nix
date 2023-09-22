{
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Console.desktop"
        "firefox.desktop"
        "code.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.TextEditor.desktop"
        "bitwarden.desktop"
        "org.telegram.desktop.desktop"
      ];
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true; # numlock on by default
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true; # tap to click the button
      two-finger-scrolling-enabled = true; # scroll with two fingers
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark"; # dark theme
      show-battery-percentage = true; # displays battery
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing"; # never suspends when connected
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true; # make dynamic workspaces, instead of a fixed number
    };
  };
}
