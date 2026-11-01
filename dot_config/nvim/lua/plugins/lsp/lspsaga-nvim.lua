return {
	"glepnir/lspsaga.nvim",
	lazy = false,
	config = function()
		require("lspsaga").setup({
			-- use enter to open file with finder
			finder = {
				keys = {
					toggle_or_open = "<CR>",
				},
			},
			-- use enter to open file with definition preview
			definition = {
				keys = {
					edit = "<CR>",
				},
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}
