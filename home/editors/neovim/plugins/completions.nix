{
  programs.nixvim.plugins = {
    nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      snippet.expand = "luasnip";
      sources = [
        # [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        # ]
        # [
        { name = "path"; } # Autocompletes from path
        { name = "buffer"; } # Autocompletes from buffer
        # ]
      ];
      mappingPresets = [ "insert" ];
      mapping =
        {
          "<C-Space>" = { modes = [ "i" ]; action = "cmp.mapping.complete()"; };
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          # Tab actions based on https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
          "<Tab>" = {
            action = ''
              function(fallback)
                local luasnip = require('luasnip')
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end
            '';
            modes = [ "i" "s" ];
          };
          "<S-Tab>" = {
            action = ''
              function(fallback)
                local luasnip = require('luasnip')
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end
            '';
            modes = [ "i" "s" ];
          };
        };
    };
    # This plugin gets completions suggestions from the language server
    cmp-nvim-lsp.enable = true;

    # These two plugins (should) offer more autocomplete options
    # But they are required for the auto-complete to work anyway
    cmp_luasnip.enable = true;
    luasnip = {
      enable = true;
      fromVscode = [
        { }
        # {paths= ./path/to/file;}
      ];
      extraConfig = {
        enable_autosnippets = true;
      };
    };
  };
}
