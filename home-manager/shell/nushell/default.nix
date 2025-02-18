{ unstablePkgs, config, ... }:
let
  nuScripts = unstablePkgs.nu_scripts;
  gstatPlugin = unstablePkgs.nushellPlugins.gstat;
  environmentVariables = builtins.attrValues (
    builtins.mapAttrs (
      name: value: "${name}: \"${builtins.toString value}\""
    ) config.home.sessionVariables
  );
  environmentVariablesString = builtins.concatStringsSep ", " environmentVariables;
  isWslString = if config.home-manager.type == "wsl" then "true" else "false";
in
{
  programs.nushell = {
    enable = true;
    package = unstablePkgs.nushell;

    shellAliases = {
      grbom = "git rebase origin/(git_main_branch)";

      la = "ls -a";
      ll = "ls -l";
      lla = "ls -la";
      l = "eza";

      nr = "node --run";

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

    /*
      This is needed while
      https://github.com/NixOS/nixpkgs/pull/343036 and
      https://github.com/nix-community/home-manager/issues/4313
      are not merged
    */
    envFile.source = ./env.nu;
    extraEnv = ''
      if $env.__HM_SESS_VARS_SOURCED? == null {
        # Loads other variables
        let envVars = { ${environmentVariablesString} }
        load-env (
          $envVars
          | transpose name value
          | update value {|x|
              $x.value
              | str replace --regex $'\$\{($x.name):\+:\$($x.name)\}' (if ($env | get --ignore-errors $x.name) != null { $":($env | get $x.name)"} else { "" })
            }
          | transpose --header-row --as-record
        )

        $env.__HM_SESS_VARS_SOURCED = '1'
      }
    '';

    configFile.source = ./config.nu;
    extraConfig = ''
      source ${./config-navi.nu}

      $env.config.shell_integration.osc9_9 = ${isWslString}
      $env.config.rm.always_trash = ${if config.home-manager.type == "wsl" then "false" else "true"}

      plugin add ${gstatPlugin}/bin/nu_plugin_gstat
      use ${nuScripts}/share/nu_scripts/aliases/git/git-aliases.nu *
    '';
  };
}
