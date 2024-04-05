{
  config = {
    opts = {
      number = true;
      relativenumber = true;

      ic = true;
      hls = true;
      is = true;

      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;

      spelllang = "en_gb";
      spell = true;
    };

    extraConfigLua = /* lua */ ''
      vim.opt.listchars:append({ multispace = "•", leadmultispace = "•", trail = "•", tab = "→ " })
      vim.opt.list = true;
    '';
  };
}
