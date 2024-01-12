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
  ];
}
