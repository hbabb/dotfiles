function ff
    if not command -q fzf
        echo "Error: fzf is not installed" >&2
        return 127
    end

    if command -q bat
        fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
    else if command -q batcat
        fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'
    else
        fzf
    end
end
