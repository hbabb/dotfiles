-- ================================================================================================
-- TITLE: root
-- ABOUT: Finds the project root: The nearest folder above the current file that has a .git folder.
--        Falls back to the folder Neovim was started in.
--        Stands in for LazyVim.root() in the LazyVim keymaps, snacks picker and terminal.
-- ================================================================================================

-- Project root: the nearest folder above the current file that has a .git folder.
-- Falls back to the folder Neovim was started in.
-- Stands in for LazyVim.root() in the LazyVim keymaps.
return function()
  return vim.fs.root(0, ".git") or vim.uv.cwd() or "."
end
