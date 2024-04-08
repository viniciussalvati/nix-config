{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;
    extensions.ui-select.enable = true;

    settings.defaults = {
      cache_picker = { num_pickers = 5; };

      mappings = {
        i = {
          "<M-Down>" = "cycle_history_next";
          "<M-Up>" = "cycle_history_prev";
          "<M-d>" = "delete_buffer";
        };
      };
    };

    enabledExtensions = [ "noice" ];
  };

  extraPlugins = [
    pkgs.vimPlugins.telescope-ui-select-nvim
  ];

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
}
