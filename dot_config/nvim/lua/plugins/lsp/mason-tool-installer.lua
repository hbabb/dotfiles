-- ================================================================================================
-- TITLE : mason-tool-installer.nvim
-- ABOUT : Installs and updates Mason tools automatically on startup.
--         Tools not listed here can still be installed by hand with :Mason.
-- LINKS :
--   > github : https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
-- ================================================================================================

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  opts = {
    ensure_installed = {
      -- runs the formatters and linters below
      "efm",

      -- Lua (your Neovim config)
      "lua-language-server",
      "stylua",
      "luacheck",

      -- Go
      "gopls",
      "gofumpt",
      "revive",
      "templ",

      -- Python
      "pyright",
      "ruff",
      "debugpy", -- Python debugger

      -- TypeScript / JavaScript / React
      "typescript-language-server",
      "eslint_d",
      "prettierd",

      -- R (needs R installed)
      "r-languageserver",

      -- Ruby
      "ruby-lsp",

      -- C / C++
      "clangd",
      "clang-format",
      "cpplint",

      -- Bash
      "bash-language-server",
      "shellcheck",
      "shfmt",

      -- Fish (fish_indent comes with fish)
      "fish-lsp",

      -- SQL (sqlite, postgres/postgis, mysql)
      "sqlfluff",
      "postgres-language-server",

      -- HTML / CSS / Tailwind / HTMX
      "emmet-ls",
      "tailwindcss-language-server",
      "htmx-lsp",

      -- Flask / Jinja templates
      "djlint",

      -- JSON / YAML
      "json-lsp",
      "fixjson",
      "yaml-language-server",

      -- TOML
      "tombi",
      "pyproject-fmt",

      -- Docker
      "dockerfile-language-server",
      "hadolint",
    },
    auto_update = true, -- update listed tools when a new version is out
    run_on_start = true, -- check every time Neovim starts
  },
}
