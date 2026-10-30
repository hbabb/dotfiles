-- ================================================================================================
-- TITLE : live-preview.nvim
-- ABOUT : Preview Markdown, HTML (with CSS/JS), AsciiDoc and SVG in the browser, updating as you
--         type and scrolling along with Neovim. Written in Lua, so nothing else to install.
--         Commands: :LivePreview start | close | pick
-- LINKS :
--   > github : https://github.com/brianhuster/live-preview.nvim
-- ================================================================================================

return {
  "brianhuster/live-preview.nvim",
  cmd = "LivePreview", -- loads the first time you run :LivePreview
  config = function()
    require("livepreview.config").set({
      picker = "snacks.picker", -- used by :LivePreview pick
    })
  end,
}
