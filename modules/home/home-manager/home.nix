{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Enable fonts
  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "IntelOneMono" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/bacon/" = {
      source = ../../../home/.config/bacon;
      recursive = true;
    };

    ".config/rofi/" = {
      source = ../../../home/.config/rofi;
      recursive = true;
    };

    ".config/hypr/" = {
      source = ../../../home/.config/hypr;
      recursive = true;
    };

    ".config/bat/" = {
      source = ../../../home/.config/bat;
      recursive = true;
    };

    ".config/fish/" = {
      source = ../../../home/.config/fish;
      recursive = true;
    };

    ".config/helix" = {
      source = ../../../home/.config/helix;
      recursive = true;
    };

    ".config/mako" = {
      source = ../../../home/.config/mako;
      recursive = true;
    };

    ".config/tuifeed" = {
      source = ../../../home/.config/tuifeed;
      recursive = true;
    };

    ".config/waybar" = {
      source = ../../../home/.config/waybar;
      recursive = true;
    };

    ".config/zellij" = {
      source = ../../../home/.config/zellij;
      recursive = true;
    };

    ".config/wlogout" = {
      source = ../../../home/.config/wlogout;
      recursive = true;
    };

    ".config/zed" = {
      source = ../../../home/.config/zed;
      recursive = true;
    };

    ".config/starship.toml" = {
      source = ../../../home/.config/starship.toml;
    };

    ".dprint.json" = {
      source = ../../../home/.dprint.json;
    };

    ".taskrc" = {
      source = ../../../home/.taskrc;
    };
  };

  # Enable fish
  programs.fish = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
}
