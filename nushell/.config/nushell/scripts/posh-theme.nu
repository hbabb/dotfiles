def --env posh-theme [theme?: string] {
    let themes_dir = ($nu.default-config-dir | path join "oh-my-posh")

    if ($theme | is-empty) {
        print "Available themes:"
        for f in (ls ($themes_dir | path join "*.omp.json")) {
            print $"  ($f.name | path basename | str replace '.omp.json' '')"
        }
        return
    }

    let theme_file = ($themes_dir | path join $"($theme).omp.json")
    if not ($theme_file | path exists) {
        print $"Theme not found: ($theme)"
        return 1
    }

    $env.POSH_THEME = $theme_file
    print $"Switched to ($theme)"
}
