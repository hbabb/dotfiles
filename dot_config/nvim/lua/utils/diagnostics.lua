-- ================================================================================================
-- TITLE : diagnostics
-- ABOUT : how errors and warnings from language servers and linters are shown:
--         icons in the sign column, the message at the end of the line, and sort order.
--         Called from plugins/lsp/nvim-lspconfig.lua.
-- ================================================================================================

local M = {}

local diagnostic_signs = {
  Error = " ",
  Warn = " ",
  Hint = "",
  Info = "",
}

M.setup = function()
  vim.diagnostic.config({
    virtual_text = { -- show the message at the end of the line
      source = "if_many",
      current_line = true,
    },
    severity_sort = true, -- errors win over warnings when a line has both
    float = {
      border = "rounded", -- draw a box so the popup stands out from the code
      source = "if_many", -- name the tool (ruff, pyright, gopls) when more than one reports
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
        [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
        [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
        [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
      },
    },
  })
end

return M
