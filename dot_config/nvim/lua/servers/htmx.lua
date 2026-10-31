-- ================================================================================================
-- TITLE : htmx-lsp LSP Setup
-- ABOUT : Completion for HTMX attributes (hx-get, hx-target, ...). Work in progress upstream.
-- LINKS :
--   > github : https://github.com/ThePrimeagen/htmx-lsp
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("htmx", {
    capabilities = capabilities,
  })
end
