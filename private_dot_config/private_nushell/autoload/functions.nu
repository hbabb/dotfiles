# ~/.config/nushell/autoload/functions.nu

def ll [] {
    ls -l | sort-by type name
}

def la [] {
    ls -la | sort-by type name
}

def --wrapped glog [...rest] {
    with-env {GIT_PAGER: "less -F -X"} { git log ...$rest }
}

def --wrapped gl [...rest] {
    with-env {GIT_PAGER: "less -F -X"} { git log --all --decorate --oneline --graph ...$rest }
}
