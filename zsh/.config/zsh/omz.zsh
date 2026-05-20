# ~/.config/zsh/omz.zsh

# =========================================================
# Oh My Zsh framework
# =========================================================
#
# Temporary transition layer.
#
# This loads Oh My Zsh as a framework while the local Zsh module/plugin system
# is being built.
#
# Starship is used for the prompt, so no OMZ theme is enabled.

export ZSH="$ZDOTDIR/vendor/oh-my-zsh"

ZSH_THEME=""

plugins=(
  git
  sudo
  systemd
  colored-man-pages
  command-not-found
  docker
  pip
  python
)

source "$ZSH/oh-my-zsh.sh"
