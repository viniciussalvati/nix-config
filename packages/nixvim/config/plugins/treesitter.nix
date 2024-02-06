{
  plugins.treesitter = {
    enable = true;
    indent = true;
    nixGrammars = true; # Because of this, we won't need ensureInstalled, since all the packages we may need comes from nixpkgs
    incrementalSelection = {
      enable = true;
      keymaps = {
        initSelection = "<C-space>";
        nodeIncremental = "<C-space>";
        scopeIncremental = "<C-s>";
        nodeDecremental = "<C-backspace>";
      };
    };
  };
}
