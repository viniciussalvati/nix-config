{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.settings.libreoffice = {
    enable = lib.mkOption {
      description = "If LibreOffice should be installed";
      type = lib.types.bool;
      default = false;
    };

    spellcheckLanguages = lib.mkOption {
      description = "List of languaes to spellcheck";
      type = lib.types.listOf lib.types.str;
      default = [
        "pt-br"
        "pt-pt"
        "en-gb-large"
      ];
    };
  };

  config = lib.mkIf (config.settings.libreoffice.enable) {
    settings.packages =
      with pkgs;
      [
        libreoffice
        hunspell
      ]
      ++ builtins.map (lang: pkgs.hunspellDicts.${lang}) config.settings.libreoffice.spellcheckLanguages;
  };
}
