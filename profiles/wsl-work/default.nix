{ unstablePkgs, localPkgs, ... }:
let
  # Forces node 20 to be installed by the node.nix
  # This is also required for yarn to use the same version of nodejs
  nodejs = unstablePkgs.nodejs_20;
in
{
  nixpkgs.overlays = [ (_self: _super: { inherit nodejs; }) ];

  settings.includePrivate = true;

  home.packages =
    [
      nodejs
      localPkgs.BrowserStackLocal
    ]
    ++ (with unstablePkgs; [
      # Makes yarn use the specific nodejs version
      (yarn.override { inherit nodejs; })
      awscli2
      jre_headless
      maven # used by slots-admin
    ]);

  programs.navi.settings.cheats.paths = [
    ./navi-cheats
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "npm"
    "yarn"
  ];
}
