{ pkgs, user, ... }: {

  imports = [
    # Include the results of the hardware scan.
    # This is to be generated for every machine in the same path, and not commited to the repo
    ./hardware-configuration.nix
    ../modules/shell
  ];

  # Easiest to use and most distros use this by default.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager = {
      gnome = {
        enable = true;
      };

      #Disables xterm
      xterm.enable = false;
    };
  };

  # Removes some packages from gnome I don't want/need
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    epiphany # web browser
    geary # email reader (I'll use thunderbird or another client if I want it)
  ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
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

  programs.sway.enable = true;

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
