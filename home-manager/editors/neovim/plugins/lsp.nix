{
  programs.nixvim.plugins = {
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
}