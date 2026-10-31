-- ================================================================================================
-- TITLE : zen-mode
-- ABOUT : Distraction-free coding for Neovim. Turns on twilight (dims the code around the
--         part you're working on) while zen mode is open.
-- LINKS :
--   > github : https://github.com/folke/zen-mode.nvim
--   > twilight.nvim : https://github.com/folke/twilight.nvim
-- ================================================================================================

return {
  "folke/zen-mode.nvim",
  dependencies = {
    "folke/twilight.nvim",
  },
  keys = {
    {
      "<leader>z",
      function()
        require("zen-mode").toggle()
      end,
      desc = "Toggle Zen Mode",
    },
  },
  opts = {
    window = {
      backdrop = 1, -- keep the background the same color as the editor (default 0.95 shades it)
      width = 0.60, -- 60% of the screen width (default is 120 columns)
    },
  },
}
