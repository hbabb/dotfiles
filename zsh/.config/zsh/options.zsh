# ~/.config/zsh/options.zsh

# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=32768
SAVEHIST=32768

setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# =========================================================
# Shell behavior
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# =========================================================
# Command hashing
# =========================================================
#
# Disables command hashing so newly installed or removed tools are resolved
# without needing to manually rehash.

unsetopt HASH_CMDS
