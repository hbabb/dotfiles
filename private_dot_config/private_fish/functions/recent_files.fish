function recent_files
    if find . -type f -printf '' >/dev/null 2>&1
        find . -type f -printf '%T@\t%p\n' | sort -rn | cut -f2-
    else if command -q stat
        switch (uname -s)
            case Darwin FreeBSD
                find . -type f -exec stat -f '%m\t%N' {} + | sort -rn | cut -f2-
            case '*'
                find . -type f -exec stat -c '%Y\t%n' {} + | sort -rn | cut -f2-
        end
    else
        find . -type f
    end
end
