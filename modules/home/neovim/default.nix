{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.home.neovim.enable = lib.mkEnableOption "Highly configurable terminal-based text editor and IDE";
  };

  config = lib.mkIf config.custom.home.neovim.enable {
    home-manager.users.nicholas.programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraLuaConfig = ''
        ${builtins.readFile ./config/colorscheme.lua}
        ${builtins.readFile ./config/options.lua}
        ${builtins.readFile ./config/plugins/autopairs.lua}
        ${builtins.readFile ./config/plugins/cmp.lua}
        ${builtins.readFile ./config/plugins/comment.lua}
        ${builtins.readFile ./config/plugins/conform.lua}
        ${builtins.readFile ./config/plugins/crates.lua}
        ${builtins.readFile ./config/plugins/fmt.lua}
        ${builtins.readFile ./config/plugins/lsp.lua}
        ${builtins.readFile ./config/plugins/none-ls.lua}
        ${builtins.readFile ./config/plugins/startup.lua}
        ${builtins.readFile ./config/plugins/telekasten.lua}
        ${builtins.readFile ./config/plugins/telescope.lua}
        ${builtins.readFile ./config/plugins/treesitter.lua}
        ${builtins.readFile ./config/plugins/ts-autotag.lua}
        ${builtins.readFile ./config/plugins/which-key-nvim.lua}
      '';

      plugins =
        with pkgs.vimPlugins;
        let
          # Version provided by vimPlugins is currently broken
          crates-nvim-main = pkgs.vimUtils.buildVimPlugin {
            name = "crates-nvim";
            src = pkgs.fetchFromGitHub {
              owner = "saecki";
              repo = "crates.nvim";
              rev = "2c8f4fab02e3e9ea42c6ad9b547e4207a914a397";
              sha256 = "sha256-Oh3krtXo38wwrcc9YWLS0uw3q7tuw8eU/QG+sUmqtDU=";
            };
            nvimSkipModules = [
              "crates.null-ls"
            ];
          };

          tree-sitter-rust-with-rstml-grammar = pkgs.tree-sitter.buildGrammar {
            language = "rust_with_rstml";
            version = "4ab78c0bb76735dbf4e1bd1a2ec43e953949edb7";
            src = pkgs.fetchFromGitHub {
              owner = "rayliwell";
              repo = "tree-sitter-rstml";
              rev = "4ab78c0bb76735dbf4e1bd1a2ec43e953949edb7";
              sha256 = "sha256-SFV+MdmY5z6DI86VEZMf/lu75QQmM7H7VYSxQg3gkRI=";
            };
            location = "rust_with_rstml";
          };
        in
        [
          calendar-vim
          cmp_luasnip
          cmp-nvim-lsp
          cmp-path
          comment-nvim
          conform-nvim
          crates-nvim-main
          formatter-nvim
          friendly-snippets
          luasnip
          melange-nvim
          neodev-nvim
          none-ls-nvim
          nvim-autopairs
          nvim-bacon
          nvim-cmp
          nvim-lspconfig
          nvim-ts-autotag
          nvim-web-devicons
          playground
          startup-nvim
          tailwindcss-colors-nvim
          telekasten-nvim
          telescope-nvim
          telescope-fzf-native-nvim
          vim-sleuth
          vim-visual-multi
          which-key-nvim

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
            plugin = nvim-highlight-colors;
            config = ''require("nvim-highlight-colors").setup({})'';
            type = "lua";
          }

          {
            plugin = (
              nvim-treesitter.withPlugins (
                _:
                nvim-treesitter.allGrammars
                ++ [
                  # Install tree-sitter-rstml for better Leptos support
                  tree-sitter-rust-with-rstml-grammar
                ]
              )
            );
            config = ''
              local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
              parser_config.rust_with_rstml = {
                install_info = {
                  url = "${tree-sitter-rust-with-rstml-grammar}",
                },
                filetype = "rust",
              }
            '';
            type = "lua";
          }
        ];
    };
  };
}
