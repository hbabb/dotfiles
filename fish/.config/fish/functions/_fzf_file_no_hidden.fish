function _fzf_file_no_hidden
    if not command -q fzf
        echo "Error: fzf is not installed" >&2
        return 127
    end

    set -l cmd

    if test -n "$FZF_DEFAULT_COMMAND"
        set cmd (string replace -- "--hidden " "" "$FZF_DEFAULT_COMMAND")
    else
        set cmd "find . -type f"
    end

    set -l result (eval "$cmd" | fzf --preview "$_FZF_PREVIEW_CMD")

    if test -z "$result"
        return
    end

    commandline --insert "$result"
    commandline --repaint
end
