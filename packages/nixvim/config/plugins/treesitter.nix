{
  plugins.treesitter = {
    enable = true;
    indent = true;
    nixGrammars = true; # Because of this, we won't need ensureInstalled, since all the packages we may need comes from nixpkgs
    settings.incremental_selection = {
      enable = true;
      keymaps = {
        init_selection = "<C-space>";
        node_incremental = "<C-space>";
        scope_incremental = "<C-s>";
        node_decremental = "<C-backspace>";
      };
    };
  };
}
