{ pkgs, ... }:
{
  programs.nixvim = {
    extraConfigLua = /* lua */ ''
      require("flutter-tools").setup({})
    '';

    extraPlugins = with pkgs.vimPlugins; [
      dart-vim-plugin
      flutter-tools-nvim
    ];
  };
}
