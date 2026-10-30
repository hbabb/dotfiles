-- ================================================================================================
-- TITLE : ccc.nvim
-- ABOUT : colour picker & highlighter for neovim. Color codes in every file type show a small
--         dot in that color. Open the picker with :CccPick.
-- LINKS :
--   > github : https://github.com/uga-rosa/ccc.nvim
-- ================================================================================================

return {
  "uga-rosa/ccc.nvim",
  config = function()
    require("ccc").setup({
      highlighter = {
        auto_enable = true, -- enable highlight automatically
      },
      highlight_mode = "virtual", -- small circles with colour next to the declaration
    })
  end,
}
