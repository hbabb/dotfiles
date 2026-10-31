-- ================================================================================================
-- TITLE : chezmoi.vim
-- ABOUT : Detects filetypes in the chezmoi source folder, so files get the right highlighting
--         under their chezmoi names (dot_zshrc => .zshrc, private_jj => jj). Also covers
--         .chezmoiignore, .chezmoiexternal.* and .tmpl templates.
-- NOTES : Must not load lazily, or filetype detection doesn't work. use_tmp_buffer is
--         required with lazy.nvim (the plugin marks it experimental). The source folder
--         defaults to ~/.local/share/chezmoi, so it doesn't need setting.
-- LINKS :
--   > github : https://github.com/alker0/chezmoi.vim
-- ================================================================================================

return {
  "alker0/chezmoi.vim",
  lazy = false,
  init = function()
    vim.g["chezmoi#use_tmp_buffer"] = true
  end,
}
