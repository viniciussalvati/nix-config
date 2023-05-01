{ pkgs, user, ... }: {

  imports = [
    ../modules/shell
    ../modules/desktop/gnome.nix
  ];

  # Easiest to use and most distros use this by default.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager" # Allows the user to manage network settings without asking for the password
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    zsh
    git
    firefox
    gnome.gedit
    rnix-lsp
    bitwarden
    telegram-desktop
    nix-index # tool to index and find references in the nix store. Use nix-locate
  ];

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };

  # programs.sway.enable = true;

  programs.zsh.enable = true;

  environment.shells = [ pkgs.zsh ];

  # Allow unfree software (such as vscode)
  nixpkgs.config.allowUnfree = true;
  nix = {
    # Allows me to use nix flakes
    extraOptions = "experimental-features = nix-command flakes";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
