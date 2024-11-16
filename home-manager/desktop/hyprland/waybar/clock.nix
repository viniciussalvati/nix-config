{
  settings = {
    clock = {
      tooltip-format = "<tt>São Paulo {tz_list}</tt>\n<tt><small>{calendar}</small></tt>";
      timezones = [
        "Europe/Lisbon"
        "America/Sao_Paulo"
      ];

      calendar = {
        mode = "month";
        format = {
          months = "<span color='#ffead3'><b>{}</b></span>";
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          weeks = "<span color='#99ffdd'><b>W{}</b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
    };
  };
}
