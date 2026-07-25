# ~/.config/zsh/bindings.zsh

# =========================================================
# Keybindings
# =========================================================

# Cursor shape per vi mode
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# Disable command mode line highlight
ZVM_VI_HIGHLIGHT_BACKGROUND=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

# zsh-vi-mode resets all bindings on init, so custom bindings
# must be registered via this hook to survive.
zvm_after_init() {
  bindkey '^[[1;5C' forward-word           # Ctrl+Right
  bindkey '^[[1;5D' backward-word          # Ctrl+Left
  bindkey '^F' _fzf_file_no_hidden         # Ctrl+F -> fzf file picker (no hidden files)
  bindkey '^\' autosuggest-toggle          # Ctrl+\ -> toggle autosuggestions
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}
