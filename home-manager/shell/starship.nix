{ unstablePkgs, ... }:
{
  programs.starship = {
    enable = true;
    package = unstablePkgs.starship;
    settings = {
      battery.display = [
        {
          threshold = 30;
          style = "bold red";
        }
      ];

      directory = {
        truncate_to_repo = false;
        truncation_length = 500;

        # for wsl
        substitutions = {
          "/mnt/c" = " c:";
          "/mnt/d" = " d:";
        };
      };

      docker_context = {
        symbol = " ";
      };

      status = {
        disabled = false;
        symbol = "";
        map_symbol = true;
        style = "bg:red";
      };
    };
  };
}
