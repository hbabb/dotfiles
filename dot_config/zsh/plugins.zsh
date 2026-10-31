# =========================================================
# Plugins
# autosuggestions and history-substring-search come from the
# Arch packages (updated by `omarchy update`).
# fast-syntax-highlighting comes from git (updated by `zplugin-update`).
# =========================================================

ZPLUGINDIR="$HOME/.config/zsh/plugins"

_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi
  source "${plugin_path}/${2}.plugin.zsh"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
_zplugin_load zdharma-continuum fast-syntax-highlighting
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Original plugin list
# ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
# _zplugin_load zsh-users zsh-autosuggestions
# _zplugin_load zsh-users zsh-history-substring-search
# _zplugin_load jeffreytse zsh-vi-mode
# _zplugin_load zdharma-continuum fast-syntax-highlighting
