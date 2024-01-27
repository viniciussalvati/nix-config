# File browser
{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;

      # Close neo-tree when a file is opened
      eventHandlers.file_opened = /* lua */ ''
        function(file_path)
          require('neo-tree').close_all()
        end
      '';
    };

    keymaps = [
      {
        mode = "n";
        key = "<C-b>";
        action = "<cmd>:Neotree last focus left reveal<CR>";
      }
    ];
  };
}
