{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    custom.language-servers.enable = lib.mkEnableOption "Language servers to support software development";
  };

  config = lib.mkIf config.custom.language-servers.enable {
    environment.systemPackages = with pkgs; [
      lua-language-server
      yaml-language-server
      markdown-oxide
      nodePackages.vscode-json-languageserver
      nodePackages.bash-language-server
      gopls
      golangci-lint-langserver
      dockerfile-language-server-nodejs
      vscode-langservers-extracted
      nixfmt-rfc-style

      # For grammar and spell checking
      harper

      # Markdown
      marksman

      # TOML
      taplo

      # Nix
      nil

      # JavaScript and TypeScript
      typescript-language-server
      typescript
    ];
  };
}
