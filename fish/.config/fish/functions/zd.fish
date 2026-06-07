function zd
    if test (count $argv) -eq 0
        builtin cd ~
        return
    end

    if test (count $argv) -eq 1; and test -d "$argv[1]"
        builtin cd "$argv[1]"
        return
    end

    if not z $argv
        echo "Error: Directory not found: $argv" >&2
        return 1
    end

    printf "󱞩 "
    pwd
end
