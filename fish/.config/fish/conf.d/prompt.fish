# Prompt engin: "starship" or "oh-my-posh"
set -q PROMPT_ENGINE; or set -gx PROMPT_ENGINE oh-my-posh

if test "$PROMPT_ENGINE" = starship
    if status is-interactive; and command -q starship
        starship init fish | source
    end
else if test "$PROMPT_ENGINE" = oh-my-posh
    if status is-interactive; and command -q oh-my-posh
        oh-my-posh init fish --config $POSH_THEME | source
    end
end
