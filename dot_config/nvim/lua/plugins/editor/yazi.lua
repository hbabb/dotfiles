-- ================================================================================================
-- TITLE : yazi.nvim
-- ABOUT : Opens the yazi file manager in a floating window. Files picked in yazi open in Neovim,
--         and files renamed, moved or deleted in yazi stay in sync with open buffers.
--         Needs the yazi program installed (omarchy pkg add yazi).
-- LINKS :
--   > github : https://github.com/mikavilpas/yazi.nvim
-- ================================================================================================

return {
  "mikavilpas/yazi.nvim",
  version = "*", -- use the latest stable version
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    -- yazi.nvim's suggested keys clash with LazyVim's:
    --   <leader>-  is Split Window Below
    --   <c-up>     is Increase Window Height
    { "<leader>y", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Yazi (current file)" },
    { "<leader>Y", "<cmd>Yazi cwd<cr>", desc = "Yazi (cwd)" },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
}
