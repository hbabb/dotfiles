-- ================================================================================================
-- TITLE : lsp
-- ABOUT : Keymaps for language-server features. Runs each time a server attaches to a file
--         (the LspAttach autocmd in config/autocmds.lua), so these keys only exist where a
--         server is running.
-- ================================================================================================

local M = {}

M.on_attach = function(event)
  if not event.data then
    return
  end

  local ok, client = pcall(vim.lsp.get_client_by_id, event.data.client_id)

  if not ok or not client then
    return
  end
  local bufnr = event.buf
  local keymap = vim.keymap.set

  local opts = {
    noremap = true, -- prevent recursive mapping
    silent = true, -- don't print the command to the cli
    buffer = bufnr, -- restrict the keymap to the local buffer number
  }

  -- native neovim keymaps
  -- CONFLICT: LazyVim <leader>gd = Git Diff (hunks)
  -- keymap("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- goto definition
  -- CONFLICT: LazyVim <leader>gD = Git Diff (origin)
  -- keymap("n", "<leader>gD", "<cmd>Lspsaga goto_definition<CR>", opts) -- goto definition
  -- CONFLICT: LazyVim <leader>gS = Git Stash
  -- keymap("n", "<leader>gS", "<cmd>vsplit | Lspsaga goto_definition<CR>", opts) -- goto definition in split
  -- CONFLICT: LazyVim <leader>ca = Code Action (native LSP, below)
  -- keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- Code actions
  keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- Rename symbol
  keymap("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- Line diagnostics (float)
  -- CONFLICT: <leader>d is LazyVim's "debug" group. LazyVim uses <leader>cd for line diagnostics
  -- keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- Cursor diagnostics
  keymap("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- previous diagnostic
  -- CONFLICT: LazyVim <leader>n = Notification History. LazyVim uses ]d for next diagnostic
  -- keymap("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- next diagnostic
  -- CONFLICT: LazyVim K = Hover (native LSP, below)
  -- keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- hover documentation

  -- === LazyVim LSP keymaps (lua/lazyvim/plugins/lsp/init.lua + snacks_picker.lua) ===
  local function lmap(mode, lhs, rhs, desc, method)
    if method and not client:supports_method(method, bufnr) then
      return
    end
    keymap(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end
  -- stylua: ignore start
  lmap("n", "<leader>cl", function() Snacks.picker.lsp_config() end, "Lsp Info")
  lmap("n", "gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition", "textDocument/definition")
  keymap("n", "grr", function() Snacks.picker.lsp_references() end, { buffer = bufnr, nowait = true, desc = "References" })
  lmap("n", "gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
  lmap("n", "gy", function() Snacks.picker.lsp_type_definitions() end, "Goto T[y]pe Definition")
  lmap("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  lmap("n", "K", function() return vim.lsp.buf.hover() end, "Hover")
  lmap("n", "gK", function() return vim.lsp.buf.signature_help() end, "Signature Help", "textDocument/signatureHelp")
  lmap("i", "<c-k>", function() return vim.lsp.buf.signature_help() end, "Signature Help", "textDocument/signatureHelp")
  lmap({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action", "textDocument/codeAction")
  lmap({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens", "textDocument/codeLens")
  -- lmap("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens", "textDocument/codeLens")
  lmap("n", "<leader>cC", function() vim.lsp.codelens.enable(true, { bufnr = bufnr }) end, "Refresh & Display codelens", "textDocument/codeLens")
  lmap("n", "<leader>cR", function() Snacks.rename.rename_file() end, "Rename File", "workspace/willRenameFiles")
  lmap("n", "<leader>cr", vim.lsp.buf.rename, "Rename", "textDocument/rename")
  lmap("n", "<leader>cA", function()
    vim.lsp.buf.code_action({ apply = true, context = { only = { "source" }, diagnostics = {} } })
  end, "Source Action", "textDocument/codeAction")
  lmap("n", "<leader>co", function()
    vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" }, diagnostics = {} } })
  end, "Organize Imports", "textDocument/codeAction")
  if client:supports_method("textDocument/documentHighlight", bufnr) then
    lmap("n", "]]", function() Snacks.words.jump(vim.v.count1) end, "Next Reference")
    lmap("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference")
    lmap("n", "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, "Next Reference")
    lmap("n", "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, "Prev Reference")
  end
  lmap("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, "LSP Symbols", "textDocument/documentSymbol")
  lmap("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols", "workspace/symbol")
  lmap("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, "C[a]lls Incoming", "callHierarchy/incomingCalls")
  lmap("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, "C[a]lls Outgoing", "callHierarchy/outgoingCalls")
  -- stylua: ignore end

  -- your <leader>f keys (were fzf-lua, now Snacks)
  -- stylua: ignore start
  lmap("n", "<leader>fs", function() Snacks.picker.lsp_symbols() end, "Symbols (file)", "textDocument/documentSymbol")
  lmap("n", "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, "Symbols (project)", "workspace/symbol")
  lmap("n", "<leader>fw", function() Snacks.picker.lsp_workspace_symbols() end, "Symbols (project)", "workspace/symbol")
  lmap("n", "<leader>fi", function() Snacks.picker.lsp_implementations() end, "Implementations", "textDocument/implementation")
  -- stylua: ignore end

  -- Order Imports (if supported by the client LSP)
  -- CONFLICT: `<leader>oi` is the same as `<leader>co` set above. This also frees up `o` for the Obsidian plugin.
  -- if client:supports_method("textDocument/codeAction", bufnr) then
  --   keymap("n", "<leader>oi", function()
  --     vim.lsp.buf.code_action({
  --       context = {
  --         only = { "source.organizeImports" },
  --         diagnostics = {},
  --       },
  --       apply = true,
  --       bufnr = bufnr,
  --     })
  --     -- format after changing import order
  --     vim.defer_fn(function()
  --       vim.lsp.buf.format({ bufnr = bufnr })
  --     end, 50) -- slight delay to allow for the import order to go first
  --   end, opts)
  -- end

  -- === DAP keymaps ===
  -- CONFLICT: LazyVim's debug keys are now global (plugins/debug/nvim-dap.lua) and work for Rust too.
  -- These clashed: <leader>do is Step Out there (Step Over here), <leader>du is Dap UI, <leader>dr toggles the REPL.
  -- if client.name == "rust-analyzer" then -- debugging only configured for Rust
  --   local dap = require("dap")
  --   keymap("n", "<leader>dc", dap.continue, opts) -- Continue / Start
  --   keymap("n", "<leader>do", dap.step_over, opts) -- Step over
  --   keymap("n", "<leader>di", dap.step_into, opts) -- Step into
  --   keymap("n", "<leader>du", dap.step_out, opts) -- Step out
  --   keymap("n", "<leader>db", dap.toggle_breakpoint, opts) -- Toggle breakpoint
  --   keymap("n", "<leader>dr", dap.repl.open, opts) -- Open DAP REPL
  -- end
end

return M
