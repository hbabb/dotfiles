function sff
    if test (count $argv) -eq 0
        echo "Usage: sff <destination> (e.g. sff host:/tmp/)" >&2
        return 1
    end

    set -l file (recent_files | ff)

    if test -z "$file"
        return
    end

    scp "$file" "$argv[1]"
end
