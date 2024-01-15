# Configures debugging
{
  programs.nixvim = {
    plugins.dap = {
      enable = true;

      adapters.executables.gdb = {
        command = "gdb";
        args = [ "-i" "dap" ];
      };

      extensions.dap-ui = {
        enable = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>dt";
        lua = true;
        action = /* lua */ "require('dap').toggle_breakpoint";
        options.desc = "Toggle Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dc";
        lua = true;
        action = /* lua */ "require('dap').continue";
        options.desc = "Debug Continue";
      }
    ];
  };
}
