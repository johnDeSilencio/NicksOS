# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "framework"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable experimental features of nix
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu " ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape"; # Swaps the Esc and Caps Lock keys
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nicholas = {
    isNormalUser = true;
    description = "Nicholas Ryan Smith";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Steam
  programs.steam.enable = true;

  # Fish
  programs.fish.enable = true;

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "nicholas" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow Minecraft to install
  nixpkgs.config.allowBroken = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    pkgs.wget
    pkgs.wezterm
    pkgs.git
    pkgs.git-credential-oauth
    pkgs.discord
    pkgs.minecraft
    pkgs.gnome3.gnome-tweaks
    pkgs.rustup
    pkgs.cargo
    pkgs.rustc
    pkgs.nodePackages.cspell
    pkgs.starship
    pkgs.android-tools
    pkgs.lua-language-server
    pkgs.yaml-language-server
    pkgs.nodePackages.typescript-language-server
    pkgs.markdown-oxide
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.taplo
    pkgs.nodePackages.bash-language-server
    pkgs.gopls
    pkgs.golangci-lint-langserver
    pkgs.zellij
    pkgs.nil
    pkgs.dockerfile-language-server-nodejs
    pkgs.lldb_16
    pkgs.nodePackages.vscode-html-languageserver-bin
    pkgs.nodePackages.vscode-css-languageserver-bin
    pkgs.buf-language-server
    pkgs.cargo-binstall
    pkgs.nixfmt-rfc-style
    pkgs.cargo-machete
    pkgs.cargo-edit
    pkgs.cargo-udeps
    pkgs.cargo-expand
    pkgs.cargo-tarpaulin
    pkgs.cargo-audit
    pkgs.cargo-deny
    pkgs.cargo-update
    pkgs.cargo-watch
    pkgs.cargo-nextest
    pkgs.cargo-flamegraph
    pkgs.cargo-crev
    pkgs.cargo-limit
    pkgs.cargo-sort
    pkgs.cargo-auditable
    pkgs.cargo-msrv
    pkgs.eureka-ideas
    pkgs.fd
    pkgs.ripgrep
    pkgs.bat
    pkgs.atuin
    pkgs.uutils-coreutils-noprefix
    pkgs.procs
    pkgs.tealdeer
    pkgs.lsd
  ];

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
}
