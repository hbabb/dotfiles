-- ================================================================================================
-- TITLE : r_language_server (R Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/REditorSupport/languageserver
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("r_language_server", {
    capabilities = capabilities,
    -- Mason's wrapper runs the language server installed by Mason. Formatting uses the
    -- styler R package and linting uses lintr, when they are installed in R.
    cmd = { "r-languageserver" },
  })
end
