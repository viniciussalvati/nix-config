{
  programs.nixvim.plugins = {
    lsp.servers.tsserver.enable = true;

    none-ls.sources = {
      code_actions.eslint_d.enable = true;
      formatting.prettier.enable = true;
      diagnostics.eslint_d.enable = true;
    };
  };
}
