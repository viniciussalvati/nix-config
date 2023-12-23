{ unstablePkgs, ... }:
{
  programs.ssh = {
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
    userName = "Vinicius Salvati Melquiades";
    userEmail = "1378981+viniciussalvati@users.noreply.github.com";
    # signing # todo: set up signing
    aliases = {
      sort = "!git rebase -i $(git merge-base origin/HEAD --fork-point)";
    };
    extraConfig = {
      advice = {
        detachedHead = false;
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
        gpgsign = true;
      };
      user = {
        signingkey = "~/.ssh/github_ed25519";
      };
    };
  };

  home = {
    packages = with unstablePkgs; [
      gitui
      tig
      git-bug
      lazygit
    ];

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
    };
  };
}
