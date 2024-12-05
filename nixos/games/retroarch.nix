{ unstablePkgs, ... }:
{
  environment.systemPackages = with unstablePkgs; [
    (retroarchFull.withCores (
      cores: with cores; [
        dolphin
        # genesis-plus-gx
        # snes9x
        # beetle-psx-hw
      ]
    ))
  ];
}
