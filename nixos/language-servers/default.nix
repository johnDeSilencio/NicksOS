{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lua-language-server
    yaml-language-server
    nodePackages.typescript-language-server
    markdown-oxide
    nodePackages.vscode-json-languageserver
    nodePackages.bash-language-server
    gopls
    golangci-lint-langserver
    dockerfile-language-server-nodejs
    vscode-langservers-extracted
    nixfmt-rfc-style

    # For code formatting
    dprint

    # For grammar and spell checking
    harper

    # Markdown
    marksman

    # TOML
    taplo

    # Nix
    nil
  ];
}
