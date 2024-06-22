{ pkgs, ... }:
{
  plugins = {
    # lsp.servers.nixd = {
    #   enable = true;
    #   filetypes = [ "nix" ];
    # };
    lsp.servers.nil-ls.enable = true;

    none-ls.sources = {
      code_actions.statix.enable = true;
      diagnostics.deadnix.enable = true;
      formatting.nixfmt.enable = true;
      formatting.nixfmt.package = pkgs.nixfmt-rfc-style;
    };
  };
}
