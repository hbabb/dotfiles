-- ================================================================================================
-- TITLE : templ (Golang templ Language Server) LSP Setup
-- ABOUT : Uses nvim-lspconfig's defaults: runs `templ lsp` on .templ files, with go.work,
--         go.mod or .git marking the project root.
-- LINKS :
--   > github : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/templ.lua
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("templ", {
    capabilities = capabilities,
  })
end
