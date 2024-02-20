{
  plugins.gitsigns = {
    enable = true;
  };

  plugins.fugitive = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gp";
      action = "<cmd>Gitsigns preview_hunk<CR>";
      options.desc = "Gitsigs Preview hunk";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
      options.desc = "Gitsigs toggle line Blame";
    }
  ];
}
