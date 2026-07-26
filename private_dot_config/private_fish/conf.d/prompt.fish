# To switch between starship and oh-my-posh
# set -U PROMPT_ENGINE starship sets it permanantly
# set -g PROMPT_ENGINE starship sets it only for the session
# 
# exec fish after setting PROMPT_ENGINE
# Prompt engine: "starship" or "oh-my-posh"
set -q PROMPT_ENGINE; or set -gx PROMPT_ENGINE oh-my-posh

if test "$PROMPT_ENGINE" = starship
    if status is-interactive; and command -q starship
        starship init fish | source
    end
else if test "$PROMPT_ENGINE" = oh-my-posh
    set -q POSH_THEME; or set -U POSH_THEME "$HOME/.config/fish/oh-my-posh/kali.omp.json"

    if status is-interactive; and command -q oh-my-posh
        oh-my-posh init fish --config $POSH_THEME | source
    end
end
