# Better status line
{
  plugins.lualine = rec {
    enable = true;

    sections.lualine_c = [
      {
        name = "filename";
        extraConfig = {
          newfile_status = true;
          path = 1;
        };
      }
    ];
    inactiveSections.lualine_c = sections.lualine_c;
  };
}
