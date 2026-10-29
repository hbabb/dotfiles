-- ================================================================================================
-- TITLE : blink.cmp
-- ABOUT : Completion menu: language server suggestions, snippets, file paths and words from open
--         files in one menu. Snippets use Neovim's built-in snippet engine and friendly-snippets
--         (plus any VS Code-format snippets in ~/.config/nvim/snippets/).
--         <leader>a turns completion off and on.
-- LINKS :
--   > github  : https://github.com/saghen/blink.cmp
--   > docs    : https://cmp.saghen.dev
--   > friendly-snippets (dep) : https://github.com/rafamadriz/friendly-snippets
-- ================================================================================================

return {
  "saghen/blink.cmp",
  -- Stay on version 1: version 2 is in development with breaking changes (see the README).
  -- Using a release version also downloads blink's prebuilt fuzzy matcher.
  version = "1.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    -- turned off and on by the <leader>a toggle below
    enabled = function()
      return not vim.g.autocomplete_disable
    end,

    -- "default" preset (C-space show, C-y accept, C-e hide, C-b/C-f scroll docs, Tab/S-Tab jump
    -- through snippet fields), plus the keys this config used with nvim-cmp:
    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" }, -- only accepts an item you selected, otherwise a new line
    },

    completion = {
      -- nothing is selected until you pick an item, so Enter never accepts by accident
      list = { selection = { preselect = false, auto_insert = false } },
      -- show the docs for the selected item
      documentation = { auto_show = true },
    },

    -- show function parameters while typing arguments
    signature = { enabled = true },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    -- <leader>a: turn completion off and on (shows in which-key as Enable/Disable Autocomplete)
    Snacks.toggle({
      name = "Autocomplete",
      get = function()
        return not vim.g.autocomplete_disable
      end,
      set = function(state)
        vim.g.autocomplete_disable = not state
      end,
    }):map("<leader>a")
  end,
}
