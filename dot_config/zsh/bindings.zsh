# =========================================================
# Keybindings
# zsh-vi-mode is gone, so these are set directly
# instead of inside zvm_after_init.
# =========================================================

# Ctrl+Right -> move forward one word (^[[1;5C is the terminal escape code)
bindkey '^[[1;5C' forward-word

# Ctrl+Left -> move backward one word (^[[1;5D is the terminal escape code)
bindkey '^[[1;5D' backward-word

# Ctrl+F -> fzf file picker (no hidden files)
bindkey '^F' _fzf_file_no_hidden

# Ctrl+\ -> toggle autosuggestions (useful for screen recordings)
bindkey '^\' autosuggest-toggle

# Alt+Up/Alt+Down -> history search by substring
# (Up and Ctrl+R go to Atuin, set in atuin.zsh)
bindkey '^[[1;3A' history-substring-search-up
bindkey '^[[1;3B' history-substring-search-down

# Original vi-mode settings
#
# # Cursor shape per vi mode
# ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
# ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
# ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
#
# # Disable command mode line highlight
# ZVM_VI_HIGHLIGHT_BACKGROUND=none
# ZVM_VI_HIGHLIGHT_FOREGROUND=none
# ZVM_VI_HIGHLIGHT_EXTRASTYLE=none
#
# zvm_after_init() {
#   ...bindings above...
#
#   # Up/Down -> history search by substring
#   bindkey '^[[A' history-substring-search-up
#   bindkey '^[[B' history-substring-search-down
# }
