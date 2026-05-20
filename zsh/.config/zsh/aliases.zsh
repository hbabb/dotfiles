# ~/.config/zsh/aliases.zsh

# =========================================================
# File system
# =========================================================

# Use eza as the primary ls replacement when available.
# Falls back to the system ls automatically if eza is not installed.
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias ll='eza -lh --icons=auto --git --group-directories-first'
  alias la='eza -lah --icons=auto --git --group-directories-first'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
  alias tree='eza --tree --icons'

  # Reuse ls completions for eza after compinit has loaded compdef.
  if (( $+functions[compdef] )); then
    compdef eza=ls
  fi
fi

# Directory shortcuts.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# =========================================================
# File preview and fuzzy finder
# =========================================================

# Fuzzy-find a file or path from stdin.
# Uses bat/batcat for previews when available.
ff() {
  if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed" >&2
    return 127
  fi

  if command -v bat >/dev/null 2>&1; then
    fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
  elif command -v batcat >/dev/null 2>&1; then
    fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'
  else
    fzf
  fi
}

# Open the selected fuzzy-find result in the configured editor.
eff() {
  local file

  file="$(ff)" || return
  [[ -n "$file" ]] || return

  "${EDITOR:-nvim}" "$file"
}

# Print files sorted by modified time.
# Uses GNU find when available, with macOS/BSD stat fallback.
_recent_files() {
  if find . -type f -printf '' >/dev/null 2>&1; then
    find . -type f -printf '%T@\t%p\n' | sort -rn | cut -f2-
  elif command -v stat >/dev/null 2>&1; then
    case "$(uname -s)" in
      Darwin|FreeBSD)
        find . -type f -exec stat -f '%m\t%N' {} + | sort -rn | cut -f2-
        ;;
      *)
        find . -type f -exec stat -c '%Y\t%n' {} + | sort -rn | cut -f2-
        ;;
    esac
  else
    find . -type f
  fi
}

# Select a recent file with fzf and copy it with scp.
sff() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: sff <destination> (e.g. sff host:/tmp/)" >&2
    return 1
  fi

  local file

  file="$(_recent_files | ff)" || return
  [[ -n "$file" ]] || return

  scp "$file" "$1"
}

# =========================================================
# Smart directory navigation
# =========================================================

# Use zoxide-backed cd when zoxide is available.
# Direct paths still use builtin cd; fuzzy/history jumps use zoxide.
if command -v zoxide >/dev/null 2>&1; then
  if ! (( $+functions[z] )); then
    eval "$(zoxide init zsh)"
  fi

  alias cd='zd'

  zd() {
    if (( $# == 0 )); then
      builtin cd ~ || return
      return
    fi

    if (( $# == 1 )) && [[ -d "$1" ]]; then
      builtin cd "$1" || return
      return
    fi

    if ! z "$@"; then
      echo "Error: Directory not found: $*" >&2
      return 1
    fi

    printf "󱞩 "
    pwd
  }
fi

# =========================================================
# Editor
# =========================================================

# Use Neovim as Vim.
if command -v nvim >/dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'

  n() {
    if [[ $# -eq 0 ]]; then
      command nvim .
    else
      command nvim "$@"
    fi
  }
fi

# =========================================================
# Core utilities
# =========================================================

# Use bat as cat when available.
if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
elif command -v batcat >/dev/null 2>&1; then
  alias cat='batcat'
fi

# Use ripgrep as grep when available.
if command -v rg >/dev/null 2>&1; then
  alias grep='rg --color=auto'
fi

# Use colored diff only when the system diff supports it.
if diff --color=auto /dev/null /dev/null >/dev/null 2>&1; then
  alias diff='diff --color=auto'
fi

alias df='df -h'

# =========================================================
# Tools
# =========================================================

# Prefer Docker for shortcut
# Fall back to Podman when Docker is not available
if command -v docker >/dev/null 2>&1; then
  alias d='docker'
elif command -v podman >/dev/null 2>&1; then
  alias d='podman'
fi

# Reverse Docker/Podman as needed
if command -v podman >/dev/null 2>&1; then
  alias p='podman'
elif command -v docker >/dev/null 2>&1; then
  alias p='docker'
fi

# Rails shortcut.
if command -v rails >/dev/null 2>&1; then
  alias r='rails'
fi

# Attach to the Work tmux session, or create it if missing.
if command -v tmux >/dev/null 2>&1; then
  t() {
    tmux attach -t Work 2>/dev/null || tmux new -s Work
  }
fi

# =========================================================
# Git
# =========================================================

if command -v git >/dev/null 2>&1; then
  alias g='git'

  alias gs='git status --short --branch'
  alias ga='git add'
  alias gaa='git add --all'

  alias gcm='git commit -m'
  alias gcam='git commit -a -m'
  alias gcad='git commit -a --amend'

  alias gp='git push'
  alias gpl='git pull --ff-only'

  alias glog='PAGER="less -F -X" git log'
  alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
fi
