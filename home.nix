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

    ".config/zellij" = {
      source = ./home/.config/zellij;
      recursive = true;
    };

    ".config/starship.toml" = {
      source = ./home/.config/starship.toml;
    };

    ".gitconfig" = {
      source = ./home/.gitconfig;
    };
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
  home.sessionVariables = { };

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
        helper = "oauth";
      };
    };
  };

  # Configure Alacritty
  programs.alacritty.settings = {
    font = {
      size = 20.0;
    };
  };

  # Configure helix
  programs.helix = {
    enable = true;
    defaultEditor = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
