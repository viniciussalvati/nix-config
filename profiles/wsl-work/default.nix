{ pkgs, ... }:
{
  # Forces node 18 to be installed by the node.nix
  # This is also required for yarn to use the same version of nodejs
  nixpkgs.overlays = [ (_self: _super: { nodejs = pkgs.nodejs-18_x; }) ];

  home.packages = with pkgs; [
    nodejs
    yarn
    awscli2
    jre_headless
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "npm"
    "yarn"
  ];
}
