{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;

    desktopManager = {
      gnome = {
        enable = true;
      };

      # Disables xterm
      xterm.enable = false;
    };

    excludePackages = with pkgs; [
      xterm # because xterm.enable = false isn't always enough
    ];
  };

  # Removes some packages from gnome I don't want/need
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany # web browser
    geary # email reader (I'll use thunderbird or another client if I want it)
  ];

  programs.dconf.profiles.gdm.databases = [
    {
      settings = {
        "org/gnome/desktop/peripherals/keyboard" = {
          numlock-state = true; # numlock on by default
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true; # tap to click the button
          two-finger-scrolling-enabled = true; # scroll with two fingers
        };
        "org/gnome/desktop/interface" = {
          show-battery-percentage = true; # displays battery
        };
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing"; # never suspends when connected
        };
      };
    }
  ];
}
