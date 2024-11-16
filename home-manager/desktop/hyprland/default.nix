{ pkgs, ... }:
{
  imports = [
    ./waybar
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = [
    pkgs.eww
    pkgs.socat
    pkgs.playerctl
    pkgs.brightnessctl
  ];

  programs.wofi.enable = true;
  stylix.targets.hyprland.enable = false;

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor = ",preferred,auto,auto";

    ## My programs

    # See https://wiki.hyprland.org/Configuring/Keywords/
    "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
    "$fileManager" = "nautilus";
    "$terminal" = "${pkgs.kitty}/bin/kitty";
    "$menu" = "${pkgs.wofi}/bin/wofi --show drun";

    exec-once = [
      "waybar"
    ];

    general = {
      gaps_out = 10;
    };

    animations = {
      enabled = true;

      # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    dwindle = {
      pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # You probably want this
      force_split = 2; # right or bottom
    };

    misc = {
      # disable_autoreload = true; # Disables config file monitoring, saving battery. Use `hyprctl reload` to reload the config
    };

    ## Inputs

    # https://wiki.hyprland.org/Configuring/Variables/#input
    input = {
      # kb_layout = "us";
      kb_layout = "br";
      kb_options = "grp:win_space_toggle";
      # kb_variant =
      # kb_model =
      # kb_options =
      # kb_rules =
      numlock_by_default = true;

      follow_mouse = 2;

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
        natural_scroll = true;
      };
    };

    decoration = {
      rounding = 5;
    };

    # https://wiki.hyprland.org/Configuring/Variables/#gestures
    gestures = {
      workspace_swipe = true;
    };

    ## Keybindings

    bind = [
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      "$mainMod, RETURN, exec, $terminal"
      "$mainMod, Q, killactive,"
      "$mainMod, M, exit,"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, V, togglefloating,"
      "$mainMod, R, exec, $menu"
      "$mainMod, P, pseudo, # dwindle"
      "$mainMod, J, togglesplit, # dwindle"
      "$mainMod, L, exec, hyprlock --immediate"

      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Example special workspace (scratchpad)
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
