inputs:
let
  inherit (import ../lib inputs) deepMerge;
  BrowserStackLocal = import ./BrowserStackLocal inputs;
  nixvim = import ./nixvim inputs;
  git-fuzzy = import ./git-fuzzy.nix inputs;
in
deepMerge [
  BrowserStackLocal
  nixvim
  git-fuzzy
]
