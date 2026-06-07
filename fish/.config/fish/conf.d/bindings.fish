if status is-interactive
    fish_vi_key_bindings

    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_visual block

    bind \e\[1\;SC forward-word
    bind \e\[1\;SD backward-word

    bind --mode insert \e\[1\;SC forward-word
    bind --mode insert \e\[1\;SD backward-word

    bind \cf _fzf_file_no_hidden
    bind --mode insert \cf _fzf_file_no_hidden
end
