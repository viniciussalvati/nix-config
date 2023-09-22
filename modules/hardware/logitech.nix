{ pkgs, ... }:
{
  # Install logiops package
  environment.systemPackages = [ pkgs.logiops ];

  # Create systemd service
  systemd.services.logiops = {
    description = "An unofficial userspace driver for HID++ Logitech devices";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.logiops}/bin/logid";
    };
  };

  # # Enables the configuration for Logitech's wireless devices
  # hardware.logitech.wireless = {
  #   enable = true;
  #   # This gives us a very basic UI
  #   enableGraphical = true;
  # };

  # environment.systemPackages = [ pkgs.logiops ];
}
