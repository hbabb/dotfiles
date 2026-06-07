# Default file source
if command -q fd
    set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --strip-cwd-prefix"
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
end

# UI
set -gx FZF_DEFAULT_OPTS "
--hight=60%
--layout=reverse
--border=rounded
--prompt=' '
--pointer=' '
--preview-window=right:65%:wrap:border-left
"

# Preview
if command -q bat
    set -gx _FZF_PREVIEW_CMD "bat --color=always --style=plain,numbers --line-range=:500 {}"
else if command -q batcat
    set -gx _FZF_PREVIEW_CMD "batcat --color=always --style=plain,numbers --line-range=:500 {}"
else
    set -gx _FZF_PREVIEW_CMD "cat {}"
end

set -gx FZF_CTRL_T_OPTS "--preview '$_FZF_PREVIEW_CMD'"
