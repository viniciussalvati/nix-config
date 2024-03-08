{ helpers, ... }: {
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "git"; }
          { name = "path"; } # Autocompletes from path
          { name = "buffer"; keywordLength = 5; } # Autocompletes from buffer
        ];
        snippet.expand = /* lua */ ''
          function(args)
            require('luasnip').lsp_expand(args.body);
          end
        '';
        mapping = helpers.mkRaw /* lua */ ''
          cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<Escape>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
            ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
          })
        '';
      };

      cmdline = {
        "/" = {
          mapping = helpers.mkRaw /* lua */ "cmp.mapping.preset.cmdline()";
          sources = [{ name = "buffer"; }];
        };
        ":" = {
          mapping = helpers.mkRaw /* lua */ "cmp.mapping.preset.cmdline()";
          sources = [{ name = "path"; }
            {
              name = "cmdline";
              option = {
                ignore_cmds = [ "Man" "!" "terminal" "te" "term" ];
              };
            }];
        };
      };
    };
    # This plugin gets completions suggestions from the language server
    cmp-nvim-lsp.enable = true;
    # Enables github and gitlab autocomplete
    cmp-git.enable = true;

    cmp-cmdline.enable = true;

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
