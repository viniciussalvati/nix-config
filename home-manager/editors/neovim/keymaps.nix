{
  programs.nixvim.keymaps = [
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
  ];
}
