{
  styles = builtins.readFile ./workspaces.css;
  settings = {
    "hyprland/workspaces" = {
      all-outputs = true;
      disable-scroll = true;
      format = "<sub>{name}</sub> {windows}";
      format-window-separator = " ";
      window-rewrite-default = "";
      window-rewrite = {
        "title<.*youtube.*>" = ""; # Windows whose titles contain "youtube"
        "class<firefox>" = ""; # Windows whose classes are "firefox"
        "class<firefox> title<.*github.*>" = ""; # Windows whose class is "firefox" and title contains "github". Note that "class" always comes first.
        "class<zen-alpha>" = ""; # Windows whose classes are "zen"
        "class<zen-alpha> title<.*github.*>" = ""; # Windows whose class is "zen" and title contains "github". Note that "class" always comes first.
        "class<Code>" = "󰨞";
        "class<kitty>" = "";
        "class<Bitwarden>" = "";
        "class<org.gnome.Nautilus>" = "󰪶";
        "class<org.telegram.desktop>" = "";
      };
    };
  };
}
