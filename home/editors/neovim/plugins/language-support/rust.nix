{
  programs.nixvim.plugins = {
    lsp.servers.rust-analyzer = {
      enable = true;
      installCargo = true;
      installRustc = true;
    };

    none-ls.sources = {
      formatting.rustfmt.enable = true;
    };
  };
}
