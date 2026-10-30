-- ================================================================================================
-- TITLE : render-markdown.nvim
-- ABOUT : Draws Markdown headings, tables, checkboxes, code blocks and callouts nicely inside
--         Neovim. The line you're editing switches back to plain text.
--         Toggle with :RenderMarkdown toggle. obsidian.nvim turns its own rendering off when
--         this plugin is installed.
-- LINKS :
--   > github : https://github.com/MeanderingProgrammer/render-markdown.nvim
-- ================================================================================================

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.icons",
  },
  ft = { "markdown" },
  opts = {},
}
