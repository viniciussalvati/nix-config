{
  programs.nixvim.plugins = {
    lsp.servers.rnix-lsp = {
      enable = true;
      filetypes = [ "nix" ];
    };

    none-ls.sources = {
      code_actions.statix.enable = true;
      diagnostics.deadnix.enable = true;
      formatting.nixpkgs_fmt.enable = true;
    };
  };
}
