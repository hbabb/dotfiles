source env.nu
source scripts/functions.nu
source scripts/aliases.nu
source scripts/fzf.nu
source scripts/bindings.nu
source scripts/posh-theme.nu
source scripts/zoxide.nu
source scripts/mise.nu

# Keybindings
$env.config.keybindings ++= [
    {
        name: fzf_file_no_hidden
        modifier: control
        keycode: char_f
        mode: [emacs, vi_normal, vi_insert]
        event: { send: executehostcommand cmd: "fzf" }
    }
]

# Prompt engine dispatch
if $env.PROMPT_ENGINE == "starship" {
    $env.PROMPT_INDICATOR = ""
    $env.PROMPT_COMMAND = {||
        (
            ^"starship" prompt
                --cmd-duration $env.CMD_DURATION_MS
                $"--status=($env.LAST_EXIT_CODE)"
                --terminal-width (term size).columns
        )
    }
} else if $env.PROMPT_ENGINE == "oh-my-posh" {
    $env.PROMPT_INDICATOR = ""
    $env.PROMPT_COMMAND = {|| oh-my-posh print primary --config $env.POSH_THEME --shell=nu }
}
