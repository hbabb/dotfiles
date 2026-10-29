-- ================================================================================================
-- TITLE : nushell (Nushell built-in Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/nushell/nushell
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp)
--- @return nil
return function(capabilities)
  -- the language server is built into nu (`nu --lsp`), so there is nothing to install
  vim.lsp.config("nushell", {
    capabilities = capabilities,
  })
end
