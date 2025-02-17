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
  };
}
