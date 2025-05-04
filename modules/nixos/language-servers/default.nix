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
        cucumber-language-server
        node2nix
        lua-language-server
        yaml-language-server
        markdown-oxide
        nodePackages.vscode-json-languageserver
        nodePackages.bash-language-server
        gopls
        golangci-lint-langserver
        dockerfile-language-server-nodejs
        tailwindcss-language-server
        tree-sitter
        vscode-langservers-extracted
        nixfmt-rfc-style

        # For grammar and spell checking
        harper

        # For the Leptos view! {} macro
        leptosfmt

        # Markdown
        marksman

        # TOML
        taplo

        # Nix
        nil

        # JavaScript and TypeScript
        typescript-language-server
        typescript

        # Language server for typst
        tinymist

        # Formatter for typst
        typstyle
      ];
  };
}
