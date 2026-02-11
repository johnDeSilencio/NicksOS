fish_config theme choose "Catppuccin Macchiato"

status is-interactive; and begin
    # PATH extensions
    fish_add_path ~/.cargo/bin/
    fish_add_path ~/.dotfiles/scripts/

    # Disable greeting
    set fish_greeting

    # Default editor
    set -gx EDITOR nvim

    # Set up the starship prompt
    starship init fish | source

    # Set up atuin shell history tool
    atuin init fish | source

    # Set up Zellij
    eval (zellij setup --generate-auto-start fish | string collect)

    # Import fish aliases
    source ~/.config/fish/aliases.fish

    # Import fish completions
    source ~/.config/fish/completions/completions.fish

    # Workaround for Primary Device Attribute query bug
    # https://github.com/fish-shell/fish-shell/issues/11841#issuecomment-3351793705
    set --universal fish_features no-query-term
end
