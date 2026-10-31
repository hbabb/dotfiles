-- ================================================================================================
-- TITLE : lazy.nvim Bootstrap & Plugin Setup
-- ABOUT :
--   bootstraps the 'lazy.nvim' plugin manager by cloning it if not present, prepends it to the
--   runtime path, and then loads core configuration files (globals, options, keymaps, autocmds).
--   Last, initialises 'lazy.nvim' with plugins.
-- LINKS :
--   > lazy.nvim github  : https://github.com/folke/lazy.nvim
--   > lazy.nvim website : https://lazy.folke.io/installation
-- ================================================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field (fs_stat)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out =
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("config.globals")
require("config.options")
require("config.remote_clipboard").setup()
-- require("config.keymaps") -- moved: loaded after plugins start (below)
require("config.autocmds")

-- Load keymaps after plugins start
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.keymaps")
  end,
})

local plugins_dir = "plugins"

require("lazy").setup({
  spec = {
    -- { import = plugins_dir },
    -- lazy.nvim only reads top level directory
    { import = plugins_dir .. ".ui" },
    { import = plugins_dir .. ".editor" },
    { import = plugins_dir .. ".coding" },
    { import = plugins_dir .. ".lsp" },
    { import = plugins_dir .. ".debug" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
      },
    },
  },
  checker = { enabled = true },
})
