{ config, unstablePkgs, ... }:
let
  cleanType = if config.home-manager.type == "nixos" then "all" else "user";
  nixCheats = unstablePkgs.writeTextDir "nix.cheat" ''
    % nix

    # Collect garbage
    nh clean ${cleanType} --keep 3 --keep-since 15d --ask
  '';
  naviNushellConfig = unstablePkgs.runCommand "navi-nushell-config.nu" { } ''
    ${unstablePkgs.navi}/bin/navi widget nushell >> "$out"
  '';
in
{
  programs.navi = {
    enable = true;
    package = unstablePkgs.navi;
    settings.cheats.paths = [
      ./cheats
      nixCheats
    ];
  };

  # Sources navi widget and adds a custom shortcut to its widget
  programs.nushell.extraConfig = ''
    source ${naviNushellConfig}
    let navi_custom_keybinding = {
      name: "navi",
      modifier: control,
      keycode: char_n,
      mode: [emacs, vi_normal, vi_insert],
      event: {
          send: executehostcommand,
          cmd: navi_widget,
      }
    }
    $env.config.keybindings = ($env.config.keybindings | append $navi_custom_keybinding)
  '';
}
