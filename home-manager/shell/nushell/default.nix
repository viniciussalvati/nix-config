{ unstablePkgs, config, ... }:
let
  nuScripts = unstablePkgs.nu_scripts;
in
{
  programs.nushell = {
    enable = true;
    package = unstablePkgs.nushell;

    shellAliases = {
      la = "ls -a";
      ll = "ls -l";
      lla = "ls -la";
      l = "ls";

      y = "yarn";
      ya = "yarn add";
      yad = "yarn add --dev";
      yap = "yarn add --peer";
      yb = "yarn build";
      ycc = "yarn cache clean";
      yd = "yarn dev";
      yf = "yarn format";
      yga = "yarn global add";
      ygls = "yarn global list";
      ygrm = "yarn global remove";
      ygu = "yarn global upgrade";
      yh = "yarn help";
      yi = "yarn init";
      yin = "yarn install";
      yln = "yarn lint";
      ylnf = "yarn lint --fix";
      yls = "yarn list";
      yout = "yarn outdated";
      yp = "yarn pack";
      yrm = "yarn remove";
      yrun = "yarn run";
      ys = "yarn serve";
      yst = "yarn start";
      yt = "yarn test";
      ytc = "yarn test --coverage";
      yuc = "do { yarn global upgrade; yarn cache clean }";
      yui = "yarn upgrade-interactive";
      yuil = "yarn upgrade-interactive --latest";
      yup = "yarn upgrade";
      yv = "yarn version";
      yw = "yarn workspace";
      yws = "yarn workspaces";
      yy = "yarn why";
    };

    configFile.source = ./config.nu;
    extraConfig = ''
      source ${./navi.nu}

      $env.config.rm.always_trash = ${if config.home-manager.type == "wsl" then "false" else "true"}

      use ${nuScripts}/share/nu_scripts/aliases/git/git-aliases.nu *
    '';
  };
}
