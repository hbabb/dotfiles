-- ================================================================================================
-- TITLE : fish_lsp (Fish Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/ndonfris/fish-lsp
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp)
--- @return nil
return function(capabilities)
  vim.lsp.config("fish_lsp", {
    capabilities = capabilities,
  })
end
