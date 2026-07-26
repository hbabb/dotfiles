function sail
    if test -f ./sail
        sh ./sail $argv
    else if test -f ./vendor/bin/sail
        sh ./vendor/bin/sail $argv
    else
        echo "sail: ./sail or ./vendor/bin/sail was not found" >$2
        return 127
    end
end
