function posh-theme --description "Switch Oh My Posh theme"
    set -l themes_dir "$HOME/.config/fish/oh-my-posh"

    if test (count $argv) -eq 0
        echo "Available themes:"
        for f in $themes_dir/*.omp.json
            echo " "(basename $f .omp.json)
        end
        return
    end

    set -l theme_file "$themes_dir/$argv[1].omp.json"
    if not test -f $theme_file
        echo "Theme not found: $argv[1]"
        return 1
    end

    set -U POSH_THEME $theme_file
    oh-my-posh init fish --config $POSH_THEME | source
    echo "Switched to $argv[1]"
end
