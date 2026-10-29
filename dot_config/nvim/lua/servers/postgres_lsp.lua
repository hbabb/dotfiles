-- ================================================================================================
-- TITLE : postgres_lsp (Postgres Language Server) LSP Setup
-- LINKS :
--   > website: https://pg-language-server.com
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp)
--- @return nil
return function(capabilities)
  -- only starts in projects that have a postgres-language-server.jsonc file (nvim-lspconfig sets
  -- workspace_required = true), so SQLite and MySQL projects are left alone
  vim.lsp.config("postgres_lsp", {
    capabilities = capabilities,
  })
end
