# ~/.zshenv

# =========================================================
# Zsh config bootstrap
# =========================================================
#
# This file is intentionally small.
#
# Zsh reads ~/.zshenv before the rest of the user startup files. Its job here
# is only to point Zsh at the XDG-based config directory.
#
# The real environment setup lives in:
#
#   ~/.config/zsh/.zshenv
#
# Do not load aliases, plugins, prompt code, completions, fzf, zoxide, mise,
# or other interactive shell behavior from this file.

# =========================================================
# XDG config home
# =========================================================

# Use an existing XDG_CONFIG_HOME if one was already set by the system.
# Otherwise, default to the standard user config directory.
if [[ -z "$XDG_CONFIG_HOME" ]]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi

# =========================================================
# ZDOTDIR
# =========================================================

# Tell Zsh to load the rest of the user config from ~/.config/zsh.
# This keeps the home directory clean and allows the config to be managed
# cleanly with GNU Stow.
if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
  export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi

. "$HOME/.local/share/../bin/env"
