local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Language Server Protocol (LSP)
require("servers.lua_ls")(capabilities) -- Lua (this Neovim config)
require("servers.gopls")(capabilities) -- Go
require("servers.templ")(capabilities) -- Go templ
require("servers.pyright")(capabilities) -- Python
require("servers.ts_ls")(capabilities) -- TypeScript / JavaScript
require("servers.r_language_server")(capabilities) -- R
require("servers.ruby_lsp")(capabilities) -- Ruby
require("servers.clangd")(capabilities) -- C / C++
require("servers.bashls")(capabilities) -- Bash
require("servers.fish_lsp")(capabilities) -- Fish
require("servers.nushell")(capabilities) -- Nushell
require("servers.postgres_lsp")(capabilities) -- PostgreSQL / PostGIS
require("servers.emmet_ls")(capabilities) -- HTML
require("servers.tailwindcss")(capabilities) -- Tailwind CSS
require("servers.htmx")(capabilities) -- HTMX
require("servers.jsonls")(capabilities) -- JSON
require("servers.yamlls")(capabilities) -- YAML
require("servers.tombi")(capabilities) -- TOML
require("servers.dockerls")(capabilities) -- Docker
-- Rust: rust-analyzer is started by rustaceanvim (plugins/debug/rustaceanvim.lua)

-- Linters & Formatters
require("servers.efm-langserver")(capabilities)

vim.lsp.enable({
  "lua_ls",
  "gopls",
  "templ",
  "pyright",
  "ts_ls",
  "r_language_server",
  "ruby_lsp",
  "clangd",
  "bashls",
  "fish_lsp",
  "nushell",
  "postgres_lsp",
  "emmet_ls",
  "tailwindcss",
  "htmx",
  "jsonls",
  "yamlls",
  "tombi",
  "dockerls",
  "efm",
})
