-- ================================================================================================
-- TITLE : dockerls (Docker Language Server) LSP Setup
-- LINKS :
--   > github : https://github.com/rcjsuen/dockerfile-language-server-nodejs
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("dockerls", {
    capabilities = capabilities,
  })
end
