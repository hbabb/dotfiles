-- ================================================================================================
-- TITLE : svelte (Svelte Language Server) LSP Setup
-- ABOUT : Completion, errors and hover in .svelte files. Uses nvim-lspconfig's defaults.
-- LINKS :
--   > github : https://github.com/sveltejs/language-tools
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("svelte", {
    capabilities = capabilities,
  })
end
