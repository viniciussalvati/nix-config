{
  plugins.yanky.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>p";
      action = "<CMD>YankyRingHistory<CR>";
      options.desc = "Open yank history";
    }
  ];
}
