# ~/.config/nushell/autoload/files.nu

def ff [] {
    if (which fzf | length) == 0 {
        print -e "Error: fzf is not installed"
        return
    }

    let piped = $in

    if (which bat | length) > 0 {
        if ($piped | is-empty) {
            ^fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
        } else {
            $piped | ^fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
        }
    } else if (which batcat | length) > 0 {
        if ($piped | is-empty) {
            ^fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'
        } else {
            $piped | ^fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'
        }
    } else {
        if ($piped | is-empty) { ^fzf } else { $piped | ^fzf }
    }
}

def eff [] {
    let file = (ff)

    if ($file | is-empty) {
        return
    }

    ^$env.EDITOR $file
}

def --wrapped n [...args] {
    if ($args | length) == 0 {
        ^nvim .
    } else {
        ^nvim ...$args
    }
}

def recent_files [] {
    ls **/* | where type == file | sort-by modified | reverse | get name
}

def sff [dest: string] {
    let file = (recent_files | ff)

    if ($file | is-empty) {
        return
    }

    ^scp $file $dest
}

def --wrapped sail [...args] {
    if ("./sail" | path exists) {
        ^sh ./sail ...$args
    } else if ("./vendor/bin/sail" | path exists) {
        ^sh ./vendor/bin/sail ...$args
    } else {
        print -e "sail: ./sail or ./vendor/bin/sail was not found"
    }
}
