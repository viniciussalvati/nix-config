{
  pkgs,
  unstablePkgs,
  hostname,
  username,
  ...
}:
{

  imports = [
    ../nixos/shell
    ../nixos/desktop/gnome.nix
    # waydroid still needs to be enabled. By default it won't auto start
    ../nixos/android/emulators/waydroid.nix
    ../nixos/games/steam.nix

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [ gedit ])
    ++ (with unstablePkgs; [
      zsh
      git
      firefox
      thunderbird
      bitwarden
      telegram-desktop
      localsend
      vscode
    ]);

  fonts.packages = with unstablePkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];

  # programs.sway.enable = true;

  programs.zsh.enable = true;

  programs.adb.enable = true;

  environment.shells = [ unstablePkgs.zsh ];

  # Allow unfree software (such as vscode)
  nixpkgs.config.allowUnfree = true;
}
