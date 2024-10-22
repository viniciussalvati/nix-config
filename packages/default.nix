inputs:
let
  inherit (import ../lib inputs) deepMerge;
  lib = inputs.nixpkgs.lib;
  directoriesSet = lib.attrsets.filterAttrs (
    name: value: value == "directory" || (lib.strings.hasSuffix ".nix" name && name != "default.nix")
  ) (builtins.readDir ./.);
  localPackages = builtins.map (path: import ./${path} inputs) (builtins.attrNames directoriesSet);
in
deepMerge (localPackages ++ [ inputs.browser-stack-local-flake ])
