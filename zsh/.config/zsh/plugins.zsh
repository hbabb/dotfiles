# ~/.config/zsh/plugins.zsh

# =========================================================
# Plugins
# =========================================================
#
# This setup does not load the Oh My Zsh framework.
#
# Standalone plugins are preferred.
# Oh My Zsh is used only as a vendor library for selected plugins.

# =========================================================
# Paths
# =========================================================

ZSH_PLUGIN_DIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
OMZ_LIB="${ZDOTDIR:-$HOME/.config/zsh}/vendor/oh-my-zsh"

mkdir -p "$ZSH_PLUGIN_DIR"
mkdir -p "${ZDOTDIR:-$HOME/.config/zsh}/vendor"

# =========================================================
# Standalone plugin helper
# =========================================================

_zsh_plugin_load() {
  local repo="$1"
  local name="$2"
  local plugin_file="$3"
  local plugin_path="$ZSH_PLUGIN_DIR/$name"

  if [[ ! -d "$plugin_path" ]]; then
    echo "Installing $name..."
    git clone --depth=1 "$repo" "$plugin_path" || {
      echo "ERROR: failed to install $name"
      return 1
    }
  fi

  if [[ -f "$plugin_path/$plugin_file" ]]; then
    source "$plugin_path/$plugin_file"
  else
    echo "ERROR: plugin file not found: $plugin_path/$plugin_file"
    return 1
  fi
}

# =========================================================
# Oh My Zsh vendor helper
# =========================================================

_omz_library_load() {
  local plugin="$1"
  local plugin_file="$OMZ_LIB/plugins/$plugin/$plugin.plugin.zsh"

  if [[ ! -d "$OMZ_LIB" ]]; then
    echo "Installing Oh My Zsh vendor library..."
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$OMZ_LIB" || {
      echo "ERROR: failed to install Oh My Zsh vendor library"
      return 1
    }
  fi

  export ZSH="$OMZ_LIB"

  if [[ -f "$plugin_file" ]]; then
    source "$plugin_file"
  else
    echo "ERROR: OMZ plugin file not found: $plugin_file"
    return 1
  fi
}

# =========================================================
# Plugin update helper
# =========================================================

zplugin-update() {
  local dir

  for dir in "$ZSH_PLUGIN_DIR"/*/; do
    [[ -d "$dir/.git" ]] || continue
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done

  if [[ -d "$OMZ_LIB/.git" ]]; then
    echo "Updating oh-my-zsh..."
    git -C "$OMZ_LIB" pull --ff-only
  fi
}

# =========================================================
# Standalone plugins
# =========================================================

_zsh_plugin_load \
  https://github.com/zsh-users/zsh-autosuggestions.git \
  zsh-autosuggestions \
  zsh-autosuggestions.zsh

_zsh_plugin_load \
  https://github.com/zsh-users/zsh-history-substring-search.git \
  zsh-history-substring-search \
  zsh-history-substring-search.zsh

_zsh_plugin_load \
  https://github.com/jeffreytse/zsh-vi-mode.git \
  zsh-vi-mode \
  zsh-vi-mode.plugin.zsh

_zsh_plugin_load \
  https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  fast-syntax-highlighting \
  fast-syntax-highlighting.plugin.zsh

# =========================================================
# Oh My Zsh library plugins
# =========================================================

_omz_library_load git
_omz_library_load sudo
_omz_library_load systemd
_omz_library_load colored-man-pages
_omz_library_load command-not-found
_omz_library_load docker
_omz_library_load npm
_omz_library_load pip
_omz_library_load python

# =========================================================
# Cleanup
# =========================================================

unfunction _zsh_plugin_load
unfunction _omz_library_load
