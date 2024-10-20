# Better status line
{
  plugins.lualine = {
    enable = true;

    settings = rec {
      sections.lualine_c = [
        "filename"
        {
          newfile_status = true;
          path = 1;
        }
      ];

      inactiveSections.lualine_c = sections.lualine_c;
    };
  };
}
