# ~/.config/nushell/autoload/navigation.nu

def --env zd [...args] {
    if ($args | length) == 0 {
        z
        return
    }

    if ($args | length) == 1 and ($args.0 | path type) == "dir" {
        z $args.0
        return
    }

    try {
        z ...$args
    } catch {
        print -e $"zd: no matching directory: ($args | str join ' ')"
        return
    }

    print $"󱞩 (pwd)"
}
