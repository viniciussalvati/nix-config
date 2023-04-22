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

      # nix settings
      "nix.enableLanguageServer" = true;
    };

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace ([
      #{
      #  name= "nix-extension-pack";
      #  publisher = "pinage404";
      #  version = "3.0.0";
      #  sha256 = "sha256-cWXd6AlyxBroZF+cXZzzWZbYPDuOqwCZIK67cEP5sNk=";
      #}
      {
        name = "nix-env-selector";
        publisher = "arrterian";
        version = "latest";
        # version = "1.0.0";
        sha256 = "sha256-FRjLh/8/qRUZB7MIY+jFb/pItNbhi49lH66ULXuTGRk=";
      }
      {
        name = "nix-ide";
        publisher = "jnoortheen";
        version = "latest";
        # version = "0.0.2";
        sha256 = "sha256-yC4ybThMFA2ncGhp8BYD7IrwYiDU3226hewsRvJYKy4=";
      }
      {
        name = "direnv";
        publisher = "mkhl";
        version = "latest";
        # version = "0.12.0";
        sha256 = "sha256-UMGTWAiPAxSjy5ALUkijD0GE9TW37TZ3UvMmgFBNYsU=";
      }
    ] ++ [
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "latest";
        # version = "13.5.0";
        sha256 = "sha256-CYI62sWPlJNRP2KIkg4vQutIMC6gaCxtTVoOWZIS8Lw=";
      }
    ]);
  };
}
