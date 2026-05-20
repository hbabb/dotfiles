# ~/.config/zsh/prompt.zsh

# =========================================================
# Prompt
# =========================================================

export VIRTUAL_ENV_DISABLE_PROMPT=1

if [[ -o interactive ]] && [[ "${TERM:-}" != "dumb" ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
