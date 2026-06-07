function eff
    set -l file (ff)

    if test -z "$file"
        return
    end

    command $EDITOR "$file"
end
