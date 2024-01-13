{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.telescope.enable = true;

    extraPlugins = [
      pkgs.vimPlugins.telescope-ui-select-nvim
    ];

    extraConfigLua = ''
      require("telescope").load_extension("ui-select");
    '';

    keymaps = [
      {
        mode = "n";
        key = "<C-p>";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "[F]ind [F]iles";
      }
      {
        mode = "n";
        key = "fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "[F]ind [B]uffers";
      }
      {
        mode = "n";
        key = "fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "[F]ind by [G]rep";
      }
      {
        mode = "n";
        key = "fw";
        action = "<cmd>Telescope grep_string<CR>";
        options.desc = "[F]ind current [S]tring";
      }
      {
        mode = "n";
        key = "fd";
        action = "<cmd>Telescope diagnostics<CR>";
        options.desc = "[F]ind [D]iagnostics";
      }
    ];
  };
}
