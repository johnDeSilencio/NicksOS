{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nicholas";
  home.homeDirectory = "/home/nicholas";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

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
    ".config/alacritty/" = {
      source = ./home/.config/alacritty;
      recursive = true;
    };

    ".config/bacon/" = {
      source = ./home/.config/bacon;
      recursive = true;
    };

    ".config/rofi/" = {
      source = ./home/.config/rofi;
      recursive = true;
    };

    ".config/hypr/" = {
      source = ./home/.config/hypr;
      recursive = true;
    };

    ".config/bat/" = {
      source = ./home/.config/bat;
      recursive = true;
    };

    ".config/fish/" = {
      source = ./home/.config/fish;
      recursive = true;
    };

    ".config/helix" = {
      source = ./home/.config/helix;
      recursive = true;
    };

    ".config/mako" = {
      source = ./home/.config/mako;
      recursive = true;
    };

    ".config/tuifeed" = {
      source = ./home/.config/tuifeed;
      recursive = true;
    };

    ".config/waybar" = {
      source = ./home/.config/waybar;
      recursive = true;
    };

    ".config/zellij" = {
      source = ./home/.config/zellij;
      recursive = true;
    };

    ".config/wlogout" = {
      source = ./home/.config/wlogout;
      recursive = true;
    };

    ".config/zed" = {
      source = ./home/.config/zed;
      recursive = true;
    };

    ".config/starship.toml" = {
      source = ./home/.config/starship.toml;
    };

    ".dprint.json" = {
      source = ./home/.dprint.json;
    };

    ".gitconfig" = {
      source = ./home/.gitconfig;
    };

    ".taskrc" = {
      source = ./home/.taskrc;
    };
  };

  # Enable fish
  programs.fish = {
    enable = true;
  };

  # Configure git
  programs.git = {
    enable = true;
    userName = "Nicholas R. Smith";
    userEmail = "nicholasrsmith1600@gmail.com";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "openpgp";
      user.signingkey = "2A603AA9D0619A75";
      credential = {
        helper = "manager";
        credentialStore = "gpg";
      };
    };
  };

  # Configure firefox
  programs.firefox = {
    enable = true;

    profiles = {
      nick = {
        id = 0;
        name = "nick";
        search = {
          force = true;
          default = "DuckDuckGo";
        };
      };
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;

      ExtensionSettings = {
        # Blocks all extensions except the ones below
        "*".installation_mode = "blocked";

        "{04188724-64d3-497b-a4fd-7caffe6eab29}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/rust-search-extension/latest.xpi";
          installation_mode = "force_installed";
        };

        "{d08be0ef-4964-48c9-b6a8-6918e05c6f89}" = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/delaywebpage/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      Preferences = {
        "browser.newtabpage.activity-stream.feeds.section.topstories" = {
          Value = false;
          Status = "locked";
        };

        "browser.newtabpage.activity-stream.feeds.snippets" = {
          Value = false;
          Status = "locked";
        };

        "browser.newtabpage.activity-stream.section.highlights.includePocket" = {
          Value = false;
          Status = "locked";
        };

        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = {
          Value = false;
          Status = "locked";
        };

        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = {
          Value = false;
          Status = "locked";
        };

        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = {
          Value = false;
          Status = "locked";
        };

        "browser.newtabpage.activity-stream.showSponsored" = {
          Value = false;
          Status = "locked";
        };

        "browser.newtabpage.activity-stream.system.showSponsored" = {
          Value = false;
          Status = "locked";
        };

        "browser.newtabpage.activity-stream.showSponsoredTopSites" = {
          Value = false;
          Status = "locked";
        };
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
