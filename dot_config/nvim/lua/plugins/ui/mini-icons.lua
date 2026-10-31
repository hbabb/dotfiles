-- ================================================================================================
-- TITLE : mini.icons
-- ABOUT : File-type icons. Also stands in for nvim-web-devicons, so plugins that ask for
--         nvim-web-devicons (lualine, bufferline, trouble, ...) get mini.icons instead.
-- LINKS :
--   > github : https://github.com/nvim-mini/mini.icons
-- ================================================================================================

return {
  "nvim-mini/mini.icons",
  lazy = true,
  opts = {},
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
