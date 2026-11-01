-- ================================================================================================
-- TITLE: root
-- ABOUT: Finds the project root: the nearest folder above the current file that has a .git or .jj
--        folder. Falls back to the folder Neovim was started in.
--        Stands in for LazyVim.root() in the LazyVim keymaps, snacks picker and terminal.
-- ================================================================================================

return function()
  return vim.fs.root(0, { ".git", ".jj" }) or vim.uv.cwd() or "."
end
