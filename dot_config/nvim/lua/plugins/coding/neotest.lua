-- ================================================================================================
-- TITLE : neotest
-- ABOUT : Run tests from Neovim: nearest test, file, or whole project. Failures show as
--         diagnostics on the failing lines. Adapters: Pest + PHPUnit (Laravel), pytest/unittest
--         (Python). Spec based on LazyVim's test/core extra and lang/php + lang/python extras.
-- LINKS :
--   > github : https://github.com/nvim-neotest/neotest
-- ================================================================================================

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"V13Axel/neotest-pest",
		"olimorris/neotest-phpunit",
		"nvim-neotest/neotest-python",
	},
	opts = {
		status = { virtual_text = true },
		output = { open_on_run = true },
		quickfix = {
			open = function()
				require("trouble").open({ mode = "quickfix", focus = false })
			end,
		},
	},
	config = function(_, opts)
		-- Keep test failure messages on one line
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					return (diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", ""))
				end,
			},
		}, neotest_ns)

		opts.adapters = {
			require("neotest-pest"),
			require("neotest-phpunit")({
				-- let neotest-pest handle Pest projects
				root_ignore_files = { "tests/Pest.php" },
			}),
			require("neotest-python"),
		}
		require("neotest").setup(opts)
	end,
	-- stylua: ignore
	keys = {
		{ "<leader>t", "", desc = "+test" },
		{ "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to Test (Neotest)" },
		{ "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
		{ "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
		{ "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
		{ "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
		{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
		{ "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
		{ "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
		{ "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
		{ "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
		---@diagnostic disable-next-line: missing-fields
		{ "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
	},
}
