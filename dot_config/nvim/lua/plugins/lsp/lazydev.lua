-- ================================================================================================
-- TITLE : lazydev.nvim
-- ABOUT : Teaches the Lua language server (lua_ls) about Neovim and your plugins while you edit
--         your config: completion, types, and no "Undefined global" warnings for plugin globals.
-- LINKS :
--   > github : https://github.com/folke/lazydev.nvim
-- ================================================================================================

return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = {
    library = {
      -- each entry: load this plugin's code when one of these words appears in the file
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
      { path = "mini.trailspace", words = { "MiniTrailspace" } },
      { path = "mini.files", words = { "MiniFiles" } },
      { path = "bufferline.nvim", words = { "nvim_bufferline" } },
      { path = "nvim-lspconfig", words = { "lspconfig.settings" } },
    },
  },
}
