-- ================================================================================================
-- TITLE : mason-tool-installer.nvim
-- ABOUT : Installs and updates Mason tools automatically on startup.
--         Tools not listed here can still be installed by hand with :Mason.
-- LINKS :
--   > github : https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
-- ================================================================================================

-- R and Ruby servers need R / Ruby on the machine, so they're only installed where those exist
local function optional_tools()
  local tools = {}
  if vim.fn.executable("R") == 1 then
    table.insert(tools, "r-languageserver")
  end
  if vim.fn.executable("ruby") == 1 then
    table.insert(tools, "ruby-lsp")
  end
  return tools
end

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  opts = {
    ensure_installed = vim.list_extend({
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
      "gotestsum", -- Go test runner used by neotest
      "delve", -- Go debugger

      -- Python
      "pyright",
      "ruff",
      "debugpy", -- Python debugger

      -- TypeScript / JavaScript / React / Vue / Svelte
      "typescript-language-server",
      "vue-language-server", -- also brings the Vue plugin ts_ls loads
      "svelte-language-server", -- also brings the Svelte plugin ts_ls loads
      "eslint_d",
      "prettierd",

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
    }, optional_tools()),
    auto_update = true, -- update listed tools when a new version is out
    run_on_start = true, -- check every time Neovim starts
  },
}
