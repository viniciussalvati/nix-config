{
  programs.nixvim = {
    plugins = {
      lsp.servers.rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };

      none-ls.sources = {
        formatting.rustfmt.enable = true;
      };
    };

    # extraPlugins = with pkgs.vimPlugins; [
    #   rustaceanvim
    # ];

    # extraConfigLua = /* lua */ ''
    #   vim.g.rustaceanvim = function()
    #       local adapter_path = '${pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter}/'
    #       local codelldb_path = adapter_path .. 'bin/codelldb'
    #       local liblldb_path = adapter_path .. 'lib/libcodelldb' .. (jit.os == 'Linux' and '.so' or '.dylib')

    #       local cfg = require('rustaceanvim.config')
    #       return {
    #         dap = {
    #           adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    #         },
    #       }
    #     end
    # '';
  };
}
