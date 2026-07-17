# File system
def ls [...args] {
    if (which eza | is-not-empty) {
        eza -lh --group-directories-first --icons=auto ...$args
    } else {
        ^ls ...$args
    }
}
def lsa [...args] {
    if (which eza | is-not-empty) {
        eza -lha --group-directories-first --icons=auto ...$args
    } else {
        ^ls -la ...$args
    }
}
def ll [...args] {
    if (which eza | is-not-empty) {
        eza -lh --icons=auto --git --group-directories-first --git-ignore ...$args
    } else {
        ^ls -l ...$args
    }
}
def la [...args] {
    if (which eza | is-not-empty) {
        eza -lah --icons=auto --git --group-directories-first --git-ignore ...$args
    } else {
        ^ls -la ...$args
    }
}
def lt [...args] { eza --tree --level=5 --long --icons --git --git-ignore ...$args }
def lta [...args] {
    eza -a --tree --level=5 --long --icons --git --git-ignore ...$args
}
def tree [...args] { eza --tree --icons --git --git-ignore ...$args }

# Directory shortcuts
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
# "cd -" abbreviation has no Nu equivalent (Nu has no abbr/expand-on-type system).
# Closest option: alias `-` to a fixed command, but that's not the same trigger behavior.

# Smart directory navigation
alias cd = zd

# Editor
alias vim = nvim
alias vi = nvim

# Core Utilities
def cat [...args] {
    if (which bat | is-not-empty) {
        bat ...$args
    } else if (which batcat | is-not-empty) {
        batcat ...$args
    } else {
        ^cat ...$args
    }
}
def grep [...args] { rg --color=auto ...$args }
def diff [...args] {
    if (^diff --color=auto /dev/null /dev/null | complete | get exit_code) == 0 {
        ^diff --color=auto ...$args
    } else {
        ^diff ...$args
    }
}
alias df = df -h

# Docker / Podman
def d [...args] {
    if (which docker | is-not-empty) {
        docker ...$args
    } else {
        podman ...$args
    }
}
alias ld = lazydocker

# Rails
alias r = rails
alias br = bin/rails

# Package manager wrappers
def npm [...args] { sfw npm ...$args }
def npx [...args] { sfw npx ...$args }
def pnpm [...args] { sfw pnpm ...$args }
def pnpx [...args] { sfw pnpx ...$args }
def yarn [...args] { sfw yarn ...$args }
def bun [...args] { sfw bun ...$args }
def bunx [...args] { sfw bunx ...$args }
def nub [...args] { sfw nub ...$args }
def nubx [...args] { sfw nubx ...$args }

# Laravel Sail
def sail [...args] {
    if ("./sail" | path exists) {
        ^sh ./sail ...$args
    } else if ("./vendor/bin/sail" | path exists) {
        ^sh ./vendor/bin/sail ...$args
    } else {
        print -e "sail: ./sail or ./vendor/bin/sail was not found"
        return 127
    }
}

# Git alias
alias g = git
alias gs = git status --short --branch
alias ga = git add
alias gaa = git add --all
alias gcm = git commit -m
alias gcam = git commit -a -m
alias gcad = git commit -a --amend
alias gp = git push
alias gpl = git pull --ff-only
def glog [...args] { with-env { GIT_PAGER: "less -F -X" } { git log ...$args } }
def gl [...args] { with-env { GIT_PAGER: "less -F -X" } { git log --all --decorate --oneline --graph ...$args } }
alias lg = lazygit
