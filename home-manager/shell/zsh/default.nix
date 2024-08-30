{ unstablePkgs, ... }:
{
  programs.zsh = {
    enable = true;
    package = unstablePkgs.zsh;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # enableVteIntegration = true; # This was supposed to let the terminal know the working folder so applications can duplicate it. But it didn't work
    initExtra = builtins.readFile ./init-extra.zsh;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "gitfast"
        "z"
        "alias-finder"
        "sudo"
        "fd"
        "ripgrep"
      ];
    };
  };
}
