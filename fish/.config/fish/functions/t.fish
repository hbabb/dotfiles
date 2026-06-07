function t
    if not command -q tmux
        echo "Error: tmux is not installed" >&2
        return 127
    end

    tmux attach -t Work 2>/dev/null; or tmux new -s Work
end
