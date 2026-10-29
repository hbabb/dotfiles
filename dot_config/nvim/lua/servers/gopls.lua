-- ================================================================================================
-- TITLE : gopls (Golang Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/golang/tools/tree/master/gopls
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp)
--- @return nil
return function(capabilities)
  vim.lsp.config("gopls", {
    capabilities = capabilities,
    filetypes = { "go", "gomod", "gowork", "gotmpl" }, -- .go, go.mod, go.work, Go templates
  })
end
