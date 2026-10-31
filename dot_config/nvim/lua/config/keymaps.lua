-- ================================================================================================
-- TITLE: NeoVim keymaps
-- ABOUT: sets some quality-of-life keymaps
--        <leader> and <localleader> are set in config/globals.lua
-- ================================================================================================

-- Quick config editing: opens chezmoi's copy (utils/config_dir.lua). Run `chezmoi apply` after.
vim.keymap.set("n", "<leader>rc", function()
  vim.cmd.edit(require("utils.config_dir")() .. "/init.lua")
end, { desc = "Edit config" })

-- CONFLICT: LazyVim sets j/k (LazyVim section below)
-- vim.keymap.set("n", "j", function()
--   return vim.v.count == 0 and "gj" or "j"
-- end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
-- vim.keymap.set("n", "k", function()
--   return vim.v.count == 0 and "gk" or "k"
-- end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- CONFLICT: <leader>c is LazyVim's "code" group. LazyVim clears search with <Esc>
-- vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- CONFLICT: LazyVim sets n/N (it does not center the screen)
-- vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
-- vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
-- CONFLICT: <leader>x is LazyVim's "diagnostics/quickfix" group
-- vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
-- CONFLICT: LazyVim <leader>bp = Toggle Pin (plugins/bufferline.lua). LazyVim uses <S-h> / [b for previous buffer
-- vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- CONFLICT: LazyVim sets <C-h/j/k/l> (same action)
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>h", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>v", "<C-W>v", { desc = "Split Window Right", remap = true })
-- CONFLICT: LazyVim <leader>sh = Help Pages. LazyVim splits with <leader>- and <leader>|
-- vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
-- CONFLICT: LazyVim sets <C-arrows> (same action)
-- vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
-- vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
-- vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
-- vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- CONFLICT: LazyVim sets <A-j>/<A-k> (same action)
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- CONFLICT: LazyVim sets < and > (same action)
-- vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
-- vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = "Copy full file path" })

-- ================================================================================================
-- LazyVim keymaps
-- Copied from LazyVim's lua/lazyvim/config/keymaps.lua, with LazyVim-only helpers swapped out.
-- ================================================================================================

local map = vim.keymap.set
local root = require("utils.root")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true }
)
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
-- CONFLICT: same action as mini.move
-- map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
-- map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
-- CONFLICT: same action as mini.move
-- map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
-- map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bi", function()
  Snacks.bufdelete.invisible()
end, { desc = "Delete Invisible Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
-- <S-h>, <S-l>, [b, ]b are set in plugins/bufferline.lua (same as LazyVim)

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  if vim.snippet then
    vim.snippet.stop()
  end
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- location list
map("n", "<leader>xl", function()
  local success, err =
    pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

-- quickfix list
map("n", "<leader>xq", function()
  local success, err =
    pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })
-- [q and ]q are set in plugins/trouble-nvim.lua (same as LazyVim)

-- formatting (LazyVim uses its own formatter; this uses the LSP, which is efm in your config)
map({ "n", "x" }, "<leader>cf", function()
  vim.lsp.buf.format()
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- toggle options
-- Auto Format toggles: your format-on-save (config/autocmds.lua) checks these
Snacks.toggle({
  name = "Auto Format (Global)",
  get = function()
    return vim.g.autoformat ~= false
  end,
  set = function(state)
    vim.g.autoformat = state
  end,
}):map("<leader>uf")
Snacks.toggle({
  name = "Auto Format (Buffer)",
  get = function()
    return vim.b.autoformat ~= false
  end,
  set = function(state)
    vim.b.autoformat = state
  end,
}):map("<leader>uF")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
  .option(
    "conceallevel",
    { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
  )
  :map("<leader>uc")
Snacks.toggle
  .option(
    "showtabline",
    { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }
  )
  :map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle
  .option("background", { off = "light", on = "dark", name = "Dark Background" })
  :map("<leader>ub")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.animate():map("<leader>ua")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.profiler():map("<leader>dpp")
Snacks.toggle.profiler_highlights():map("<leader>dph")

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function()
    Snacks.lazygit({ cwd = root() })
  end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
end

map("n", "<leader>gL", function()
  Snacks.picker.git_log()
end, { desc = "Git Log (cwd)" })
map("n", "<leader>gb", function()
  Snacks.picker.git_log_line()
end, { desc = "Git Blame Line" })
map("n", "<leader>gf", function()
  Snacks.picker.git_log_file()
end, { desc = "Git Current File History" })
map("n", "<leader>gl", function()
  Snacks.picker.git_log({ cwd = root() })
end, { desc = "Git Log" })
map({ "n", "x" }, "<leader>gB", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
map({ "n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse({
    open = function(url)
      vim.fn.setreg("+", url)
    end,
    notify = false,
  })
end, { desc = "Git Browse (copy)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })

-- LazyVim Changelog (<leader>L) is left out: it only shows LazyVim's own changelog

-- floating terminal
map("n", "<leader>fT", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<leader>ft", function()
  Snacks.terminal(nil, { cwd = root() })
end, { desc = "Terminal (Root Dir)" })
map({ "n", "t" }, "<c-/>", function()
  Snacks.terminal.focus(nil, { cwd = root() })
end, { desc = "Terminal (Root Dir)" })
map({ "n", "t" }, "<c-_>", function()
  Snacks.terminal.focus(nil, { cwd = root() })
end, { desc = "which_key_ignore" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
Snacks.toggle.zen():map("<leader>uz")

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- lua
-- Off. This used to clash with <leader>rc and <leader>rn when localleader was Space.
-- localleader is now "\" (config/globals.lua), so uncommenting this gives \r = Run Lua.
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "lua",
--   callback = function(ev)
--     map({ "n", "x" }, "<localleader>r", function() Snacks.debug.run() end, { desc = "Run Lua", buffer = ev.buf })
--   end,
-- })

-- mini.pairs toggle (from LazyVim's mini.pairs spec in coding.lua)
Snacks.toggle({
  name = "Mini Pairs",
  get = function()
    return not vim.g.minipairs_disable
  end,
  set = function(state)
    vim.g.minipairs_disable = not state
  end,
}):map("<leader>up")
