{
  keymaps = [
    {
      mode = "n";
      key = "<leader>f";
      lua = true;
      action = "vim.lsp.buf.format";
      options.desc = "[F]ormat code";
    }
    {
      mode = [ "n" "i" ];
      key = "<C-f>";
      lua = true;
      action = "vim.lsp.buf.format";
      options.desc = "[F]ormat code";
    }
    # Shortcuts for spliting the screen
    {
      mode = "n";
      key = "<leader>st";
      action = "<cmd>leftabove split<CR>";
      options.desc = "Split Top";
    }
    {
      mode = "n";
      key = "<leader>sr";
      action = "<cmd>rightbelow vsplit<CR>";
      options.desc = "Split Right";
    }
    {
      mode = "n";
      key = "<leader>sl";
      action = "<cmd>leftabove vsplit<CR>";
      options.desc = "Split Left";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action = "<cmd>rightbelow split<CR>";
      options.desc = "Split Down";
    }
    {
      mode = "n";
      key = "<leader>ss";
      action = "<cmd>rightbelow split<CR>";
      options.desc = "Split Down";
    }
    # Window resizing mappings
    {
      mode = "n";
      key = "<M-,>";
      lua = true;
      action = /* lua */ ''
        function()
          local current_window = vim.api.nvim_get_current_win()
          local current_size = vim.api.nvim_win_get_width(current_window)
          vim.api.nvim_win_set_width(current_window, current_size - 1)
        end
      '';
      options.desc = "Decrease width of current window";
    }
    {
      mode = "n";
      key = "<M-.>";
      lua = true;
      action = /* lua */ ''
        function()
          local current_window = vim.api.nvim_get_current_win()
          local current_size = vim.api.nvim_win_get_width(current_window)
          vim.api.nvim_win_set_width(current_window, current_size + 1)
        end
      '';
      options.desc = "Increase width of current window";
    }
    {
      mode = "n";
      key = "<M-->";
      lua = true;
      action = /* lua */ ''
        function()
          local current_window = vim.api.nvim_get_current_win()
          local current_size = vim.api.nvim_win_get_height(current_window)
          vim.api.nvim_win_set_height(current_window, current_size - 1)
        end
      '';
      options.desc = "Decrease height of current window";
    }
    {
      mode = "n";
      key = "<M-=>";
      lua = true;
      action = /* lua */ ''
        function()
          local current_window = vim.api.nvim_get_current_win()
          local current_size = vim.api.nvim_win_get_height(current_window)
          vim.api.nvim_win_set_height(current_window, current_size + 1)
        end
      '';
      options.nowait = true;
      options.desc = "Increase height of current window";
    }

  ];
}
