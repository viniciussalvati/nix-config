{
  programs.nixvim = {
    options = {
      number = true;
      relativenumber = true;

      ic = true;
      hls = true;
      is = true;

      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
    };

    extraConfigLua = /* lua */ ''
      vim.opt.listchars:append({ multispace = ".", trail = "." })
      vim.opt.list = true;
    '';
  };
}
