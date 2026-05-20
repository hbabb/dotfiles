# ~/.config/zsh/functions.zsh

# =========================================================
# Function loader
# =========================================================
#
# Loads grouped function files from:
#
#   ~/.config/zsh/fns/

for f in "$ZDOTDIR"/fns/*(.N); do
  source "$f"
done
