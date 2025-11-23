# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Load ble.sh for ne functionality
source ~/dotfiles/bash/plugins/.ble.sh/out/ble.sh --noattach

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
alias lg='lazygit'
alias vim='nvim'
alias vi='nvim'

. "$HOME/.local/share/../bin/env"
. "$HOME/.cargo/env"

# Attach ble.sh (This line MUST be at the bottom)
[[ ! ${BLE_VERSION-} ]] || ble-attach

export UV_LINK_MODE=copy
