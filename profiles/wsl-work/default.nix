{ unstablePkgs, localPkgs, ... }:
{
  # Forces node 18 to be installed by the node.nix
  # This is also required for yarn to use the same version of nodejs
  nixpkgs.overlays = [ (_self: _super: { nodejs = unstablePkgs.nodejs_20; }) ];

  settings.includePrivate = true;

  home.packages = with unstablePkgs; [
    nodejs
    yarn
    awscli2
    jre_headless
    localPkgs.BrowserStackLocal
  ];

  programs.navi.settings.cheats.paths = [
    ./navi-cheats
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "npm"
    "yarn"
  ];
}
