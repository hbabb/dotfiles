-- ================================================================================================
-- TITLE : obsidian.nvim
-- ABOUT : Work with an Obsidian notes vault: new notes, daily notes, search, links.
--         Only loads on machines where the vault folder exists, so it never errors on startup.
--         Keys: <leader>on new, <leader>of find, <leader>os search, <leader>ot today
-- LINKS :
--   > github : https://github.com/obsidian-nvim/obsidian.nvim
-- ================================================================================================

local vault = vim.fn.expand("~/Documents/Notes")

return {
  "obsidian-nvim/obsidian.nvim",
  -- skip the plugin entirely when the vault folder isn't on this machine
  cond = function()
    return vim.uv.fs_stat(vault) ~= nil
  end,
  ft = "markdown",
  cmd = "Obsidian",
  keys = {
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New Note" },
    { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Find note" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Today's daily note" },
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      { name = "Notes", path = vault },
    },
    picker = { name = "snacks.picker" },
  },
}
