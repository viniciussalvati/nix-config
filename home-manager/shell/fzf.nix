{ unstablePkgs, ... }:
let
  fzfBin = "${unstablePkgs.fzf}/bin/fzf";
  fdBin = "${unstablePkgs.fd}/bin/fd";
  batBin = "${unstablePkgs.bat}/bin/bat";
  ezaBin = "${unstablePkgs.eza}/bin/exa";

  cdPreview = "${ezaBin} --tree --color=always {} | head -200";
  fzfTabCdPreview = builtins.replaceStrings [ "{}" ] [ "$realpath" ] cdPreview;

  fzf-comprun = [
    {
      name = "cd";
      preview = cdPreview;
    }
    {
      name = "export|unset";
      preview = "eval 'echo $'{}";
    }
    {
      name = "ssh";
      preview = "dig {}";
    }
  ];
  mkCmd = cmd: if (builtins.stringLength cmd) > 0 then ''${cmd} |'' else "";
  mkPreview = preview: if (builtins.stringLength preview) > 0 then ''--preview "${preview}"'' else "";
  fzfString = builtins.concatStringsSep "\n" (
    builtins.map (
      {
        name,
        cmd ? "",
        preview ? "",
        ...
      }:
      ''
        ${name}) ${mkCmd cmd} ${fzfBin} ${mkPreview preview} "$@" ;;
      ''
    ) fzf-comprun
  );
in
{
  programs.fzf = rec {
    enable = true;
    package = unstablePkgs.fzf;
    defaultCommand = "${fdBin} --hidden --strip-cwd-prefix --exclude .git";
    fileWidgetCommand = defaultCommand; # CTRL-T command
    changeDirWidgetCommand = "${fdBin} --type=d --strip-cwd-prefix --exclude .git"; # ALT-C command
    fileWidgetOptions = [ "--preview '${batBin} -n --color=always {}'" ];
    changeDirWidgetOptions = [ "--preview '${cdPreview}'" ];
  };

  programs.zsh = {
    plugins = [
      # https://github.com/Aloxaf/fzf-tab
      {
        name = "fzf-tab";
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
        src = unstablePkgs.zsh-fzf-tab;
      }
      {
        name = "fzf-git";
        file = "share/fzf-git-sh/fzf-git.sh";
        src = unstablePkgs.fzf-git-sh;
      }
    ];

    initContent = # zsh
      ''
        # Use fd for listing path candidates.
        # - The first argument to the function ($1) is the base path to start traversal
        # - See the source code (completion.{bash,zsh}) for the details.
        _fzf_compgen_path() {
          ${fdBin} --hidden --exclude .git . "$1"
        }

        # Use fd to generate the list for directory completion
        _fzf_compgen_dir() {
          ${fdBin} --type=d --hidden --exclude .git . "$1"
        }

        _fzf_comprun() {
          local command=$1
          shift

          case "$command" in
            ${fzfString}
            *)              ${fzfBin} --preview "${batBin} -n --color=always --line-range :500 {}" "$@" ;;
          esac
        }

        # preview directory's content with eza when completing cd
        zstyle ':fzf-tab:complete:*' fzf-preview 'test -d $realpath && ${fzfTabCdPreview} || (test -f $realpath && ${batBin} $realpath)'
      '';
  };
}
