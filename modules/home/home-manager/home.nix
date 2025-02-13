{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

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

    ".config/tuifeed" = {
      source = ../../../home/.config/tuifeed;
      recursive = true;
    };

    ".config/zed" = {
      source = ../../../home/.config/zed;
      recursive = true;
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
