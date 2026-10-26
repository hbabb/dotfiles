-- ================================================================================================
-- TITLE : phpactor LSP Setup
-- ABOUT : General PHP language server: completion, go-to-definition, rename, code actions.
-- LINKS :
--   > github: https://github.com/phpactor/phpactor
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("phpactor", {
		capabilities = capabilities,
	})
end
