{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps.lspBuf = {
          K = "hover";
          gr = "references";
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

    # Formats the code automatically before writing the file
    autoCmd = [
      {
        event = "BufWritePre";
        callback = { __raw = /* lua */ "function() vim.lsp.buf.format() end"; };
      }
    ];
  };
}
