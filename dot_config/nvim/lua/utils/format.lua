-- ================================================================================================
-- TITLE : format
-- ABOUT : Picks the one language server that formats a buffer, so format-on-save
--         (config/autocmds.lua) and <leader>cf (config/keymaps.lua) always format the same way.
--         Most file types format through efm (formatters are set in servers/efm-langserver.lua).
-- ================================================================================================

local M = {}

-- These file types format through their own language server instead of efm:
M.lsp_formatters = {
  toml = "tombi", -- efm has no tombi entry
  templ = "templ", -- the templ language server runs `templ fmt`
  r = "r_language_server", -- formats with the styler R package
  rmd = "r_language_server",
  ruby = "ruby_lsp", -- formats with RuboCop
  rust = "rust-analyzer", -- formats with rustfmt (started by rustaceanvim)
}

-- name of the server that formats this buffer
function M.server(bufnr)
  return M.lsp_formatters[vim.bo[bufnr].filetype] or "efm"
end

-- true when that server is running for this buffer
function M.available(bufnr)
  return not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = bufnr, name = M.server(bufnr) }))
end

-- format the buffer with that server only (waits until formatting is done)
function M.format(bufnr)
  if M.available(bufnr) then
    vim.lsp.buf.format({ bufnr = bufnr, name = M.server(bufnr) })
  end
end

return M
