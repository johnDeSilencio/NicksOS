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

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.spotify
    pkgs.signal-desktop
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

  # Configure NeoVim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = "${builtins.readFile ./home/.config/nvim/options.lua}";

    extraPackages = with pkgs; [
      lua-language-server
      nil
    ];

    plugins = with pkgs.vimPlugins; [
      cmp_luasnip
      cmp-nvim-lsp
      formatter-nvim
      friendly-snippets
      luasnip
      miasma-nvim
      neodev-nvim
      nvim-bacon
      nvim-cmp
      nvim-web-devicons
      telescope-fzf-native-nvim
      vim-sleuth
      vim-visual-multi

      {
        plugin = comment-nvim;
        config = ''require("Comment").setup()'';
        type = "lua";
      }

      {
        plugin = formatter-nvim;
        config = "${builtins.readFile ./home/.config/nvim/plugin/fmt.lua}";
        type = "lua";
      }

      {
        plugin = gitsigns-nvim;
        config = ''require("gitsigns").setup()'';
        type = "lua";
      }

      {
        plugin = lualine-nvim;
        config = ''require("lualine").setup({ icons_enabled = true })'';
        type = "lua";
      }

      {
        plugin = nvim-cmp;
        config = "${builtins.readFile ./home/.config/nvim/plugin/cmp.lua}";
        type = "lua";
      }

      {
        plugin = nvim-lspconfig;
        config = "${builtins.readFile ./home/.config/nvim/plugin/lsp.lua}";
        type = "lua";
      }

      {
        plugin = startup-nvim;
        config = "${builtins.readFile ./home/.config/nvim/plugin/startup.lua}";
        type = "lua";
      }

      {
        plugin = telescope-nvim;
        config = "${builtins.readFile ./home/.config/nvim/plugin/telescope.lua}";
        type = "lua";
      }

      {
        plugin = (
          nvim-treesitter.withPlugins (p: [
            p.tree-sitter-asm
            p.tree-sitter-bash
            p.tree-sitter-c
            p.tree-sitter-cpp
            p.tree-sitter-csv
            p.tree-sitter-diff
            p.tree-sitter-dockerfile
            p.tree-sitter-fish
            p.tree-sitter-git_config
            p.tree-sitter-git_rebase
            p.tree-sitter-gitattributes
            p.tree-sitter-gitignore
            p.tree-sitter-go
            p.tree-sitter-gomod
            p.tree-sitter-gosum
            p.tree-sitter-helm
            p.tree-sitter-javascript
            p.tree-sitter-json
            p.tree-sitter-json5
            p.tree-sitter-jsonc
            p.tree-sitter-just
            p.tree-sitter-latex
            p.tree-sitter-llvm
            p.tree-sitter-lua
            p.tree-sitter-make
            p.tree-sitter-markdown
            p.tree-sitter-markdown_inline
            p.tree-sitter-nix
            p.tree-sitter-passwd
            p.tree-sitter-proto
            p.tree-sitter-python
            p.tree-sitter-ron
            p.tree-sitter-rust
            p.tree-sitter-sql
            p.tree-sitter-ssh_config
            p.tree-sitter-strace
            p.tree-sitter-toml
            p.tree-sitter-typescript
            p.tree-sitter-verilog
            p.tree-sitter-vhdl
            p.tree-sitter-vim
            p.tree-sitter-xml
            p.tree-sitter-yaml
          ])
        );
      }
    ];
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
