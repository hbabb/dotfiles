-- ================================================================================================
-- TITLE : nvim-dap-python
-- ABOUT : Python debugging with debugpy (installed by Mason). Finds the project's .venv
--         on its own. Spec based on LazyVim's python extra.
-- LINKS :
--   > github : https://github.com/mfussenegger/nvim-dap-python
-- ================================================================================================

return {
	"mfussenegger/nvim-dap-python",
	ft = "python",
	dependencies = { "mfussenegger/nvim-dap" },
	-- stylua: ignore
	keys = {
		{ "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug Method", ft = "python" },
		{ "<leader>dPc", function() require("dap-python").test_class() end, desc = "Debug Class", ft = "python" },
	},
	config = function()
		require("dap-python").setup("debugpy-adapter")
	end,
}
