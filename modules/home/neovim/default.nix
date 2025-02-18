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
        ${builtins.readFile ./config/plugins/cmp.lua}
        ${builtins.readFile ./config/plugins/fmt.lua}
        ${builtins.readFile ./config/plugins/lsp.lua}
        ${builtins.readFile ./config/plugins/startup.lua}
        ${builtins.readFile ./config/plugins/telekasten.lua}
        ${builtins.readFile ./config/plugins/telescope.lua}
        ${builtins.readFile ./config/plugins/which-key-nvim.lua}
      '';

      extraPackages = with pkgs; [
        lua-language-server
        nil
      ];

      plugins = with pkgs.vimPlugins; [
        calendar-vim
        cmp_luasnip
        cmp-nvim-lsp
        cmp-path
        crates-nvim
        formatter-nvim
        friendly-snippets
        luasnip
        miasma-nvim
        neodev-nvim
        nvim-bacon
        nvim-cmp
        nvim-lspconfig
        nvim-ts-autotag
        nvim-web-devicons
        startup-nvim
        telekasten-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        vim-sleuth
        vim-visual-multi
        which-key-nvim

        {
          plugin = comment-nvim;
          config = ''require("Comment").setup()'';
          type = "lua";
        }

        {
          plugin = crates-nvim;
          config = ''require("crates").setup()'';
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
          plugin = nvim-highlight-colors;
          config = ''require("nvim-highlight-colors").setup({})'';
          type = "lua";
        }

        {
          plugin = nvim-treesitter.withAllGrammars;
        }
      ];
    };
  };
}
