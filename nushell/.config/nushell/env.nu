# XDG base directories
$env.XDG_CONFIG_HOME = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config"))
$env.XDG_CACHE_HOME = ($env.XDG_CACHE_HOME? | default ($env.HOME | path join ".cache"))
$env.XDG_DATA_HOME = ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share"))
$env.XDG_STATE_HOME = ($env.XDG_STATE_HOME? | default ($env.HOME | path join ".local/state"))

# Editor
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.SUDO_EDITOR = $env.EDITOR

# Pager
$env.PAGER = "less"
$env.BAT_THEME = ($env.BAT_THEME? | default "ansi")
$env.MANROFFOPT = ($env.MANROFFOPT? | default "-c")

if (which bat | is-not-empty) {
  $env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
} else if (which batcat | is-not-empty) {
  $env.MANPAGER = "batcat -l man -p"
}

# GPG
if (is-terminal --stdin) {
  $env.GPG_TTY = (^tty)
}

# 1Password ssh agent
$env.SSH_AUTH_SOCK = ($env.HOME | path join ".1password/agen.sock")

# Prompt engine: "starship" or "oh-my-posh"
$env.PROMPT_ENGINE = ($env.PROMPT_ENGINE? | default "oh-my-posh")

# Oh My Posh theme
$env.POSH_THEME = ($nu.default-config-dir | path join "oh-my-posh/atomicBit.omp.json")

# Vite+ bin (https://viteplus.dev)
$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".vite-plus/bin"))

# User PATH entries
$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local/bin"))
