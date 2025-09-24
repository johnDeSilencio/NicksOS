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

      # WASM tools
      binaryen

      # For audio visualization on the command-line
      cava

      # For instrumenting Chrome
      chromedriver
      cmake

      # Used for pretty diffs
      delta

      # Query and display system information like serial #
      dmidecode

      # For command-line DNS queries
      dogdns

      # For dealing with WebP file format
      libwebp

      # For writing down ideas in the terminal quickly
      eureka-ideas

      # A better GNU find
      fd
      ffmpeg
      framework-tool
      gcc

      # For instrumenting Firefox
      geckodriver

      gnumake
      gping
      htop

      # For benchmarking command evocations
      hyperfine

      # For image conversion capabilities
      imagemagickBig
      inotify-tools

      # For manipulating JSON text on the command-line
      jaq
      killall

      # For getting CPU temperature
      lm_sensors
      loco-cli

      # ;) (ls replacement)
      lsd
      lshw

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

      # Over-engineered terminal screensaver written in Rust
      pipes-rs

      # Analyzer power usage
      powertop

      # Supports running arbitrary hooks during commit lifecycle
      pre-commit
      procs
      qemu
      reveal-md

      # A better, faster grep
      ripgrep

      # BitTorrent client written in Rust
      rqbit

      # Record & replay debugger
      rr

      # A modern, faster version of nmap
      rustscan

      # Query and display data about SSD / hard drive health
      smartmontools
      sea-orm-cli
      tailwindcss

      # TL;DR tool for CLI commands
      tealdeer

      # Alternative to trash-cli written in Rust
      trashy
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

    # Direnv
    programs.direnv = {
      enable = true;
      silent = true;
    };

    # Fish
    programs.fish.enable = true;

    programs.fish.shellAliases = {
      rm = "trash put";
    };
  };
}
