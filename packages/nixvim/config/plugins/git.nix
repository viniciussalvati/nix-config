{ pkgs, ... }: {
  plugins.gitsigns = {
    enable = true;
  };

  plugins.fugitive = {
    enable = true;
  };

  plugins.gitblame.enable = true;

  extraPlugins = with pkgs.vimPlugins; [
    lazygit-nvim
  ];

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

  extraConfigLua = /* lua */ ''
    -- Disables gitblame by default. It can be toggled with GitBlameToggle
    vim.g.gitblame_enabled = 0;
  '';

}
