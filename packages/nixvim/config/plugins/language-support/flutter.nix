{ pkgs, ... }:
{
  extraConfigLua = # lua
    ''
      require("flutter-tools").setup({
        debugger = {
          enabled = true,
          run_via_dap = true,
        }
      })
    '';

  extraPlugins = with pkgs.vimPlugins; [
    dart-vim-plugin
    flutter-tools-nvim
  ];
}
