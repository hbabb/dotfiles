-- ================================================================================================
-- TITLE : Laravel LSP Setup
-- ABOUT : Laravel's official language server: routes, views, Blade components, config, .env,
--         middleware, translations and validation rules. Runs alongside phpactor.
--         Only starts in Laravel projects (folders with an artisan file).
-- LINKS :
--   > github: https://github.com/laravel/lsp
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("laravel_lsp", {
		capabilities = capabilities,
		cmd = { "laravel-lsp" },
		filetypes = { "php", "blade" },
		root_dir = function(bufnr, on_dir)
			local root = vim.fs.root(bufnr, "artisan")
			if root then
				on_dir(root)
			end
		end,
	})
end
