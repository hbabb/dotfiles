-- ================================================================================================
-- TITLE : tailwindcss (Tailwind CSS Language Server) LSP Setup
-- ABOUT : Tailwind class completion and hover. Uses nvim-lspconfig's defaults: HTML, templ,
--         Django-style templates, CSS, JS/TS, JSX/TSX, Svelte and Vue, with .templ read as HTML.
-- LINKS :
--   > github : https://github.com/tailwindlabs/tailwindcss-intellisense
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("tailwindcss", {
    capabilities = capabilities,
  })
end
