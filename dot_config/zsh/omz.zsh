# =========================================================
# Oh My Zsh
# Runs the only completion setup (compinit). Omarchy's is
# skipped in zoptions.zsh.
#
# chezmoi downloads Oh My Zsh into ~/.oh-my-zsh (see
# .chezmoiexternal.toml in the dotfiles repo) and downloads it
# again at most once a week on `chezmoi apply`. That copy isn't a
# git repo, so Oh My Zsh's own update check skips itself.
# =========================================================

export ZSH="$HOME/.oh-my-zsh"

# Keep Oh My Zsh's cache out of ~/.oh-my-zsh. chezmoi removes
# anything in that folder that isn't in the download.
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"

# Empty = no Oh My Zsh theme; Starship draws the prompt
ZSH_THEME=""

plugins=(git jj)

source "$ZSH/oh-my-zsh.sh"

# zoxide (started by Omarchy before this file) registers its `z` completion
# only if completion is already set up. It wasn't yet, so register it here.
(( $+functions[__zoxide_z_complete] )) && compdef __zoxide_z_complete z
