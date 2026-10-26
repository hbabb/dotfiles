-- ================================================================================================
-- TITLE: templ (Golang templ Language Server) LSP Setup
-- LINKS:
--    > https://github.com/neovim/nvim-lspconfig/blob/master/lsp/templ.lua
-- ================================================================================================

---@param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
---@return nil
return function(capabilities)
  vim.lsp.config('templ', {
    capabilities = capabilities,
    cmd = { "templ", "lsp" },
    filetypes = { "templ" },
    root_markers = { "go.work", "go.mod", ".git" },
  })
end
