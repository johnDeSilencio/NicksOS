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
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

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
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nicholas/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    STARSHIP_CONFIG = "/home/nicholas/.dotfiles/starship.toml";
    ZELLIJ_CONFIG_DIR = "/home/nicholas/.dotfiles/";
  };

  # Configure theme
  catppuccin.flavor = "frappe";

  # Configure VSCodium
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions =
      with pkgs.vscode-extensions;
      [
        nonylene.dark-molokai-theme
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        serayuzgur.crates
        usernamehw.errorlens
        esbenp.prettier-vscode
        davidanson.vscode-markdownlint
        yzhang.markdown-all-in-one
        bbenoist.nix
        streetsidesoftware.code-spell-checker
        vscodevim.vim
        usernamehw.errorlens
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "dendron";
          publisher = "dendron";
          version = "0.124.0";
          sha256 = "/hxgmmiMUfBtPt5BcuNvtXs3LzDmPwDuUOyDf2udHws=";
        }
      ];
  };

  # Configure fish
  programs.fish = {
    enable = true;
    catppuccin.enable = true;
    interactiveShellInit = ''
      # PATH extensions
      fish_add_path ~/.cargo/bin/

      # Disable greeting
      set fish_greeting

      # Set up the starship prompt
      starship init fish | source

      # Set up atuin shell history tool
      atuin init fish | source

      # Set up Zellij
      eval (zellij setup --generate-auto-start fish | string collect)
    '';
  };

  # Configure git
  programs.git = {
    enable = true;
    userName = "Nicholas R. Smith";
    userEmail = "nicholasrsmith1600@gmail.com";
    extraConfig = {
      credential = {
        helper = "oauth";
      };
    };
  };

  # Configure helix
  programs.helix = {
    enable = true;
    catppuccin.enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        rulers = [
          80
          120
        ];
      };
    };
    languages = {
      language = [
        {
          name = "json";
          language-servers = [ "vscode-json-language-server" ];
        }
        {
          name = "html";
          language-servers = [ "vscode-html-languageserver" ];
        }
        {
          name = "css";
          language-servers = [ "vscode-css-languageserver" ];
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nil" ];
          formatter = {
            command = "nixfmt";
          };
        }
      ];

      language-server.vscode-json-language-server = {
        command = "vscode-json-languageserver";
      };

      language-server.vscode-html-languageserver = {
        command = "html-languageserver";
      };

      language-server.vscode-css-languageserver = {
        command = "css-languageserver";
      };
    };
  };

  # Configure GNOME
  dconf.settings = {
    "org/gnome/desktop/background" = {
      "picture-uri-dark" = "/home/nicholas/.dotfiles/.background-image";
    };
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
      "font-antialiasing" = "rgba";
      "text-scaling-factor" = 1.5;
    };
  };

  # Configure GTK theme
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "macchiato";
      accent = "pink";
      size = "standard";
      tweaks = [ "normal" ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
