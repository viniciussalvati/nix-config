{
  pkgs,
  unstablePkgs,
  localPkgs,
  lib,
  ...
}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    package = pkgs.openssh;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github_ed25519";
        identitiesOnly = true;
        extraOptions = {
          addKeysToAgent = "yes";
        };
      };
    };
  };

  programs.git = {
    enable = true;
    package = unstablePkgs.gitFull;
    settings = {
      user = {
        name = "Vinicius Salvati Melquiades";
        email = "1378981+viniciussalvati@users.noreply.github.com";
        signingkey = "~/.ssh/github_ed25519";
      };
      alias = {
        sort = "!git rebase -i $(git merge-base origin/HEAD --fork-point)";
      };
      advice = {
        detachedHead = false;
      };
      core = {
        sshCommand = "${pkgs.openssh}/bin/ssh";
      };
      pull = {
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
      gpg = {
        format = "ssh";
        ssh = {
          allowedSignersFile = "~/.config/git/allowed_signers";
        };
      };
      commit = {
        verbose = true;
        gpgsign = true;
      };
    };
  };

  programs.delta = {
    enable = true;
    package = unstablePkgs.delta;
    enableGitIntegration = true;
    options = {
      side-by-side = true;
    };
  };

  programs.lazygit = {
    enable = true;
    package = unstablePkgs.lazygit;
    settings = {
      git.commit = {
        autoWrapCommitMessage = false;
      };
    };
  };

  programs.gh = {
    enable = true;
    package = unstablePkgs.gh;
    settings.git_protocol = "ssh";
  };

  programs.gitui = {
    enable = true;
    package = unstablePkgs.gitui;
  };

  home = {
    packages =
      with unstablePkgs;
      [
        git-bug
        glab
        tig
      ]
      ++ [ localPkgs.git-fuzzy ];

    shellAliases = {
      gk = ": $(gitk --all > /dev/null 2>&1 &)";
      gui = "gitui";
      main = "gfa && gsw -d origin/$(git_main_branch)";

      # git-bug aliases
      gbug = "git bug";
      gbgui = "git bug termui";
      gbga = "git bug add";
      gbgl = "git bug pull";
      gbgp = "git bug push";
      gbgls = "git bug ls";

      gfb = "git fuzzy branch";

      ta = "tig --all";
    };
  };
  programs.nushell.shellAliases = builtins.mapAttrs (name: value: lib.mkForce value) {
    gk = "do { job spawn { gitk --all } | ignore }";
    main = "do { gfa; gsw -d origin/(git_main_branch) }";
  };
}
