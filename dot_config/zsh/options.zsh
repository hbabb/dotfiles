# =========================================================
# Options
# Moved from .zshrc. Loaded from ~/.zshrc after Omarchy's setup,
# so anything set here replaces Omarchy's value.
# =========================================================

# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

# Omarchy already sets these
# setopt APPEND_HISTORY
# setopt SHARE_HISTORY
# setopt HIST_IGNORE_DUPS
# setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# =========================================================
# Shell behaviour
# =========================================================

# Omarchy already sets these
# setopt AUTOCD
# setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# =========================================================
# Smart directory navigation & lf
# =========================================================

if [[ -f ~/.config/lf/icons ]]; then
  LF_ICONS=$(cat ~/.config/lf/icons | tr '\n' ':')
  export LF_ICONS
fi

# Omarchy already initializes zoxide
# if command -v zoxide >/dev/null 2>&1; then
#   eval "$(zoxide init zsh)"
# fi

# =========================================================
# Completion
# =========================================================

# Omarchy already runs compinit, menu select and case-insensitive matching
# autoload -Uz compinit
# compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
# zstyle ':completion:*' menu select
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# =========================================================
# Fuzzy finder
# =========================================================

# Omarchy already loads fzf's key bindings and completion
# from /usr/share/fzf/
#
# if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
#   source /usr/share/fzf/key-bindings.zsh
# fi
# if [[ -f /usr/share/fzf/completion.zsh ]]; then
#   source /usr/share/fzf/completion.zsh
# fi

# =========================================================
# Tool manager
# =========================================================

# Omarchy already activates mise
# if command -v mise >/dev/null 2>&1; then
#   eval "$(mise activate zsh)"
# fi
