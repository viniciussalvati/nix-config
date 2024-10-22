inputs:
let
  inherit (import ../lib inputs) deepMerge;
  nixvim = import ./nixvim inputs;
  git-fuzzy = import ./git-fuzzy.nix inputs;
in
deepMerge [
  nixvim
  git-fuzzy
  inputs.browser-stack-local-flake
]
