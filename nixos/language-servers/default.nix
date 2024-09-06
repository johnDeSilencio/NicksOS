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

    # TOML
    taplo

    # Nix
    nil

    # Protobuf
    buf-language-server
  ];
}
