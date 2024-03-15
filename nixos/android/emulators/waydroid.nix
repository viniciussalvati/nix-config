{ lib, config, ... }:
{
  options.virtualisation.waydroid = {
    autostart = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Sets if waydroid will be started on boot";
    };
  };

  config = lib.mkIf (config.virtualisation.waydroid.autostart == false) {
    systemd.services.waydroid-container.wantedBy = lib.mkForce [ ];
  };
}
