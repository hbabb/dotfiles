# ~/.config/nushell/config.nu

$env.config.show_banner = false

$env.config.history = {
    file_format: sqlite
    max_size: 100_000
}
