# ~/.config/nushell/autoload/aliases.nu
#
# Aliases can't be conditionally defined in Nushell — they don't persist
# outside an `if` block. So these are unguarded; if a tool isn't
# installed, the alias exists but errors when called, same as an
# unguarded alias would in zsh/fish.

alias lsa = ls -a
alias vim = nvim
alias vi = nvim
alias cat = bat
alias grep = rg --color=auto
alias df = df -h

alias d = docker
alias p = podman
alias ld = lazydocker

alias npm = sfw npm
alias npx = sfw npx
alias pnpm = sfw pnpm
alias pnpx = sfw pnpx
alias yarn = sfw yarn
alias bun = sfw bun
alias bunx = sfw bunx
alias nub = sfw nub
alias nubx = sfw nubx

alias tree = ^eza --tree --icons
alias lt = ^eza --tree --level=2 --long --icons --git
alias lta = ^eza --tree --level=2 --long --icons --git --all

alias g = git
alias gs = git status --short --branch
alias ga = git add
alias gaa = git add --all
alias gcm = git commit -m
alias gcam = git commit -a -m
alias gcad = git commit -a --amend
alias gp = git push
alias gpl = git pull --ff-only
alias lg = lazygit
