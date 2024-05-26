# For instructions and help see:
# https://nixos.wiki/wiki/Nvidia
# https://www.youtube.com/watch?v=qlfm3MEbqYA&t=53s
# https://github.com/vimjoyer/nixos-gaming-video
{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.modesetting.enable = true;

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      # Will enable nvidia-offload command
      enableOffloadCmd = true;
    };

    # Bus ids retrieved with command:
    # nix shell nixpkgs#pciutils -c lspci
    # And confirmed with
    # sudo nix run nixpkgs#lshw -- -c display

    # integrated
    intelBusId = "PCI:0:2:0";
    # amdgpuBusId = "PCI:6:0:0"

    # dedicated
    nvidiaBusId = "PCI:1:0:0";
  };
}
