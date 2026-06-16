{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    custom.language-servers.enable = lib.mkEnableOption "Language servers to support software development";
  };

  config = lib.mkIf config.custom.language-servers.enable {
    environment.systemPackages =
      with pkgs;
      let
        cucumber-language-server = inputs.cucumber-language-server.packages.x86_64-linux.default;
      in
      [
        bash-language-server
        cucumber-language-server

        # For debugging
        gdb

        lua-language-server
        yaml-language-server
        markdown-oxide
        gopls
        golangci-lint-langserver
        dockerfile-language-server
        tailwindcss-language-server
        tree-sitter
        vscode-langservers-extracted
        nixfmt

        # For grammar and spell checking
        harper

        # For the Leptos view! {} macro
        leptosfmt

        # Markdown
        marksman

        # Nix
        nil

        # For styling Lua
        stylua

        # JavaScript and TypeScript
        typescript-language-server
        typescript

        # Language server for typst
        tinymist

        # Formatter for typst
        typstyle
        vscode-json-languageserver
      ];
  };
}
