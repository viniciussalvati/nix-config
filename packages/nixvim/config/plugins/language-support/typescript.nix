{
  plugins = {
    lsp.servers.ts_ls.enable = true;
    lsp.servers.eslint = {
      enable = true;
    };

    none-ls.sources = {
      formatting.prettier = {
        enable = true;
        disableTsServerFormatter = true;
      };
    };
  };
}
