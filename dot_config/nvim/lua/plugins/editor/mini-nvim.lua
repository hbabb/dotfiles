-- ================================================================================================
-- TITLE : mini.nvim
-- LINKS :
--   > github : https://github.com/echasnovski/mini.nvim
-- ABOUT : Library of 40+ independent Lua modules.
-- ================================================================================================

return {
	{ "echasnovski/mini.ai", version = "*", opts = {} },
	{ "echasnovski/mini.comment", version = "*", opts = {} },
	{ "echasnovski/mini.move", version = "*", opts = {} },
	-- CONFLICT: mini.surround uses "s", which LazyVim gives to flash. LazyVim's mini.surround uses "gs".
	-- { "echasnovski/mini.surround", version = "*", opts = {} },
	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	{ "echasnovski/mini.cursorword", version = "*", opts = {} },
	-- CONFLICT: LazyVim uses snacks indent/scope ([i ]i ii ai), which these keys collide with
	-- { "echasnovski/mini.indentscope", version = "*", opts = {} },
	{ "echasnovski/mini.pairs", version = "*", opts = {} },
	{
		"echasnovski/mini.trailspace",
		version = "*",
		opts = {},
		init = function()
			-- The snacks dashboard pads its lines with spaces, which trailspace paints red.
			-- Turn trailspace off on the dashboard.
			vim.api.nvim_create_autocmd("User", {
				pattern = "SnacksDashboardOpened",
				callback = function(ev)
					vim.b[ev.buf].minitrailspace_disable = true
					vim.schedule(function()
						pcall(MiniTrailspace.unhighlight)
					end)
				end,
			})
		end,
	},
	{ "echasnovski/mini.bufremove", version = "*", opts = {} },
	-- CONFLICT: LazyVim uses noice + snacks notifier for notifications
	-- { "echasnovski/mini.notify", version = "*", opts = {} },
}
