# =========================================================
# Load Omarchy's zoptions, with two lines skipped
# Loads Omarchy's file from /usr/share as-is (so it still updates),
# but skips:
#   - zsh-syntax-highlighting (fast-syntax-highlighting is loaded in plugins.zsh)
#   - compinit, the completion setup (Oh My Zsh runs it in omz.zsh)
# =========================================================

# Temporarily wrap `source` so the zsh-syntax-highlighting line is skipped
source() {
  [[ $1 == */zsh-syntax-highlighting.zsh ]] && return 0
  builtin source "$@"
}

# Temporarily replace compinit with a no-op so only Oh My Zsh's runs
compinit() { : }

builtin source /usr/share/omarchy-zsh/shell/zoptions

# Put `source` and `compinit` back to normal
unfunction source compinit
