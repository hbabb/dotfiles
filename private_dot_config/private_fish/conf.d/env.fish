# XDG base directories
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME "$HOME/.local/state"

# Editor
if command -q nvim
    set -gx EDITOR (command -v nvim)
    set -gx VISUAL $EDITOR
else if command -q vi
    set -gx EDITOR vi
    set -gx VISUAL vi
end

set -gx SUDO_EDITOR $EDITOR

# Pager
set -gx PAGER less
set -q BAT_THEME; or set -gx BAT_THEME ansi
set -q MANROFFOPT; or set -gx MANROFFOPT -c

if command -q bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
else if command -q batcat
    set -gx MANPAGER "batcat -l man -p"
end

# GPG
if status is-interactive
    set -gx GPG_TTY (tty)
end

# 1Password ssh agent
set -q SSH_AUTH_SOCK; or set -gx SSH_AUTH_SOCK "$HOME/.1password/agent.sock"

# Starship config location
# set -gx STARSHIP_CONFIG "$HOME/.config/fish/starship.toml"

# User PATH entries
fish_add_path -g "$HOME/.local/bin"
