# specific configuration for standalone home-manager
{
  nixpkgs.config.allowUnfree = true;

  programs.zsh.initExtraFirst = builtins.readFile ./zsh-init-extra-first.zsh;
}
