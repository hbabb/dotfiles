if $nu.is-interactive {
    $env.config.edit_mode = "vi"

    $env.config.cursor_shape.vi_normal = "block"
    $env.config.cursor_shape.vi_insert = "line"

    $env.config.keybindings ++= [
        {
            name: forward_word
            modifier: control
            keycode: right
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movewordright }
        }
        {
            name: backward_word
            modifier: control
            keycode: left
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movewordleft }
        }
        {
            name: fzf_file_no_hidden
            modifier: control
            keycode: char_f
            mode: [emacs, vi_normal, vi_insert]
            event: {
                send: executehostcommand
                cmd: "commandline edit --insert (fzf-file-no-hidden)"
            }
        }
    ]
}
