-- ================================================================================================
-- TITLE : ruby_lsp (Ruby Language Server) LSP Setup
-- LINKS :
--   > website: https://shopify.github.io/ruby-lsp/
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp)
--- @return nil
return function(capabilities)
  vim.lsp.config("ruby_lsp", {
    capabilities = capabilities,
  })
end
