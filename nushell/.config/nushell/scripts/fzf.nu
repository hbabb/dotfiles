# Default file source
if (which fd | is-not-empty) {
  $env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --strip-cwd-prefix"
  $env.FZF_CTRL_T_COMMAND = $env.FZF_DEFAULT_COMMAND
}

# UI
$env.FZF_DEFAULT_OPTS = "
--height=60%
--layout=reverse
--border=rounded
--prompt=' '
--pointer=' '
--preview-window=right:65%:wrap:border-left
"

# Preview
if (which bat | is-not-empty) {
    $env._FZF_PREVIEW_CMD = "bat --color=always --style=plain,numbers --line-range=:500 {}"
} else if (which batcat | is-not-empty) {
    $env._FZF_PREVIEW_CMD = "batcat --color=always --style=plain,numbers --line-range=:500 {}"
} else {
    $env._FZF_PREVIEW_CMD = "cat {}"
}

$env.FZF_CTRL_T_OPTS = $"--preview '($env._FZF_PREVIEW_CMD)'"
