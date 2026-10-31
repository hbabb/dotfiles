-- ================================================================================================
-- TITLE : vue_ls (Vue Language Server) LSP Setup
-- ABOUT : The template and style parts of .vue files. The TypeScript parts are handed to ts_ls
--         (see servers/ts_ls.lua). Uses nvim-lspconfig's defaults, which do that hand-off.
--         Vue 3 projects only, unless the project adds extra setup for Vue 2.
-- LINKS :
--   > github : https://github.com/vuejs/language-tools
--   > neovim : https://github.com/vuejs/language-tools/wiki/Neovim
-- ================================================================================================

--- @param capabilities table LSP client capabiliites (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("vue_ls", {
    capabilities = capabilities,
  })
end
