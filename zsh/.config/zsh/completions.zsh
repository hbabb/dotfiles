# ~/.config/zsh/completions.zsh

# =========================================================
# Completion system
# =========================================================
#
# Completion is initialized before aliases and plugins so later files can use
# compdef when needed.

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# =========================================================
# Completion behavior
# =========================================================

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' squeeze-slashes true
