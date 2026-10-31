# =========================================================
# Prompt
# =========================================================

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

FUNCNEST=100

# Omarchy already starts starship
# if [[ -o interactive ]] && [[ "${TERM:-}" != "dumb" ]] && command -v starship >/dev/null 2>&1; then
#   eval "$(starship init zsh)"
# fi
