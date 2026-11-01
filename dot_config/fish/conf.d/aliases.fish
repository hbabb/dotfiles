if type -q eza
    alias lt 'eza --tree --level=5 --long --icons --git --group-directories-first -I "node_modules|.venv"'
    alias lta 'lt -a -I ".git|.jj|node_modules|.venv"'
end
