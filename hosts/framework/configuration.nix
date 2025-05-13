# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.home-manager
    ../../modules/default.nix
  ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;

      gfxmodeEfi = "2560x1600";
      font = "${pkgs.nerd-fonts.intone-mono}/share/fonts/truetype/NerdFonts/IntoneMono/IntoneMonoNerdFont-Regular.ttf";
      fontSize = 36;

      # Ensures that /boot doesn't fill up with old kernels
      configurationLimit = 50;
    };
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "framework"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.extraHosts = ''
    192.168.88.119 capernaum
    192.168.88.120 nazareth
    192.168.88.121 bethany
    192.168.88.122 jerusalem
  '';

  # Enable experimental features of nix
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Load AMD module for GPU
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Disable CPUS
  services.printing.browsed.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape"; # Swaps the Esc and Caps Lock keys
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    nicholas = {
      isNormalUser = true;
      description = "Nicholas Ryan Smith";
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };

  # Enable dconf at the system level
  programs.dconf.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  custom = {
    home = {
      chrome.enable = true;
      corectrl.enable = true;
      firefox.enable = true;
      home-manager.enable = true;
      neovim.enable = true;
      signal-desktop.enable = true;
      zed.enable = true;
    };

    alacritty.enable = true;
    bacon.enable = true;
    bat.enable = true;
    cargo.enable = true;
    cli-tools.enable = true;
    desktop-environment.enable = true;
    discord.enable = true;
    dprint.enable = true;
    fish.enable = true;
    fonts.enable = true;
    gimp.enable = true;
    git.enable = true;
    gnupg.enable = true;
    keepassxc.enable = true;
    language-servers.enable = true;
    libreoffice.enable = true;
    localization.enable = true;
    login.enable = true;
    obsidian.enable = true;
    photoqt.enable = true;
    printing.enable = true;
    qalculate-qt.enable = true;
    sound.enable = true;
    sound-engineering.enable = true;
    spotify.enable = true;
    starship.enable = true;
    steam.enable = true;
    taskwarrior.enable = true;
    thunderbird.enable = true;
    tuifeed.enable = true;
    vlc.enable = true;
    zellij.enable = true;
    zoom-us.enable = true;
  };
}
