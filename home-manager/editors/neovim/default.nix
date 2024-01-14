{ pkgs, ... }:
{
  imports = [
    ./keymaps.nix
    ./colorscheme.nix
    ./options.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/lualine.nix
    ./plugins/lsp.nix
    ./plugins/language-support/nix.nix
    ./plugins/language-support/rust.nix
    ./plugins/language-support/typescript.nix
    ./plugins/language-support/flutter.nix
    ./plugins/completions.nix
    ./plugins/neo-tree.nix
    ./plugins/alpha.nix
  ];

  # See all options in https://nix-community.github.io/nixvim
  # or use `man nixvim`
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    editorconfig.enable = true;

    clipboard = {
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    plugins = {
      nix.enable = true;

      # Adds git symbols for status and helpers such as line blame and other tools
      gitsigns.enable = true;

      # Adds indent guides
      indent-blankline.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      lazygit-nvim
    ];

    autoCmd = [
      {
        event = "BufWritePre";
        callback = { __raw = "function() vim.lsp.buf.format() end"; };
      }
    ];
  };
}
