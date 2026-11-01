-- ================================================================================================
-- TITLE : auto-commands
-- ABOUT : automatically run code on defined events (e.g. save, yank)
-- ================================================================================================
local on_attach = require("utils.lsp").on_attach

-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", { clear = true })
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
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank_group,
  callback = function()
    vim.hl.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

-- Format on save
-- utils/format.lua picks the server (efm for most file types), so <leader>cf formats the same way.
local format = require("utils.format")

local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = lsp_fmt_group,
  callback = function(args)
    -- <leader>uf / <leader>uF turn format-on-save off and on
    if vim.g.autoformat == false or vim.b.autoformat == false then
      return
    end

    -- remove spaces at the end of lines (only when format-on-save is on)
    require("mini.trailspace").trim()

    -- not async: wait for formatting to finish before the file is written
    format.format(args.buf)

    -- pyproject.toml also runs through pyproject-fmt, after tombi
    local file_name = vim.fs.basename(vim.api.nvim_buf_get_name(args.buf))
    if file_name == "pyproject.toml" and vim.fn.executable("pyproject-fmt") == 1 then
      local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
      local result = vim
        .system({ "pyproject-fmt", "-" }, { stdin = table.concat(lines, "\n") .. "\n" })
        :wait()
      -- pyproject-fmt exits with 1 when it changed something, so 0 and 1 both mean success
      if (result.code == 0 or result.code == 1) and result.stdout ~= "" then
        vim.api.nvim_buf_set_lines(
          args.buf,
          0,
          -1,
          false,
          vim.split(result.stdout, "\n", { trimempty = true })
        )
      end
    end
  end,
})

-- on attach function shortcuts
local lsp_on_attach_group = vim.api.nvim_create_augroup("LspMappings", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_on_attach_group,
  callback = on_attach,
})

-- custom options for text/markdown files
local markdown_options = vim.api.nvim_create_augroup("MarkdownOptions", { clear = true })
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
local python_docstrings = vim.api.nvim_create_augroup("PythonDocstrings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = python_docstrings,
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
    end, {
      buffer = args.buf,
      expr = true,
      replace_keycodes = false,
      desc = "Pair triple quotes",
    })
  end,
})
