-- ================================================================================================
-- TITLE : tombi (TOML Language Server) LSP Setup
-- LINKS :
--   > github : https://github.com/tombi-toml/tombi
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("tombi", {
    capabilities = capabilities,
  })
end
