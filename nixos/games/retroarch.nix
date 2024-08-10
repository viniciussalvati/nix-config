{ unstablePkgs, ... }:
{
  environment.systemPackages = with unstablePkgs; [
    (retroarchFull.override {
      cores = with libretro; [
        dolphin
        # genesis-plus-gx
        # snes9x
        # beetle-psx-hw
      ];
    })
  ];
}
