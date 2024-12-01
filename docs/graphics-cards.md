## Grafics cards

Instructions came from [this video](https://www.youtube.com/watch?v=qlfm3MEbqYA), which also links to [this repo](https://github.com/vimjoyer/nixos-gaming-video).

NixOS documentation is also available at https://nixos.wiki/wiki/Nvidia

### How to install

- First enable openGL  
  ```nix
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  ```
- Follow the instructions for the graphics card

### nvidia

Add the following to the config:

```nix
services.xserver.videoDrivers = [ "nvidia" ];
```

If the host is a laptop and has two graphics cards, like an Intel, which consumes less energy, and the NVidia, which has more power, add the following:

```nix
# This is not the only way to configure the driver. Please check more options in nixos documentation
  hardware.nvidia = {
    open = true;
    prime = {
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
  };
```

Also note that the `intelBusId` and `nvidiaBusId` will have to be changed, as they vary by hardware.

To get the Bus IDs, you need to use either the command `nix shell nixpkgs#pciutils -c lspci | grep ' VGA '"` (you may need to omit the `grep` part) or the command `sudo lshw -c display `. I used both to ensure I got the correct value. Also, the values will need to be in decimal, while the commands could output them in hexadecimal. For more details, read the [documentation](https://nixos.wiki/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_.28Mandatory.29).

#### Using the graphics cards

To use the graphics card, use `nvidia-offload %command%`. This will instruct the OS to use the GPU for the spawned process.

### AMD

I haven't installed with AMD graphics cards right now, but it's possible that the instructions on the video/repo will still work.
