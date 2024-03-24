{ ... }: {
  imports = [
    ./keymaps.nix
    ./colorscheme.nix
    ./options.nix
    ./userCommands.nix
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
    ./plugins/debugging.nix
    ./plugins/noice.nix
    ./plugins/git.nix
    ./plugins/yanky.nix
  ];

  # See all options in https://nix-community.github.io/nixvim
  # or use `man nixvim`
  luaLoader.enable = true;
  viAlias = true;
  vimAlias = true;
  editorconfig.enable = true;
  globals.mapleader = " ";

  clipboard = {
    register = "unnamedplus";

    # This doesn't seem required if wl-clipboard is installed in the system
    # providers.wl-copy.enable = true;
  };

  plugins = {
    nix.enable = true;

    # Adds indent guides
    indent-blankline.enable = true;

    # Adds a markdown previewer
    markdown-preview.enable = true;
  };
}
