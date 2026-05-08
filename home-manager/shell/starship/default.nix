{ pkgs, unstablePkgs, ... }:
{
  programs.starship = {
    enable = true;
    package = unstablePkgs.starship;
    settings = {
      format = "$username$hostname$localip$shlvl$singularity$kubernetes$nats$directory$vcsh$fossil_branch$fossil_metrics$git_branch$git_commit$git_state$git_metrics$git_status\${custom.git_spice}$hg_branch$hg_state$pijul_channel$docker_context$package$bun$c$cmake$cobol$cpp$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$fortran$gleam$golang$gradle$haskell$haxe$helm$java$julia$kotlin$lua$mojo$nim$nodejs$ocaml$odin$opa$perl$php$pulumi$purescript$python$quarto$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$typst$vlang$vagrant$xmake$zig$buf$guix_shell$nix_shell$conda$pixi$meson$spack$memory_usage$aws$gcloud$openstack$azure$direnv$env_var$mise$crystal$custom$sudo$cmd_duration$line_break$jobs$battery$time$status$container$netns$os$shell$character";
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

      custom.git_spice = {
        shell = [
          "${pkgs.nushell}/bin/nu"
          ./custom-git-spice.nu
        ];
        require_repo = true;
        when = "which gs";
        format = ''[\[$output\]]($style) '';
        style = "bold red";
      };
    };
  };
}
