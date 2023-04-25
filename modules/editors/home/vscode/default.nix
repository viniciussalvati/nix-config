{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    userSettings = {
      # common settings
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
      "extensions.autoUpdate" = false; # Not update extensions (updates will still be checked)

      # nix settings
      "nix.enableLanguageServer" = true;
    };

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./extensions.nix).extensions;
  };
}
