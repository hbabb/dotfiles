# ~/.config/nushell/env.nu

# XDG base directories
$env.XDG_CONFIG_HOME = ($env | get -i XDG_CONFIG_HOME | default ($env.HOME | path join ".config"))
$env.XDG_CACHE_HOME = ($env | get -i XDG_CACHE_HOME | default ($env.HOME | path join ".cache"))
$env.XDG_DATA_HOME = ($env | get -i XDG_DATA_HOME | default ($env.HOME | path join ".local" "share"))
$env.XDG_STATE_HOME = ($env | get -i XDG_STATE_HOME | default ($env.HOME | path join ".local" "state"))

# Editor — computed first, assigned once, outside any block.
let editor = (
    if (which nvim | length) > 0 {
        which nvim | get 0.path
    } else if (which vi | length) > 0 {
        "vi"
    } else {
        ""
    }
)

$env.EDITOR = $editor
$env.VISUAL = $editor
$env.SUDO_EDITOR = $editor

# Pager
$env.PAGER = "less"
$env.BAT_THEME = ($env | get -i BAT_THEME | default "ansi")
$env.MANROFFOPT = ($env | get -i MANROFFOPT | default "-c")

let manpager = (
    if (which bat | length) > 0 {
        "sh -c 'col -bx | bat -l man -p'"
    } else if (which batcat | length) > 0 {
        "batcat -l man -p"
    } else {
        "less"
    }
)

$env.MANPAGER = $manpager

# 1Password ssh agent
$env.SSH_AUTH_SOCK = ($env.HOME | path join ".1password" "agent.sock")

# fzf
let fzf_default_command = (
    if (which fd | length) > 0 {
        "fd --type f --hidden --strip-cwd-prefix"
    } else {
        ""
    }
)

$env.FZF_DEFAULT_COMMAND = $fzf_default_command
$env.FZF_CTRL_T_COMMAND = $fzf_default_command
$env.FZF_DEFAULT_OPTS = "--height=60% --layout=reverse --border=rounded --prompt=' ' --pointer=' ' --preview-window=right:65%:wrap:border-left"

# PATH
$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local" "bin"))

# Tool init scripts — generated straight into the autoload directory.
# Unaffected by the scoping issue above: this is a file write, not an
# alias/def/$env mutation, so the `if` guard here works fine as written.
let autoload_dir = ($nu.default-config-dir | path join "autoload")
mkdir $autoload_dir

if (which starship | length) > 0 {
    starship init nu | save -f ($autoload_dir | path join "starship.nu")
}

if (which zoxide | length) > 0 {
    zoxide init nushell --hook prompt | save -f ($autoload_dir | path join "zoxide.nu")
}

if (which mise | length) > 0 {
    mise activate nu | save -f ($autoload_dir | path join "mise.nu")
}

if (which fzf | length) > 0 {
    fzf --nushell | save -f ($autoload_dir | path join "_fzf_integration.nu")
}
