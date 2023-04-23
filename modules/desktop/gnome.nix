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
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    epiphany # web browser
    geary # email reader (I'll use thunderbird or another client if I want it)
  ]);
}
