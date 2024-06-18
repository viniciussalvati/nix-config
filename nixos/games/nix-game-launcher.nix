pkgs:
let
  mangohud = "${pkgs.mangohud}/bin/mangohud";
  gamemode = "${pkgs.gamemode}/bin/gamemoderun";
in
pkgs.writeShellScriptBin "nix-game-launcher" # bash
  ''
    if [ "$LD_LIBRARY_PATH" == "" ]; then
      export LD_LIBRARY_PATH="/run/opengl-driver/lib"
    fi
    exec nvidia-offload ${gamemode} ${mangohud} "$@"
  ''
