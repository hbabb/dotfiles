-- ================================================================================================
-- TITLE : render-markdown.nvim
-- ABOUT : draws markdown inside Neovim (headings, code blocks, tables, checkboxes, callouts).
--         the obsidian preset keeps it drawn while typing, like Obsidian's Live Preview.
--         toggle with :RenderMarkdown toggle. obsidian.nvim turns its own drawing off when this
--         is installed.
-- LINKS :
--   > github : https://github.com/MeanderingProgrammer/render-markdown.nvim
-- ================================================================================================

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.icons",
  },
  ft = { "markdown", "rmd" },
  opts = {
    preset = "obsidian", -- keep drawing in every mode (normal, insert, visual), like Obsidian
    file_types = { "markdown", "rmd" }, -- markdown and R Markdown
    completions = { lsp = { enabled = true } }, -- blink.cmp suggests callouts and checkboxes
  },
}
