# =========================================================
# Environment
# Moved from .zshenv. Loaded from ~/.zshrc after Omarchy's setup.
# =========================================================

# =========================================================
# XDG base directories
# =========================================================
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# =========================================================
# Editor
# =========================================================
# Omarchy already sets EDITOR=nvim and SUDO_EDITOR
# if command -v nvim >/dev/null 2>&1; then
#   export EDITOR="$(command -v nvim)"
#   export VISUAL="$EDITOR"
# elif command -v vi >/dev/null 2>&1; then
#   export EDITOR="vi"
#   export VISUAL="vi"
# fi
#
# export SUDO_EDITOR="$EDITOR"

export VISUAL="$EDITOR"

# =========================================================
# Pager
# =========================================================
export PAGER="less"

# Omarchy already sets BAT_THEME=ansi, MANROFFOPT and MANPAGER
# export BAT_THEME="${BAT_THEME:-ansi}"
# export MANROFFOPT="${MANROFFOPT:--c}"
#
# if command -v bat >/dev/null 2>&1; then
#   export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# elif command -v batcat >/dev/null 2>&1; then
#   export MANPAGER="batcat -l man -p"
# fi

# =========================================================
# GPG
# =========================================================
if [[ -t 0 ]]; then
  export GPG_TTY="$(tty)"
fi

# =========================================================
# 1Password SSH agent
# =========================================================
export SSH_AUTH_SOCK="${SSH_AUTH_SOCK:-$HOME/.1password/agent.sock}"

# =========================================================
# Starship
# =========================================================
# ZDOTDIR is no longer set, so point at the repo folder directly
# export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/zsh/starship.toml"

# =========================================================
# Path
# =========================================================
# Omarchy appends ~/.local/bin; this puts it first and removes duplicates
path=("$HOME/.local/bin" $path)
typeset -U path PATH

# =========================================================
# Homebrew
# =========================================================
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# =========================================================
# tuxedo (todo.txt)
# =========================================================
export NOTES_DIR="$HOME/Documents/MemoryCore"
export TODO_DIR="$NOTES_DIR/Operations"
export TODO_FILE="$TODO_DIR/todo.txt"
export DONE_FILE="$TODO_DIR/done.txt"
