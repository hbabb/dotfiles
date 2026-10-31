-- ================================================================================================
-- TITLE : jsonls (JSON Language Server) LSP Setup
-- LINKS :
--   > github : https://github.com/microsoft/vscode-json-languageservice
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("jsonls", {
    capabilities = capabilities,
  })
end
