{ unstablePkgs, ... }:
{
  imports = [ ../../home-manager/wsl ];

  # Forces node 18 to be installed by the node.nix
  # This is also required for yarn to use the same version of nodejs
  nixpkgs.overlays = [
    (_self: _super: {
      nodejs = unstablePkgs.nodejs-18_x;
    })
  ];

  home.packages = with unstablePkgs; [
    nodejs
    yarn
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "npm"
    "yarn"
  ];
}
