# specific configuration for standalone home-manager
{
  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;
}