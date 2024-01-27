{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps.lspBuf = {
          K = "hover";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
          "<leader>." = "code_action";
          "<leader>r" = "rename";
        };

        servers = {
          tsserver.enable = true;
        };
      };
      fidget.enable = true; # Indicator for LSP
      # lsp-lines.enable = true; # Makes the diagnostics messages appear as virtual lines

      none-ls.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "gr";
        action = "<cmd>Telescope lsp_references<CR>";
        options.desc = "Go to References";
      }
    ];

    # Formats the code automatically before writing the file
    autoCmd = [
      {
        event = "BufWritePre";
        callback = { __raw = /* lua */ "function() vim.lsp.buf.format() end"; };
      }
    ];
  };
}
