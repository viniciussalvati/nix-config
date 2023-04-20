{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    userSettings = {
      "workbench.sideBar.location" = "right";
      "editor.tabSize" = 2;
      "editor.renderWhitespace" = "boundary";
      "editor.formatOnSave" = true;
      "editor.fontFamily" = "FiraCode Nerd Font";
      "editor.fontLigatures" = true;
      "editor.guides.bracketPairs" = "active";
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
      "terminal.integrated.customGlyphs" = true;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "nix.enableLanguageServer" = true;
    };
  };
}
