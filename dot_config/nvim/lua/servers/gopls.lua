-- ================================================================================================
-- TITLE : gopls (Golang Language Server) LSP Setup
-- ABOUT : Go, go.mod, go.work and Go templates (nvim-lspconfig's default file types).
-- LINKS :
--   > github : https://github.com/golang/tools/tree/master/gopls
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("gopls", {
    capabilities = capabilities,
  })
end
