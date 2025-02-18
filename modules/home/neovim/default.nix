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

      extraLuaConfig = "${builtins.readFile ./config/options.lua}";

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
        nvim-ts-autotag
        nvim-web-devicons
        rustaceanvim
        telescope-fzf-native-nvim
        vim-sleuth
        vim-visual-multi

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
          plugin = formatter-nvim;
          config = "${builtins.readFile ./config/plugin/fmt.lua}";
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
          config = "${builtins.readFile ./config/plugin/cmp.lua}";
          type = "lua";
        }

        {
          plugin = nvim-highlight-colors;
          config = ''require("nvim-highlight-colors").setup({})'';
          type = "lua";
        }

        {
          plugin = nvim-lspconfig;
          config = "${builtins.readFile ./config/plugin/lsp.lua}";
          type = "lua";
        }

        {
          plugin = startup-nvim;
          config = "${builtins.readFile ./config/plugin/startup.lua}";
          type = "lua";
        }

        {
          plugin = telekasten-nvim;
          config = "${builtins.readFile ./config/plugin/telekasten.lua}";
          type = "lua";
        }

        {
          plugin = telescope-nvim;
          config = "${builtins.readFile ./config/plugin/telescope.lua}";
          type = "lua";
        }

        {
          plugin = which-key-nvim;
          config = "${builtins.readFile ./config/plugin/which-key-nvim.lua}";
          type = "lua";
        }

        {
          plugin = nvim-treesitter.withAllGrammars;
        }
      ];
    };
  };
}
