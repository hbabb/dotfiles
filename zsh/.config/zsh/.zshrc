# ~/.config/zsh/.zshrc
#
# Powerful but minimal zsh configuration
# Author: Heath Babb - TechSolvd
# GitLab:
#
# Inspired by: Radley E. Sidwell-Lewis setup (https://www.github.com/radleylewis/zsh)
#
# Uses:
#   Plugins:      fast-syntax-highlighting, zsh-autosuggestions,
#                 zsh-history-substring-search, zsh-vi-mode
#   Prompt:       starship
#   Navigation:   zoxide, fzf, fd
#   CLI tools:    eza, bat, nvim, ripgrep
#   Tool manager: mise in place of nvm
#
# Oh My Zsh is used only as a vendor library for selected plugins.
# The Oh My Zsh framework is not loaded with this setup.

# =========================================================
# Interactive shell configuration
# =========================================================
#
# This file is the main loader for the interactive Zsh session.
#
# Environment variables that must exist in every Zsh process belong in:
#
#   ~/.config/zsh/.zshenv
#
# Interactive behavior belongs here or in files loaded from here.

# =========================================================
# Safety directories
# =========================================================

# Create the directories used by history, completion cache, plugins, and
# vendor-managed source code. These are safe to run repeatedly.
mkdir -p "$XDG_STATE_HOME/zsh"
mkdir -p "$XDG_CACHE_HOME/zsh"
mkdir -p "$ZDOTDIR/plugins"
mkdir -p "$ZDOTDIR/vendor"
mkdir -p "$ZDOTDIR/fns"

# =========================================================
# Source helper
# =========================================================

# Source a file only when it exists.
# This keeps the setup portable across machines where some optional files may
# not be present yet.
source_if_exists() {
  [[ -f "$1" ]] && source "$1"
}

# =========================================================
# Core shell setup
# =========================================================

source_if_exists "$ZDOTDIR/options.zsh"
source_if_exists "$ZDOTDIR/completions.zsh"

# =========================================================
# Smart directory navigation
# =========================================================

# zoxide tracks frequently used directories and provides smarter cd behavior.
# The cd alias itself is defined in aliases.zsh so the behavior stays visible.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# =========================================================
# Fuzzy finder shell integration
# =========================================================

# macOS / Homebrew - Apple Silicon
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

if [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# macOS / Homebrew - Intel
if [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
fi

if [[ -f /usr/local/opt/fzf/shell/completion.zsh ]]; then
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# Fedora / Arch
if [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
  source /usr/share/fzf/shell/key-bindings.zsh
fi

if [[ -f /usr/share/fzf/shell/completion.zsh ]]; then
  source /usr/share/fzf/shell/completion.zsh
fi

if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi

if [[ -f /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh
fi

# Debian / Ubuntu
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

if [[ -f /usr/share/doc/fzf/examples/completion.zsh ]]; then
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# =========================================================
# Modular config files
# =========================================================

source_if_exists "$ZDOTDIR/fzf.zsh"
source_if_exists "$ZDOTDIR/aliases.zsh"
source_if_exists "$ZDOTDIR/functions.zsh"
source_if_exists "$ZDOTDIR/bindings.zsh"
source_if_exists "$ZDOTDIR/plugins.zsh"
source_if_exists "$ZDOTDIR/prompt.zsh"

# =========================================================
# Tool manager
# =========================================================

# mise manages project runtimes such as Node, Python, Ruby, and PHP.
# This belongs in .zshrc because mise updates the interactive shell environment.
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# =========================================================
# Cleanup
# =========================================================

# Keep the interactive namespace clean after startup.
unfunction source_if_exists
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
