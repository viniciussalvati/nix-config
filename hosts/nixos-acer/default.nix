# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hardware-nvidia.nix

    ../../nixos/boot/systemd-boot.nix
    ../../nixos/boot/secure-boot.nix

    ../../nixos/hardware/logitech/solaar.nix
  ];

  services.xserver.xkb.layout = "br";
  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable sound.
  services.pipewire.enable = true;

  hardware.bluetooth.enable = true;

  virtualisation.waydroid.enable = true;

  settings.enableGaming = true;
  settings.libreoffice.enable = true;

  programs.kdeconnect.enable = true;

  environment.sessionVariables = {
    # makes gnome apps use the old renderer, allowing it to work with faulty nvidia driver
    # Error messages:
    # MESA-INTEL: warning: ../src/intel/vulkan/anv_formats.c:763: FINISHME: support YUV colorspace with DRM format modifiers
    # MESA-INTEL: warning: ../src/intel/vulkan/anv_formats.c:794: FINISHME: support more multi-planar formats with DRM modifiers
    #
    # See https://bbs.archlinux.org/viewtopic.php?id=299546
    GSK_RENDERER = "ngl";
  };
}
