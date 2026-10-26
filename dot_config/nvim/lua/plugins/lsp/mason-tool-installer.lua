-- ================================================================================================
-- TITLE : mason-tool-installer.nvim
-- ABOUT : Installs and updates Mason tools automatically on startup.
--         Tools not listed here can still be installed by hand with :Mason.
-- LINKS :
--   > github : https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
-- ================================================================================================

return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim" },
	opts = {
		ensure_installed = {
			-- runs the formatters and linters below
			"efm",

			-- Lua (your Neovim config)
			"lua-language-server",
			"stylua",
			"luacheck",

			-- Python
			"pyright",
			-- "flake8",
			-- "black",
			"ruff",
			"debugpy", -- Python debugger

			-- Go
			"gopls",
			"gofumpt",
			"revive",
			"templ",

			-- TypeScript / JavaScript / React
			"typescript-language-server",
			"eslint_d",
			"prettierd",

			-- HTML / CSS / Tailwind
			"emmet-ls",
			"tailwindcss-language-server",

			-- JSON / YAML
			"json-lsp",
			"fixjson",
			"yaml-language-server",

			-- Bash
			"bash-language-server",
			"shellcheck",
			"shfmt",

			-- Docker
			"dockerfile-language-server",
			"hadolint",

			-- PHP / Laravel
			"phpactor",
			"laravel_lsp",
			"pint",
			"phpstan",
			"php-debug-adapter",

			-- Django / Flask templates, HTMX
			"djlint",
			"htmx-lsp",

			-- TOML
			"tombi",
			"pyproject-fmt",
		},
		auto_update = true, -- update listed tools when a new version is out
		run_on_start = true, -- check every time Neovim starts
	},
}
