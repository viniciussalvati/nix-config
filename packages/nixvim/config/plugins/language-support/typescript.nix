{
  plugins = {
    lsp.servers.tsserver.enable = true;

    none-ls.sources = {
      code_actions.eslint_d.enable = true;
      formatting.eslint_d.enable = true;
      formatting.prettier = {
        enable = true;
        disableTsServerFormatter = true;
      };
      diagnostics.eslint_d.enable = true;
    };
  };
}
