{
  plugins = {
    lsp.servers.tsserver.enable = true;
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
