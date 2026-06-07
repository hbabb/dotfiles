# File system
if command -q eza
    alias ls "eza -lh --group-directories-first --icons=auto"
    alias lsa "ls -a"
    alias ll "eza -lh --icons=auto --git --group-directories-first"
    alias la "eza -lah --icons=auto --git --group-directories-first"
    alias lt "eza --tree --level=2 --long --icons --git"
    alias lta "lt -a"
    alias tree "eza --tree --icons"
end

# Directory shortcuts
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
abbr -a -- - "cd -"

# Smart directory navigation
if command -q zoxide
    alias cd zd
end

# Editor
if command -q nvim
    alias vim nvim
    alias vi nvim
end

# Core Utilities
if command -q bat
    alias cat bat
else if command -q batcat
    alias cat batcat
end

if command -q rg
    alias grep "rg --color=auto"
end

if diff --color=auto /dev/null /dev/null >/dev/null 2>&1
    alias diff "diff --color=auto"
end

alias df "df -h"

# Docker / Podman
if command -q docker
    alias d docker
else if command -q podman
    alias d podman
end

if command -q lazydocker
    alias ld lazydocker
end

# Rails
if command -q rails
    alias r rails
    alias br bin/rails
end

# Package manager wrappers
if command -q sfw
    alias npm "sfw npm"
    alias npx "sfw npx"
    alias pnpm "sfw pnpm"
    alias pnpx "sfw pnpx"
    alias yarn "sfw yarn"
    alias bun "sfw bun"
    alias bunx "sfw bunx"
end

# Git alias
if command -q git
    alias g git

    alias gs "git status --short --branch"
    alias ga "git add"
    alias gaa "git add --all"

    alias gcm "git commit -m"
    alias gcam "git commit -a -m"
    alias gcad "git commit -a --amend"

    alias gp "git push"
    alias gpl "git pull --ff-only"

    alias glog "env PAGER='less -F -X' git log"
    alias gadog "env PAGER='less -F -X' git log --all --decorate --oneline --graph"
end
if command -q lazygit
    alias lg lazygit
end
