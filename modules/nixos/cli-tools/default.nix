{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.cli-tools.enable = lib.mkEnableOption "Grab bag of useful command-line tools";
  };

  config = lib.mkIf config.custom.cli-tools.enable {
    environment.systemPackages = with pkgs; [
      android-tools

      # Polyglot tool for code searching, linting, and rewriting
      ast-grep

      # Shell history tool
      atuin

      # cat clone that supports colors and paging
      bat

      # Background Rust code checker
      bacon
      cmake

      # Used for pretty diffs
      delta

      # Query and display system information like serial #
      dmidecode

      # For command-line DNS queries
      dogdns

      # For writing down ideas in the terminal quickly
      eureka-ideas

      # A better GNU find
      fd
      ffmpeg
      gcc
      gnumake
      gping
      htop
      killall

      # For getting CPU temperature
      lm_sensors
      loco-cli

      # ;) (ls replacement)
      lsd

      # Markdown linker
      lychee

      markuplinkchecker
      miniserve

      # Displaying OS / system information
      neofetch
      nix-prefetch-github
      nmap

      # Compression / decompression tool
      ouch

      # JavaScript linter written in Rust
      oxlint
      pass

      # Analyzer power usage
      powertop

      # Supports running arbitrary hooks during commit lifecycle
      pre-commit
      procs
      qemu
      reveal-md

      # A better, faster grep
      ripgrep

      # Query and display data about SSD / hard drive health
      smartmontools
      sea-orm-cli

      # Colorful & configurable terminal prompt
      starship
      tailwindcss

      # An engine for writing and checking of to-dos
      taskwarrior3
      taskwarrior-tui

      # TL;DR tool for CLI commands
      tealdeer

      # Alternative to trash-cli written in Rust
      trashy

      # Manage and read RSS feeds in the terminal
      tuifeed
      usbutils

      # Rust rewrite
      uutils-coreutils-noprefix

      # Execute arbitrary commands when a file changes
      watchexec
      wasm-pack
      wf-recorder
      wget

      # wl-copy and wl-paste
      wl-clipboard-rs

      # Terminal multiplexer
      zellij
    ];

    # Fish
    programs.fish.enable = true;

    programs.fish.shellAliases = {
      rm = "trash put";
    };
  };
}
