# ~/.config/zsh/fns/worktrees.zsh

# =========================================================
# Git worktree helpers
# =========================================================

# Create a new worktree and branch from within current git directory.
gwa() {
  if [[ -z "$1" ]]; then
    echo "Usage: gwa [branch name]"
    return 1
  fi

  local branch="$1"
  local base
  local wt_path

  base="$(basename "$PWD")"
  wt_path="../${base}--${branch}"

  git worktree add -b "$branch" "$wt_path" || return 1

  if command -v mise >/dev/null 2>&1; then
    mise trust "$wt_path"
  fi

  cd "$wt_path" || return 1
}

# Remove worktree and branch from within active worktree directory.
gwd() {
  local reply

  echo -n "Remove worktree and branch? [y/N] "
  read -r reply

  if [[ "$reply" != "y" && "$reply" != "Y" ]]; then
    return 0
  fi

  local cwd
  local branch
  local root
  local worktree

  cwd="$(pwd)"
  worktree="$(basename "$cwd")"

  root="${worktree%%--*}"
  branch="${worktree#*--}"

  if [[ "$root" == "$worktree" ]]; then
    echo "Error: current directory does not look like a worktree directory."
    return 1
  fi

  cd "../$root" || return 1
  git worktree remove "$cwd" --force || return 1
  git branch -D "$branch"
}
