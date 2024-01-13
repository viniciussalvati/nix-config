{
  boot.loader = {
    timeout = 30;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # The OSProber can be used to identify other OS in the disks (Windows)
      # It also makes rebuild of the OS very slow.
      useOSProber = false;
    };
  };

}
