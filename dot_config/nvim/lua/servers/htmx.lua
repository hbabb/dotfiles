-- ================================================================================================
-- TITLE : htmx-lsp Setup
-- ABOUT : Completion for HTMX attributes (hx-get, hx-target, ...). Work in progress upstream.
-- LINKS :
--   > github: https://github.com/ThePrimeagen/htmx-lsp
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("htmx", {
		capabilities = capabilities,
	})
end
