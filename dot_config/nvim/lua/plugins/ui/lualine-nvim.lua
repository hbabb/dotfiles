-- ================================================================================================
-- TITLE : lualine.nvim
-- ABOUT : The status line along the bottom. Colors follow the current colorscheme, and icons
--         come from mini.icons (see ui/mini-icons.lua).
-- LINKS :
--   > github : https://github.com/nvim-lualine/lualine.nvim
-- ================================================================================================

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      section_separators = { left = "\u{e0b4}", right = "\u{e0b6}" }, -- rounded ends
      component_separators = "|",
    },
  },
}
