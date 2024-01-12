# Specific configuration when running inside wsl
{
  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;
}
