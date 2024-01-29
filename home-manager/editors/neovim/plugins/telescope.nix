{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      defaults = {
        cache_picker = { num_pickers = 5; };

        mappings = {
          # Mappings will probably be lua functions, so better use __raw anyway
          __raw = /* lua */ ''
            {
              i = {
                ["<Down>"] = require('telescope.actions').cycle_history_next,
                ["<Up>"] = require('telescope.actions').cycle_history_prev,
              }
            }
          '';
        };
      };
    };

    extraPlugins = [
      pkgs.vimPlugins.telescope-ui-select-nvim
    ];

    extraConfigLua = /* lua */ ''
      require("telescope").load_extension("ui-select");
    '';

    keymaps = [
      {
        # Same shortcut as vscode
        mode = "n";
        key = "<C-p>";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "ff";
        action = "<cmd>Telescope git_files<CR>";
        options.desc = "Find git Files";
      }
      {
        mode = "n";
        key = "FF";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Find Buffers";
      }
      {
        mode = "n";
        key = "fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Find by Grep";
      }
      {
        mode = "n";
        key = "fw";
        action = "<cmd>Telescope grep_string<CR>";
        options.desc = "Find current String";
      }
      {
        mode = "n";
        key = "fd";
        action = "<cmd>Telescope diagnostics<CR>";
        options.desc = "Find Diagnostics";
      }
    ];
  };
}
