function zd
    set -l argc (count $argv)

    # No arguments: go home without printing.
    if test $argc -eq 0
        z
        return $status
    end

    # Existing path: use Zoxide's regular-cd path without printing.
    if test $argc -eq 1; and test -d "$argv[1]"
        z -- "$argv[1]"
        return $status
    end

    # Otherwise, treat the arguments as a Zoxide query.
    if not z $argv
        printf 'zd: no matching directory: %s\n' \
            (string join ' ' -- $argv) >&2
        return 1
    end

    printf '󱞩 %s\n' (pwd)
end
