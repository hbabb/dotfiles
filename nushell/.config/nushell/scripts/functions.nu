# ff.fish
def ff [] {
    if (which fzf | is-empty) {
        print -e "Error: fzf is not installed"
        return 127
    }

    if (which bat | is-not-empty) {
        fzf --preview "bat --style=numbers --color=always --line-range :500 {}"
    } else if (which batcat | is-not-empty) {
        fzf --preview "batcat --style=numbers --color=always --line-range :500 {}"
    } else {
        fzf
    }
}

# eff.fish
def eff [] {
    let file = (ff)

    if ($file | is-empty) {
        return
    }

    run-external $env.EDITOR $file
}

# sff.fish
def sff [destination?: string] {
    if ($destination | is-empty) {
        print -e "Usage: sff <destination> (e.g. sff host:/tmp/)"
        return 1
    }

    let file = (recent_files | ff)

    if ($file | is-empty) {
        return
    }

    ^scp $file $destination
}

# n.fish
def n [...args] {
    if ($args | is-empty) {
        run-external nvim "."
    } else {
        run-external nvim ...$args
    }
}

# t.fish
def t [] {
    if (which tmux | is-empty) {
        print -e "Error: tmux is not installed"
        return 127
    }

    try {
        ^tmux attach -t Work
    } catch {
        ^tmux new -s Work
    }
}

# recent_files.fish
def recent_files [] {
    if (which find | is-not-empty) {
        ^find . -type f -printf "%T@\t%p\n" | lines | sort --reverse | each { |row| $row | split column "\t" | get column2 } | flatten
    } else if (which stat | is-not-empty) {
        if $nu.os-info.name in ["macos", "freebsd"] {
            ^find . -type f -exec stat -f "%m\t%N" {} + | lines | sort --reverse | each { |row| $row | split column "\t" | get column2 } | flatten
        } else {
            ^find . -type f -exec stat -c "%Y\t%n" {} + | lines | sort --reverse | each { |row| $row | split column "\t" | get column2 } | flatten
        }
    } else {
        ^find . -type f | lines
    }
}

# _fzf_file_no_hidden.fish
def fzf-file-no-hidden [] {
    if (which fzf | is-empty) {
        print -e "Error: fzf is not installed"
        return 127
    }

    let cmd = if not ($env.FZF_DEFAULT_COMMAND? | default "" | is-empty) {
        $env.FZF_DEFAULT_COMMAND | str replace "--hidden " ""
    } else {
        "find . -type f"
    }

    let result = (nu -c $cmd | fzf --preview $env._FZF_PREVIEW_CMD | str trim)

    if ($result | is-empty) {
        return
    }

    $result
}

# zd.fish
def --env zd [...args] {
    let argc = ($args | length)

    # No arguments: go home without printing.
    if $argc == 0 {
        z
        return
    }

    # Existing path: use zoxide's regular-cd path without printing.
    if $argc == 1 and ($args.0 | path exists) {
        z $args.0
        return
    }

    # Otherwise, treat the arguments as a zoxide query.
    try {
        z ...$args
    } catch {
        print -e $"zd: no matching directory: ($args | str join ' ')"
        return 1
    }

    print $"󱞩 (pwd)"
}

