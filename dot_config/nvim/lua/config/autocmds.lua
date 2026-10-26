-- ================================================================================================
-- TITLE : auto-commands
-- ABOUT : automatically run code on defined events (e.g. save, yank)
-- ================================================================================================
local on_attach = require("utils.lsp").on_attach

-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = last_cursor_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Highlight the yanked text for 200ms
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- format on save using efm langserver and configured formatters
local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	-- callback = function()
	callback = function(args)
		require("mini.trailspace").trim()
    -- LazyVim's <leader>uf / <leader>uF turn format-on-save off and on
    if vim.g.autoformat == false or vim.b.autoformat == false then
      return
    end

		-- TOML formats with tombi (efm has no tombi entry)
		if vim.bo[args.buf].filetype == "toml" then
			vim.lsp.buf.format({ bufnr = args.buf, name = "tombi" })
			-- pyproject.toml also runs through pyproject-fmt, after tombi
			local file_name = vim.fs.basename(vim.api.nvim_buf_get_name(args.buf))
			if file_name == "pyproject.toml" and vim.fn.executable("pyproject-fmt") == 1 then
				local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
				local result = vim.system({ "pyproject-fmt", "-" }, { stdin = table.concat(lines, "\n") .. "\n" }):wait()
				-- pyproject-fmt exits with 1 when it changed something, so 0 and 1 both mean success
				if (result.code == 0 or result.code == 1) and result.stdout ~= "" then
					vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, vim.split(result.stdout, "\n", { trimempty = true }))
				end
			end
			return
		end

		local efm = vim.lsp.get_clients({ name = "efm" })
		if vim.tbl_isempty(efm) then
			return
		end
		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})

-- on attach function shortcuts
local lsp_on_attach_group = vim.api.nvim_create_augroup("LspMappings", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_on_attach_group,
	callback = on_attach,
})

-- custom options for text/markdown files
local markdown_options = vim.api.nvim_create_augroup("MardownOptions", {})
vim.api.nvim_create_autocmd("FileType", {
	group = markdown_options,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.opt_local.cursorline = false
		vim.opt_local.colorcolumn = ""
		vim.opt_local.signcolumn = "no"
	end,
})

-- Python: typing """ creates a full """ """ docstring pair, cursor in the middle
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function(args)
		vim.keymap.set("i", '"', function()
			local col = vim.fn.col(".")
			local line = vim.fn.getline(".")
			local before = line:sub(col - 2, col - 1) -- the 2 characters left of the cursor
			local after = line:sub(col, col) -- the character right of the cursor
			local pairs_off = vim.g.minipairs_disable or vim.b.minipairs_disable
			if not pairs_off and before == '""' and after ~= '"' then
				-- add the 3rd opening quote plus 3 closing quotes, then move back between them
				return '""""' .. vim.api.nvim_replace_termcodes(string.rep("<Left>", 3), true, false, true)
			end
			-- anything else: let mini.pairs handle " exactly like it normally does
			return MiniPairs.closeopen('""', "^[^\\]")
		end, { buffer = args.buf, expr = true, replace_keycodes = false, desc = "Pair triple quotes" })
	end,
})
