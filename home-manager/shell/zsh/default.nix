{ unstablePkgs, ... }:
let
  mkOhMyZshPlugin = name: {
    inherit name;
    file = "share/oh-my-zsh/plugins/${name}/${name}.plugin.zsh";
    src = unstablePkgs.oh-my-zsh;
  };
in
{
  programs.zsh = {
    enable = true;
    package = unstablePkgs.zsh;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # enableVteIntegration = true; # This was supposed to let the terminal know the working folder so applications can duplicate it. But it didn't work
    initExtra = builtins.readFile ./init-extra.zsh;
    autocd = true;
    plugins = [
      (mkOhMyZshPlugin "alias-finder")
      (mkOhMyZshPlugin "git")
      (mkOhMyZshPlugin "gitfast")
      (mkOhMyZshPlugin "sudo")
      (mkOhMyZshPlugin "yarn")
      (mkOhMyZshPlugin "z")
    ];
  };
}
