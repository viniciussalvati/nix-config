{ pkgs, ... }:
{
  programs.nixvim = {
    extraConfigLua = ''
      require("flutter-tools").setup({})
    '';

    extraPlugins = with pkgs.vimPlugins; [
      dart-vim-plugin
      flutter-tools-nvim
    ];
  };
}
