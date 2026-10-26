-- ================================================================================================
-- TITLE : laravel.nvim
-- ABOUT : Laravel tools: pickers for Artisan, routes, make commands and related files,
--         an Artisan Hub, Tinker, and gf on views/routes/config to open them.
--         Keys moved from the README's <leader>l to <leader>L (<leader>l is LazyVim's Lazy).
-- LINKS :
--   > github : https://github.com/adalessa/laravel.nvim
-- ================================================================================================

return {
	"adalessa/laravel.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
	},
	ft = { "php", "blade" },
	event = { "BufEnter composer.json" },
	-- stylua: ignore
	keys = {
		{ "<leader>LL", function() Laravel.pickers.laravel() end, desc = "Laravel: Picker" },
		{ "<leader>La", function() Laravel.pickers.artisan() end, desc = "Laravel: Artisan Picker" },
		{ "<leader>Lr", function() Laravel.pickers.routes() end, desc = "Laravel: Routes Picker" },
		{ "<leader>Lm", function() Laravel.pickers.make() end, desc = "Laravel: Make Picker" },
		{ "<leader>Lc", function() Laravel.pickers.commands() end, desc = "Laravel: Custom Commands Picker" },
		{ "<leader>Lo", function() Laravel.pickers.resources() end, desc = "Laravel: Resources Picker" },
		{ "<leader>Lh", function() Laravel.run("artisan docs") end, desc = "Laravel: Documentation" },
		{ "<leader>Lt", function() Laravel.commands.run("actions") end, desc = "Laravel: Code Actions" },
		{ "<leader>Lu", function() Laravel.commands.run("hub") end, desc = "Laravel: Artisan Hub" },
		{ "<leader>Lp", function() Laravel.commands.run("command_center") end, desc = "Laravel: Command Center" },
		{ "<c-g>", function() Laravel.commands.run("view:finder") end, desc = "Laravel: View Finder" },
		{
			"gf",
			function()
				if Laravel.app("gf").cursorOnResource() then
					return "<cmd>lua Laravel.commands.run('gf')<cr>"
				end
				return "gf"
			end,
			expr = true,
			noremap = true,
			desc = "Laravel: Go to resource",
		},
	},
	opts = {
		features = {
			pickers = {
				provider = "snacks", -- telescope | fzf-lua | snacks | ui.select
			},
		},
	},
}
