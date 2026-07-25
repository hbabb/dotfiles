# ~/.config/zsh/completions.zsh

# =========================================================
# Completion system
# =========================================================
# Initialized before aliases/plugins so later files can use compdef.
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# =========================================================
# Completion behavior
# =========================================================
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' squeeze-slashes true
