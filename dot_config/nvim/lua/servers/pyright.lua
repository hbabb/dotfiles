-- ================================================================================================
-- TITLE : pyright (Python Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/microsoft/pyright
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil This function doesn't return a value, it configures the LSP server
return function(capabilities)
  local venv_ls = vim.fn.getcwd() .. "/.venv/bin/pyright-langserver"

	vim.lsp.config('pyright', {
    cmd = { vim.fn.executable(venv_ls) == 1 and venv_ls or "pyright-langserver", "--stdio" },
		capabilities = capabilities,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})
end
