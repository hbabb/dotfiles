# ~/.config/zsh/.zshenv

# =========================================================
# XDG base directories
# =========================================================
#
# Centralizes config, cache, data, and state paths.
#
# The ${VAR:-fallback} form preserves an existing value if one was already set
# by the system, display manager, or another parent process.

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# =========================================================
# Editor
# =========================================================
#
# EDITOR is used by CLI tools such as git, crontab, and visudo.
# VISUAL is used by tools that prefer a full-screen editor.

export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="$EDITOR"

# =========================================================
# Pager
# =========================================================
#
# PAGER is the generic pager used by CLI programs that need to display long
# output one screen at a time.
#
# MANPAGER is used specifically by man pages. Use bat when available, with
# batcat as the Debian/Ubuntu fallback package name.

export PAGER="less"
export BAT_THEME="${BAT_THEME:-ansi}"
export MANROFFOPT="${MANROFFOPT:--c}"

if command -v bat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif command -v batcat >/dev/null 2>&1; then
  export MANPAGER="batcat -l man -p"
fi

# =========================================================
# GPG
# =========================================================
#
# GPG_TTY should only be set when a real terminal is attached.
# This avoids bad tty values in non-interactive Zsh processes.

if [[ -t 0 ]]; then
  export GPG_TTY="$(tty)"
fi

# =========================================================
# 1Password SSH agent
# =========================================================

export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# =========================================================
# Starship
# =========================================================
#
# Keep the Starship prompt config with the rest of the Zsh config.

export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# =========================================================
# Path
# =========================================================
#
# Zsh exposes PATH through the path array.
# Using the array makes it easier to prepend paths and remove duplicates.

path=("$HOME/.local/bin" $path)

# Remove duplicate PATH entries while preserving order.
typeset -U path PATH
