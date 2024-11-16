{
  pkgs,
  unstablePkgs,
  hostname,
  username,
  ...
}:
{

  imports = [
    ../nixos
    ../nixos/shell
    ../nixos/desktop/gnome.nix
    ../nixos/desktop/hyprland.nix
    # waydroid still needs to be enabled. By default it won't auto start
    ../nixos/android/emulators/waydroid.nix
    ../nixos/games

    ../shared/nix.nix
    ../shared/stylix
  ];

  # Easiest to use and most distros use this by default.
  networking.networkmanager.enable = true;
  networking.hostName = hostname;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager" # Allows the user to manage network settings without asking for the password
      "adbusers" # Add to the list of adb users. I don't really know what this does
    ];
  };
  users.defaultUserShell = unstablePkgs.zsh;

  # Allows my user to manage nix caches (aka, through devenv)
  nix.settings.trusted-users = [
    "root"
    username
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [
      gedit
      nushell
    ])
    ++ (with unstablePkgs; [
      zsh
      git
      firefox
      thunderbird
      telegram-desktop
      vscode
      vlc
    ]);

  fonts.packages = with unstablePkgs.nerd-fonts; [ fira-code ];

  programs.localsend = {
    enable = true;
    package = unstablePkgs.localsend;
    openFirewall = true;
  };

  programs.zsh.enable = true;

  programs.adb.enable = true;

  environment.shells = [ unstablePkgs.zsh ];

  # Allow unfree software (such as vscode)
  nixpkgs.config.allowUnfree = true;

  home-manager.backupFileExtension = "backup";

  services.flatpak.enable = true;

  services.flatpak = {
    update.auto.enable = true;

    packages = [
      {
        appId = "io.github.zen_browser.zen";
        origin = "flathub";
      }
      {
        appId = "com.bitwarden.desktop";
        origin = "flathub";
      }
    ];
  };
}
