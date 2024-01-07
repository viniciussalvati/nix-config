# Enables linters and formatters
{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    sources = {
      # nix
      formatting.nixpkgs_fmt.enable = true;

      # rust
      formatting.rustfmt.enable = true;

      # typescript/javascript
      code_actions.eslint_d.enable = true;
      formatting.prettier.enable = true;
      diagnostics.eslint_d.enable = true;
    };
  };
}
