-- ================================================================================================
-- TITLE : grug-far.nvim
-- ABOUT : Search and replace across files (LazyVim's spec).
-- LINKS :
--   > github : https://github.com/MagicDuck/grug-far.nvim
-- ================================================================================================

return {
	"MagicDuck/grug-far.nvim",
	opts = { headerMaxWidth = 80 },
	cmd = { "GrugFar", "GrugFarWithin" },
	keys = {
		{
			"<leader>sr",
			function()
				local grug = require("grug-far")
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				grug.open({
					transient = true,
					prefills = {
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "Search and Replace",
		},
	},
}
