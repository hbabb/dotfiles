-- ================================================================================================
-- TITLE : lua_ls (Lua Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/LuaLS/lua-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config('lua_ls', {
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
        -- lazydev.nvim (plugins/lazydev.lua) now  tells lua_ls where Neovim's and the plugins' code is
				-- workspace = {
					-- library = {
						-- vim.fn.expand("$VIMRUNTIME/lua"),
						-- vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
					-- },
				-- },
			},
		},
	})
end
