{ unstablePkgs, localPkgs, ... }:
let
  # Forces node 20 to be installed by the node.nix
  # This is also required for yarn to use the same version of nodejs
  nodejs = unstablePkgs.nodejs_24;
in
{
  nixpkgs.overlays = [ (_self: _super: { inherit nodejs; }) ];

  settings.includePrivate = true;

  home.packages = [
    nodejs
    localPkgs.BrowserStackLocal
  ]
  ++ (with unstablePkgs; [
    (yarn.override { inherit nodejs; }) # Yarn with specific node version, instead of latest
    awscli2 # Used to load some pre-built docker images
    jre_headless # Used by wiremock, which is used by wtr-website to run business scenario tests
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
