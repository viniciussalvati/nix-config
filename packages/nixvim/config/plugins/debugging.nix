# Configures debugging
{
  # See https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation for adapters for specific languages
  plugins.dap = {
    enable = true;

    extensions.dap-ui = {
      enable = true;
    };
  };

  # Opens/closes dapui interface when we start/end the debugging session
  extraConfigLua = /* lua */
    ''
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    '';

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
}
