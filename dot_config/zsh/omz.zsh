# =========================================================
# Oh My Zsh
# Runs the only completion setup (compinit). Omarchy's is
# skipped in load-omarchy.zsh.
# =========================================================

export ZSH="$HOME/.oh-my-zsh"

# Empty = no Oh My Zsh theme; Starship draws the prompt
# ZSH_THEME=""
# Oh My Zsh's default theme; change the name to use a different one
ZSH_THEME="bira"

# Turn off Starship (Omarchy's setup starts it before this file loads)
add-zsh-hook -d precmd prompt_starship_precmd
add-zsh-hook -d preexec prompt_starship_preexec
RPROMPT=''

plugins=(git jj)

source "$ZSH/oh-my-zsh.sh"

# zoxide (started by Omarchy before this file) registers its `z` completion
# only if completion is already set up. It wasn't yet, so register it here.
(( $+functions[__zoxide_z_complete] )) && compdef __zoxide_z_complete z
