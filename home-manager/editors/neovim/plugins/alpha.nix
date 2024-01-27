{ pkgs, ... }:
# Configures a default start screen
# The nixvim configuration options for the plugin wasn't used because I wanted to use alpha's startify theme.
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      alpha-nvim
      nvim-web-devicons
    ];

    extraConfigLua = /* lua */ ''
      require("alpha").setup(require("alpha.themes.startify").config)
    '';
  };
}
