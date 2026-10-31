-- ================================================================================================
-- TITLE : emmet_ls (Emmet Language Server) LSP Setup
-- ABOUT : Emmet abbreviations (div.card>ul>li*3). Uses nvim-lspconfig's default file types:
--         HTML, templ, Django-style templates, CSS/Sass/Less, JSX/TSX, Svelte and Vue.
-- LINKS :
--   > github : https://github.com/aca/emmet-ls
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("emmet_ls", {
    capabilities = capabilities,
  })
end
