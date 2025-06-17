{ unstablePkgs, ... }:
{
  programs.zsh = {
    enable = true;
    package = unstablePkgs.zsh;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # enableVteIntegration = true; # This was supposed to let the terminal know the working folder so applications can duplicate it. But it didn't work
    initContent = builtins.readFile ./init-content.zsh;
    autocd = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "alias-finder"
        "docker"
        "docker-compose"
        "git"
        "gitfast"
        "sudo"
        "yarn"
      ];
    };
  };
}
