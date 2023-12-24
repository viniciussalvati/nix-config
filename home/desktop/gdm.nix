# This configures gnome's login screen
{
  dconf.settings = {
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
  };
}
